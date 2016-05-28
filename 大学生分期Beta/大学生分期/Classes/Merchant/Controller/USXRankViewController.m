//
//  USXRankViewController.m
//  大学生分期
//
//  Created by HeXianShan on 16/1/8.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import "USXRankViewController.h"
#import "USXRankView.h"
@interface USXRankViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataView;
@property(nonatomic,strong)NSMutableDictionary *paramDic;
@property(nonatomic,strong)UIView *dataTipView;
@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSString *url;
@property(nonatomic,assign)int totalPage;
@property(nonatomic,assign)int currentPage;
@end

@implementation USXRankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent= NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"人气榜";
    //    USXRankView *xrankVC = [[USXRankView alloc]initWithArray:@[@{},@{},@{}] superVC:self];
    //    [self.view addSubview:xrankVC];
    _dataView = [NSMutableArray array];
    _msg = @"正在加载人气榜...";
    _url = @"wangkaClientController/getRenqibangList.action";
    _dataView = [NSMutableArray array];
    _paramDic = [NSMutableDictionary dictionary];
    _paramDic[@"pageSize"] = @(kPageSize+2);
    _paramDic[@"currentPage"] = @(1);
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.y = 0;
    self.tableView.height*=0.892;
    [self.view addSubview:self.tableView];
    _dataTipView = [USUIViewTool createDataTipViewWithTarget:self action:@selector(loadData)];
    [self setupRefresh];
    [self loadData];
}

-(void)loadData{
    [_dataTipView removeFromSuperview];
    [USWebTool POST:_url showMsg:_msg paramDic:_paramDic success:^(NSDictionary *dic) {
        if([dic[@"totalNum"]intValue]>0){
            [self createDataView:dic[@"data"]];
            _currentPage =[dic[@"currentPage"] intValue];
            _totalPage = [dic[@"totalPage"] intValue];
            [_tableView reloadData];
        }else{
            [self.view addSubview:_dataTipView];
        }
        
    } failure:^(id data) {
        [self.view addSubview:_dataTipView];
    }];
}


-(void)createDataView:(NSArray *)dicData{
    if (dicData!=nil&&dicData.count>0) {
        NSMutableArray *dataArrayList = [NSMutableArray array];
        NSMutableArray *dataArray = nil;
        for (NSDictionary *dic in dicData) {
            //3个3个分组
            if (dataArray==nil) {
                dataArray =  [NSMutableArray array];
            }
            if (dic!=nil&&dic.count>0) {
                [dataArray addObject:dic];
            }
            
            if (dataArray.count==3) {
                [dataArrayList addObject:dataArray];
                dataArray = nil;
            }
        }
        if (dataArray !=nil&&dataArray.count>0) {
            [dataArrayList addObject:dataArray];
            dataArray = nil;
        }
        [dataArrayList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSMutableArray *dataArray = obj;
            USXRankView *contentView = [[USXRankView alloc]initWithArray:dataArray superVC:self];
            [_dataView addObject:contentView];
        }];
        
        
    }
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
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_paramDic];
        dic[@"currentPage"] = @(_currentPage);
        [USWebTool POST:_url paramDic:dic success:^(NSDictionary *dataDic) {
            if ([dataDic[@"data"] count]==0) {
                _currentPage--;
                [MBProgressHUD showSuccess:@"没有更多的数据可显示..."];
                return ;
            }
            [self createDataView:dataDic[@"data"]];
            [self.tableView reloadData];
            _currentPage =[dataDic[@"currentPage"] intValue];
            _totalPage = [dataDic[@"totalPage"] intValue];
        } failure:^(id data) {
            
        }];
    }
    [self.tableView footerEndRefreshing];
}





#pragma mark - tableview datasource delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataView.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"reuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
        
    }
    for (UIView *view in cell.subviews) {
        [view removeFromSuperview];
        view.hidden = YES;
        
    }
    USXRankView *view = [_dataView objectAtIndex:indexPath.row];
    cell.userInteractionEnabled = YES;
    view.hidden = NO;
    [cell addSubview:view];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    USXRankView *view = [_dataView objectAtIndex:indexPath.row];
    return view.height+2;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
