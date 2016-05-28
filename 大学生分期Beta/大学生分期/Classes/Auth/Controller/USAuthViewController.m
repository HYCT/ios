//
//  AuthViewController.m
//  红云创投
//
//  Created by HeXianShan on 15/8/14.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USAuthViewController.h"

@interface USAuthViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *webView;
@end

@implementation USAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=1217315862&redirect_uri=http://www.qq.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    self.webView.delegate= self;
    [self.view addSubview:self.webView];
    [self.webView loadRequest:request];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    HYLog(@"shouldStartLoadWithRequest---%@",request.URL.absoluteString);
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
   // HYLog(@"webViewDidStartLoad");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
   //HYLog(@"webViewDidFinishLoad");
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}

@end
