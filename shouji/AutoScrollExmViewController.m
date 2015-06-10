//
//  AutoScrollExmViewController.m
//  shouji
//  可滚动的标签
//  Created by 常敏 on 15-4-2.
//  Copyright (c) 2015年 cm. All rights reserved.
//

#import "AutoScrollExmViewController.h"
#import "CBAutoScrollLabel/CBAutoScrollLabel.h"

#define SCREEN_WIDTH                    ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT                   ([UIScreen mainScreen].bounds.size.height)

@interface AutoScrollExmViewController ()

@property (nonatomic, weak) CBAutoScrollLabel *scrollLabel;

@end

@implementation AutoScrollExmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initScrollLabel];
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

- (void) initScrollLabel
{

    CBAutoScrollLabel *scrollLabel = [[CBAutoScrollLabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    self.navigationItem.titleView = scrollLabel;
    scrollLabel.text = @"This text may be clipped, but now it will be scrolled.";
    scrollLabel.textColor = [UIColor whiteColor];
    scrollLabel.labelSpacing = 35; // distance between start and end labels
    scrollLabel.pauseInterval = 3.7; // seconds of pause before scrolling starts again
    scrollLabel.scrollSpeed = 30; // pixels per second
    scrollLabel.textAlignment = NSTextAlignmentCenter; // centers text when no auto-scrolling is applied
    scrollLabel.fadeLength = 2.f; // length of the left and right edge fade, 0 to disable
}

@end
