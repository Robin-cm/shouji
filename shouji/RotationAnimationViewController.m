//
//  RotationAnimationViewController.m
//  shouji
//
//  Created by 常敏 on 15-5-13.
//  Copyright (c) 2015年 cm. All rights reserved.
//

#import "RotationAnimationViewController.h"

@interface RotationAnimationViewController ()

@property (weak, nonatomic) IBOutlet UIView* mRotationAnimationView;

@end

@implementation RotationAnimationViewController

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

    [self spin];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)spin
{
    __weak typeof(self) weakSelf = self;
    //    [UIView animateWithDuration:1
    //                     animations:^{
    //                         weakSelf.mRotationAnimationView.transform = CGAffineTransformMakeRotation(M_PI);
    //                     }];
    [UIView animateWithDuration:1
        delay:0
        options:UIViewAnimationOptionRepeat | UIViewAnimationOptionCurveLinear
        animations:^{
            weakSelf.mRotationAnimationView.transform = CGAffineTransformRotate(weakSelf.mRotationAnimationView.transform, M_PI);
        }
        completion:^(BOOL finished) {
            [weakSelf spin];
        }];
}

@end
