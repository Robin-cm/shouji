//
//  TimerLocationManager.h
//  shouji
//
//  Created by 常敏 on 15-4-16.
//  Copyright (c) 2015年 cm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimerLocationManager : NSObject

+ (TimerLocationManager *) timerLocation;


+ (TimerLocationManager *) timerLocationWithTimerInterval:(double)ti;


+ (TimerLocationManager *) timerLocationWithTimerInterval:(double)ti target:(id)target selector:(SEL)aSelector;


+ (TimerLocationManager *) timerLocationWithTimerInterval:(double)ti target:(id)target selector:(SEL)aSelector repeat:(BOOL)repeat;



+ (void) timerStart;


+ (void) timerStop;


+ (void) isActive;

@end
