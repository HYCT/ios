//
//  USProductRecommdViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/12.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USProductRecommdViewController.h"
#import "USBorrowAccountInfoView.h"
@implementation USProductRecommdViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"产品推荐";
    [self.view setBackgroundColor:HYCTColor(240, 241, 240)];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent= NO;
    USBorrowAccountInfoView *accountBrowView = [[USBorrowAccountInfoView alloc]initWithFrame:CGRectZero];
    accountBrowView.height = 50;
    accountBrowView.y = 15;
    [accountBrowView setBackgroundColor:[UIColor clearColor]];
    [accountBrowView.backgroundView setBackgroundColor:[UIColor clearColor]];
    accountBrowView.personImageView.size = CGSizeMake(40, 40);
    
    accountBrowView.personImageView.image = [UIImage imageNamed:@"discover_sy"];
    //[accountBrowView setBackgroundColor:[UIColor redColor]];
    [accountBrowView.bgImgeView removeFromSuperview];
    [accountBrowView.accountNameLabel setText:@"今日收益"];
    [accountBrowView.accountNameLabel setFont:[UIFont systemFontOfSize:8]];
    accountBrowView.accountNameLabel.y = accountBrowView.personImageView.y+accountBrowView.personImageView.height;
    [accountBrowView.accountNameLabel setTextColor:[UIColor blackColor]];
    [accountBrowView updateFrame];
    [self.view addSubview:accountBrowView];
    UILabel *comInLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, accountBrowView.y+accountBrowView.height+5, kAppWidth, 40)];
    [comInLabel setText:@"1.28"];
    [comInLabel setTextAlignment:NSTextAlignmentCenter];
    [comInLabel setFont:[UIFont systemFontOfSize:40]];
    [comInLabel setTextColor:[UIColor blackColor]];
    [self.view addSubview:comInLabel];
    //
    CGFloat height = (kAppHeight -comInLabel.y-comInLabel.height)/3-15;
    //
    UIView *view = [USUIViewTool createComplexViewWithTile:@"9%收益，随投随取" imageName:@"account_test_myincom_bg_1" fontSize:17 fontColor:HYCTColor(255, 255, 255) bgsize:CGSizeMake(kAppWidth, height) bgColor:HYCTColor(27, 185, 195)];
    view.x = 0;
    view.y = comInLabel.y+comInLabel.height+20;
    [self.view addSubview:view];
    CGFloat y = view.y+view.height;
    view = [USUIViewTool createComplexViewWithTile:@"18%收益，安全有保障" imageName:@"account_test_myincom_bg_2" fontSize:17 fontColor:HYCTColor(255, 255, 255) bgsize:CGSizeMake(kAppWidth, height) bgColor:HYCTColor(255, 197, 87)];
    view.x = 0;
    view.y = y;
    [self.view addSubview:view];
}

@end
