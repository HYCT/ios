//
//  USActivitDetalViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/10/29.
//  Copyright © 2015年 hongyunct. All rights reserved.
//

#import "USActivitDetalViewController.h"

@interface USActivitDetalViewController ()
@property(nonatomic,strong)UIWebView *webView;
@property(nonatomic,strong)UIView *dataTipView;

@end

@implementation USActivitDetalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:HYCTColor(240, 241, 240)];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent= NO;
    _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_webView];
    _url = @"firstpageimgcilent/getActDetailDataByid.action";
    _dataTipView = [USUIViewTool createDataTipViewWithTarget:self action:@selector(loadData)];
    [self loadData];
}


-(void)loadData{
    [_dataTipView removeFromSuperview];
    [USWebTool POSTWithNoTip:_url showMsg:_msg paramDic:_param success:^(NSDictionary *data) {
        [_webView loadHTMLString:data[@"data"][@"content"] baseURL:nil];
    }];
}


@end
