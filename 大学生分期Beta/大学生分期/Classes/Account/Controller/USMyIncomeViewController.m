//
//  USMyIncomeViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/11.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USMyIncomeViewController.h"
#import "USAccountView.h"
#import "USAccountTableViewController.h"
#import "USAccountApproveView.h"
#import "USAccountHistoryView.h"
#import "USAccountBlanceViewController.h"
#import "USFinancialAssertsViewController.h"
#import "USPerDateRateIncomeViewController.h"
@interface USMyIncomeViewController()<USAccountViewDelegate,USAccountHistoryViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) USAccountView *accountView ;
@property(nonatomic,strong) USAccountHistoryView *histroyView;
@property(nonatomic,strong)UITableView *tableView;
@end
@implementation USMyIncomeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的收益";
    self.navigationController.navigationBar.translucent= NO;
    [self createAccountView];
    [self createAccountHistoryView];
    _histroyView.leftView.upTitle = @"66.44";
    _histroyView.leftView.downTitle = @"累计收益";
    _histroyView.rightView.upTitle = @"1,000.00";
    _histroyView.rightView.downTitle = @"投资本金";
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    self.tableView.y = _histroyView.y+_histroyView.height+5;
    self.tableView.height = (kAppHeight -self.tableView.y)/3;
    [self.view addSubview:self.tableView];
    CGFloat height = (kAppHeight -self.tableView.y)/3-15;
    //
    UIView *view = [USUIViewTool createComplexViewWithTile:@"9%收益，随投随取" imageName:@"account_test_myincom_bg_1" fontSize:17 fontColor:HYCTColor(255, 255, 255) bgsize:CGSizeMake(kAppWidth, height) bgColor:HYCTColor(27, 185, 195)];
    view.x = 0;
    view.y = self.tableView.y+110;
    [self.view addSubview:view];
    CGFloat y = view.y+view.height;
    view = [USUIViewTool createComplexViewWithTile:@"18%收益，安全有保障" imageName:@"account_test_myincom_bg_2" fontSize:17 fontColor:HYCTColor(255, 255, 255) bgsize:CGSizeMake(kAppWidth, height) bgColor:HYCTColor(255, 197, 87)];
    view.x = 0;
    view.y = y;
    [self.view addSubview:view];
}
-(void)createAccountView{
    USAccountView *accountView = [[USAccountView alloc]initWithFrame:CGRectMake(0, 0, kAppWidth, 80)];
    accountView.delegate = self;
    [accountView.blanceTipLabel removeFromSuperview];
    [accountView.borrowingButton removeFromSuperview];
    accountView.blanceLabel.y = 10;
    [accountView.blanceLabel setText:@"0.94"];
    accountView.totalBlanceLabel.y = accountView.blanceLabel.y+accountView.blanceLabel.height;
    [accountView.totalBlanceLabel setFont:[UIFont systemFontOfSize:12]];
    [accountView.totalBlanceLabel setText:@"昨日收(元)"];
    [self.view addSubview:accountView];
    self.accountView = accountView;
}
-(void)createAccountHistoryView{
    USAccountHistoryView *histroyView = [[USAccountHistoryView alloc]initWithFrame:CGRectMake(0, _accountView.y+_accountView.height, kAppWidth, 44)];
    [histroyView.leftView.upLabel setFont:[UIFont boldSystemFontOfSize:12]];
    [histroyView.rightView.upLabel setFont:[UIFont boldSystemFontOfSize:12]];
    _histroyView = histroyView;
    _histroyView.delegate =self;
    [self.view addSubview:histroyView];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, histroyView.y+histroyView.height+1 , kAppWidth, 1)];
    [line setBackgroundColor:HYCTColor(224, 224, 224)];
    [self.view addSubview:line];
}


-(void)didLeftClick:(UIButton *)button{
    HYLog(@"didLeftClick");
    USPerDateRateIncomeViewController *perDateRateIncome = [[USPerDateRateIncomeViewController alloc]init];
    perDateRateIncome.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:perDateRateIncome animated:YES];
}
-(void)didRightClick:(UIButton *)button{
   
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"reuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    }
    [cell.textLabel setTextColor:HYCTColor(166, 166, 166)];
    [cell.textLabel setFont:[UIFont systemFontOfSize:12]];
    [cell.detailTextLabel setFont:[UIFont systemFontOfSize:12]];
    [cell.detailTextLabel setTextColor:HYCTColor(0, 0, 0)];
    cell.accessoryType = UITableViewCellAccessoryNone;
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row==0) {
                cell.textLabel.text = @"总资产(元)";
                cell.detailTextLabel.text = @"1,088.77";
            }else if(indexPath.row==1){
                cell.textLabel.text = @"理财资产";
                cell.detailTextLabel.text = @"1,066.44";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }else if(indexPath.row==2){
                cell.textLabel.text = @"账户余额";
                cell.detailTextLabel.text = @"22.33";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
        }
            break;
        
    }
        return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 5;
    }
    return 9;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  30;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *toCV = nil;
    switch (indexPath.row) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
           
            toCV = [[USFinancialAssertsViewController alloc]init];
        }
            break;
        case 2:
        {
            
            toCV = [[USAccountBlanceViewController alloc]init];
        }
            break;
            
    }
    toCV.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:toCV animated:YES];
}

@end
