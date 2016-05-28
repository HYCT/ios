//
//  USLoanRebackTableViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/10/19.
//  Copyright © 2015年 hongyunct. All rights reserved.
//

#import "USLoanRebackTableViewController.h"
#import "USLoadRebackRecordCellView.h"
@interface USLoanRebackTableViewController()
@property(nonatomic,strong)UIView *dataTipView;
@end
@implementation USLoanRebackTableViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.y = _y;
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.height = (self.view.height-_y)*0.88;
    self.tableView.y = 0;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    if (_cellType == RebackType) {
        self.tableView.separatorStyle = NO;
    }else{
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    [self setupRefresh];
    _dataTipView = [USUIViewTool createDataTipViewWithTarget:self action:@selector(loadData)];
    [self loadData];
}
-(void)loadData{
    [_dataTipView removeFromSuperview];
    [USWebTool POSTWithNoTip:_url showMsg:_msg paramDic:_param success:^(NSDictionary *data) {
        if (_dataArrayList == nil) {
            _dataArrayList = [NSMutableArray arrayWithCapacity:[data[@"data"] count]];
           
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
            
        }];
    }
    [self.tableView footerEndRefreshing];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_cellType == RebackType) {
        return 1;
    }
    return  _dataArrayList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_cellType == RebackType) {
        return _dataArrayList.count;
    }
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"reuseIdentifier";
    USLoadRebackRecordCellView *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    cell.cellType = _cellType;
    if (cell==nil) {
        cell = [[USLoadRebackRecordCellView alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier type:_cellType];
    }
    NSDictionary * data = nil;
    if (_cellType == RebackType) {
        data = _dataArrayList[indexPath.row];
    }else{
        data = _dataArrayList[indexPath.section];
    }
    [cell setDataWithDic:data];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (_cellType == RebackType) {
        return 1;
    }
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (_cellType == RebackType) {
        return 1;
    }
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_cellType == RebackType) {
        return 60;
    }
    
    return  120;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //    NSArray *selected = [tableView indexPathsForSelectedRows];
//    if (selected) {
//        for (NSIndexPath *path in selected){
//            UITableViewCell *cell = [tableView cellForRowAtIndexPath:path];
//            [cell setSelected:YES animated:YES];
//        }
//    }
    
}

@end
