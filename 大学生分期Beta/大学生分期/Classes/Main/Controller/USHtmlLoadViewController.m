//
//  USHtmlLoadViewViewController.m
//  大学生分期
//
//  Created by HeXianShan on 16/1/1.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import "USHtmlLoadViewController.h"

@interface USHtmlLoadViewController ()

@end

@implementation USHtmlLoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]] ;
    [self.navigationItem setTitle:_htmlTitle] ;
   // self.view.y =50 ;
    UIWebView  *webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    //webView.y =self.view.y+60;
    webView.y =self.view.y+65;
    
    
    [webView setBackgroundColor:[UIColor whiteColor]] ;
    
    NSURL *url = [[NSURL alloc]initWithString:_htmlUrl];
    _webView = webView;
    webView.delegate = self;
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    [self.view addSubview:webView];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [_mssageView hide:YES];
    if (_showMsg) {
        [MBProgressHUD showError:@"加载数据失败,请检查网络..."];
    }
   
}
-(void)webViewDidStartLoad:(UIWebView *)webView{
    
    if (_showMsg) {
       
      _mssageView =  [MBProgressHUD showMessage:_loadMsg toView:[[self.view subviews] firstObject]];
        _mssageView.userInteractionEnabled = YES;
    }
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [_mssageView hide:YES];
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
{
    NSURL *requestURL = [request URL];
    if ( ( [ [ requestURL scheme ] isEqualToString: @"http" ] || [ [ requestURL scheme ] isEqualToString: @"https" ] || [ [ requestURL scheme ] isEqualToString: @"mailto" ])
        && ( navigationType == UIWebViewNavigationTypeLinkClicked ) ) {
        return ![ [ UIApplication sharedApplication ] openURL: requestURL];
    }
    return YES;
}

@end
