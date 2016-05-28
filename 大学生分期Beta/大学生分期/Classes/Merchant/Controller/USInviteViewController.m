//
//  USInviteViewController.m
//  大学生分期
//
//  Created by HeXianShan on 16/1/9.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import "USInviteViewController.h"
#import "USSenInivteViewController.h"
#import "USInviteView.h"
#import "USMyInviteViewController.h"
@interface USInviteViewController ()
@property(nonatomic,strong)NSMutableArray *dataDicList;
@property(nonatomic,strong)NSMutableDictionary *paramDic;
@property(nonatomic,strong)UIView *dataTipView;
@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSString *url;
@property(nonatomic,assign)int totalPage;
@property(nonatomic,assign)int currentPage;
@property(nonatomic,strong)USAccount *account;
@property(nonatomic,strong)NSMutableDictionary *viewHeigthDic;
@end

@implementation USInviteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"热门邀约";
    self.navigationController.navigationBar.translucent= NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.height = (kAppHeight -60)*0.99;
    self.tableView.y =30;
    //UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kAppWidth, 10)];
  //  headerView.backgroundColor = self.view.backgroundColor;
    //[self.tableView setTableHeaderView:headerView];
    _viewHeigthDic = [NSMutableDictionary dictionary];
    _account = [USUserService accountStatic];
    _msg = @"正在加载邀约...";
    _url = @"wangkaInviterClientcontroller/getInviterList.action";
    _dataDicList = [NSMutableArray array];
    
    _paramDic = [NSMutableDictionary dictionary];
    _paramDic[@"customer_id"] = _account.id;
    _paramDic[@"pageSize"] = @(kPageSize);
    _paramDic[@"currentPage"] = @(1);
    self.tableView.delegate = self;
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self initTopButton];
    _dataTipView = [USUIViewTool createDataTipViewWithTarget:self action:@selector(loadData)];
    [self setupRefresh];
}

-(void)loadData{
    dispatch_async(dispatch_get_main_queue(), ^{
        [_dataTipView removeFromSuperview];
        _dataDicList = [NSMutableArray array];
        _viewHeigthDic = [NSMutableDictionary dictionary];
        [USWebTool POST:_url showMsg:_msg paramDic:_paramDic success:^(NSDictionary *dic) {
            if([dic[@"totalNum"]intValue]>0){
                _currentPage =[dic[@"currentPage"] intValue];
                _totalPage = [dic[@"totalPage"] intValue];
                [_dataDicList addObjectsFromArray:dic[@"data"]];
                [_tableView reloadData];
            }else{
                [self.view addSubview:_dataTipView];
            }
            
        } failure:^(id data) {
            
        }];
 
    });
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
            [_dataDicList addObjectsFromArray:dic[@"data"]];
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
    return _dataDicList.count;
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
    USInviteView *view = [[USInviteView alloc]initWithDic:_dataDicList[indexPath.row] superVC:self];
    cell.contentView.userInteractionEnabled = YES;
    view.hidden = NO;
    cell.backgroundColor = [UIColor clearColor];
    [cell addSubview:view];
    _viewHeigthDic[@(indexPath.row)] = @(view.dyHeight);
    return cell;
}


//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 0.00001;
//}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = [_viewHeigthDic[@(indexPath.row)] floatValue];
    return height;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
}

//发起邀约按钮
-(void)initTopButton{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kAppWidth, 60)];
    UIButton *topButton = [USUIViewTool createButtonWith:@"发起邀约"];
    topButton.font = [UIFont systemFontOfSize:14] ;
    topButton.backgroundColor = [UIColor orangeColor];
    topButton.frame = CGRectMake(bgView.width*0.25, (bgView.height-30)/2, bgView.width*0.5, 30);
    topButton.layer.cornerRadius = topButton.height*0.5;
    topButton.layer.masksToBounds = YES;
    [bgView addSubview:topButton];
    [self.view addSubview:bgView];
     [topButton addTarget:self action:@selector(inviteClick) forControlEvents:UIControlEventTouchUpInside];
}
-(void)inviteClick{
    USSenInivteViewController *invc = [[USSenInivteViewController alloc]init];
    invc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:invc animated:YES];
}
- (void)initRigtBarButton {
    UIImage *backImage = [[UIImage imageNamed:@"right_next_bg"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIButton *rightNextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightNextButton.backgroundColor = [UIColor clearColor];
    UIFont *font = [UIFont systemFontOfSize:kCommonNextFontSize];
    [rightNextButton.titleLabel setFont:font];
    NSString *leftTitle = @"我的邀约";
    [rightNextButton setTitle:leftTitle forState:UIControlStateNormal];
    [rightNextButton setImage:backImage forState:UIControlStateNormal];
    [rightNextButton setImage:backImage forState:UIControlStateHighlighted];
    [rightNextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [rightNextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightNextButton.size = CGSizeMake(95, 15);
    rightNextButton.imageEdgeInsets = UIEdgeInsetsMake(0, 80, 0, 0);
    rightNextButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [rightNextButton.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [rightNextButton addTarget:self action:@selector(record) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightNextButton];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

-(void)record{
    USMyInviteViewController *myIvitVC = [[USMyInviteViewController alloc]init];
    myIvitVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:myIvitVC animated:YES];
   
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self performSelectorInBackground:@selector(loadData) withObject:nil];
}
@end
