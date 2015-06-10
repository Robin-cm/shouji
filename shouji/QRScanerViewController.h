//
//  QRScanerViewController.h
//  shouji
//  二维码扫描
//  Created by 常敏 on 15-4-30.
//  Copyright (c) 2015年 cm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"

@protocol ScanCodeViewDelegate <NSObject>

- (void)finishRead:(NSString*)barCode;

@end

@interface QRScanerViewController : UIViewController <ZBarReaderViewDelegate> {
    //    id<ScanCodeViewDelegate> delegate;
    UIImageView* lineView;
}

/**
 *  扫描视图
 */
@property (nonatomic) ZBarReaderView* readerView;

/**
 *  扫描的代理类
 */
@property (assign, nonatomic) id<ScanCodeViewDelegate> delegate;

@end
