//
//  NewsExmViewController.m
//  shouji
//  新闻页面
//  Created by 常敏 on 15-3-27.
//  Copyright (c) 2015年 cm. All rights reserved.
//

#import "NewsExmViewController.h"
#import "SCNavTabBarController.h"
#import "YALExmViewController.h"

@interface NewsExmViewController ()

@end

@implementation NewsExmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNewsControlers];
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

#pragma mark - init

- (void) initNewsControlers{
    YALExmViewController *toutiao = [[YALExmViewController alloc] init];
    toutiao.title = @"头条";
    toutiao.view.backgroundColor = [UIColor redColor];
    
    YALExmViewController *yule = [[YALExmViewController alloc] init];
    yule.title = @"娱乐";
    yule.view.backgroundColor = [UIColor darkGrayColor];
    
    YALExmViewController *tiyu = [[YALExmViewController alloc] init];
    tiyu.title = @"体育";
    tiyu.view.backgroundColor = [UIColor greenColor];
    
    YALExmViewController *tianjin = [[YALExmViewController alloc] init];
    tianjin.title = @"天津";
    tianjin.view.backgroundColor = [UIColor blackColor];
    
    YALExmViewController *nba = [[YALExmViewController alloc] init];
    nba.title = @"NBA";
    nba.view.backgroundColor = [UIColor blueColor];
    
    YALExmViewController *cba = [[YALExmViewController alloc] init];
    cba.title = @"CBA";
    cba.view.backgroundColor = [UIColor yellowColor];
    
    YALExmViewController *caijing = [[YALExmViewController alloc] init];
    caijing.title = @"财经";
    caijing.view.backgroundColor = [UIColor purpleColor];
    
    YALExmViewController *duanzi = [[YALExmViewController alloc] init];
    duanzi.title = @"段子";
    duanzi.view.backgroundColor = [UIColor orangeColor];
    
    YALExmViewController *keji = [[YALExmViewController alloc] init];
    keji.title = @"科技";
    keji.view.backgroundColor = [UIColor whiteColor];
    
    YALExmViewController *qiche = [[YALExmViewController alloc] init];
    qiche.title = @"汽车";
    qiche.view.backgroundColor = [UIColor blackColor];
    
    
    SCNavTabBarController *navController = [[SCNavTabBarController alloc] init];
    navController.subViewControllers = @[toutiao, yule, tiyu, tianjin, nba, cba, caijing, duanzi, keji, qiche];
    navController.canPopAllItemMenu = YES;
    navController.mainViewBounces = YES;
    [navController addParentController:self];
    
}

@end
