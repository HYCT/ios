//
//  USMoreMessageViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/12.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USMoreMessageViewController.h"
#import "USMessageCellView.h"
@interface USMoreMessageViewController()

@property(nonatomic,strong)NSMutableArray *dataView;
@property(nonatomic,strong) USAccount *account;
@property(nonatomic,strong)NSMutableDictionary *paramDic;
@property(nonatomic,assign)int currentPage;
@property(nonatomic,assign)int totalPage;
@property(nonatomic,strong)UIView *dataTipView;
@property(nonatomic,strong)UIImage *headerPic;
@property(nonatomic,strong)NSString *url ;
@end
@implementation USMoreMessageViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"消息";
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
    
    _dataView = [NSMutableArray array];
    
    //用户
    _account = [USUserService accountStatic];
    _paramDic = [NSMutableDictionary dictionary];
    
    _paramDic[@"customer_id"] = _account.id;
    _paramDic[@"pageSize"] = @(kPageSize);
    _currentPage=1 ;
    _paramDic[@"currentPage"] = @(_currentPage);
    _url=@"messageclient/getCustomerMessage.action";
    
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
    [_dataTipView removeFromSuperview];
    [USWebTool POSTPageWIthTip:_url showMsg:@"请稍后..." paramDic:_paramDic success:^(NSDictionary *dic) {
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
    if (_currentPage>=_totalPage) {
        [MBProgressHUD showSuccess:@"暂时没有更多的数据..."];
    }else
        if (_currentPage<_totalPage&&_currentPage>0) {
            _currentPage++;
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_paramDic];
            dic[@"currentPage"] = @(_currentPage);
            [USWebTool POST:_url paramDic:dic success:^(NSDictionary *dataDic) {
                _currentPage =[dataDic[@"currentPage"] intValue];
                _totalPage = [dataDic[@"totalPage"] intValue];
                if ([dataDic[@"data"] count]==0) {
                    //_currentPage--;
                    [MBProgressHUD showSuccess:@"暂时没有更多的数据......"];
                }else{
                    //[_dataList addObjectsFromArray:dataDic[@"data"]];
                    [self createDataView:dataDic[@"data"]];
                    [self.tableView reloadData];
                }
                
            } failure:^(id data) {
                
            }];
        }else{
            [MBProgressHUD showSuccess:@"暂时没有更多的数据..."];
        }
    [self.tableView footerEndRefreshing];
}


/**
 **createDataView
 **/
-(void)createDataView:(NSArray *)dicData{
    if (dicData!=nil&&dicData.count>0) {
        for (NSDictionary *dic in dicData) {
            USMessageCellView *contentView = [[USMessageCellView alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"reuseIdentifier_message" data:dic];
            [_dataView addObject:contentView];
        }
        
    }
}

///
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataView.count;
}

//行内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"reuseIdentifier_message";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
        
    }
    
    for (UIView *view in cell.subviews) {
        [view removeFromSuperview];
        view.hidden = YES;
        
    }
    USMessageCellView *view = [_dataView objectAtIndex:indexPath.row];
    cell.contentView.userInteractionEnabled = YES;
    view.hidden = NO;
    [cell addSubview:view];
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
//高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    USMessageCellView *cell = [_dataView objectAtIndex: indexPath.row];
    return cell.height;
    //return 80 ;
}
//当击行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
