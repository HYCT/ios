//
//  USNearProfZoneViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/29.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USNearProfZoneViewController.h"
#import "USNearTopPersonView.h"
#import "USPersonZoneTableViewCell.h"
#import "USPersonZoneView.h"
#import "USCircleDetailViewController.h"
@interface USNearProfZoneViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataView;
@property(nonatomic,strong)USNearTopPersonView *topView;
@property(nonatomic,strong)NSMutableDictionary *paramDic;
@property(nonatomic,strong)UIView *dataTipView;
@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSString *url;
@property(nonatomic,assign)int type;
@property(nonatomic,assign)int totalPage;
@property(nonatomic,assign)int currentPage;
@property(nonatomic,strong)USAccount *account;
@end

@implementation USNearProfZoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _account = [USUserService accountStatic];
    self.title = _account.name;
    [super initRightImgButton];
    _dataView = [NSMutableArray array];
    _msg = @"正在玩命加载...";
    _url = @"wangkaClientController/getCustomerMessageList.action";
    _dataView = [NSMutableArray array];
    _paramDic = [NSMutableDictionary dictionary];
    _paramDic[@"customer_id"] = _customer_id!=nil?_customer_id:_account.id;
    _paramDic[@"pageSize"] = @(kPageSize);
    _paramDic[@"currentPage"] = @(1);
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView setBackgroundColor:[UIColor whiteColor]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.y = 0;
    [self.tableView setTableHeaderView:[self createNearTopPersonView]];
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
-(void)createDataView:(NSArray *)dicData{
    if (dicData!=nil&&dicData.count>0) {
        for (NSDictionary *dic in dicData) {
            USPersonZoneView *contentView = [[USPersonZoneView alloc]initWithDic:dic];
            [_dataView addObject:contentView];
        }
        
    }
}

-(UIView *)createNearTopPersonView{
    if (_customer_id==nil) {
        USNearTopPersonView *topView = [[USNearTopPersonView alloc]initWithFrame:CGRectMake(0, 0, kAppWidth, kAppHeight*0.55)];
        topView.backgroundColor = [UIColor whiteColor];
        return  topView;
    }else{
        USNearTopPersonView *topView = [[USNearTopPersonView alloc]initWithFrame:CGRectMake(0, 0, kAppWidth, kAppHeight*0.55) noMotto:YES customeId:_customer_id supervc:self];
        topView.backgroundColor = [UIColor whiteColor];
        _topView = topView;
        return  topView;
    }
   
}


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
    }
    USPersonZoneView *dataView = [_dataView objectAtIndex:indexPath.row];
    cell.contentView.userInteractionEnabled = YES;
        if (indexPath.row ==0) {
        [dataView setDate:dataView.monthStr flag:YES];
        }else{
         [dataView setDate:dataView.monthStr flag:NO];
        }
    [cell addSubview:dataView];
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     USPersonZoneView *view = [_dataView objectAtIndex:indexPath.row];
    return  view.dyHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0000001f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
   return 0.0000001f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    USCircleDetailViewController *detailVC = [[USCircleDetailViewController alloc]init];
    USPersonZoneView *dataView = _dataView[indexPath.row];
    detailVC.newsId = dataView.dataDic[@"id"];
    detailVC.title = _account.name;
    [self.navigationController pushViewController:detailVC animated:YES];
}
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    view.tintColor = [UIColor clearColor];
}
@end
