//
//  CMCyclePageView.m
//  shouji
//  滚动幻灯片视图
//  Created by 常敏 on 15-3-31.
//  Copyright (c) 2015年 cm. All rights reserved.
//

#import "CMCyclePageView.h"
#import "CMCollectionViewCell.h"
#import "UIView+CMExtention.h"
#import "CMPageControl.h"
#import "CMDotVIew.h"
#import "CMAnimatedDotView.h"

//默认的时间
const CGFloat DEDAULT_TIME_INTERVAL = 1.0f;

//默认的cell标示符
NSString * const CELL_IDENTIFIER = @"cycle_cell";

@interface CMCyclePageView () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

//CollectionView
@property (nonatomic, weak) UICollectionView *mainCollectionView;

//FlowLayout
@property (nonatomic, weak) UICollectionViewFlowLayout *flowLayout;

//计时器
@property (nonatomic, strong) NSTimer *timer;

//图片的总得个数
@property (nonatomic, assign) NSInteger totalItemsCount;

//页面切换容器
@property (nonatomic, weak) CMPageControl *pageControl;

@end

@implementation CMCyclePageView

#pragma mark - 静态方法

/**
 *  初始化幻灯片
 *  @param  frame       尺寸
 *  @param  images      所有的图片的数组
 **/
+ (instancetype) cmCyclePageViewWithFrame:(CGRect)frame withImages:(NSArray *)images{
    CMCyclePageView *cmCyclePageView = [[self alloc] initWithFrame:frame];
    cmCyclePageView.images = images;
    return cmCyclePageView;
}

/**
 *  初始化幻灯片
 *  @param  frame       尺寸
 *  @param  images      所有的图片的数组
 *  @param  titles      所有的图片的标题
 **/
+ (instancetype) cmCyclePageViewWithFrame:(CGRect)frame withImages:(NSArray *)images withTitles:(NSArray *)titles{
    CMCyclePageView *cmCyclePageView = [[self alloc] initWithFrame:frame];
    cmCyclePageView.images = images;
    cmCyclePageView.titles = titles;
    return cmCyclePageView;
}

#pragma mark - Setter 和 Getter方法

- (void) setAutoScrollTimeInterval:(CGFloat)autoScrollTimeInterval {
    _autoScrollTimeInterval = autoScrollTimeInterval;
    
    [_timer invalidate];
    _timer = nil;
    [self initTimer];
}

- (void) setImages:(NSArray *)images {
    _images = images;
    _totalItemsCount = _images.count * 100;
    
    [self initTimer];
    [self initPageControl];
}

#pragma mark - 父类方法


- (void) setFrame:(CGRect)frame {
    [super setFrame:frame];
    _flowLayout.itemSize = self.frame.size;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.pageControlAlignment = CMCyclePageViewPageControlAlignmentCenter;
        _autoScrollTimeInterval = DEDAULT_TIME_INTERVAL;
        [self initMainView];
    }
    return self;
}


- (void) layoutSubviews {
    [super layoutSubviews];
    
    _mainCollectionView.frame = self.bounds;
    
    if (_mainCollectionView.contentOffset.x == 0) {
        [_mainCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_totalItemsCount * 0.5 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    
    CGSize size = [_pageControl sizeWithPages:self.images.count];
    CGFloat x;
    
    if(self.pageControlAlignment == CMCyclePageViewPageControlAlignmentLeft){
        x = 10;
    }else if (self.pageControlAlignment == CMCyclePageViewPageControlAlignmentRight) {
        x = self.cm_width - size.width - 10;
    }else if (self.pageControlAlignment == CMCyclePageViewPageControlAlignmentCenter){
        x = (self.cm_width - size.width) / 2;
    }
    
    CGFloat y = self.cm_height - size.height - 10;
    
    _pageControl.frame = CGRectMake(x, y, size.width, size.height);
    [_pageControl sizeToFit];
    
}


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _totalItemsCount;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CMCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
    long itemIndex = indexPath.item % _images.count;
    cell.imageView.image = _images[itemIndex];
    if(_titles.count > 0){
        [cell setTitle:_titles[itemIndex]];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if([self.delegate respondsToSelector:@selector(cyclePageView: didSelectItemAtIndex:)]){
        [self.delegate cyclePageView:self didSelectItemAtIndex:indexPath.item % _images.count];
    }
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    return nil;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.frame.size.width, self.frame.size.height);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeZero;
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int itemIndex = (scrollView.contentOffset.x + self.mainCollectionView.cm_width * 0.5) / self.mainCollectionView.cm_width;
    int indexOnPageControl = itemIndex % self.images.count;
    _pageControl.currentPage = indexOnPageControl;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_timer invalidate];
    _timer = nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self initTimer];
}


#pragma mark - 实例方法

/**
 *  初始化视图
 **/
- (void) initMainView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = self.frame.size;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    [flowLayout setSectionInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    _flowLayout = flowLayout;

    
    UICollectionView *mainCollectionView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:flowLayout];
    mainCollectionView.backgroundColor = [UIColor blackColor];
    mainCollectionView.pagingEnabled = YES;
    mainCollectionView.showsHorizontalScrollIndicator = NO;
    mainCollectionView.showsVerticalScrollIndicator = NO;
    [mainCollectionView registerClass:[CMCollectionViewCell class] forCellWithReuseIdentifier:CELL_IDENTIFIER];
    mainCollectionView.dataSource = self;
    mainCollectionView.delegate = self;
    [self addSubview:mainCollectionView];
    _mainCollectionView = mainCollectionView;
}


/**
 *  初始化计时器
 **/
- (void) initTimer {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollTimeInterval target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    _timer = timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

/**
 *  自动滚动
 **/
- (void) automaticScroll {
    int currentIndex = _mainCollectionView.contentOffset.x / _flowLayout.itemSize.width;
    int nextIndex = currentIndex + 1;
    if(nextIndex == _totalItemsCount){
        nextIndex = _totalItemsCount * 0.5;
        [_mainCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:nextIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    [_mainCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:nextIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}


/**
 *  初始化页面控件
 **/
- (void) initPageControl {
    CMPageControl *pageControl = [[CMPageControl alloc] init];
    pageControl.dotViewClass = [CMAnimatedDotView class];
    pageControl.countOfPages = self.images.count;
    pageControl.dotSize = CGSizeMake(4, 4);
    [self addSubview:pageControl];
    _pageControl = pageControl;
}


@end
