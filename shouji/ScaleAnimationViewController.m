//
//  ScaleAnimationViewController.m
//  shouji
//
//  Created by 常敏 on 15-5-13.
//  Copyright (c) 2015年 cm. All rights reserved.
//

#import "ScaleAnimationViewController.h"

@interface ScaleAnimationViewController ()

@property (weak, nonatomic) IBOutlet UIView* mScaleAnimationView;

@end

@implementation ScaleAnimationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:1
                     animations:^{
                         weakSelf.mScaleAnimationView.transform = CGAffineTransformMakeScale(2.0, 2.0);
                     }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
