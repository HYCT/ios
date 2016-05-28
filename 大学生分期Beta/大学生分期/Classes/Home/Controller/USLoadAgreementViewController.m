//
//  USLoadAgreementViewController.m
//  大学生分期
//
//  Created by HeXianShan on 16/1/12.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import "USLoadAgreementViewController.h"
#import "USAccount.h"

@interface USLoadAgreementViewController ()<UIAlertViewDelegate>
@property(nonatomic,strong)UIButton *loanButton;
@property(nonatomic,strong)UIAlertView *inputAlertView;
@end

@implementation USLoadAgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent= NO;
    self.webView.y = self.view.y ;
    self.webView.height = self.view.height - 80 ;
    self.title = @"《汪卡借款协议》" ;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [super webViewDidFinishLoad:webView];
    [self initLoadButton];
}
-(void)initLoadButton{
    
    
    
    UIButton *loanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _loanButton = loanButton;
    loanButton.frame = CGRectMake(15,kAppHeight-80, kAppWidth-30, 30);
    [loanButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [loanButton setTitle:@"确定借款" forState:UIControlStateNormal];
    [loanButton setTitle:@"确定借款" forState:UIControlStateHighlighted];
    [loanButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loanButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    UIImage *image = [UIImage imageNamed:@"finance_loan_button_bg"];
    [loanButton setBackgroundImage:image forState:UIControlStateNormal];
    [loanButton setBackgroundImage:image forState:UIControlStateHighlighted];
    [loanButton addTarget:self action:@selector(didLoan) forControlEvents:UIControlEventTouchUpInside];
    
    //加个背景
    UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(0, _loanButton.y-5, kAppWidth, _loanButton.height+10)] ;
    [bgview setBackgroundColor:HYCTColor(240, 240, 240)] ;
    [self.view addSubview:bgview] ;
    
    [self.view addSubview:loanButton];
}

/**
 验证密码
 **/
-(void)didLoan{
    if (_loadDelegate!=nil) {
        if ([_loadDelegate respondsToSelector:@selector(didActLoad)]) {
            _inputAlertView = [[UIAlertView alloc] initWithTitle:@""
                                                         message:@"请输入密码"
                                                        delegate:self
                                               cancelButtonTitle:@"取消"
                                               otherButtonTitles:@"确定", nil];
            _inputAlertView.alertViewStyle = UIAlertViewStyleSecureTextInput;
            
            [_inputAlertView show];
            //            [_loadDelegate didActLoad];
            //            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
}
/**
 alertview 代理
 **/
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == alertView.firstOtherButtonIndex) {
        USAccount *account = [USUserService accountStatic] ;
        UITextField *txt = [alertView textFieldAtIndex:0];
        NSString *pwd = txt.text ;
        [USWebTool POSTWIthTip:@"loginclient/validateCustomerPwdByid.action" showMsg:@"正在验证密码..." paramDic:@{@"customer_id":account.id,@"pwd":pwd} success:^(NSDictionary *dic) {
            
            //
            [self saveBorrowPost] ;
            
        } failure:^(id data) {
            [self didLoan] ;
        }];
    }
}

/**
 向服务器保存借款----
 **/
- (void)saveBorrowPost{
    USAccount *account = [USUserService accountStatic] ;
    NSString *borrowmoney = [NSString stringWithFormat:@"%g",_borrowmoney] ;
    [USWebTool POSTWIthTip:@"borrowcilent/saveBorrowMoney.action" showMsg:@"正在提交..." paramDic:@{@"customer_id":account.id,@"borrowmoney":borrowmoney,@"usage":_usage} success:^(NSDictionary *dic) {
        //重新设置用户信息
         USAccount *account = [USAccount accountWithDic:dic[@"data"]];
        [USUserService saveAccount:account];
        //出栈
        [self.navigationController popToRootViewControllerAnimated:YES];
    } failure:^(id data) {
    }];
    
}

@end
