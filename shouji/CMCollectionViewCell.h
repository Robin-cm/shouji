//
//  CMCollectionViewCell.h
//  shouji
//  幻灯片的CollectionView的Cell
//  Created by 常敏 on 15-3-31.
//  Copyright (c) 2015年 cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMCollectionViewCell : UICollectionViewCell

#pragma mark - 成员变量

/**
 *  图片组件
 **/
@property (nonatomic, weak) UIImageView *imageView;


/**
 *  图片的标题
 **/
@property (nonatomic, copy) NSString *title;

@end
