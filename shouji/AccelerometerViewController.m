//
//  AccelerometerViewController.m
//  shouji
//
//  Created by 常敏 on 15-3-23.
//  Copyright (c) 2015年 cm. All rights reserved.
//

#import "AccelerometerViewController.h"
#import <CoreMotion/CoreMotion.h>
#import "ZBarReaderViewController.h"

@interface AccelerometerViewController () <UIImagePickerControllerDelegate, ZBarReaderDelegate>

@end

@implementation AccelerometerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self initAccelerometer];
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
- (IBAction)gotoScanner:(id)sender {
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    ZBarImageScanner *scanner = reader.scanner;
    [scanner setSymbology:ZBAR_I25 config:ZBAR_CFG_ENABLE to:0];
//    [self presentModalViewController:reader animated:YES];
    [self presentViewController:reader animated:YES completion:nil];
}

- (void) imagePickerController: (UIImagePickerController*) picker didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    UIImage *image = [info objectForKey: UIImagePickerControllerOriginalImage];
    
    id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    
    for(symbol in results)
    {
        break;
    }
    
    if(!symbol || !image)
    {
        return;
    }
    
    NSLog(@"symbol.data = %@", symbol.data);
    
//    [self sendRQcode:symbol.data];
    
    //最关键的移行代码
    //   self.resultLabel.text = symbol.data;
    [picker dismissViewControllerAnimated:YES completion:nil];
//    [picker dismissModalViewControllerAnimated: YES ];
}



-(void) motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if (motion == UIEventSubtypeMotionShake) {
        NSLog(@"摇一摇");
    }
}

#pragma mark - Functions

-(void) initAccelerometer{
    CMMotionManager *cmManager = [[CMMotionManager alloc] init];
    if (!cmManager.accelerometerAvailable) {
        
        NSLog(@"CMMotionManager unavailable");
        
    }else{
        NSLog(@"CMMotionManager available");
    }
    cmManager.accelerometerUpdateInterval =0.1; // 数据更新时间间隔
    
    [cmManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
        double x = accelerometerData.acceleration.x;
        double y = accelerometerData.acceleration.y;
        double z = accelerometerData.acceleration.z;
        
        if (fabs(x)>2.0 ||fabs(y)>2.0 ||fabs(z)>2.0) {
            
            NSLog(@"检测到晃动");
            
        }
        
        NSLog(@"CoreMotionManager, x: %f,y: %f, z: %f",x,y,z);
        
        if (error) {
            NSLog(@"错误是：%@", error);
        }
        
    }];
    
}

@end
