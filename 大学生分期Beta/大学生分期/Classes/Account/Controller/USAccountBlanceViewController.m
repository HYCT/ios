//
//  USAccountBlanceViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/11.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USAccountBlanceViewController.h"
#import "USAccountView.h"
#import "USAccountTableViewController.h"
#import "USAccountApproveView.h"
#import "USAccountHistoryView.h"
@interface USAccountBlanceViewController()<USAccountViewDelegate,USAccountHistoryViewDelegate>
@property(nonatomic,strong) USAccountView *accountView ;
@property(nonatomic,strong) USAccountHistoryView *histroyView;
@end

@implementation USAccountBlanceViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"账户余额";
    self.navigationController.navigationBar.translucent= NO;
    [self createAccountView];
    [self createAccountHistoryView];
    _histroyView.leftView.downTitle = @"提现";
    _histroyView.rightView.downTitle = @"充值";
   //
    UILabel *tip = [USUIViewTool createUILabel];
    [tip setTextColor:HYCTColor(168, 168, 168)];
    tip.y = _histroyView.y+_histroyView.height+15;
    [tip setFont:[UIFont systemFontOfSize:10]];
    [tip setText:@"提现:账户余额不产生收益,购买日息宝才有收益噢"];
    [self.view addSubview:tip];
    //
    UIButton *finishButton = [USUIViewTool createButtonWith:@"立即投钱赚钱" imageName:@"login_bt_img"];
    finishButton.frame = CGRectMake(10, tip.y+tip.height+15, kAppWidth-20, 35);
    [self.view addSubview: finishButton];
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
    [accountView.totalBlanceLabel setText:@"账户余额(元)"];
    [self.view addSubview:accountView];
    self.accountView = accountView;
}
-(void)createAccountHistoryView{
    USAccountHistoryView *histroyView = [[USAccountHistoryView alloc]initWithFrame:CGRectMake(0, _accountView.y+_accountView.height, kAppWidth, 30)];
    [histroyView.leftView.upLabel removeFromSuperview];
    [histroyView.rightView.upLabel removeFromSuperview];
    _histroyView = histroyView;
    _histroyView.delegate =self;
    [self.view addSubview:histroyView];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, histroyView.y+histroyView.height+1 , kAppWidth, 1)];
    [line setBackgroundColor:HYCTColor(224, 224, 224)];
    [self.view addSubview:line];
}
-(void)didLeftClick:(UIButton *)button{
    HYLog(@"didLeftClick");
    
}
-(void)didRightClick:(UIButton *)button{
    
}
@end
