//
//  CMAutoScrollLabel.m
//  shouji
//  可以自动滚动的标签
//  Created by 常敏 on 15-4-3.
//  Copyright (c) 2015年 cm. All rights reserved.
//

#import "CMAutoScrollLabel.h"


/**
 *  默认的标签的数量，两个就够了
 **/
static NSInteger const kLabelCount = 2;

/**
 *  默认的
 **/
static CGFloat const kDefaultFadeLength = 7.f;

/**
 *  默认的两个标签之间的距离
 **/
static NSInteger const kDefaultspaceBetweenLabels = 20;

/**
 *  默认的滚动的速度
 **/
static NSInteger const kDefaultPixelsPerSecond = 30;

/**
 *  默认的暂停的时间
 **/
static CGFloat const kDefaultPauseTime = 1.5f;


static void each_object(NSArray *objects, void(^block)(id object)){
    for (id obj in objects) {
        block(obj);
    }
}

//循环给label设置属性的简写
#define EACH_LABEL(ATTR, VALUE) each_object(self.labels, ^(UILabel * label){label.ATTR = VALUE;});


@interface CMAutoScrollLabel ()

/**
 *  所有的标签的数组
 **/
@property (nonatomic, strong) NSArray *labels;

/**
 *  主要的一个标签
 **/
@property (nonatomic, strong, readonly) UILabel *mainLabel;


/**
 *  滚动框
 **/
@property (nonatomic, weak) UIScrollView *scrollView;

@end

@implementation CMAutoScrollLabel

#pragma 继承父类方法

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialization];
    }
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initialization];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}


#pragma mark - Setter 方法

- (void) setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    [self refreshLabels];
    [self applyGradientMaskForFadeLength:self.fadeLength enableFade:self.scrolling];
}

- (void) setText:(NSString *)text
{
    [self setText:text needRefreshLabels:YES];
}

- (void) setAttributedText:(NSAttributedString *)attributedText
{
    [self setAttributedText:attributedText needRefreshLabels:YES];
}

- (void) setFadeLength:(CGFloat)fadeLength
{
    if(_fadeLength != fadeLength){
        _fadeLength = fadeLength;
        [self refreshLabels];
        [self applyGradientMaskForFadeLength:self.fadeLength enableFade:NO];
    }
}


- (void) setTextColor:(UIColor *)textColor
{
    EACH_LABEL(textColor, textColor);
}

- (void) setTextFont:(UIFont *)textFont
{
    EACH_LABEL(font, textFont);
}

- (void) setScrollDeriction:(CMAutoScrollDirection)scrollDeriction
{
    _scrollDeriction = scrollDeriction;
    [self scrollLabelIfNeeded];
}

- (void) setScrollSpeed:(float)scrollSpeed
{
    _scrollSpeed = scrollSpeed;
    [self scrollLabelIfNeeded];
}

- (void) setShadowColor:(UIColor *)shadowColor
{
    EACH_LABEL(shadowColor, shadowColor);
}

- (void) setShadowOffset:(CGSize)shadowOffset
{
    EACH_LABEL(shadowOffset, shadowOffset);
}

#pragma mark - Getter 方法


- (UILabel *) mainLabel
{
    if(_labels && _labels.count > 0){
        return _labels[0];
    }
    return nil;
}

- (NSString *) text
{
    if(self.mainLabel)
    {
        return self.mainLabel.text;
    }
    return nil;
}


- (NSAttributedString *) attributedText
{
    if(self.mainLabel)
    {
        return self.mainLabel.attributedText;
    }
    return nil;
}


- (UIColor *) textColor
{
    if(self.mainLabel)
    {
        return self.mainLabel.textColor;
    }
    return nil;
}


- (UIFont *) textFont
{
    if(self.mainLabel)
    {
        return self.mainLabel.font;
    }
    return nil;
}


- (UIColor *) shadowColor
{
    if(self.mainLabel)
    {
        return self.mainLabel.shadowColor;
    }
    return nil;
}


- (CGSize) shadowOffset
{
    if(self.mainLabel)
    {
        return self.mainLabel.shadowOffset;
    }
    return CGSizeZero;
}


/**
 *  scrollView的getter方法
 **/
- (UIScrollView *) scrollView
{
    if(!_scrollView){
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        scrollView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        scrollView.backgroundColor = [UIColor clearColor];
        
        [self addSubview:scrollView];
        _scrollView = scrollView;
    }
    
    return _scrollView;
}


#pragma mark - 自定义方法


/**
 *  初始化方法
 **/
- (void) initialization
{
    NSMutableSet *labelsSet = [[NSMutableSet alloc] initWithCapacity:kLabelCount];
    for (int i = 0; i < kLabelCount; ++i) {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.autoresizingMask = self.autoresizingMask;
        [self.scrollView addSubview:label];
        [labelsSet addObject:label];
    }
    
    self.labels = [[labelsSet allObjects] copy];
    
    //设置默认值
    _scrollDeriction = CMAutoScrollDirectionLeft;
    _scrollSpeed = kDefaultPixelsPerSecond;
    self.pauseInterval = kDefaultPauseTime;
    self.spaceBetweenLabels = kDefaultspaceBetweenLabels;
    self.textAlignment = NSTextAlignmentLeft;
    //匀速，平稳动画
    self.animationOptions = UIViewAnimationCurveLinear;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.scrollEnabled = NO;
    self.userInteractionEnabled = NO;
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds = YES;
    self.fadeLength = kDefaultFadeLength;
}


