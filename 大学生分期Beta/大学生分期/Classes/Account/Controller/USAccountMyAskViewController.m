//
//  USMyAskViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/3.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USAccountMyAskViewController.h"
#import "USMyAskTableViewCell.h"
#define kMargin 10
#define kPadding 5
#define kMarginTop 20

@interface USAccountMyAskViewController()
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong) UILabel *payeAbleTip;
@property(nonatomic,strong) UILabel *payedTip;
@property(nonatomic,copy)NSString *pageUrl;
@property(nonatomic,copy)NSString *msg;
@property(nonatomic,strong)NSMutableArray *dataArrayList;
@property(nonatomic,assign)int currentPage;
@property(nonatomic,assign)int totalPage;
@property(nonatomic,strong)USAccount *account;
@property(nonatomic,strong)NSDictionary *pageParam;
@end
@implementation USAccountMyAskViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"我的邀请记录";
    _currentPage = 1;
    _totalPage = 1;
    _pageUrl = @"invitercilent/getMyInviterListByCustomerid.action";
    _account = [USUserService accountStatic];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent= NO;
    self.view.backgroundColor = HYCTColor(240, 240, 240);
    UILabel *payeAbleTip = [USUIViewTool createUILabelWithTitle:@"" fontSize:kCommonFontSize_18 color:HYCTColor(98, 98, 98) heigth:kCommonFontSize_18];
    _payeAbleTip = payeAbleTip;
    payeAbleTip.frame = CGRectMake(kMargin, kMargin, kAppWidth-kMargin*2, 15);
    payeAbleTip.attributedText = [self createCountBlanceAttrString:@"应奖励人民币:%@元" result:0];
    [self.view addSubview:payeAbleTip];
    UILabel *payedTip = [USUIViewTool createUILabelWithTitle:@"" fontSize:kCommonFontSize_18 color:HYCTColor(98, 98, 98) heigth:kCommonFontSize_18];
    _payedTip = payedTip;
    payedTip.frame = CGRectMake(kMargin, kMargin*2+payeAbleTip.height+payeAbleTip.y, kAppWidth-kMargin*2, 15);
    payedTip.attributedText = [self createCountBlanceAttrString:@"已奖励人民币:%@元" result:0];
    [self.view addSubview:payedTip];
    UIView *hrozenView = [self createHrozonUILables:payedTip.y+payedTip.height+kMarginTop];
    [self.view addSubview:hrozenView];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.y = hrozenView.y+hrozenView.height;
    self.tableView.height = kAppHeight*0.65;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    [self setupRefresh];
    [self loadData];
    
}
-(void)loadData{
    [USWebTool POSTWithNoTip:@"invitercilent/getMyInviterRewardByCustomerid.action" showMsg:@"" paramDic:@{@"customer_id":_account.id} success:^(NSDictionary *dataDic) {
        _payeAbleTip.attributedText = [self createCountBlanceAttrString:@"应奖励人民币:%@元" resultStr:dataDic[@"data"][@"sum_should_reward"]];
        _payedTip.attributedText = [self createCountBlanceAttrString:@"已奖励人民币:%@元" resultStr:dataDic[@"data"][@"sum_reward"]];
    }];
    _pageParam = @{@"customer_id":_account.id,
                   @"pageSize":@(kPageSize),
                   @"currentPage":@(_currentPage)};
    [USWebTool POSTWithNoTip:_pageUrl showMsg:@""
                    paramDic: _pageParam
                     success:^(NSDictionary *dataDic) {
                         if (_dataArrayList == nil) {
                             _dataArrayList = [NSMutableArray array];
                         }
                         [_dataArrayList addObjectsFromArray:dataDic[@"data"]];
                         _currentPage =[dataDic[@"currentPage"] intValue];
                         _totalPage = [dataDic[@"totalPage"] intValue];
                         [_tableView reloadData];
                     }];
}
//
-(NSMutableAttributedString *)createCountBlanceAttrString:(NSString *)formater resultStr:(NSString *)resultstr{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:formater,resultstr]];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kCommonFontSize_18] range:NSMakeRange(0,str.length)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(7,str.length-8)];
    return str;
}
-(NSMutableAttributedString *)createCountBlanceAttrString:(NSString *)formater result:(CGFloat)result{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:formater,[USStringTool getCurrencyStr:result]]];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kCommonFontSize_18] range:NSMakeRange(0,str.length)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(7,str.length-8)];
    return str;
}
-(UIView *)createHrozonUILables:(CGFloat)y{
    UIView *bigViw = [[UIView alloc]initWithFrame:CGRectMake(0, y, kAppWidth, 40)];
    bigViw.backgroundColor = HYCTColor(230, 230, 230);
    UILabel *nameLB = [self createUILable:@"    用户名" width:kNameWidth];
    nameLB.frame = CGRectMake(0, 0,kNameWidth, 40);
    [bigViw addSubview:nameLB];
    //
    UILabel *registerLB = [self createUILable:@"注册" width:kRegisterWidth];
    registerLB.frame = CGRectMake(nameLB.x+nameLB.width+kPadding, 0,kRegisterWidth, 40);
    registerLB.textAlignment = NSTextAlignmentCenter;
    [bigViw addSubview:registerLB];
    //
    UILabel *identityLB = [self createUILable:@"认证" width:kIdentityWidth];
    identityLB.frame = CGRectMake(registerLB.x+registerLB.width+kPadding, 0,kIdentityWidth, 40);
    identityLB.textAlignment = NSTextAlignmentCenter;
    [bigViw addSubview:identityLB];
    //
    UILabel *awardLB = [self createUILable:@"奖励" width:kAwardWidth];
    awardLB.frame = CGRectMake(identityLB.x+identityLB.width+kPadding, 0,kAwardWidth, 40);
    awardLB.textAlignment = NSTextAlignmentCenter;
    [bigViw addSubview:awardLB];
    return bigViw;
}
-(UILabel *)createUILable:(NSString *)title width:(CGFloat) width{
    UILabel *uiLB = [USUIViewTool createUILabelWithTitle:title fontSize:kCommonFontSize_18 color:HYCTColor(84, 84, 84) heigth:40];
    uiLB.width = width;
    //uiLB.backgroundColor = [UIColor redColor];
    return uiLB;
}

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
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_pageParam];
        dic[@"currentPage"] = @(_currentPage);
        [USWebTool POST:_pageUrl paramDic:dic success:^(NSDictionary *dataDic) {
            if ([dataDic[@"data"]count]==0) {
                _currentPage--;
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
//
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArrayList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"reuseIdentifier";
    USMyAskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell==nil) {
        cell = [[USMyAskTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
        
    }
    [cell setDataWithDic: _dataArrayList[indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.00001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  45;
}
@end
