//
//  TimePickerExmViewController.h
//  shouji
//
//  Created by 常敏 on 15-4-2.
//  Copyright (c) 2015年 cm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMTimePickerViewController.h"

@interface TimePickerExmViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *timeSelecter;

@property (strong, nonatomic) CMTimePickerViewController *timePicker;

@end
