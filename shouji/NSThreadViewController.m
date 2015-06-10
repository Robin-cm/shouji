//
//  NSThreadViewController.m
//  shouji
//
//  Created by 常敏 on 15-5-5.
//  Copyright (c) 2015年 cm. All rights reserved.
//

#import "NSThreadViewController.h"

@interface NSThreadViewController ()
{
    int mTickets;
    int mCount;
    
    BOOL mStopFlag;
    
    NSThread *mTicketThreadOne;
    NSThread *mTicketThreadTwo;
    
    NSThread *mTicketThreadThree;
    
    NSCondition *mConditionLock;
    NSLock *mLock;
}

@end

@implementation NSThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    mTickets = 100;
    mCount = 0;
    mStopFlag = TRUE;
    
    mConditionLock = [[NSCondition alloc] init];
    mLock = [[NSLock alloc] init];
    
    mTicketThreadOne = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
    [mTicketThreadOne setName:@"第一个人：张三"];
    [mTicketThreadOne start];
    
    mTicketThreadTwo = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
    [mTicketThreadTwo setName:@"第二个人：李四"];
    [mTicketThreadTwo start];
    
    
    mTicketThreadThree = [[NSThread alloc] initWithTarget:self selector:@selector(run3) object:nil];
    [mTicketThreadThree setName:@"第三个人：王五"];
    [mTicketThreadThree start];
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

- (void) run3
{
    while (mStopFlag) {
        NSLog(@"停止的标志的值是: %hhd", mStopFlag);
        [mConditionLock lock];
        [NSThread sleepForTimeInterval:0.05];
        [mConditionLock signal];
        [mConditionLock unlock];
    }
    NSLog(@"线程三结束了");
}


- (void) run
{
    while (TRUE) {
        [mConditionLock lock];
        [mConditionLock wait];
        [mLock lock];
        if(mTickets > 0){
//            [NSThread sleepForTimeInterval:0.09];
            mCount = 100 - mTickets;
            NSLog(@"当前票数是:%d,售出:%d,线程名:%@", mTickets, mCount,[[NSThread currentThread] name]);
            mTickets--;
        }else{
            NSLog(@"现在的票已经卖完了@@@@@@@@@@@@@@");
//            mStopFlag = FALSE;
            break;
        }
        [mLock unlock];
        [mConditionLock unlock];
    }
}


@end
