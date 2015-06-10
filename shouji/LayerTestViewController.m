//
//  LayerTestViewController.m
//  shouji
//
//  Created by 常敏 on 15-5-11.
//  Copyright (c) 2015年 cm. All rights reserved.
//

#import "LayerTestViewController.h"

@interface LayerTestViewController ()

/**
 *  显示容器
 */
@property (nonatomic, strong) UIView *mShowView;


/**
 *  圆圈圈的路径
 */
@property (nonatomic, strong) UIBezierPath *mCirclePath;


/**
 *  背景的圆圈圈
 */
@property (nonatomic, strong) CAShapeLayer *mBackgroundLayer;


/**
 *  进度条圆圈圈
 */
@property (nonatomic, strong) CAShapeLayer *mProgressLayer;

@end

@implementation LayerTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initAnimation];
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

/**
 *  初始化Layer动画
 */
- (void) initAnimation
{
    //显示容器
    _mShowView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:_mShowView];
    _mShowView.backgroundColor = [UIColor redColor];
    _mShowView.alpha = 0.5f;
    
    //创建贝塞尔曲线路径
    _mCirclePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(100 / 2.f, 100 / 2.f)
                                                        radius:100 / 2.f - 2
                                                    startAngle: -M_PI_2
                                                      endAngle:M_PI * 2
                                                     clockwise:YES];
    
    //创建一个shapeLayer
    _mBackgroundLayer = [CAShapeLayer layer];
    _mBackgroundLayer.frame = _mShowView.bounds;
    //边线的颜色
    _mBackgroundLayer.strokeColor = [UIColor grayColor].CGColor;
    //填充颜色
    _mBackgroundLayer.fillColor = [UIColor clearColor].CGColor;
    //线条的类型
    _mBackgroundLayer.lineCap = kCALineCapSquare;
    //线条的路径
    _mBackgroundLayer.path = _mCirclePath.CGPath;
    //线条的宽度
    _mBackgroundLayer.lineWidth = 4.0;
    //线条开始弧度
    _mBackgroundLayer.strokeStart = 0.f;
    //线条结束的弧度
    _mBackgroundLayer.strokeEnd = 1.0f;
    
    _mBackgroundLayer.shadowColor = [UIColor blackColor].CGColor;

    _mBackgroundLayer.shadowOffset = CGSizeMake(4, 4);
    _mBackgroundLayer.shadowOpacity = 0.2;
    
    [_mShowView.layer addSublayer:_mBackgroundLayer];
    
    
    _mProgressLayer = [CAShapeLayer layer];
    _mProgressLayer.frame = _mShowView.bounds;
    //边线的颜色
    _mProgressLayer.strokeColor = [UIColor yellowColor].CGColor;
    //填充颜色
    _mProgressLayer.fillColor = [UIColor clearColor].CGColor;
    //线条的类型
    _mProgressLayer.lineCap = kCALineCapSquare;
    //线条的路径
    _mProgressLayer.path = _mCirclePath.CGPath;
    //线条的宽度
    _mProgressLayer.lineWidth = 4.0;
    //线条开始弧度
    _mProgressLayer.strokeStart = 0.0f;
    
    _mProgressLayer.strokeEnd = 0.0;
    
    [_mShowView.layer addSublayer:_mProgressLayer];
    
//    [self performSelector:@selector(startAnimation) withObject:nil afterDelay:3.0 inModes:nil];
    
    [self startAnimation];
}

/**
 *  开始执行动画
 */
- (void) startAnimation
{
    // 给这个layer添加动画效果
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 5.0;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    [_mProgressLayer addAnimation:pathAnimation forKey:nil];
}

@end
