//
//  CalenderViewController.h
//  shouji
//
//  Created by 常敏 on 15-4-1.
//  Copyright (c) 2015年 cm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THDatePickerViewController.h"

@interface CalenderViewController : UIViewController <THDatePickerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *dataSelector;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (strong, nonatomic) THDatePickerViewController *datePicker;

@end
