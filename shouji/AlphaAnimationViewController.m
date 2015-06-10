//
//  AlphaAnimationViewController.m
//  shouji
//  透明度动画
//  Created by 常敏 on 15-5-13.
//  Copyright (c) 2015年 cm. All rights reserved.
//

#import "AlphaAnimationViewController.h"

@interface AlphaAnimationViewController ()

/**
 *  透明度变化的视图
 */
@property (weak, nonatomic) IBOutlet UIView* mAlphaAnimationView;

@end

@implementation AlphaAnimationViewController

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
                         weakSelf.mAlphaAnimationView.alpha = 0.1;
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
