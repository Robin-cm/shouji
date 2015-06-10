//
//  CMCyclePageView.h
//  shouji
//
//  Created by 常敏 on 15-3-31.
//  Copyright (c) 2015年 cm. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 *  页码显示的位置(小圆点的位置)
 **/
typedef enum {
    CMCyclePageViewPageControlAlignmentLeft,
    CMCyclePageViewPageControlAlignmentCenter,
    CMCyclePageViewPageControlAlignmentRight
}CMCyclePageViewPageControlAlignment;


@class CMCyclePageView;

/**
 *  幻灯片的委托类
 **/
@protocol CMCyclePageViewDelegate <NSObject>

#pragma mark - 委托方法
/**
 *  点击某张图片
 *  @param  pageView
 *  @param  index       图片的序号
 **/
- (void) cyclePageView:(CMCyclePageView *)pageView didSelectItemAtIndex:(NSInteger)index;

@end

@interface CMCyclePageView : UIView

#pragma mark - 成员变量

/**
 *  所有的图片的数组
 **/
@property (nonatomic, strong) NSArray *images;

/**
 *  所有的标题的数组
 **/
@property (nonatomic, strong) NSArray *titles;

/**
 *  自动切换下一张图片的时间，单位是 秒  S
 **/
@property (nonatomic, assign) CGFloat autoScrollTimeInterval;

/**
 *  页码显示的位置(小圆点的位置)
 **/
@property (nonatomic, assign) CMCyclePageViewPageControlAlignment pageControlAlignment;


/**
 *  委托类
 **/
@property (nonatomic, weak) id<CMCyclePageViewDelegate> delegate;

#pragma mark - 静态方法

/**
 *  初始化幻灯片
 *  @param  frame       尺寸
 *  @param  images      所有的图片的数组
 **/
+ (instancetype) cmCyclePageViewWithFrame:(CGRect)frame withImages:(NSArray *)images;

/**
 *  初始化幻灯片
 *  @param  frame       尺寸
 *  @param  images      所有的图片的数组
 *  @param  titles      所有的图片的标题
 **/
+ (instancetype) cmCyclePageViewWithFrame:(CGRect)frame withImages:(NSArray *)images withTitles:(NSArray *)titles;

#pragma mark - 实例方法

@end
