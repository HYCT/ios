//
//  USAddBankCardViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/9.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USCommonBankCardListViewController.h"
#import "USBindBankHuifuAccountViewController.h"
#import "USBindBankCardViewController.h"
#import "USBankCardCell.h"

@interface USCommonBankCardListViewController()
@property(nonatomic,strong)NSArray *bankCardList;
@property(nonatomic,strong)USAccount *account;
@property(nonatomic,strong)NSString *type ;
@end
@implementation USCommonBankCardListViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    
    
    
    self.title = @"我的银行卡";
    _account = [USUserService accountStatic];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent= NO;
    [self.view setBackgroundColor:HYCTColor(240, 241, 240)];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    self.tableView.y = 15;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.x = 10;
    
    
    [self.view addSubview:self.tableView];
    
    [self loadBankCardlist] ;
}

-(void)loadBankCardlist{
    
    [USWebTool POST:@"bindbankcardcilent/bindBankCardlist.action" showMsg:@"正在玩命获取你绑定的银行卡..." paramDic:@{@"customer_id":_account.id} success:^(NSDictionary *dic) {
        _bankCardList = dic[@"data"];
        [_tableView reloadData];
    } failure:^(id data) {
        _bankCardList = nil;
        [_tableView reloadData];
    }];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  [_bankCardList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"reuseIdentifier";
    USBankCardCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell==nil) {
        cell = [[USBankCardCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    [cell setDateWithDic:_bankCardList[indexPath.section]];
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  120;
}


//当击行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *data = _bankCardList[indexPath.row];
     [self.navigationController popViewControllerAnimated:YES] ;
    if (_bankCardListCommonDelegate != nil) {
        [ _bankCardListCommonDelegate BankCardListClickReturn:data type:_type] ;
    }
   
}

@end
