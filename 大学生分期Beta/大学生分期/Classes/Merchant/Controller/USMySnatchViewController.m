//
//  USMySnatchViewController.m
//  大学生分期
//
//  Created by HeXianShan on 16/1/6.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import "USMySnatchViewController.h"
#import "USUpImageDownLabelView.h"
#import "USUpLoadImageServiceTool.h"
#import "USMySnatchView.h"
@interface USMySnatchViewController ()<UITableViewDataSource,UITableViewDelegate,USMySnatchViewDelegate>
@property(nonatomic,strong) USUpImageDownLabelView *upImgDownLBView;
@property(nonatomic,strong)USUpLoadImageServiceTool *upLoadImageService;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataView;
@property(nonatomic,strong)NSMutableDictionary *paramDic;
@property(nonatomic,strong)UIView *dataTipView;
@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSString *url;
@property(nonatomic,assign)int type;
@property(nonatomic,assign)int totalPage;
@property(nonatomic,assign)int currentPage;
@property(nonatomic,strong)USAccount *account;
@end

@implementation USMySnatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent= NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.title = @"我的夺宝";
    _account = [USUserService accountStatic];
    _dataView = [NSMutableArray array];
    _msg = @"正在加载...";
    _url = @"indianaJohnsClient/getMyjoinRecorder.action";
    _dataView = [NSMutableArray array];
    _paramDic = [NSMutableDictionary dictionary];
    _paramDic[@"customer_id"] = _account.id;
    _paramDic[@"pageSize"] = @(kPageSize);
    _paramDic[@"currentPage"] = @(1);
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView setTableHeaderView:[self createNearTopPersonView]];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.view.backgroundColor = HYCTColor(240, 240, 240);
    self.tableView.backgroundColor = HYCTColor(240, 240, 240);
    [self.view addSubview:self.tableView];
    //设置高度
    //[self.tableView setHeight:self.view.height - 80];
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
            USMySnatchView *view = [[USMySnatchView alloc]initWithDic:dic];
            [_dataView addObject:view];
        }
        
    }
}
//

-(UIView *)createNearTopPersonView{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kAppWidth, 100)];
    topView.userInteractionEnabled = YES;
    topView.backgroundColor = HYCTColor(240, 240, 240);
    USUpImageDownLabelView *upImgDownLBView = [[USUpImageDownLabelView alloc]initWithFrame:CGRectMake(0, 15, kAppWidth, 100)];
    _upImgDownLBView = upImgDownLBView;
    [upImgDownLBView setBackgroundColor:[UIColor clearColor]];
    upImgDownLBView.personImageView.size = CGSizeMake(57, 57);
    if (_account!=nil) {
        upImgDownLBView.personImageView.image = _account.headerImg;
        [upImgDownLBView.accountNameLabel setText:_account.name];
    }else{
        upImgDownLBView.personImageView.image = [UIImage imageNamed:@"account_seconde_image"];
        [upImgDownLBView.accountNameLabel setText:@"未知"];
    }
    //    UIButton *carmera = [USUIViewTool createButtonWith:@"" imageName:@"account_camera"];
    //    carmera.frame = CGRectMake(_upImgDownLBView.personImageView.width*0.80+_upImgDownLBView.personImageView.x, _upImgDownLBView.personImageView.height*0.9-kPhotoImageSize, kPhotoImageSize, kPhotoImageSize);
    //    [_upImgDownLBView addSubview:carmera];
    //    //[carmera addTarget:self action:@selector(carmera) forControlEvents:UIControlEventTouchUpInside];
    //
    upImgDownLBView.accountNameLabel.height = 25;
    [upImgDownLBView.accountNameLabel setTextColor:[UIColor blackColor]];
    [upImgDownLBView updateFrame];
    upImgDownLBView.accountNameLabel.y-=5;
    [topView addSubview:upImgDownLBView];
    return  topView;
}

-(void)didDetailClick:(USMySnatchView *)detail{
    // NSInteger row = [_dataView indexOfObject:detail];
    //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:row];
    //[_tableView reloadData];
    //[_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    //NSIndexSet *sectionSet = [NSIndexSet indexSetWithIndex:row];
    //[_tableView reloadSections:sectionSet withRowAnimation:UITableViewRowAnimationNone];
}

#pragma tableDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  _dataView.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"reuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        
    }
    
    for (UIView *view in cell.subviews) {
        [view removeFromSuperview];
    }
    USMySnatchView *view = [_dataView objectAtIndex:indexPath.section];
    cell.backgroundColor = [UIColor clearColor];
    [cell addSubview:view];
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    USMySnatchView *view = [_dataView objectAtIndex:indexPath.row];
    return  view.height;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0000001f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //    USCircleDetailViewController *detailVC = [[USCircleDetailViewController alloc]init];
    //    USPersonZoneView *dataView = _dataView[indexPath.row];
    //    detailVC.newsId = dataView.dataDic[@"id"];
    //    detailVC.title = _account.name;
    //    [self.navigationController pushViewController:detailVC animated:YES];
}
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    view.tintColor = [UIColor clearColor];
}

@end
