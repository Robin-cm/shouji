//
//  SDCycleScrollViewController.m
//  shouji
//  幻灯播放
//  Created by 常敏 on 15-3-30.
//  Copyright (c) 2015年 cm. All rights reserved.
//

#import "SDCycleScrollViewController.h"
#import "CMCyclePageView.h"

@interface SDCycleScrollViewController ()

@end

@implementation SDCycleScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) initView {
    self.view.backgroundColor = [UIColor colorWithHue:0.98 saturation:0.98 brightness:0.98 alpha:0.99];
    
    NSArray *images = @[[UIImage imageNamed:@"h1.jpg"], [UIImage imageNamed:@"h2.jpg"], [UIImage imageNamed:@"h3.jpg"], [UIImage imageNamed:@"h4.jpg"]];
    
    NSArray *titles = @[@"这是第一张图片", @"这是第二张图片，好", @"这是第三章图片，很好", @"这是第四章图片，非常好"];
    
    
    CGFloat screenWidth = self.view.bounds.size.width;
    
    CGFloat imageHeight = screenWidth * 220 / 338;
    
    CMCyclePageView *cycleView = [CMCyclePageView cmCyclePageViewWithFrame:CGRectMake(0.f, 50.f, screenWidth, imageHeight) withImages:images];
    cycleView.autoScrollTimeInterval = 2.0;
    cycleView.titles = titles;
    [self.view addSubview:cycleView];
    
}

@end
