//
//  ZLPhotoViewController.m
//  shouji
//  照片选择
//  Created by 常敏 on 15-3-30.
//  Copyright (c) 2015年 cm. All rights reserved.
//

#import "ZLPhotoViewController.h"

@interface ZLPhotoViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSArray *examples;

@end

@implementation ZLPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"ZLPickerLib";
    [self tableView];
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


#pragma mark - getter
- (NSArray *)examples{
    return @[
             @"相片多选 + 图片游览器 >>> TableView",
             @"相片连拍/多选 + 图片游览器 >>> UICollectionView",
             @"相片多选/支持不重复选择照片 >>> UICollectionView",
             @"图片游览器 -> 自定义UIView >>> UIView",
             @"视频选择 + 视频游览器 >>>",
             @"查看当个图片（头像） >>>",
             ];
}

- (UITableView *)tableView{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.dataSource = self;
        tableView.delegate = self;
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [self.view addSubview:tableView];
        self.tableView = tableView;
        
        tableView.translatesAutoresizingMaskIntoConstraints = NO;
        
        NSString *vfl = @"V:|-0-[tableView]-20-|";
        NSDictionary *views = NSDictionaryOfVariableBindings(tableView);
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vfl options:0 metrics:nil views:views]];
        NSString *vfl2 = @"H:|-0-[tableView]-0-|";
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vfl2 options:0 metrics:nil views:views]];
    }
    return _tableView;
}


#pragma mark - <UITableViewDataSource>
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.examples.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = self.examples[indexPath.row];
    
    return cell;
    
}

#pragma mark - <UITableViewDelegate>
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *exampleVc = [NSString stringWithFormat:@"Example%dViewController",indexPath.row + 1];
    UIViewController *vc = [[NSClassFromString(exampleVc) alloc] init];
    vc.title = self.examples[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
