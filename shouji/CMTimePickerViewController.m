//
//  CMTimePickerViewController.m
//  shouji
//
//  Created by 常敏 on 15-4-2.
//  Copyright (c) 2015年 cm. All rights reserved.
//

#import "CMTimePickerViewController.h"
#import "CMTimePickerToolBar.h"

#define SCREEN_WIDTH                    ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT                   ([UIScreen mainScreen].bounds.size.height)

@interface CMTimePickerViewController () <CMTimePickerToolBarDelegate>

    //上面的工具条
    @property (nonatomic, weak) CMTimePickerToolBar *timePickerToolbar;
    
    //放置内容的容器
    @property (nonatomic, weak) UIView *contentView;
    
    //时间选择器
    @property (nonatomic, weak) UIDatePicker *timePicker;

@end



@interface NSDate (CMTimePicker)

- (NSString *) getLocalString;

@end


@implementation CMTimePickerViewController



#pragma mark - 静态方法

/**
 *  静态的方法，得到实例
 *  @param  大小
 **/
+ (CMTimePickerViewController *)timePickerWithFrame:(CGSize)size{
    CMTimePickerViewController *timePicker = [[CMTimePickerViewController alloc] init];
    [timePicker setViewSize:size];
    return timePicker;
}


#pragma mark - 继承父类方法


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialization];
    }
    return self;
}


#pragma mark - Setter方法

- (void) setViewSize:(CGSize)viewSize
{
    _viewSize = viewSize;
}


- (void) setDate:(NSDate *)date
{
    _date = date;
    if(_timePicker){
        [_timePicker setDate:_date animated:YES];
    }
}


#pragma mark - Getter方法



#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - CMTimePickerToolBarDelegate

- (void) timePickerToolBarDidBtnSelectedWithType:(CMTimePickerToolBarButtonType)type
{
    if(type == CMTimePickerToolBarButtonTypeCancel){
        if(self.delegate && [self.delegate respondsToSelector:@selector(timePickerBtnPressed:withDate:)]){
            [self.delegate timePickerBtnPressed:self withDate:nil];
        }
    }else if (type == CMTimePickerToolBarButtonTypeOK){
        if(self.delegate && [self.delegate respondsToSelector:@selector(timePickerBtnPressed:withDate:)]){
            [self.delegate timePickerBtnPressed:self withDate:_timePicker.date];
        }
    }
}


#pragma mark - 自定义方法


/**
 *  初始化参数
 **/
- (void) initialization
{
}


/**
 *  初始化视图
 **/
- (void) initView
{
    if(!_contentView){
        UIView *contentView = [[UIView alloc] init];
        [self.view addSubview:contentView];
        _contentView = contentView;
    }
    
    if(!_timePickerToolbar){
        CMTimePickerToolBar *timePickerToolbar = [[CMTimePickerToolBar alloc] init];
        timePickerToolbar.delegate = self;
        [self.view addSubview:timePickerToolbar];
        _timePickerToolbar = timePickerToolbar;
    }
    
    if(!_timePicker){
        UIDatePicker *timePicker = [[UIDatePicker alloc] init];
        [timePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
        timePicker.datePickerMode = UIDatePickerModeTime;
        [self.view addSubview:timePicker];
        _timePicker = timePicker;
    }
    
    [self layoutSubViews];
    
}

/**
 *  拜访各个视图的位置
 **/
- (void) layoutSubViews
{
    self.view.frame = CGRectMake(0.f, SCREEN_HEIGHT - _viewSize.height, SCREEN_WIDTH, _viewSize.height);
    
    if(_contentView){
        _contentView.frame = CGRectMake(0.f, 0.f, SCREEN_WIDTH, _viewSize.height);
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    
    if(_timePickerToolbar){
        _timePickerToolbar.frame = CGRectMake(0.f, 0, SCREEN_WIDTH, [CMTimePickerToolBar toolBarGetHeight]);
    }
    
    if(_timePicker){
        _timePicker.frame = CGRectMake(0.f, [CMTimePickerToolBar toolBarGetHeight], SCREEN_WIDTH, _viewSize.height - [CMTimePickerToolBar toolBarGetHeight]);
    }
}


/**
 *  时间改变
 **/
- (void) dateChanged:(id)sender
{
    if (_timePickerToolbar && _timePicker) {
        NSLog(@"选择的时间是：%@", [_timePicker.date getLocalString]);
        _timePickerToolbar.title = [NSString stringWithFormat:@"时间选择：%@", [_timePicker.date getLocalString]];
    }
}


@end



@implementation NSDate (CMTimePicker)

- (NSString *) getLocalString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH点mm分"];
    NSString *destDateString = [dateFormatter stringFromDate:self];
    NSLog(@"选择的时间是：%@", destDateString);
    return destDateString;
}

@end
