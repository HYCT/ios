//
//  USAllRebackViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/9.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USRebackListViewController.h"
#import "USRebackTableViewCell.h"
#import "USRebackViewController.h"
#import "USSegmentView.h"
#import "USMyLoadRebackListViewController.h"
#define kBottomHeight 100
@interface USRebackInnerListViewController: UIViewController<UITableViewDataSource,UITableViewDelegate,USRebackTableViewCellDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,assign)RebackType cellType;
@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,strong)UIButton *rebackButton;
//
@property(nonatomic,strong)NSMutableArray *dataList;
@property(nonatomic,strong)NSMutableDictionary *selectedDataDic;
@property(nonatomic,strong)USAccount *account;
@property(nonatomic,strong)NSString *url;
@property(nonatomic,copy)NSString *msg;
@property(nonatomic,strong) UILabel *accountLabel;
@property(nonatomic,strong)NSMutableDictionary *paramDic;
//
@property(nonatomic,strong)NSMutableArray *planIds;
@property(nonatomic,strong)UIView *dataTipView;
@property(nonatomic,assign)int type;
@property(nonatomic,assign)int totalPage;
@property(nonatomic,assign)int currentPage;
//
@end
@implementation USRebackInnerListViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    _account = [USUserService accountStatic];
    self.view.width = kAppWidth;
    self.view.x = 0;
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    //self.tableView.y = 10;
    self.tableView.height = kAppHeight*0.9;
    [self.view addSubview:self.tableView];
    //self.tableView.height = self.view.height-kBottomHeight;
    //_bottomView = [self createBottom];
    //[self.view addSubview:_bottomView];
    [self setupRefresh];
    [self loadData];
    _dataTipView = [USUIViewTool createDataTipViewWithTarget:self action:@selector(loadData)];
}
-(void)loadData{
    [_dataTipView removeFromSuperview];
    if (_cellType == CurrentReback) {
        _url = @"repaymoneycilent/getCurrentRepayList.action";
        _paramDic = [NSMutableDictionary dictionary];
        [_paramDic setValue:_account.id forKey:@"customer_id"];
        _msg = @"正在玩命加载当前应还款数据...";
    }else if (_cellType == PrePayReback)
    {
        _url = @"repaymoneycilent/getBeforehandRepayList.action";
        _paramDic = [NSMutableDictionary dictionary];
        [_paramDic setValue:_account.id forKey:@"customer_id"];
        _msg = @"正在玩命加载提前应还款数据...";
    }else if(_cellType == FreeReback){
        _url = @"repaymoneycilent/getFreeRepayList.action";
        _msg = @"正在玩命加载免息还款数据...";
        _paramDic = [NSMutableDictionary dictionary];
        [_paramDic setValue:_account.id forKey:@"customer_id"];
        
    }else{
        //return;
        _url = @"repaymoneycilent/getRepayMoneyList.action";
        _msg = @"正在玩命加载待还款数据...";
        _paramDic = [NSMutableDictionary dictionary];
        [_paramDic setValue:_account.id forKey:@"customer_id"];
        [_paramDic setValue:@(kPageSize) forKey:@"pageSize"];
        [_paramDic setValue:@(1) forKey:@"currentPage"];
    }
    [USWebTool POST:_url showMsg:_msg paramDic:_paramDic success:^(NSDictionary *dic) {
        _dataList = [NSMutableArray array];
        if([dic[@"totalNum"]intValue]>0){
            [_dataList addObjectsFromArray:dic[@"data"]];
            [_tableView reloadData];
            _currentPage =[dic[@"currentPage"] intValue];
            _totalPage = [dic[@"totalPage"] intValue];
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
            [_dataList addObjectsFromArray:dataDic[@"data"]];
            [self.tableView reloadData];
            _currentPage =[dataDic[@"currentPage"] intValue];
            _totalPage = [dataDic[@"totalPage"] intValue];
        } failure:^(id data) {
            
        }];
    }
    [self.tableView footerEndRefreshing];
}
-(UIView *)createBottom{
    CGFloat height = 60;
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.height-kBottomHeight-height, kAppWidth, height)];
    [bottomView setBackgroundColor:[UIColor whiteColor]];
    UILabel *accountLabel = [USUIViewTool createUILabel];
    accountLabel.height = bottomView.height;
    accountLabel.y = 0;
    accountLabel.backgroundColor = [UIColor clearColor];
    accountLabel.font = [UIFont systemFontOfSize:kCommonFontSize_18];
    accountLabel.attributedText = [USStringTool createCountBlanceAttrString:0];
    _accountLabel = accountLabel;
    UIButton *rebackBt = [USUIViewTool createButtonWith:@"立即还款" imageName:@"account_reback_bt_ico"];
    _rebackButton = rebackBt;
    _rebackButton.enabled = NO;
    [rebackBt addTarget:self action:@selector(reback) forControlEvents:UIControlEventTouchUpInside];
    rebackBt.height = bottomView.height;
    [rebackBt.titleLabel setFont:[UIFont systemFontOfSize:14]];
    rebackBt.width = 90;
    rebackBt.y = 0;
    rebackBt.x = kAppWidth - rebackBt.width;
    [bottomView addSubview:accountLabel];
    [bottomView addSubview:rebackBt];
    bottomView.userInteractionEnabled = YES;
    return bottomView;
    
}
-(void)reback{
    HYLog(@"立即还款......");
    if (_planIds.count>0) {
        NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
        NSMutableArray *idsMapArray = [NSMutableArray arrayWithCapacity:_planIds.count];
        for (NSString *idstr in _planIds) {
            [idsMapArray addObject:@{@"id":idstr}];
        }
        NSError *error = nil;
        NSData *jsonarrayData = [NSJSONSerialization dataWithJSONObject:idsMapArray options:NSJSONWritingPrettyPrinted error:&error];
        NSString *jsonarrayIdsStr = [[NSString alloc] initWithData:jsonarrayData encoding:NSUTF8StringEncoding];
        [paramDic setValue:@(_type)forKey:@"type"];
        [paramDic setValue:_account.id forKey:@"customer_id"];
        [paramDic setValue:jsonarrayIdsStr forKey:@"jsonarray_id"];
        [USWebTool POST:@"repaymoneycilent/saveRepayList.action" showMsg:@"正在进行还款..." paramDic:paramDic success:^(id data) {
            _type = -1;
            _planIds = [NSMutableArray array];
            _dataList = nil;
            _selectedDataDic = nil;
            [_tableView reloadData];
            [self updateBlance];
            [self loadData];
        } failure:^(id data) {
            
        }];
    }else{
        [MBProgressHUD showError:@"请选择还款项..."];
    }
    
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //return  10;
    return  _dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"CELL_ID_";
    USRebackTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell==nil) {
        cell = [[USRebackTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier type:NoReback_1];
        cell.delegate = self;
    }
    cell.checkButtonTag = indexPath.section;
    cell.accessoryBt.tag = indexPath.section;
    NSDictionary *data = _dataList[indexPath.section];
    [cell setDataWithDic:data];
    /*if (_selectedDataDic ==nil) {
     _selectedDataDic = [NSMutableDictionary dictionary];
     }
     NSString *key = data[@"id"];
     
     if([_selectedDataDic objectForKey:key]!=nil){
     [cell checkedBox];
     }else{
     
     [cell unCheckedBox];
     }*/
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //return  80;
    return  100;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =  [tableView cellForRowAtIndexPath:indexPath];
    UIButton *actbt = (UIButton *)cell.accessoryView;
    if (actbt.enabled) {
        
    }
    /*UITableViewCell *cell =  [tableView cellForRowAtIndexPath:indexPath];
     [cell setSelected:YES animated:YES];
     NSArray *selected = [tableView indexPathsForSelectedRows];
     if (selected) {
     for (NSIndexPath *path in selected){
     cell = [tableView cellForRowAtIndexPath:path];
     [cell setSelected:YES animated:YES];
     [cell setSelectedBackgroundView:nil];
     }
     }*/
    
}

