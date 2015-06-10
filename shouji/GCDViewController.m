//
//  GCDViewController.m
//  shouji
//
//  Created by 常敏 on 15-5-5.
//  Copyright (c) 2015年 cm. All rights reserved.
//

#import "GCDViewController.h"

#define kGCDUrl @"http://www.xiaxingke.com/images/edit/2013122537101465.jpg"

@interface GCDViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *mScrollView;

@property (weak, nonatomic) IBOutlet UIImageView *mImageView;

@end

@implementation GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _mScrollView.delegate = self;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:kGCDUrl]];
        UIImage *image = [UIImage imageWithData:imageData];
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.mImageView.contentMode = UIViewContentModeCenter;
            weakSelf.mImageView.image = image;
        });
    });
    
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

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.mImageView;
}

@end
