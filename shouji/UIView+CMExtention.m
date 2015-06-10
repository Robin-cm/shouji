//
//  UIView+CMExtention.m
//  shouji
//
//  Created by 常敏 on 15-3-31.
//  Copyright (c) 2015年 cm. All rights reserved.
//

#import "UIView+CMExtention.h"

@implementation UIView (CMExtention)


/**
 *  View的高度
 **/
- (CGFloat) cm_height {
    return self.frame.size.height;
}

/**
 *  设置View的高度
 **/
- (void) setCm_height:(CGFloat)cm_height {
    CGRect tmp = self.frame;
    tmp.size.height = cm_height;
    self.frame = tmp;
}

/**
 *  View的宽度
 **/
- (CGFloat) cm_width {
    return self.frame.size.width;
}

/**
 *  设置View的宽度
 **/
- (void) setCm_width:(CGFloat)cm_width {
    CGRect tmp = self.frame;
    tmp.size.width = cm_width;
    self.frame = tmp;
}

/**
 *  View的Y坐标
 **/
- (CGFloat) cm_y {
    return self.frame.origin.y;
}

/**
 *  设置View的Y坐标
 **/
- (void) setCm_y:(CGFloat)cm_y {
    CGRect tmp = self.frame;
    tmp.origin.y = cm_y;
    self.frame = tmp;
}


/**
 *  View的X坐标
 **/
- (CGFloat) cm_x {
    return self.frame.origin.x;
}

/**
 *  设置View的X坐标
 **/
- (void) setCm_x:(CGFloat)cm_x {
    CGRect tmp = self.frame;
    tmp.origin.x = cm_x;
    self.frame = tmp;
}

@end