-(void)didSelectButton:(NSInteger)buttonTag flag:(Boolean)flag{
    HYLog(@"ssssssss----%li--",buttonTag);
    /*
     if (_selectedDataDic ==nil) {
     _selectedDataDic = [NSMutableDictionary dictionary];
     }
     
     if (flag) {
     if([_selectedDataDic objectForKey:_dataList[buttonTag][@"id"]]==nil){
     [ _selectedDataDic setValue:_dataList[buttonTag] forKey:_dataList[buttonTag][@"id"]];
     }
     
     }else{
     [_selectedDataDic removeObjectForKey:_dataList[buttonTag][@"id"]];
     }
     [self updateBlance];
     */
    
    USRebackViewController *rebackVC = [[USRebackViewController alloc]init];
    rebackVC.rebackId = _dataList[buttonTag][@"id"];
    [self.navigationController pushViewController:rebackVC animated:YES];
}
-(void)updateBlance{
    CGFloat result = 0;
    NSArray *keys = [_selectedDataDic allKeys];
    if ([keys count]>0) {
        _planIds = [NSMutableArray array];
        _rebackButton.enabled = YES;
        for (NSString *key in keys) {
            [_planIds addObject:key];
            NSDictionary *dic = _selectedDataDic[key];
            result+=[dic[@"repay_total"]floatValue];
            //            if (_cellType!=FreeReback) {
            //                result+=[dic[@"repaymoney_rate"]floatValue];
            //            }
        }
    }else{
        _rebackButton.enabled = NO;
    }
    _accountLabel.attributedText = [USStringTool createCountBlanceAttrString:result];
    
}

