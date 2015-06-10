//
//  NSOperationViewController.m
//  shouji
//
//  Created by 常敏 on 15-5-5.
//  Copyright (c) 2015年 cm. All rights reserved.
//

#import "NSOperationViewController.h"

#define kURL @"http://avatar.csdn.net/2/C/D/1_totogo2010.jpg"

@interface NSOperationViewController ()
{
    NSInvocationOperation *mDownloadOperation;
    NSOperationQueue *mDownloadOperationQueue;
}

@property (weak, nonatomic) IBOutlet UIImageView *mImageView;

@end

@implementation NSOperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    mDownloadOperation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downloadImage:) object:kURL];

    mDownloadOperationQueue = [[NSOperationQueue alloc] init];
    [mDownloadOperationQueue addOperation:mDownloadOperation];
    
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

- (void) downloadImage:(NSString *)url
{
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
    UIImage *img = [UIImage imageWithData:imageData];
    [self performSelectorOnMainThread:@selector(updateUI:) withObject:img waitUntilDone:YES];
}


- (void) updateUI:(UIImage *)image
{
    self.mImageView.contentMode = UIViewContentModeCenter;
    self.mImageView.image = image;
}


@end
