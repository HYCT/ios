//
//  USSayHelloViewController.m
//  大学生分期
//
//  Created by mac on 16/2/22.
//  Copyright © 2016年 hongyunct. All rights reserved.
//
//打招呼信息
#import "USCashierListViewController.h"
#import "USCashierTableCell.h"
@interface USCashierListViewController()
@property(nonatomic,strong)NSMutableArray *dataList;
@property(nonatomic,strong)NSMutableDictionary *paramDic;
@property(nonatomic,strong)NSString *url ;
@end
@implementation USCashierListViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"选择收银员";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent= NO;
    [self.view setBackgroundColor:HYCTColor(240, 240, 240)];
    
    
    
    //列表
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView setBackgroundColor:[UIColor whiteColor]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.y=-30;
    [self.view addSubview:self.tableView];
    
    self.tableView.height = self.view.height -10 ;
    
    //初始化参数
    [self initPara] ;
    
    
}
//初始化参数
-(void) initPara{
    _dataList = [NSMutableArray array];
    //用户
    _paramDic = [NSMutableDictionary dictionary];
    
    _paramDic[@"shop_id"] = _shop_id;
    _url=@"shopClient/getShopUser.action";
    
    //加载数据
    [self loadData] ;
    
    return ;
}

//加载数据
-(void) loadData{
    [USWebTool POSTPageWIthTip:_url showMsg:@"请稍后..." paramDic:_paramDic success:^(NSDictionary *dic) {
        [_dataList addObjectsFromArray:dic[@"data"]];
        
        [_tableView reloadData];
        
        
    } failure:^(id data) {
        
    }];
    
    return  ;
}


-(void)returnbak{
    dispatch_async(dispatch_get_main_queue(), ^{
        
    });
}
/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    self.tableView.footerPullToRefreshText = @"上拉加载更多数据";
    self.tableView.footerReleaseToRefreshText = @"松开加载更多数据";
    self.tableView.footerRefreshingText = @"正在玩命加载中...";
}


///
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataList.count;
}

//行内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *data = _dataList[indexPath.row];
    static NSString *reuseIdentifier = @"reuseIdentifier";
    USCashierTableCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell==nil) {
        
        cell = [[USCashierTableCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier ];
        
    }
    cell.nameLabel.text = data[@"name"] ;
    
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
//高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50 ;
}
//当击行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //回传
    [_scanDelegate didCashierClick: _dataList[indexPath.row]];
    [self.navigationController popViewControllerAnimated:YES] ;
}


@end
