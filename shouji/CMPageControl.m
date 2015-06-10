//
//  CMPageControl.m
//  shouji
//  页面控件
//  Created by 常敏 on 15-3-31.
//  Copyright (c) 2015年 cm. All rights reserved.
//

#import "CMPageControl.h"
#import "CMAnimatedDotView.h"


/**
 *  默认的页数的总数
 */
static NSInteger const kDefaultCountOfPages = 0;

/**
 *  默认的当前的页码
 */
static NSInteger const kDefaultCurrentPage = 0;

/**
 *  单页面的时候，是不是隐藏
 */
static BOOL const kDefaultHideForSinglePage = NO;

/**
 *  是否能resize
 */
static BOOL const kDefaultShouldResizeFromCenter = YES;

/**
 *  默认的点和点之间的距离
 */
static NSInteger const kDefaultSpacingBetweenDots = 8;

/**
 *  默认的点得大小
 */
static CGSize const kDefaultDotSize = {8, 8};


@interface CMPageControl()

/**
 *  Array of dot views for reusability and touch events.
 *  点的数组
 */
@property (strong, nonatomic) NSMutableArray *dots;

@end



@implementation CMPageControl

#pragma mark - 声明周期

- (instancetype)init
{
    self = [super init];
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

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initialization];
    }
    return self;
}


#pragma mark - Setter 和 Getter 方法

/**
 *  设置页面的个数
 **/
- (void) setCountOfPages:(NSInteger)countOfPages {
    _countOfPages = countOfPages;
    [self resetDotViews];
}


/**
 *  设置点和点之间的间隙
 **/
- (void) setSpaceBetweenDots:(NSInteger)spaceBetweenDots {
    _spaceBetweenDots = spaceBetweenDots;
    [self resetDotViews];
}


/**
 *  设置当前的选中的页数
 **/
- (void) setCurrentPage:(NSInteger)currentPage {
    if(self.dots.count == 0 || _currentPage == currentPage){
        _currentPage = currentPage;
        return;
    }
    [self changeActivity:NO atIndex:_currentPage];
    _currentPage = currentPage;
    [self changeActivity:YES atIndex:_currentPage];
}


/**
 *  设置点视图的渲染类
 **/
- (void) setDotViewClass:(Class)dotViewClass {
    _dotViewClass = dotViewClass;
    self.dotSize = CGSizeZero;
    [self resetDotViews];
}

/**
 *  设置选中的图片
 **/
- (void) setCurrentDotImage:(UIImage *)currentDotImage {
    _currentDotImage = currentDotImage;
    self.dotViewClass = nil;
    [self resetDotViews];
}

/**
 *  选中未选中的图片
 **/
- (void) setDotImage:(UIImage *)dotImage {
    _dotImage = dotImage;
    self.dotViewClass = nil;
    [self resetDotViews];
}


/**
 *  dots的GET方法
 **/
- (NSMutableArray *) dots {
    if(!_dots){
        _dots = [[NSMutableArray alloc] init];
    }
    return _dots;
}


/**
 *  dotSize的GET方法
 **/
- (CGSize) dotSize {
    if(self.dotImage && CGSizeEqualToSize(_dotSize, CGSizeZero)){
        _dotSize = self.dotImage.size;
    }else if (self.dotViewClass && CGSizeEqualToSize(_dotSize, CGSizeZero)){
        _dotSize = kDefaultDotSize;
    }
    return _dotSize;
}


#pragma mark - 继承父类

- (void) sizeToFit {
    [self updateFrame:true];
}


#pragma mark - 自定义实例方法

- (void) initialization {
    self.dotViewClass = [CMAnimatedDotView class];
    self.spaceBetweenDots     = kDefaultSpacingBetweenDots;
    self.countOfPages          = kDefaultCountOfPages;
    self.currentPage            = kDefaultCurrentPage;
    self.hideForSinglePage     = kDefaultHideForSinglePage;
    self.shouldResizeFromCenter = kDefaultShouldResizeFromCenter;
}


