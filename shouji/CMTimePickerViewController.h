//
//  CMTimePickerViewController.h
//  shouji
//
//  Created by 常敏 on 15-4-2.
//  Copyright (c) 2015年 cm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+KNSemiModal.h"

@class CMTimePickerViewController;

/**
 *  委托类
 **/
@protocol CMTimePickerViewControllerDelegate <NSObject>

- (void)timePickerBtnPressed:(CMTimePickerViewController *)timePicker withDate:(NSDate *)date;

@end


@interface CMTimePickerViewController : UIViewController


#pragma mark - 成员变量

/**
 * 视图大小
 **/
@property (nonatomic, assign) CGSize viewSize;


/**
 *  时间
 **/
@property (nonatomic, strong) NSDate *date;


/**
 *  委托类
 **/
@property (nonatomic, strong) id<CMTimePickerViewControllerDelegate> delegate;

#pragma mark - 静态方法

/**
 *  静态的方法，得到实例
 *  @param  大小
 **/
+ (CMTimePickerViewController *)timePickerWithFrame:(CGSize)size;

@end
