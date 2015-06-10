//
//  SDImageExmViewController.m
//  shouji
//  图片加载
//  Created by 常敏 on 15-3-27.
//  Copyright (c) 2015年 cm. All rights reserved.
//

#import "SDImageExmViewController.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface SDImageExmViewController ()
{
    NSArray *_objects;
}
@end

@implementation SDImageExmViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
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

#pragma mark - private functions

- (void) initData{

    if (self)
    {
        self.title = @"SDWebImage";
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem.alloc initWithTitle:@"清空"
                                                                                style:UIBarButtonItemStylePlain
                                                                               target:self
                                                                               action:@selector(flushCache)];
        
        // HTTP NTLM auth example
        // Add your NTLM image url to the array below and replace the credentials
        [SDWebImageManager sharedManager].imageDownloader.username = @"httpwatch";
        [SDWebImageManager sharedManager].imageDownloader.password = @"httpwatch01";
        
        _objects = [NSArray arrayWithObjects:
                    @"http://b.hiphotos.baidu.com/image/h%3D360/sign=bafea3d135d12f2ed105a8667fc2d5ff/94cad1c8a786c917be2c903fca3d70cf3bc7578d.jpg",     // requires HTTP auth, used to demo the NTLM auth
                    @"http://f.hiphotos.baidu.com/image/h%3D360/sign=2f91cd4588d4b31cef3c92bdb7d7276f/6a600c338744ebf87f30b239daf9d72a6059a777.jpg",
                    @"http://c.hiphotos.baidu.com/image/h%3D360/sign=c73a86bd4410b912a0c1f0f8f3fdfcb5/42a98226cffc1e1780a94d374990f603738de9a6.jpg",
                    @"http://b.hiphotos.baidu.com/image/h%3D360/sign=804d79da891363270aedc435a18ea056/11385343fbf2b21102816048c98065380cd78e0d.jpg",
                    @"http://d.hiphotos.baidu.com/image/h%3D360/sign=4420db1241a7d933a0a8e2759d4ad194/6f061d950a7b02083067dee761d9f2d3572cc80e.jpg",
                    @"http://a.hiphotos.baidu.com/image/h%3D360/sign=9c64e60d58b5c9ea7df305e5e538b622/cf1b9d16fdfaaf515b2151b98f5494eef11f7af2.jpg",
                    @"http://a.hiphotos.baidu.com/image/h%3D360/sign=bd13261c2b34349b6b066883f9ea1521/91ef76c6a7efce1b05280fccac51f3deb48f65b1.jpg",
                    @"http://a.hiphotos.baidu.com/image/h%3D360/sign=1838f1f9c0fdfc03fa78e5bee43e87a9/8b82b9014a90f603a3499b403a12b31bb051ed38.jpg",
                    @"http://f.hiphotos.baidu.com/image/h%3D360/sign=a884e42c0df41bd5c553eef261db81a0/f9198618367adab49f77184488d4b31c8701e416.jpg",
                    @"http://d.hiphotos.baidu.com/image/h%3D360/sign=e2435e81d3a20cf45990f8d946084b0c/9d82d158ccbf6c813bcbf5eebf3eb13533fa403c.jpg",
                    @"http://h.hiphotos.baidu.com/image/h%3D360/sign=4c3ebfb88f5494ee9822091f1df4e0e1/c2cec3fdfc0392456968df088494a4c27c1e25d3.jpg",
                    @"http://h.hiphotos.baidu.com/image/h%3D360/sign=50bd1779261f95cab9f594b0f9167fc5/72f082025aafa40f8c4cdcdaa864034f78f0192a.jpg",
                    @"http://g.hiphotos.baidu.com/image/h%3D360/sign=db8f67fcd2c8a786a12a4c085708c9c7/5bafa40f4bfbfbed55f4f1797bf0f736afc31f03.jpg",
                    @"http://h.hiphotos.baidu.com/image/h%3D360/sign=d6c94f97ce11728b2f2d8a24f8fdc3b3/eac4b74543a98226c835eb218982b9014b90ebc4.jpg",
                    @"http://h.hiphotos.baidu.com/image/h%3D360/sign=867eb13d334e251ffdf7e2fe9786c9c2/d01373f082025aaf63456dccf8edab64034f1a45.jpg",
                    @"http://g.hiphotos.baidu.com/image/h%3D360/sign=0f6941f838c79f3d90e1e2368aa1cdbc/f636afc379310a55754ddaf3b44543a98226104f.jpg",
                    @"http://e.hiphotos.baidu.com/image/h%3D360/sign=7cfc88da57e736d147138a0eab514ffc/241f95cad1c8a7860de58c086409c93d71cf50ed.jpg",
                    @"http://e.hiphotos.baidu.com/image/h%3D360/sign=7ee5b426ba12c8fcabf3f0cbcc0292b4/8326cffc1e178a82b56fb9a6f503738da977e861.jpg",
                    @"http://h.hiphotos.baidu.com/image/h%3D360/sign=660b12ecb5fd5266b82b3a129b199799/b21c8701a18b87d6c0bfb518040828381f30fd3c.jpg",
                    @"http://g.hiphotos.baidu.com/image/h%3D360/sign=296f64d975c6a7efa626ae20cdfbafe9/f9dcd100baa1cd11bcf5b326ba12c8fcc3ce2d71.jpg",
                    @"http://b.hiphotos.baidu.com/image/h%3D360/sign=9213f7797bf0f736c7fe4a073a54b382/f603918fa0ec08fa684ad2a15aee3d6d55fbda6a.jpg",
                    @"http://c.hiphotos.baidu.com/image/h%3D360/sign=4dbdd21241a7d933a0a8e2759d4bd194/6f061d950a7b020839fad7e761d9f2d3572cc881.jpg",
                    @"http://e.hiphotos.baidu.com/image/h%3D360/sign=4a3929a2097b020813c939e752d9f25f/14ce36d3d539b6001ecc0eb0ea50352ac65cb7b2.jpg",
                    @"http://e.hiphotos.baidu.com/image/h%3D360/sign=434c946f262dd42a400907ad333a5b2f/e4dde71190ef76c633893a2d9e16fdfaaf516759.jpg",
                    @"http://b.hiphotos.baidu.com/image/h%3D360/sign=47ea0f8249ed2e73e3e9802ab700a16d/6a63f6246b600c33f6d43ece194c510fd9f9a103.jpg",
                    nil];
    }
    [SDWebImageManager.sharedManager.imageDownloader setValue:@"SDWebImage Demo" forHTTPHeaderField:@"AppName"];
    SDWebImageManager.sharedManager.imageDownloader.executionOrder = SDWebImageDownloaderLIFOExecutionOrder;

}

- (void)flushCache
{
    [SDWebImageManager.sharedManager.imageCache clearMemory];
    [SDWebImageManager.sharedManager.imageCache clearDisk];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Image #%ld", (long)indexPath.row];
    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:[_objects objectAtIndex:indexPath.row]]
                      placeholderImage:[UIImage imageNamed:@"placeholder"] options:indexPath.row == 0 ? SDWebImageRefreshCached : 0];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.detailViewController)
    {
        self.detailViewController = [[DetailViewController alloc] init];
    }
    NSString *largeImageURL = [[_objects objectAtIndex:indexPath.row] stringByReplacingOccurrencesOfString:@"small" withString:@"source"];
    self.detailViewController.imageURL = [NSURL URLWithString:largeImageURL];
    CATransition *animation = [CATransition animation];
    
    [animation setDuration:0.5];
    
    [animation setType: kCATransitionMoveIn];
    
    [animation setSubtype: kCATransitionFromTop];
    
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [self.navigationController pushViewController:self.detailViewController animated:NO];
    [self.navigationController.view.layer addAnimation:animation forKey:Nil];

}

@end