/**
 *  重置所有的点视图
 **/
- (void) resetDotViews {
    for (UIView *dotView in self.dots) {
        [dotView removeFromSuperview];
    }
    [self.dots removeAllObjects];
    [self updateDots];
}


/**
 *  更新点视图
 **/
- (void) updateDots {
    if(self.countOfPages <= 0){
        return;
    }
    for (NSInteger i = 0; i < self.countOfPages; i++) {
        UIView *dot;
        if(i < self.dots.count){
            dot = [self.dots objectAtIndex:i];
        }else{
            dot = [self generateDotView];
        }
        [self updateDotFrame:dot atIndex:i];
    }
    
    [self changeActivity:YES atIndex:self.currentPage];
 
    [self hidesForSinglePage];
}


/**
 *  生成一个点视图
 **/
- (UIView *) generateDotView {
    UIView *dotView;
    if(self.dotViewClass){
        dotView = [[self.dotViewClass alloc] initWithFrame:CGRectMake(0, 0, self.dotSize.width, self.dotSize.height)];
    }else{
        dotView = [[UIImageView alloc] initWithImage:self.dotImage];
        dotView.frame = CGRectMake(0.f, 0.f, self.dotSize.width, self.dotSize.height);
    }
    
    if(dotView){
        [self addSubview:dotView];
        [self.dots addObject:dotView];
    }
    
    dotView.userInteractionEnabled = YES;
    
    return dotView;
}


/**
 *  更新第一几个点的大小
 **/
- (void) updateDotFrame:(UIView *)dot atIndex:(NSInteger)index{
    CGFloat x = (self.dotSize.width + self.spaceBetweenDots) * index + (CGRectGetWidth(self.frame) - [self sizeWithPages:self.countOfPages].width) / 2;
    CGFloat y = (CGRectGetHeight(self.frame) - self.dotSize.height) / 2;
    dot.frame = CGRectMake(x, y, self.dotSize.width, self.dotSize.height);
}


/**
 *  所有的小圆点的大小
 **/
- (CGSize) sizeWithPages:(NSInteger)pageCount {
    return CGSizeMake((self.dotSize.width + self.spaceBetweenDots) * pageCount - self.spaceBetweenDots, self.dotSize.height);
}


/**
 *  改变圆点的状态
 **/
- (void) changeActivity:(BOOL)activity atIndex:(NSInteger)index {
    if(self.dotViewClass){
        CMAbstractDotView *abstractDotView = (CMAbstractDotView *)[self.dots objectAtIndex:index];
        if([abstractDotView respondsToSelector:@selector(changeActivityState:)]){
            [abstractDotView changeActivityState:activity];
        }else{
            NSLog(@"Custom view : %@ must implement an 'changeActivityState' method or you can subclass %@ to help you.", self.dotViewClass, [CMAbstractDotView class]);
        }
    }else if(self.currentDotImage && self.dotImage){
        UIImageView *dotImage = (UIImageView *)[self.dots objectAtIndex:index];
        dotImage.image = activity ? self.currentDotImage : self.dotImage;
    }
}


/**
 *  隐藏只有一个item的
 **/
- (void) hidesForSinglePage {
    if(self.dots.count <= 1 && self.hideForSinglePage){
        self.hidden = YES;
    }else{
        self.hidden = NO;
    }
}


/**
 *  更新视图
 *
 **/
- (void)updateFrame:(BOOL)overrideExistingFrame {
    CGPoint center = self.center;
    CGSize requiredSize = [self sizeWithPages:self.countOfPages];
    if(overrideExistingFrame || ((CGRectGetWidth(self.frame) < requiredSize.width || CGRectGetHeight(self.frame) < requiredSize.height) && !overrideExistingFrame)){
        self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), requiredSize.width, requiredSize.height);
        if (self.shouldResizeFromCenter) {
            self.center = center;
        }
    }
    [self resetDotViews];
}


@end
