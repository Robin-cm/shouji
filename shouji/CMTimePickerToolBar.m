//
//  CMTimePickerToolBar.m
//  shouji
//  时间选择器的上面的工具条
//  Created by 常敏 on 15-4-2.
//  Copyright (c) 2015年 cm. All rights reserved.
//

#import "CMTimePickerToolBar.h"

#define SCREEN_WIDTH                    ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT                   ([UIScreen mainScreen].bounds.size.height)

static CGFloat SIZE_BTN = 40;

static CGFloat PADDING_BTN = 5;


@interface CMTimePickerToolBar()


/**
 *  取消按钮
 **/
@property (nonatomic, weak) UIButton *cancelBtn;

/**
 *  确定按钮
 **/
@property (nonatomic, weak) UIButton *okBtn;


/**
 *  标题控件
 **/
@property (nonatomic, weak) UILabel *titleLabel;


@end


@implementation CMTimePickerToolBar


#pragma mark - 静态方法

+ (instancetype) toolBarWithSize:(CGSize)size{
    CMTimePickerToolBar *toolBar = [[CMTimePickerToolBar alloc] init];
    toolBar.size = size;
    return toolBar;
}

+ (instancetype) toolBarWithSize:(CGSize)size setTitle:(NSString *)title{
    CMTimePickerToolBar *toolBar = [[CMTimePickerToolBar alloc] init];
    toolBar.title = title;
    return toolBar;
}


/**
 *  得到工具条的高度
 **/
+ (CGFloat) toolBarGetHeight{
    return SIZE_BTN + PADDING_BTN * 2;
}

#pragma mark - 继承父类

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initView];
    }
    return self;
}


- (void) layoutSubviews
{
    if(_cancelBtn){
        _cancelBtn.frame = CGRectMake(PADDING_BTN, PADDING_BTN, SIZE_BTN, SIZE_BTN);
    }
    if(_okBtn){
        _okBtn.frame = CGRectMake(SCREEN_WIDTH - SIZE_BTN - PADDING_BTN, PADDING_BTN, SIZE_BTN, SIZE_BTN);
    }
    if(_titleLabel){
        _titleLabel.frame = CGRectMake(SIZE_BTN + PADDING_BTN * 2, PADDING_BTN, SCREEN_WIDTH - SIZE_BTN * 2 - PADDING_BTN * 4, 40);
    }
}

#pragma mark - Setter

- (void) setSize:(CGSize)size
{
    _size = size;
    [self setNeedsLayout];
}

- (void) setTitle:(NSString *)title
{
    _title = title;
    if(_titleLabel){
        _titleLabel.text = title;
    }
}

#pragma mark - 自定义公共方法

- (void) setDate:(NSDate *)date{
}


#pragma mark - 自定义私有方法

/**
 *  初始化视图
 **/
- (void) initView
{
    [self setBackgroundColor:[UIColor whiteColor]];
    
    if(!_cancelBtn)
    {
        UIButton *cancelBtn = [[UIButton alloc] init];
        [cancelBtn setBackgroundImage:[UIImage imageNamed:@"dialog_cancel"] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelBtnTaped:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelBtn];
        _cancelBtn = cancelBtn;
    }
    
    if(!_okBtn)
    {
        UIButton *okBtn = [[UIButton alloc] init];
        [okBtn setBackgroundImage:[UIImage imageNamed:@"dialog_ok"] forState:UIControlStateNormal];
        [okBtn addTarget:self action:@selector(okBtnTaped:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:okBtn];
        _okBtn = okBtn;
    }
    
    if(!_titleLabel)
    {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = @"时间选择";
        titleLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    
}

#pragma mark - 定义事件


/**
 *  取消点击
 **/
- (void) cancelBtnTaped:(id)sender
{
    if([self.delegate respondsToSelector:@selector(timePickerToolBarDidBtnSelectedWithType:)]){
        [self.delegate timePickerToolBarDidBtnSelectedWithType:CMTimePickerToolBarButtonTypeCancel];
    }
}

/**
 *  OK点击
 **/
- (void) okBtnTaped:(id)sender
{
    if([self.delegate respondsToSelector:@selector(timePickerToolBarDidBtnSelectedWithType:)]){
        [self.delegate timePickerToolBarDidBtnSelectedWithType:CMTimePickerToolBarButtonTypeOK];
    }
}


@end
