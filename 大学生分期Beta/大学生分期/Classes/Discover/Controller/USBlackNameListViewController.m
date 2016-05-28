//
//  USBlackListViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/12.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USBlackNameListViewController.h"
#import "USBlackNameCell.h"
#import "UIImageView+WebCache.h"
@interface USBlackNameListViewController()
@property(nonatomic,strong)USAccount *acount;
@end
@implementation USBlackNameListViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"黑名单";
    //_acount = [USUserService account];
    _url= @"blackCilent/getBlackList.action";
    _param = @{@"currentPage":@(1),@"pageSize":@(kPageSize)};
    _msg = @"正在加载黑名单...";
    [self.view setBackgroundColor:HYCTColor(240, 241, 240)];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent= NO;
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.height = kAppHeight*0.9;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.tableView];
    [self setupRefresh];
    _dataTipView = [USUIViewTool createDataTipViewWithTarget:self action:@selector(loadData)];
    [self loadData];
}
-(void)loadData{
    [_dataTipView removeFromSuperview];
    [USWebTool POSTWithNoTip:_url showMsg:_msg paramDic:_param success:^(NSDictionary *data) {
        
        _currentPage =[data[@"currentPage"] intValue];
        _totalPage = [data[@"totalPage"] intValue];
        if ([data[@"totalNum"] intValue]==0) {
            [self.view addSubview:_dataTipView];
            return ;
        }
        if (_dataArrayList == nil) {
            _dataArrayList = [NSMutableArray arrayWithCapacity:[data[@"data"] count]];
            
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
            
        }];
    }
    [self.tableView footerEndRefreshing];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _dataArrayList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return 1;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"reuseIdentifier";
    USBlackNameCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell==nil) {
        cell = [[USBlackNameCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSDictionary *data = _dataArrayList[indexPath.section];
    NSString *imgurl = data[@"headpic"];
    if (imgurl!=nil&&imgurl.length>0) {
        imgurl = HYWebDataPath(imgurl);
        [cell.header sd_setImageWithURL:[NSURL URLWithString:imgurl]];
    }
    cell.nameLB.text = data[@"name"];
    cell.warinLB.text = data[@"black_type_label"];
    cell.textView.text = data[@"black_content"];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 230;
}


@end
