//
//  CMCollectionViewCell.m
//  shouji
//
//  Created by 常敏 on 15-3-31.
//  Copyright (c) 2015年 cm. All rights reserved.
//

#import "CMCollectionViewCell.h"
#import "UIView+CMExtention.h"

@implementation CMCollectionViewCell
{
    //标题的标签
    __weak UILabel *_titleLabel;
}

#pragma mark - 继承父类方法

- (instancetype)initWithFrame:(CGRect)frame
{
    frame.origin.y = 0;
    self = [super initWithFrame:frame];
    if (self) {
        
        NSLog(@"frame ---- x %f y %f width %f height %f", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
        
        [self setBackgroundColor:[UIColor blueColor]];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        _imageView = imageView;
        [self addSubview:imageView];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.5f];
        titleLabel.hidden = YES;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont systemFontOfSize:14.f];
        [self addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return self;
}

- (void) layoutSubviews {
    [super layoutSubviews];

    CGRect size = self.frame;
    size.origin.x = 0;
    _imageView.frame = size;
    
    CGFloat titleLabelWidth = self.cm_width;
    CGFloat titleLabelHeight = 30;
    CGFloat titleLabelX = 0;
    CGFloat titleLabelY = self.cm_height - titleLabelHeight + size.origin.y;
    _titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelWidth, titleLabelHeight);
    _titleLabel.hidden = !_titleLabel.text;
}

#pragma mark - Setter 和 Getter方法

- (void) setTitle:(NSString *)title{
    _title = [title copy];
    _titleLabel.text = [NSString stringWithFormat:@"   %@", title];
}

@end
