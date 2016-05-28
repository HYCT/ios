//
//  USIvitRecordViewController.m
//  大学生分期
//
//  Created by HeXianShan on 16/1/10.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import "USInvitRecordViewController.h"
#import "USUSInvitRecordView.h"
@interface USInvitRecordViewController ()
@property(nonatomic,strong)NSMutableDictionary *paramDic;
@property(nonatomic,strong)UIView *dataTipView;
@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSString *url;
@property(nonatomic,assign)int totalPage;
@property(nonatomic,assign)int currentPage;
@property(nonatomic,strong)USAccount *account;
@property(nonatomic,strong) NSMutableArray *dataView;
@end

@implementation USInvitRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title  = @"邀约报名记录";
    self.navigationController.navigationBar.translucent= NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = HYCTColor(240, 240, 240);
    self.view.backgroundColor = [UIColor clearColor];
   
    _account = [USUserService accountStatic];
    _msg = @"正在加载...";
    _url = @"wangkaInviterClientcontroller/getInviterEnterList.action";
    _paramDic = [NSMutableDictionary dictionary];
    _paramDic[@"inviter_id"] = _inviter_id;
    _paramDic[@"pageSize"] = @(kPageSize);
    _paramDic[@"currentPage"] = @(1);
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.height = kAppHeight*0.95;
    self.tableView.delegate = self;
    [self.tableView setBackgroundColor:[UIColor whiteColor]];
    self.tableView.separatorStyle = UITableViewCellAccessoryNone ;
    self.tableView.y =-32 ;
    [self.view addSubview:self.tableView];
    
    _dataView = [NSMutableArray array];
    _dataTipView = [USUIViewTool createDataTipViewWithTarget:self action:@selector(loadData)];
    
    [self setupRefresh];
    [self loadData];
}

-(void)loadData{
    [_dataTipView removeFromSuperview];
    _dataView = [NSMutableArray array];
    [USWebTool POST:_url showMsg:_msg paramDic:_paramDic success:^(NSDictionary *dic) {
        if([dic[@"totalNum"]intValue]>0){
            _currentPage =[dic[@"currentPage"] intValue];
            _totalPage = [dic[@"totalPage"] intValue];
            [self createDataView:dic[@"data"]];
            [_tableView reloadData];
        }else{
            [self.view addSubview:_dataTipView];
        }
        
    } failure:^(id data) {
        
    }];
}

-(void)createDataView:(NSArray *)dicData{
    if (dicData!=nil&&dicData.count>0) {
        for (NSDictionary *dic in dicData) {
            USUSInvitRecordView *view = [[USUSInvitRecordView alloc]initWithDic:dic];
             [_dataView addObject:view];
        }
        
        
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
            [self createDataView:dic[@"data"]];
            [self.tableView reloadData];
            _currentPage =[dataDic[@"currentPage"] intValue];
            _totalPage = [dataDic[@"totalPage"] intValue];
        } failure:^(id data) {
            
        }];
    }
    [self.tableView footerEndRefreshing];
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
        view.hidden = YES;
        
    }
    USUSInvitRecordView *view = _dataView[indexPath.row];
    cell.contentView.userInteractionEnabled = YES;
    view.hidden = NO;
    cell.backgroundColor = [UIColor clearColor];
    [cell addSubview:view];
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    USUSInvitRecordView *view = _dataView[indexPath.row];
    return view.height;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end