@end
@interface USRebackListViewController ()
@property(nonatomic,strong)UIView *innerView;
@property(nonatomic,strong)USAccount *account;
@end

@implementation USRebackListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我要还款";
    [self initRigtBarButton];
    _account = [USUserService accountStatic];
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    /*CGFloat margin = 10;
     CGFloat y = 15;
     CGFloat height = 25;
     CGRect frame = CGRectMake(margin, y, kAppWidth-2*margin, height);
     USSegmentView *segview = [[USSegmentView alloc]initWithTitles:@[@"当期还",@"提前还",@"免息还"] frame:frame];
     y = segview.y+segview.height;
     height = kAppHeight -y;
     segview.clickBlock = ^(NSInteger tag){
     USRebackInnerListViewController *innerListVC = nil;
     if (!innerListVC) {
     switch (tag) {
     case 0:
     {
     innerListVC = [[USRebackInnerListViewController alloc]init];
     innerListVC.cellType = CurrentReback;
     innerListVC.view.y = y;
     innerListVC.view.tag = tag;
     innerListVC.view.height = height;
     innerListVC.type = 0;
     }
     break;
     case 1:
     {
     innerListVC = [[USRebackInnerListViewController alloc]init];
     innerListVC.cellType = PrePayReback;
     innerListVC.view.y = y;
     innerListVC.view.tag = tag;
     innerListVC.view.height = height;
     innerListVC.type = 1;
     }
     break;
     case 2:
     {
     innerListVC = [[USRebackInnerListViewController alloc]init];
     innerListVC.cellType = FreeReback;
     innerListVC.view.y = y;
     innerListVC.view.tag = tag;
     innerListVC.view.height = height;
     innerListVC.type = 2;
     }
     break;
     }
     }
     
     [_innerView removeFromSuperview];
     _innerView = innerListVC.view;
     [self.view addSubview:innerListVC.view];
     [self addChildViewController:innerListVC];
     
     };
     segview.selectedIndex = _selectedIndex;
     [self.view addSubview:segview];
     */
    USRebackInnerListViewController *innerListVC = [[USRebackInnerListViewController alloc]init];
    innerListVC.cellType = NoReback_1;
    //innerListVC.view.tag = tag;
    [self addChildViewController:innerListVC];
    [self.view addSubview:innerListVC.view];
}

- (void)initRigtBarButton {
    //UIImage *backImage = [[UIImage imageNamed:@"right_next_bg"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIButton *rightNextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightNextButton.backgroundColor = [UIColor clearColor];
    UIFont *font = [UIFont systemFontOfSize:kCommonNextFontSize];
    [rightNextButton.titleLabel setFont:font];
    NSString *leftTitle = @"我的记录>";
    [rightNextButton setTitle:leftTitle forState:UIControlStateNormal];
    // [rightNextButton setImage:backImage forState:UIControlStateNormal];
    // [rightNextButton setImage:backImage forState:UIControlStateHighlighted];
    [rightNextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [rightNextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //CGSize size = [leftTitle sizeWithFont:font];
    rightNextButton.size = CGSizeMake(55, 15);
    //rightNextButton.imageEdgeInsets = UIEdgeInsetsMake(0, 40, 0, 0);
    rightNextButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10);
    [rightNextButton.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [rightNextButton addTarget:self action:@selector(record) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightNextButton];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}
-(void)record{
    USMyLoadRebackListViewController *myLoadRebackListVC = [[USMyLoadRebackListViewController alloc]init];
    myLoadRebackListVC.selectedIndex = 0;
    myLoadRebackListVC.loanUrl = @"borrowcilent/getMyBorrowMoneyListByCustomerid.action";
    myLoadRebackListVC.loanParam = @{@"customer_id":_account.id,@"pageSize":@(kPageSize),@"currentPage":@(1)};
    myLoadRebackListVC.loanMsg = @"正在玩命加载借款记录...";
    myLoadRebackListVC.rebackUrl = @"repaymoneycilent/getRepayMoneyListByCustomerid.action";
    myLoadRebackListVC.rebackParam = @{@"customer_id":_account.id,@"pageSize":@(kPageSize),@"currentPage":@(1)};
    myLoadRebackListVC.rebackMsg = @"正在玩命加载还款记录...";
    [self.navigationController pushViewController:myLoadRebackListVC animated:YES];
}



@end
