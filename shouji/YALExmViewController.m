//
//  YALExmViewController.m
//  shouji
//  下拉刷新页面
//  Created by 常敏 on 15-3-26.
//  Copyright (c) 2015年 cm. All rights reserved.
//

#import "YALExmViewController.h"
#import "YALSunnyRefreshControll/YALSunnyRefreshControl.h"

@interface YALExmViewController ()

@property (nonatomic,strong) YALSunnyRefreshControl *sunnyRefreshControl;

@property (nonatomic, strong) UIView *bg;

@end

@implementation YALExmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"contentOffset的Y值是： %f", self.tableView.contentOffset.y);
    
    self.bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 0.f)];
    self.bg.backgroundColor = [UIColor redColor];
    
//    [self.view addSubview:self.bg];
//    [self.view bringSubviewToFront:self.tableView];
    
    [self setupRefreshControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
//    [self.sunnyRefreshControl startRefreshing];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - tablesource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    
    //初始化cell并指定其类型，也可自定义cell
    
    UITableViewCell *cell = (UITableViewCell*)[tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = @"asdasd";
    return cell;
}


#pragma mark - UIScrollViewDelegate methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"contentOffset的Y值是： %f", self.tableView.contentOffset.y);
    NSLog(@"contentInset的上间距值是： %f", self.tableView.contentInset.top);
    
//    [self.bg setFrame:CGRectMake(0, self.tableView.contentOffset.y + self.tableView.contentInset.top, CGRectGetWidth(self.view.bounds), -self.tableView.contentOffset.y - self.tableView.contentInset.top)];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{

}


-(void)setupRefreshControl{
    self.sunnyRefreshControl = [YALSunnyRefreshControl attachToScrollView:self.tableView
                                                                   target:self
                                                            refreshAction:@selector(sunnyControlDidStartAnimation)];
}


-(void)sunnyControlDidStartAnimation{
    
    // start loading something
    [self performSelector:@selector(endAnimationHandle) withObject:nil afterDelay:2.0f];
    
}

-(IBAction)endAnimationHandle{
    
    [self.sunnyRefreshControl endRefreshing];
}

@end
