//
//  QRScanerViewController.m
//  shouji
//  二维码扫描
//  Created by 常敏 on 15-4-30.
//  Copyright (c) 2015年 cm. All rights reserved.
//

#import "QRScanerViewController.h"
#import "ZBarReaderController.h"

static const float size_image = 250;

#define kIsIphone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

@interface QRScanerViewController ()

@property (nonatomic) UIView* mLeftBgView;

@property (nonatomic) UIView* mRightBgView;

@property (nonatomic) UIView* mTopBgView;

@property (nonatomic) UIView* mBottomBgView;

@end

@implementation QRScanerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{

    [super viewDidAppear:YES];

    [_readerView start];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self cancelScan];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - 自定义方法

- (void)initView
{
    self.title = @"二维码扫描";

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelScan)];
    //    _readerView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64);

    _readerView = [ZBarReaderView new];

    _readerView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);

    _readerView.readerDelegate = self;

    //    [_readerView.scanner setSymbology:ZBAR_QRCODE config:ZBAR_CFG_ENABLE to:0];

    //关闭闪光灯
    _readerView.torchMode = 0;

    //取消手动对焦
    _readerView.allowsPinchZoom = NO;

    //扫描区域，这里可以自己调整
    CGRect scanMaskRect = CGRectMake((_readerView.frame.size.width - size_image) / 2.0, (_readerView.frame.size.height - size_image) / 2.0, size_image, size_image);

    _mLeftBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, (_readerView.frame.size.width - size_image) / 2.0, _readerView.frame.size.height)];

    _mRightBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, scanMaskRect.size.width, scanMaskRect.size.height)];

    _mTopBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, scanMaskRect.size.width, scanMaskRect.size.height)];

    _mBottomBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, scanMaskRect.size.width, scanMaskRect.size.height)];

    if (TARGET_IPHONE_SIMULATOR) {

        ZBarCameraSimulator* cameraSimulator

            = [[ZBarCameraSimulator alloc] initWithViewController:self];

        cameraSimulator.readerView = _readerView;
    }

    [self.view addSubview:_readerView];

    //扫描区域计算
    CGRect scanCrop = [self getScanCrop:scanMaskRect readerViewBounds:self.readerView.bounds];

    //    NSLog(@"扫描的X坐标：%f Y坐标：%f 宽度：%f 高度：%f", scanCrop.origin.x, scanCrop.origin.y, scanCrop.size.width, scanCrop.size.height);

    //    NSLog(@"扫描的X坐标：%f Y坐标：%f 宽度：%f 高度：%f", scanMaskRect.origin.x, scanMaskRect.origin.y, scanMaskRect.size.width, scanMaskRect.size.height);

    _readerView.scanCrop = scanCrop;

    //这里添加了一个类似微信的扫描框，可以根据自己需要添加

    UIImageView* imageView = [[UIImageView alloc] init];

    if (kIsIphone5) {

        imageView.image = [UIImage imageNamed:@"scan_bg_568h"];

        imageView.frame = self.view.bounds;
    }
    else {

        imageView.image = [UIImage imageNamed:@"scan_bg"];

        imageView.frame = self.view.bounds;
    }

    [self.view addSubview:imageView];

    //这里添加了类似微信的扫描线，并开始上线滑动动画

    lineView = [[UIImageView alloc] initWithFrame:CGRectMake(51, 200, 219, 3)];

    lineView.image = [UIImage imageNamed:@"scan_line"];

    [self.view addSubview:lineView];

    [self loadAnimationStart];
}

/**
 *  得到扫描的范围
 *
 *  @param rect     扫描区域
 *  @param rvBounds readerView的区域
 *
 *  @return 真正的范围
 */
- (CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)rvBounds
{
    CGFloat x, y, width, height;

    x = rect.origin.y / rvBounds.size.height;

    y = 1 - (rect.origin.x + rect.size.width) / rvBounds.size.width;

    width = (rect.origin.y + rect.size.height) / rvBounds.size.height;

    height = 1 - rect.origin.x / rvBounds.size.width;

    return CGRectMake(x, y, width, height);

    //    CGFloat x, y, width, height;
    //
    //    x = rect.origin.x / rvBounds.size.width;
    //    y = rect.origin.y / rvBounds.size.height;
    //    width = rect.size.width / rvBounds.size.width;
    //    height = rect.size.height / rvBounds.size.height;
    //
    //    return CGRectMake(x, y, width, height);
}

- (void)loadAnimationStart
{

    if (kIsIphone5) {

        [UIView animateWithDuration:2.0
            animations:^{

                lineView.frame = CGRectMake(lineView.frame.origin.x, 390, lineView.frame.size.width, lineView.frame.size.height);

            }
            completion:^(BOOL finished) {

                [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(secStart) userInfo:nil repeats:NO];

            }];
    }
    else {

        [UIView animateWithDuration:2.0
            animations:^{

                lineView.frame = CGRectMake(lineView.frame.origin.x, 345, lineView.frame.size.width, lineView.frame.size.height);

            }
            completion:^(BOOL finished) {

                [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(secStart) userInfo:nil repeats:NO];

            }];
    }
}

- (void)secStart
{

    if (kIsIphone5) {

        lineView.frame = CGRectMake(lineView.frame.origin.x, 175, lineView.frame.size.width, lineView.frame.size.height);

        [self loadAnimationStart];
    }
    else {

        lineView.frame = CGRectMake(lineView.frame.origin.x, 130, lineView.frame.size.width, lineView.frame.size.height);

        [self loadAnimationStart];
    }
}

/**
 *  取消扫描
 */
- (void)cancelScan
{
    [_readerView stop];

    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - ZBarReaderViewDelegate

- (void)readerView:(ZBarReaderView*)readerView
    didReadSymbols:(ZBarSymbolSet*)symbols
         fromImage:(UIImage*)image
{
    NSString* str;

    for (ZBarSymbol* symbol in symbols) {

        NSLog(@"%@", symbol.data);

        str = symbol.data;

        break;
    }

    [_readerView stop];

    if ([_delegate respondsToSelector:@selector(finishRead:)]) {

        [_delegate finishRead:str];
    }

    //    [self dismissViewControllerAnimated:YES completion:nil];
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
