//
//  CMAnimatedDotView.m
//  shouji
//
//  Created by 常敏 on 15-3-31.
//  Copyright (c) 2015年 cm. All rights reserved.
//

#import "CMAnimatedDotView.h"

static CGFloat const kAnimateDuration = 1;

@implementation CMAnimatedDotView

#pragma mark - 继承父类方法

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialization];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initialization];
    }
    return self;
}


- (void)changeActivityState:(BOOL)active
{
    if (active) {
        [self animateToActiveState];
    } else {
        [self animateToDeactiveState];
    }
}


#pragma mark - 自定义方法

- (void) initialization{
    self.backgroundColor    = [UIColor clearColor];
    self.layer.cornerRadius = CGRectGetWidth(self.frame) / 2;
    self.layer.borderColor  = [UIColor whiteColor].CGColor;
    self.layer.borderWidth  = 2;
}


- (void) animateToActiveState {
//    [UIView animateWithDuration:kAnimateDuration delay:0 options:<#(UIViewAnimationOptions)#> animations:<#^(void)animations#> completion:<#^(BOOL finished)completion#>]
//    
    [UIView animateWithDuration:kAnimateDuration delay:0 usingSpringWithDamping:5 initialSpringVelocity:-20 options:UIViewAnimationOptionCurveLinear animations:^{
        self.backgroundColor = [UIColor whiteColor];
        self.transform = CGAffineTransformMakeScale(1.4, 1.4);
    } completion:nil];
}



- (void) animateToDeactiveState {
    [UIView animateWithDuration:kAnimateDuration delay:0 usingSpringWithDamping:.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.backgroundColor = [UIColor clearColor];
        self.transform = CGAffineTransformIdentity;
    } completion:nil];
}

@end
