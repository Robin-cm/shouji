//
//  CMPageControl.h
//  shouji
//
//  Created by 常敏 on 15-3-31.
//  Copyright (c) 2015年 cm. All rights reserved.
//

#import <UIKit/UIKit.h>


@class CMPageControl;

/**
 *  页面控件的委托类
 **/
@protocol CMPageControlDelegate <NSObject>

@optional
- (void)CMPageControl:(CMPageControl *)pageControl didSelectPageAtIndex:(NSInteger)index;

@end

@interface CMPageControl : UIControl

/**
 *  点得视图的CLASS
 **/
@property (nonatomic) Class dotViewClass;


/**
 *  点得图片
 **/
@property (nonatomic) UIImage *dotImage;


/**
 *  当前的点得图片
 **/
@property (nonatomic) UIImage *currentDotImage;


/**
 *  点得大小,默认大小是8X8
 **/
@property (nonatomic) CGSize dotSize;


/**
 *  两点之间的距离，默认是8
 **/
@property (nonatomic) NSInteger spaceBetweenDots;


/**
 *  委托类
 **/
@property (nonatomic, assign) id<CMPageControlDelegate> delegate;


/**
 *  页面的总数，默认是0
 **/
@property (nonatomic) NSInteger countOfPages;


/**
 *  当前的页码,默认是0
 **/
@property (nonatomic) NSInteger currentPage;


/**
 *  只有一个页面时隐藏
 **/
@property (nonatomic) BOOL hideForSinglePage;


/**
 *  Let the control know if should grow bigger by keeping center, or just get longer (right side expanding). By default YES.
 */
@property (nonatomic) BOOL shouldResizeFromCenter;


#pragma mark - 实例方法

/**
 *  Return the minimum size required to display control properly for the given page count.
 *
 *  @param pageCount Number of dots that will require display
 *
 *  @return The CGSize being the minimum size required.
 */
- (CGSize)sizeWithPages:(NSInteger)pageCount;


@end
