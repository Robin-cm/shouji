//
//  G8ViewController.m
//  shouji
//
//  Created by 常敏 on 15-5-13.
//  Copyright (c) 2015年 cm. All rights reserved.
//

#import "G8ViewController.h"

@interface G8ViewController ()

@property (nonatomic, strong) NSOperationQueue* operationQueue;

@end

@implementation G8ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Create a queue to perform recognition operations
    self.operationQueue = [[NSOperationQueue alloc] init];
}

- (void)didReceiveMemoryWarning
{
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

@end
