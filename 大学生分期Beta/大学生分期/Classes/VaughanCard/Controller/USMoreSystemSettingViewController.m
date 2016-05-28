//
//  USMoreSafetyCentrenViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/13.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USMoreSystemSettingViewController.h"
#import "USFindPwdViewController.h"
#import "USModifyExcPwdViweController.h"
@interface USMoreSystemSettingViewController()
@property(nonatomic,strong)NSArray *titles;
@property(nonatomic,strong)NSArray *succesMegs;
@end
@implementation USMoreSystemSettingViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"系统设置";
    self.navigationController.navigationBar.translucent= NO;
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    _tableView.y = 10;
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.tableView];
    //_titles = @[@"检查更新",@"清除缓存",@"接收消息"];
    //_succesMegs = @[@"当前已是最新版...",@"清除缓存成功...",@"接收消息成功..."];
    //_titles = @[@"检查更新",@"清除缓存"];
    //_succesMegs = @[@"当前已是最新版...",@"清除缓存成功..."];
    _titles = @[@"清除缓存1"];
    _succesMegs = @[@"清除缓存成功..."];
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_titles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"reuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
        cell.textLabel.textColor = HYCTColor(123, 123, 123);
        cell.textLabel.font = [UIFont systemFontOfSize:kCommonFontSize_15];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
     }
    
    cell.textLabel.text = _titles[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    return 9;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MBProgressHUD *progressView = nil;
    NSInteger time = 5;
    switch (indexPath.row) {
        case 0:
        {
           progressView = [MBProgressHUD showMessage:@"正在检查版本信息..."];
            time = 6;
        }
            break;
        case 1:
        {
            progressView = [MBProgressHUD showMessage:@"正在清除缓存..."];
        }
            break;
        
        case 2:
        {
            progressView = [MBProgressHUD showMessage:@"正在接收消息..."];
            time = 8;
        }
            break;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [progressView hide:YES];
        [MBProgressHUD showSuccess:_succesMegs[indexPath.row]];
    });
}
@end
