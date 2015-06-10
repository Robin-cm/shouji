//
//  DetailViewController.h
//  shouji
//
//  Created by 常敏 on 15-3-27.
//  Copyright (c) 2015年 cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) NSURL *imageURL;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end
