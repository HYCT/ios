//
//  USHtmlLoadViewViewController.h
//  大学生分期
//
//  Created by HeXianShan on 16/1/1.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "USBaseViewController.h"
@interface USHtmlLoadViewInsideController : UIViewController<UIWebViewDelegate>
@property(nonatomic,copy)NSString *htmlTitle;
@property(nonatomic,copy)NSString *htmlUrl;
@property(nonatomic,copy)NSString *loadMsg;
@property(nonatomic,strong) UIWebView  *webView;
@property(nonatomic,strong) MBProgressHUD *mssageView;
@property(nonatomic,assign)BOOL showMsg;

@end
