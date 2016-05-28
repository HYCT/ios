//
//  USActivityViwController.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/12.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USActivityViewController.h"
#import "USActiviTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "USActivitDetalViewController.h"
@interface USActivityViewController()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIView *dataTipView;
@property(nonatomic,strong)NSDictionary *param;
@property(nonatomic,copy)NSString *url;
@property(nonatomic,copy)NSString *msg;
@property(nonatomic,strong)NSMutableArray *dataArrayList;
@property(nonatomic,assign)int currentPage;
@property(nonatomic,assign)int totalPage;
@end
@implementation USActivityViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"活动";
    [self.view setBackgroundColor:HYCTColor(240, 241, 240)];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent= NO;
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.y = 10;
    self.tableView.height = kAppHeight*0.9;
    [self.view addSubview:self.tableView];
    _url = @"firstpageimgcilent/getActivList.action";
    [self setupRefresh];
    _dataTipView = [USUIViewTool createDataTipViewWithTarget:self action:@selector(loadData)];
    [self loadData];
}
-(void)loadData{
    [_dataTipView removeFromSuperview];
    [USWebTool POSTWithNoTip:_url showMsg:_msg paramDic:@{@"currentPage":@(1),@"pageSize":@(kPageSize)} success:^(NSDictionary *data) {
        if (_dataArrayList == nil) {
            _dataArrayList = [NSMutableArray array];
            
        }
        _currentPage =[data[@"currentPage"] intValue];
        _totalPage = [data[@"totalPage"] intValue];
        if ([data[@"totalNum"] intValue]==0) {
            [self.view addSubview:_dataTipView];
            return ;
        }
        [_dataArrayList addObjectsFromArray:data[@"data"]];
        [_tableView reloadData];
        
    }];
}
/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    self.tableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.tableView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    self.tableView.footerRefreshingText = @"正在玩命加载中...";
}



- (void)footerRereshing
{
    if (_currentPage<=_totalPage&&_currentPage>0) {
        _currentPage++;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_param];
        dic[@"currentPage"] = @(_currentPage);
        [USWebTool POST:_url paramDic:dic success:^(NSDictionary *dataDic) {
            if ([dataDic[@"data"] count]==0) {
                _currentPage--;
                [MBProgressHUD showSuccess:@"没有更多的数据可显示..."];
                return ;
            }
            [_dataArrayList addObjectsFromArray:dataDic[@"data"]];
            [self.tableView reloadData];
            _currentPage =[dataDic[@"currentPage"] intValue];
            _totalPage = [dataDic[@"totalPage"] intValue];
        } failure:^(id data) {
            _currentPage--;
           [MBProgressHUD showSuccess:@"没有更多的数据可显示..."];
        }];
    }
    [self.tableView footerEndRefreshing];
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArrayList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
    //return _dataArrayList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"CELL_ID_";
    USActiviTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell==nil) {
        cell = [[USActiviTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier ];
    }
   // UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, kAppWidth-20, 120)];
    //imageView.image =
    //[self.view addSubview:imageView];
   // cell.activiImageView.image = [UIImage imageNamed:@"activi_img"];
    
    //NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:HYWebDataPath(_dataArrayList[indexPath.section][@"imgpath"])]];
   // cell.activiImageView.image = [UIImage imageWithData:data];
    cell.backgroundColor = [UIColor clearColor];
    [cell.activiImageView sd_setImageWithURL:[NSURL URLWithString:HYWebDataPath(_dataArrayList[indexPath.section][@"imgpath"])]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  120;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *data = _dataArrayList[indexPath.section];
    USActivitDetalViewController *detalVC = [[USActivitDetalViewController alloc]init];
    detalVC.title = data[@"title"];
    detalVC.param = @{@"id":data[@"id"]};
    detalVC.msg = @"正在加载活动详情...";
    [self.navigationController pushViewController:detalVC animated:YES];
}

@end
