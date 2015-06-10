//
//  GestureViewController.m
//  shouji
//
//  Created by 常敏 on 15-3-23.
//  Copyright (c) 2015年 cm. All rights reserved.
//

#import "GestureViewController.h"

@interface GestureViewController ()

@end

@implementation GestureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initGestures];
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


#pragma mark - UIView

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    NSLog(@"现在正在执行的方法是： --  touchesBegan, 参数是： -- %@ ；%@", touches, event);
    NSLog(@"现在正在执行的方法是： --  touchesBegan");
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
//    NSLog(@"现在正在执行的方法是： --  touchesMoved, 参数是： -- %@ ；%@", touches, event);
    NSLog(@"现在正在执行的方法是： --  touchesMoved");
}

-(void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
//    NSLog(@"现在正在执行的方法是： --  touchesCancelled, 参数是： -- %@ ；%@", touches, event);
    NSLog(@"现在正在执行的方法是： --  touchesCancelled");
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
//    NSLog(@"现在正在执行的方法是： --  touchesEnded, 参数是： -- %@ ；%@", touches, event);
    NSLog(@"现在正在执行的方法是： --  touchesEnded");
}

#pragma mark - Function

-(void) initGestures{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureHandler:)];
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tapGesture];
}




-(void) tapGestureHandler:(UITapGestureRecognizer *)recognizer{
    NSLog(@"我点击了一下");
}

@end