/**
 *  设置文本的文字，是否同时更新所有 的label;
 *  @param  text    文本文字
 *  @param  refresh 是否更新
 **/
- (void) setText:(NSString *)text needRefreshLabels:(BOOL)refresh
{
    if([text isEqualToString:self.text]) {
        return;
    }
    EACH_LABEL(text, text)
    if(refresh) {
        [self refreshLabels];
    }
}


/**
 *  设置文本的文字，是否同时更新所有 的label;
 *  @param  attributedText 文本文字
 *  @param  refresh        是否更新
 **/
- (void) setAttributedText:(NSAttributedString *)attributedText needRefreshLabels:(BOOL)refresh
{
    if([attributedText.string isEqualToString:self.attributedText.string])
    {
        return;
    }
    EACH_LABEL(attributedText, attributedText);
    if (refresh) {
        [self refreshLabels];
    }
}


/**
 *  刷新所有的标签
 **/
- (void) refreshLabels
{
    __block float offsetX = 0;
    each_object(self.labels, ^(UILabel *label) {
        [label sizeToFit];
        CGRect frame = label.frame;
        frame.origin = CGPointMake(offsetX, 0);
        frame.size.height = CGRectGetHeight(self.bounds);
        label.frame= frame;
        label.center = CGPointMake(label.center.x, roundf(self.center.y - CGRectGetMinY(self.frame)));
        offsetX += CGRectGetWidth(label.bounds) + self.spaceBetweenLabels;
    });
    
    self.scrollView.contentOffset = CGPointZero;
    [self.scrollView.layer removeAllAnimations];
    
    //如果文本的长度大于label的长度，就要滚动
    if(CGRectGetWidth(self.mainLabel.frame) > CGRectGetWidth(self.bounds)){
        CGSize size;
        size.width = CGRectGetWidth(self.mainLabel.frame) + self.spaceBetweenLabels + CGRectGetWidth(self.bounds);
        size.height = CGRectGetHeight(self.bounds);
        self.scrollView.contentSize = size;
        EACH_LABEL(hidden, NO)
        [self applyGradientMaskForFadeLength : self.fadeLength enableFade : self.scrolling];
        [self scrollLabelIfNeeded];
    }else{
        EACH_LABEL(hidden, (self.mainLabel != label))
        self.scrollView.contentSize = self.bounds.size;
        self.mainLabel.frame = self.bounds;
        self.mainLabel.textAlignment = NSTextAlignmentLeft;
        self.mainLabel.hidden = NO;
        [self.scrollView.layer removeAllAnimations];
        [self applyGradientMaskForFadeLength:0 enableFade:NO];
    }
    
}


/**
 *  有必要的话，开始滚动标签
 **/
- (void) scrollLabelIfNeeded
{
    if(!self.text.length && !self.attributedText.string.length){
        return;
    }

    CGFloat labelWidth = CGRectGetWidth(self.mainLabel.bounds);
    if(labelWidth <= CGRectGetWidth(self.bounds)){
        return;
    }
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(scrollLabelIfNeeded) object:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(enableShadow) object:nil];
    
    [self.scrollView.layer removeAllAnimations];
    
    BOOL doScrollLeft = (self.scrollDeriction = CMAutoScrollDirectionLeft);
    
    self.scrollView.contentOffset = doScrollLeft ? CGPointZero : CGPointMake(labelWidth + self.spaceBetweenLabels, 0);
 
    // Add the left shadow after delay
    [self performSelector:@selector(enableShadow) withObject:nil afterDelay:self.pauseInterval];
    
    //开始滚动
    NSTimeInterval duration = labelWidth / self.scrollSpeed;
    [UIView animateWithDuration:duration
                          delay:self.pauseInterval
                        options:(self.animationOptions | UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         self.scrollView.contentOffset = doScrollLeft ? CGPointMake(labelWidth + self.spaceBetweenLabels, 0) : CGPointZero;
                     }
                     completion:^(BOOL finished) {
                         _scrolling = NO;
                         [self applyGradientMaskForFadeLength:self.fadeLength enableFade:NO];
                         if(finished){
                             [self performSelector:@selector(scrollLabelIfNeeded) withObject:nil];
                         }
                     }];
}



/**
 *  添加应用的通知监听
 **/
- (void) observeApplicationNotifacations
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(scrollLabelIfNeeded)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(scrollLabelIfNeeded)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onUIApplicationDidChangeStatusBarOrientationNotification:)
                                                 name:UIApplicationDidChangeStatusBarOrientationNotification
                                               object:nil];
}


/**
 *  私有方法，添加阴影
 **/
- (void) enableShadow {
    _scrolling = YES;
    [self applyGradientMaskForFadeLength:self.fadeLength enableFade:YES];
}


#pragma mark - Gradient

// ref: https://github.com/cbpowell/MarqueeLabel
- (void)applyGradientMaskForFadeLength:(CGFloat)fadeLength enableFade:(BOOL)fade
{
}



#pragma mark - Notifications

- (void)onUIApplicationDidChangeStatusBarOrientationNotification:(NSNotification *)notification {
    // delay to have it re-calculate on next runloop
    [self performSelector:@selector(refreshLabels) withObject:nil afterDelay:.1f];
    [self performSelector:@selector(scrollLabelIfNeeded) withObject:nil afterDelay:.1f];
}

@end
