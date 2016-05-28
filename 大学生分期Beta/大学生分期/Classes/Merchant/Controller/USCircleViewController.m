//
//  USCircleViewController.m
//  大学生分期
//
//  Created by HeXianShan on 16/1/4.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import "USCircleViewController.h"
#import "USNearTableViewController.h"
#import "USNearTopPersonView.h"
#import "USNearProfZoneViewController.h"
#import "USCircleListContentView.h"
#import "USImageButton.h"
#import "USCirclListTableViewController.h"
@interface USCircleViewController ()
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)USNearTableViewController *groupListTable;
@property(nonatomic,strong)USCirclListTableViewController *personListTable;
@property(nonatomic,strong) USCircleListContentView *usview;
@property(nonatomic,strong)USAccount *account;
@end

@implementation USCircleViewController
//圈子------圈子------圈子------圈子------圈子------
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _account = [USUserService accountStatic];
    self.title = _account.name;
    [super initRightImgButton];
    //     USCircleListContentView *view = [[USCircleListContentView alloc]initWithDic:nil];
    //    _usview = view;
    //    [self.view addSubview:view];
    USCirclListTableViewController *nearTableCV= [[USCirclListTableViewController alloc]init];
    nearTableCV.type = _type ;
    nearTableCV.view.y = 0;
    _personListTable = nearTableCV;
    [nearTableCV.tableView setTableHeaderView:[self createNearTopPersonView]];
    [self addChildViewController:nearTableCV];
    [self.view addSubview:self.personListTable.view];
}

//圈子头部
-(UIView *)createNearTopPersonView{
    USNearTopPersonView *topView = [[USNearTopPersonView alloc]initWithFrame:CGRectMake(0, 0, kAppWidth, kAppHeight*0.5) noMotto:NO];
    topView.backgroundColor = [UIColor whiteColor];
    topView.nearTopButtonClickBlock = ^(){
        USNearProfZoneViewController *profZoneVC = [[USNearProfZoneViewController alloc]init];
        [self.navigationController pushViewController:profZoneVC animated:YES];
    };
    return  topView;
}

@end
