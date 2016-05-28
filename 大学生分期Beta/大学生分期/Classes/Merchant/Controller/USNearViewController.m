//
//  USNearViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/3.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USNearViewController.h"
#import "USNearTableViewController.h"
#import "USNearTopPersonView.h"
#import "USNearProfZoneViewController.h"
#import "USLoginViewController.h"
@interface  USNearViewController ()
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)USNearTableViewController *groupListTable;
@property(nonatomic,strong)USNearTableViewController *personListTable;
@property(nonatomic,strong)USAccount *acount;
@property(nonatomic,assign)BOOL loadFlag;
@end
@implementation USNearViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent= NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"附近的人";
    USAccount *account = [USUserService accountStatic];
    _acount = account;
    if (account==nil) {
    }else{
        _loadFlag = YES;
        [self loadViews];
    }
    
    
}
-(void)loadViews{
    USAccount *account = [USUserService account];
    _acount = account;
    USNearTableViewController *nearTableCV= [[USNearTableViewController alloc]init];
    nearTableCV.tableView.y = 0;
    nearTableCV.tableView.height = kAppHeight*0.9;
    nearTableCV.view.y = -30;
    [self addChildViewController:nearTableCV];
    self.personListTable = nearTableCV;
    _loadFlag = NO;
    [self.view addSubview:self.personListTable.view];
    
}
-(void)checkLogin{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD showError:@"还没有登录，请先登录..."];
        USLoginViewController *loginVC = [[USLoginViewController alloc]init];
        loginVC.muslogin = YES;
        loginVC.hidesBottomBarWhenPushed = YES;
        loginVC.nextViewController = self;
        _loadFlag = YES;
        [self.navigationController pushViewController:loginVC animated:YES];
    });
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (_acount == nil&&!_loadFlag) {
        [NSThread detachNewThreadSelector:@selector(checkLogin) toTarget:self withObject:nil];
        return;
    }
    if (_acount==nil) {
        [self loadViews];
    }
}
@end
