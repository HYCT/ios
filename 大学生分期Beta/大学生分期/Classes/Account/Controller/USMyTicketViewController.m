//
//  USSayHelloViewController.m
//  大学生分期
//
//  Created by mac on 16/2/22.
//  Copyright © 2016年 hongyunct. All rights reserved.
//
//打招呼信息
#import "USMyTicketViewController.h"
#import "USMyTicketTableCell.h"
#import "USNearProfZoneViewController.h"
@interface USMyTicketViewController()
@property(nonatomic,strong) USAccount *account;
@property(nonatomic,strong)NSMutableArray *dataList;
@property(nonatomic,strong)NSMutableDictionary *paramDic;
@property(nonatomic,assign)int currentPage;
@property(nonatomic,assign)int totalPage;
@property(nonatomic,strong)UIView *dataTipView;
@property(nonatomic,strong)UIImage *headerPic;
@property(nonatomic,strong)NSString *url ;
@end
@implementation USMyTicketViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的优惠券";
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
    
    self.tableView.height = self.view.height;
    
    //初始化参数
    [self initPara] ;
    
    
}
//初始化参数
-(void) initPara{
    if (_used == nil) {
        _used = @"" ;
    }
    _dataList = [NSMutableArray array];
    //用户
    _account = [USUserService accountStatic];
    _paramDic = [NSMutableDictionary dictionary];
    
    _paramDic[@"customer_id"] = _account.id;
    _paramDic[@"used"] = _used;
    _paramDic[@"pageSize"] = @(kPageSize);
    _paramDic[@"typeCodeStr"] = _typeCodeStr ;
    _paramDic[@"fullMoney"] = _fullMoney ;
    _currentPage=1 ;
    _paramDic[@"currentPage"] = @(_currentPage);
    _url=@"ticketClient/getMyTicketList.action";
    
    //
    _dataTipView = [USUIViewTool createDataTipViewWithTarget:self action:@selector(loadData)];
    
    //默认头像
    _headerPic = [UIImage imageNamed:@"near_table_cell_person_img"];
    
    //底部的刷新控件
    [self setupRefresh];
    
    
    //加载数据
    [self loadData] ;
    
    return ;
}

//加载数据
-(void) loadData{
    [USWebTool POSTPageWIthTip:_url showMsg:@"请稍后..." paramDic:_paramDic success:^(NSDictionary *dic) {
        if([dic[@"totalNum"]intValue]>0){
            [_dataList addObjectsFromArray:dic[@"data"]];
            _currentPage =[dic[@"currentPage"] intValue];
            _totalPage = [dic[@"totalPage"] intValue];
            [_tableView reloadData];
        }else{
            [self.view addSubview:_dataTipView];
        }
        
    } failure:^(id data) {
        [self.view addSubview:_dataTipView];
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



- (void)footerRereshing
{
    if (_currentPage<=_totalPage&&_currentPage>0) {
        _currentPage++;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_paramDic];
        dic[@"currentPage"] = @(_currentPage);
        [USWebTool POST:_url paramDic:dic success:^(NSDictionary *dataDic) {
            
            if ([dataDic[@"data"] count]==0||[NSNull null]==dataDic[@"data"]||!([dataDic[@"totalNum"]intValue]>0)) {
                _currentPage--;
                [MBProgressHUD showSuccess:@"没有更多的数据可显示..."];
                return ;
            }
            [_dataList addObjectsFromArray:dataDic[@"data"]];
            [self.tableView reloadData];
            _currentPage =[dataDic[@"currentPage"] intValue];
            _totalPage = [dataDic[@"totalPage"] intValue];
        } failure:^(id data) {
            
        }];
    }
    [self.tableView footerEndRefreshing];
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
    static NSString *reuseIdentifier = @"myticketIdentifier";
    USMyTicketTableCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell==nil) {
        cell = [[USMyTicketTableCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier  ];
    }
    [cell setData:data] ;
   
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
//高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //USSayHelloTableCell *cell = [self tableView: _tableView cellForRowAtIndexPath: indexPath];
    //return cell.height +10;
    return 120 ;
}
//当击行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     NSDictionary *data = _dataList[indexPath.row];
    if (_ticketDelegate != nil) {
        //回调
        [_ticketDelegate didTicketClick:data] ;
        [self.navigationController popViewControllerAnimated:YES] ;
    }
    if (_rebackTicketDelegate != nil) {
        //回调
        [_rebackTicketDelegate didTicketClick:data] ;
        [self.navigationController popViewControllerAnimated:YES] ;
    }
    /**
    USNearProfZoneViewController *profZoneVC = [[USNearProfZoneViewController alloc]init];
    profZoneVC.customer_id = data[@"customer_id"];
    [self.navigationController pushViewController:profZoneVC animated:YES];
     **/
   
}


@end
