//
//  USCirclListTableViewController.m
//  大学生分期
//
//  Created by HeXianShan on 16/1/4.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import "USCirclListTableViewController.h"
#import "USCircleListContentView.h"
#import "USNearProfZoneViewController.h"
#import "USCircleListTableCellView.h"
#import "USCircleDetailViewController.h"
@interface USCirclListTableViewController ()

@property(nonatomic,strong)NSMutableArray *dataView;
@property(nonatomic,strong)NSMutableDictionary *paramDic;
@property(nonatomic,strong)UIView *dataTipView;
@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSString *url;
@property(nonatomic,assign)int totalPage;
@property(nonatomic,assign)int currentPage;
@property(nonatomic,strong)USAccount *account;

@end

@implementation USCirclListTableViewController
-(void)viewDidLoad{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    _account = [USUserService accountStatic];
    _msg = @"正在汪圈子数据...";
    _url = @"wangkaClientController/getWangquanziList.action";
    _dataView = [NSMutableArray array];
    _paramDic = [NSMutableDictionary dictionary];
    _paramDic[@"customer_id"] = _account.id;
    _paramDic[@"pageSize"] = @(kPageSize);
    _paramDic[@"currentPage"] = @(1);
    //加载的数据类型
    _paramDic[@"type"] = _type;
    
    self.tableView.delegate = self;
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    _dataTipView = [USUIViewTool createDataTipViewWithTarget:self action:@selector(loadData)];
    [self setupRefresh];
    
    //初始化
    //_dataList = [NSMutableArray array];
    [self loadData];
}

-(void)loadData{
    [_dataTipView removeFromSuperview];
    [USWebTool POST:_url showMsg:_msg paramDic:_paramDic success:^(NSDictionary *dic) {
        if([dic[@"totalNum"]intValue]>0){
            [self createDataView:dic[@"data"]];
            //[_dataList addObjectsFromArray:dic[@"data"]];
            _currentPage =[dic[@"currentPage"] intValue];
            _totalPage = [dic[@"totalPage"] intValue];
            [_tableView reloadData];
        }else{
            [self.view addSubview:_dataTipView];
        }
        
    } failure:^(id data) {
        
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
    @try {
        NSLog(@"currentPage：%d totalPage ：%d",_currentPage ,_totalPage) ;
        if (_currentPage>=_totalPage ) {
            [MBProgressHUD showSuccess:@"暂时没有更多的数据..."];
        }else if (_currentPage<_totalPage&&_currentPage>0) {
            _currentPage++;
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_paramDic];
            dic[@"currentPage"] = @(_currentPage);
            [USWebTool POST:_url paramDic:dic success:^(NSDictionary *dataDic) {
                _currentPage =[dataDic[@"currentPage"] intValue];
                _totalPage = [dataDic[@"totalPage"] intValue];
                if ([dataDic[@"data"] count]==0) {
                    //_currentPage--;
                    [MBProgressHUD showSuccess:@"暂时没有更多的数据..."];
                    return ;
                }else{
                    [self createDataView:dataDic[@"data"]];
                    //[_dataList addObjectsFromArray:dataDic[@"data"]];
                    [self.tableView reloadData];
                }
                
                
            } failure:^(id data) {
                
            }];
        }else{
            [MBProgressHUD showSuccess:@"暂时没有更多的数据..."];
        }
        [self.tableView footerEndRefreshing];
    }
    @catch (NSException *exception) {
        HYLog(@"%@",exception) ;
    }
    
    
}
-(void)createDataView:(NSArray *)dicData{
    if (dicData!=nil&&dicData.count>0) {
        for (NSDictionary *dic in dicData) {
            USCircleListContentView *contentView = [[USCircleListContentView alloc]initWithDic:dic customerId:_account.id tableview:_tableView navController:self.navigationController];
            contentView.account = _account;
            [_dataView addObject:contentView];
        }
        
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataView.count;
    //return _dataList.count;
}
/**
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 @try {
 NSDictionary *data = _dataList[indexPath.row];
 static NSString *reuseIdentifier = @"wangquanzitableview";
 USCircleListTableCellView *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
 if (cell==nil) {
 cell = [[USCircleListTableCellView alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier dataDic:data
 customerId:_account.id tableview:_tableView navController:self.navigationController];
 
 }
 
 return cell;
 }
 @catch (NSException *exception) {
 HYLog(@"%@",exception) ;
 }
 
 
 }
 **/


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    @try {
        static NSString *reuseIdentifier = @"wangquanzitableview";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
        if (cell==nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
            
        }
        for (UIView *view in cell.subviews) {
            [view removeFromSuperview];
            view.hidden = YES;
            
        }
        USCircleListContentView *view = [_dataView objectAtIndex:indexPath.row];
        cell.contentView.userInteractionEnabled = YES;
        view.hidden = NO;
        [cell addSubview:view];
        return cell;
    }
    @catch (NSException *exception) {
        HYLog(@"%@",exception) ;
    }
    
    
}


//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if (section==0) {
//        return 0.01;
//    }
//    return 9;
//}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    USCircleListContentView *view = [_dataView objectAtIndex:indexPath.row];
    return view.dyHeight;
    //return 400;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    USCircleDetailViewController *detailVC = [[USCircleDetailViewController alloc]init];
    USCircleListContentView *dataView = _dataView[indexPath.row];
    detailVC.newsId = dataView.dataDic[@"id"];
    detailVC.title = _account.name;
    [self.navigationController pushViewController:detailVC animated:YES];
    
}



@end
