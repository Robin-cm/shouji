//
//  TimePickerExmViewController.m
//  shouji
//
//  Created by 常敏 on 15-4-2.
//  Copyright (c) 2015年 cm. All rights reserved.
//

#import "TimePickerExmViewController.h"
#import "CMTimePickerViewController.h"


@interface TimePickerExmViewController () <CMTimePickerViewControllerDelegate>



@end

@implementation TimePickerExmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)timeTaped:(id)sender {
    
    
    self.timePicker = [CMTimePickerViewController timePickerWithFrame:CGSizeMake(self.view.bounds.size.width, 200)];
    
    self.timePicker.delegate = self;
    
//    [self presentSemiViewController:self.timePicker withOptions:@{
//                                                                  KNSemiModalOptionKeys.pushParentBack    : @(YES),
//                                                                  KNSemiModalOptionKeys.animationDuration : @(0.3),
//                                                                  KNSemiModalOptionKeys.shadowOpacity     : @(0.1),
//                                                                  }];
   
    [self presentSemiViewController:self.timePicker withOptions:@{
                                                                  KNSemiModalOptionKeys.pushParentBack    : @(YES),
                                                                  KNSemiModalOptionKeys.animationDuration : @(0.3),
                                                                  KNSemiModalOptionKeys.shadowOpacity     : @(0.1),
                                                                  } completion:^{
                                                                      self.timePicker.date = [NSDate date];
                                                                  } dismissBlock:^{
                                                                      
                                                                  }];

}



- (void)timePickerBtnPressed:(CMTimePickerViewController *)timePicker withDate:(NSDate *)date
{
    NSLog(@"得到的时间是：%@", date);
    [self dismissSemiModalView];
}


@end
