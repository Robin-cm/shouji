//
//  TimerLocationManager.m
//  shouji
//
//  Created by 常敏 on 15-4-16.
//  Copyright (c) 2015年 cm. All rights reserved.
//

#import "TimerLocationManager.h"


@interface TimerLocationManager()


/**
 *  计时器
 **/
@property (nonatomic, strong) NSTimer *currentTimer;


/**
 *  当前的目标
 **/
@property (nonatomic, strong) id currentTarget;


/**
 *  当前的执行方法
 **/
@property (nonatomic) SEL currentSelector;


/**
 *  当前的参数
 **/
@property (nonatomic, strong) id currentUserInfo;


/**
 *  是否重复
 **/
@property (nonatomic, assign) BOOL isRepeat;


/**
 *  当前的重复时间
 **/
@property (nonatomic, assign) double currentTimerInterval;


/**
 *  是不是正在定时任务中
 **/
@property (nonatomic, assign) BOOL isActive;


@end


@implementation TimerLocationManager


/**
 *  得到单个实例
 **/
+ (TimerLocationManager *)sharedInstance
{
    static dispatch_once_t once;
    static TimerLocationManager *sharedInstance;
    dispatch_once(&once, ^ {
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        _currentTarget = self;
        _currentTimerInterval = 5.0;
        _currentSelector = @selector(doTask);
        _currentUserInfo = nil;
        _isActive = NO;
        _isRepeat = YES;
    }
    return self;
}


#pragma mark - SETTER    GETTER


- (BOOL) isActive
{
    return YES;
}


#pragma mark - 实现

+ (TimerLocationManager *) timerLocation
{
    [[self sharedInstance] initTimerWithInterval:-1.0 target:nil selector:nil userInfo:nil repeat:YES];
    return (TimerLocationManager *)self;
}


+ (TimerLocationManager *) timerLocationWithTimerInterval:(double)ti
{
    [[self sharedInstance] initTimerWithInterval:ti target:nil selector:nil userInfo:nil repeat:YES];
    return (TimerLocationManager *)self;
}


+ (TimerLocationManager *) timerLocationWithTimerInterval:(double)ti target:(id)target selector:(SEL)aSelector
{
    [[self sharedInstance] initTimerWithInterval:ti target:target selector:aSelector userInfo:nil repeat:YES];
    return (TimerLocationManager *)self;
}

+ (TimerLocationManager *) timerLocationWithTimerInterval:(double)ti target:(id)target selector:(SEL)aSelector repeat:(BOOL)repeat
{
    [[self sharedInstance] initTimerWithInterval:ti target:target selector:aSelector userInfo:nil repeat:repeat];
    return (TimerLocationManager *)self;
}



+ (void) timerStart
{
    [[self sharedInstance] startTimer];
}


+ (void) timerStop
{
    [[self sharedInstance] stopTimer];
}


#pragma mark - 实例方法


- (void) initTimerWithInterval:(double)ti
                        target:(id)target
                      selector:(SEL)aSelector
                      userInfo:(id)userInfo
                        repeat:(BOOL)repeat
{

    if(ti > 0){
        _currentTimerInterval = ti;
    }
    
    if(target){
        _currentTarget = target;
    }
    
    if(aSelector){
        _currentSelector = aSelector;
    }
    
    if(userInfo){
        _currentUserInfo = userInfo;
    }

    _isRepeat = repeat;

    if(_currentTimer){
        [_currentTimer invalidate];
        _currentTimer = nil;
    }
    
    _currentTimer = [NSTimer timerWithTimeInterval:_currentTimerInterval
                                            target:_currentTarget
                                          selector:_currentSelector
                                          userInfo:_currentUserInfo
                                           repeats:_isRepeat];
    
}



- (void) startTimer
{
    if(!_currentTimer){
        NSLog(@"Timer还没有初始化");
        return;
    }
    [[NSRunLoop currentRunLoop] cancelPerformSelector:@selector(doTimerTask) target:_currentTarget argument:nil];
    [self performSelectorInBackground:@selector(doTimerTask) withObject:nil];
}


- (void) stopTimer
{
    if(_currentTimer){
        [_currentTimer invalidate];
        _currentTimer = nil;
    }
    [[NSRunLoop currentRunLoop] cancelPerformSelector:@selector(doTimerTask) target:self argument:nil];
}


#pragma mark -

- (void) doTimerTask
{
    if(!_currentTimer){
        [[NSRunLoop currentRunLoop] cancelPerformSelector:@selector(doTimerTask) target:self argument:nil];
    }
    @autoreleasepool {
        if(![NSThread isMainThread]){
            [[NSRunLoop currentRunLoop] addTimer:_currentTimer forMode:NSDefaultRunLoopMode];
            [[NSRunLoop currentRunLoop] run];
        }
    }
}


- (void) doTask
{
    if(![NSThread isMainThread]){
        NSLog(@"我呗执行了~~~~~~~");
    }
}


@end
