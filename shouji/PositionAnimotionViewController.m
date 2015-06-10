//
//  PositionAnimotionViewController.m
//  shouji
//
//  Created by 常敏 on 15-5-12.
//  Copyright (c) 2015年 cm. All rights reserved.
//

#import "PositionAnimotionViewController.h"

@interface PositionAnimotionViewController ()
/**
 *  红色方块
 */
@property (weak, nonatomic) IBOutlet UIView* mPositionTestView;
/**
 *  绿色方块
 */
@property (strong, nonatomic) IBOutlet UIView* mPositionTestYView;

/**
 *  紫色方块
 */
@property (weak, nonatomic) IBOutlet UIView* mPositionTestXYView;

@end

@implementation PositionAnimotionViewController

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
    [UIView animateWithDuration:1.0f
                     animations:^{
                         CGRect frame = weakSelf.mPositionTestView.frame;
                         frame.origin.x = CGRectGetWidth(weakSelf.view.bounds) - CGRectGetWidth(weakSelf.mPositionTestView.bounds);

                         CGRect yFrame = weakSelf.mPositionTestYView.frame;
                         yFrame.origin.y = CGRectGetHeight(weakSelf.view.bounds) - CGRectGetHeight(weakSelf.mPositionTestYView.bounds);

                         CGRect xyFrame = weakSelf.mPositionTestXYView.frame;
                         xyFrame.origin.x = 0;
                         xyFrame.origin.y = CGRectGetHeight(weakSelf.view.bounds) - CGRectGetHeight(weakSelf.mPositionTestXYView.bounds);

                         weakSelf.mPositionTestView.frame = frame;
                         weakSelf.mPositionTestYView.frame = yFrame;
                         weakSelf.mPositionTestXYView.frame = xyFrame;
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
