//
//  USFinancialAssertsViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/11.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USFinancialAssertsViewController.h"
#import "USAccountView.h"
#import "USAccountApproveView.h"
#import "USAccountHistoryView.h"
#import "USFinanceAssertsCell.h"
#import "USPerDateRateIncomeViewController.h"
#import "USExchangeDetailViewController.h"
@interface USFinancialAssertsViewController()<USAccountViewDelegate,USAccountHistoryViewDelegate>
@property(nonatomic,strong) USAccountView *accountView ;
@property(nonatomic,strong) USAccountHistoryView *histroyView;
@end
@implementation USFinancialAssertsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"理财资产";
    self.navigationController.navigationBar.translucent= NO;
    [self createAccountView];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.y =_accountView.y+_accountView.height + 15;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.tableView];

}
-(void)createAccountView{
    USAccountView *accountView = [[USAccountView alloc]initWithFrame:CGRectMake(0, 0, kAppWidth, 80)];
    accountView.delegate = self;
    [accountView.blanceTipLabel removeFromSuperview];
    [accountView.borrowingButton removeFromSuperview];
    accountView.blanceLabel.y = 10;
    [accountView.blanceLabel setText:@"1066.44"];
    accountView.totalBlanceLabel.y = accountView.blanceLabel.y+accountView.blanceLabel.height;
    [accountView.totalBlanceLabel setFont:[UIFont systemFontOfSize:12]];
    [accountView.totalBlanceLabel setText:@"理财总资产(元)"];
    [self.view addSubview:accountView];
    self.accountView = accountView;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"reuseIdentifier";
    USFinanceAssertsCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell==nil) {
        cell = [[USFinanceAssertsCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    }
    [cell.todetailBt addTarget:self action:@selector(todetailLit:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
-(void)todetailLit:(UIButton *)button{
    USExchangeDetailViewController *exchangeVC = [[USExchangeDetailViewController alloc]init];
    [self.navigationController pushViewController:exchangeVC animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    return 9;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  130;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
}

@end
