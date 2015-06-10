//
//  CMTimePickerToolBar.h
//  shouji
//
//  Created by 常敏 on 15-4-2.
//  Copyright (c) 2015年 cm. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  点击的按钮的类型
 **/
typedef enum{
    CMTimePickerToolBarButtonTypeCancel,
    CMTimePickerToolBarButtonTypeOK
}CMTimePickerToolBarButtonType;

/**
 *  委托类
 ***/
@protocol CMTimePickerToolBarDelegate <NSObject>

- (void) timePickerToolBarDidBtnSelectedWithType:(CMTimePickerToolBarButtonType)type;

@end


@interface CMTimePickerToolBar : UIView

#pragma mark - 成员变量

/**
 *  显示的标题
 **/
@property (nonatomic, strong) NSString *title;


/**
 *  大小
 **/
@property (nonatomic) CGSize size;


/**
 *  委托类
 **/
@property (nonatomic, strong) id<CMTimePickerToolBarDelegate> delegate;


#pragma mark - 静态方法

+ (instancetype) toolBarWithSize:(CGSize)size;

+ (instancetype) toolBarWithSize:(CGSize)size setTitle:(NSString *)title;

/**
 *  得到工具条的高度
 **/
+ (CGFloat) toolBarGetHeight;

#pragma mark - 设置时间

- (void) setDate:(NSDate *)date;

@end
