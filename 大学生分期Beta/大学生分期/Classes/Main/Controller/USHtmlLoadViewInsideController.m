//
//  USHtmlLoadViewViewController.m
//  大学生分期
//
//  Created by HeXianShan on 16/1/1.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import "USHtmlLoadViewInsideController.h"

@interface USHtmlLoadViewInsideController ()

@end

@implementation USHtmlLoadViewInsideController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent= YES;
    
    [self.view setBackgroundColor:[UIColor whiteColor]] ;
    [self.navigationItem setTitle:_htmlTitle] ;
    
    [self initLeftItemBar];
    
    
    
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


-(void)initLeftItemBar{
    UIImage *backImage = [[UIImage imageNamed:@"nav_back_bg"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.backgroundColor = [UIColor clearColor];
    UIFont *font = [UIFont systemFontOfSize:kCommonNavFontSize];
    [leftButton.titleLabel setFont:font];
    NSString *leftTitle = @"返回";
    [leftButton setTitle:leftTitle forState:UIControlStateNormal];
    [leftButton setImage:backImage forState:UIControlStateNormal];
    [leftButton setImage:backImage forState:UIControlStateHighlighted];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //CGSize size = [leftTitle sizeWithFont:font];
    leftButton.size = CGSizeMake(60, 24);
    leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -24, 0, 0);
    leftButton.titleEdgeInsets = UIEdgeInsetsMake(0, -24, 0, 0);
    [leftButton.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [leftButton addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    [self.view setBackgroundColor:HYCTColor(240, 240, 240)];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [_mssageView hide:YES];
}
-(void)webViewDidStartLoad:(UIWebView *)webView{
    
    if (_showMsg) {
       
      _mssageView =  [MBProgressHUD showMessage:_loadMsg toView:[[self.view subviews] firstObject]];
        _mssageView.userInteractionEnabled = YES;
    }
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    //self.navigationItem.leftBarButtonItem.enabled = self.webView.canGoBack;
    [_mssageView hide:YES];
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
{
    NSURL *requestURL = [request URL];
    if ( ( [ [ requestURL scheme ] isEqualToString: @"http" ] || [ [ requestURL scheme ] isEqualToString: @"https" ] || [ [ requestURL scheme ] isEqualToString: @"mailto" ])
        && ( navigationType == UIWebViewNavigationTypeLinkClicked ) ) {
         [webView loadRequest:[NSURLRequest requestWithURL:requestURL]];
        //return ![ [ UIApplication sharedApplication ] openURL: requestURL];
    }
    return YES;
}

- (void)pop{
    if(_webView.canGoBack){
      [_webView goBack] ;
    }else{
      [self.navigationController popViewControllerAnimated:YES];
    }
    
   
}

@end
