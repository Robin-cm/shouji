//
//  CMAutoScrollLabel.h
//  shouji
//  可以自动滚动的标签
//  Created by 常敏 on 15-4-3.
//  Copyright (c) 2015年 cm. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 *  滚动方向的枚举类，向左或者向右滚动
 **/
typedef enum
{
    CMAutoScrollDirectionLeft,
    CMAutoScrollDirectionRight
}CMAutoScrollDirection;


@interface CMAutoScrollLabel : UIView <UIScrollViewDelegate>

#pragma mark - 成员变量，属性 ---- 滚动相关属性

/**
 *  滚动的方向
 **/
@property (nonatomic) CMAutoScrollDirection scrollDeriction;


/**
 *  滚动的速度,每秒滚动的像素
 **/
@property (nonatomic) float scrollSpeed;


/**
 * 中间暂停的时间
 **/
@property (nonatomic) NSTimeInterval pauseInterval;


/**
 *  两个标签之间的距离,像素
 **/
@property (nonatomic) NSInteger spaceBetweenLabels;


/**
 *
 **/
@property (nonatomic) UIViewAnimationOptions animationOptions;


/**
 *  只读属性，得到当前的label是否正在滚动的属性
 **/
@property (nonatomic, readonly) BOOL scrolling;


/**
 *
 **/
@property (nonatomic) CGFloat fadeLength;


#pragma mark - 成员变量，属性 ---- UILabel的相关属性

/**
 *  显示的文字
 **/
@property (nonatomic, copy) NSString *text;


/**
 *  设置属性的文字
 **/
@property (nonatomic, copy) NSAttributedString *attributedText;


/**
 *  文字显示的颜色
 **/
@property (nonatomic, strong) UIColor *textColor;


/**
 *  文字显示的样式
 ***/
@property (nonatomic, strong) UIFont *textFont;


/**
 *  阴影的颜色
 **/
@property (nonatomic, strong) UIColor *shadowColor;


/**
 *  阴影的位置，大小
 **/
@property (nonatomic) CGSize shadowOffset;


/**
 *  文本的对其方式
 **/
@property (nonatomic) NSTextAlignment textAlignment;


#pragma mark - 实例方法


/**
 *  刷新所有的标签
 **/
- (void) refreshLabels;


/**
 *  有必要的话，开始滚动标签
 **/
- (void) scrollLabelIfNeeded;


/**
 *  设置文本的文字，是否同时更新所有 的label;
 *  @param  text    文本文字
 *  @param  refresh 是否更新
 **/
- (void) setText:(NSString *)text needRefreshLabels:(BOOL)refresh;


/**
 *  设置文本的文字，是否同时更新所有 的label;
 *  @param  attributedText 文本文字
 *  @param  refresh        是否更新
 **/
- (void) setAttributedText:(NSAttributedString *)attributedText needRefreshLabels:(BOOL)refresh;


/**
 *  添加应用的通知监听
 **/
- (void) observeApplicationNotifacations;


@end
