//
//  USModifyPayPwdViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/9.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USModifyPayPwdViewController.h"
#import "USBorrowAccountInfoView.h"
#import "USTextFieldTool.h"
#import "USUserService.h"
#import "USStringTool.h"
#import "USMainUITabBarController.h"
@interface USModifyPayPwdViewController()
@property(nonatomic,strong)UITextField *oldPwdTF;
@property(nonatomic,strong)UITextField *pwdTF;
@property(nonatomic,strong)UITextField *dubelPwdTF;
@property(nonatomic,strong)USAccount *account;

@end
@implementation USModifyPayPwdViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"修改密码";
    _account = [USUserService accountStatic];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent= NO;
    USBorrowAccountInfoView *accountBrowView = [[USBorrowAccountInfoView alloc]initWithFrame:CGRectZero];
    accountBrowView.height = 90;
    accountBrowView.y = 30;
    [accountBrowView setBackgroundColor:[UIColor clearColor]];
    [accountBrowView.backgroundView setBackgroundColor:[UIColor clearColor]];
    accountBrowView.personImageView.size = CGSizeMake(80, 80);
    if (_account.headerImg == nil) {
     accountBrowView.personImageView.image = [UIImage imageNamed:@"account_seconde_image"];
    }else{
        accountBrowView.personImageView.image = _account.headerImg;
    }
    [accountBrowView.bgImgeView removeFromSuperview];
    [accountBrowView.accountNameLabel setTextColor:[UIColor orangeColor]];
    [accountBrowView.accountNameLabel setText:_account.name];
    [accountBrowView.accountNameLabel setFont:[UIFont systemFontOfSize:kCommonFontSize_18]];
    accountBrowView.accountNameLabel.height = kCommonFontSize_18;
    accountBrowView.accountNameLabel.y = accountBrowView.personImageView.y+accountBrowView.personImageView.height+30;
    [accountBrowView updateFrame];
    [self.view addSubview:accountBrowView];
    //
    _oldPwdTF = [USTextFieldTool createTextFieldWithPlaceholder:@"旧密码" target:self leftImage:nil];
    _oldPwdTF.secureTextEntry = YES;
    _oldPwdTF.y = accountBrowView.y+accountBrowView.height+15;
    [self.view addSubview:_oldPwdTF];
        //
    _pwdTF = [USTextFieldTool createTextFieldWithPlaceholder:@"新密码" target:self leftImage:nil];
    _pwdTF.secureTextEntry = YES;
    _pwdTF.y = _oldPwdTF.y+_oldPwdTF.height+15;
    [self.view addSubview:_pwdTF];
    //
    _dubelPwdTF = [USTextFieldTool createTextFieldWithPlaceholder:@"重复新密码" target:self leftImage:nil];
    _dubelPwdTF.y =  _pwdTF.y+ _pwdTF.height+15;
    _dubelPwdTF.secureTextEntry = YES;
    [self.view addSubview: _dubelPwdTF];
    //
    super.commonButton = [USUIViewTool createButtonWith:@"确定修改" imageName:@"login_bt_img"];
    super.commonButton.frame = CGRectMake(10,  _dubelPwdTF.y+_dubelPwdTF.height+25, kAppWidth-20, 35);
    [self.view addSubview: super.commonButton];
    [super.commonButton addTarget:self action:@selector(modify) forControlEvents:UIControlEventTouchUpInside];
    UILabel *label1 = [USUIViewTool createUILabel];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.y = kAppHeight*0.8;
    label1.width = kAppWidth;
    label1.x = 0;
    //label1.text = @"点击下一步,即表示你同意";
    [label1 setFont:[UIFont systemFontOfSize:12]];
    [label1 setTextColor:HYCTColor(187, 187, 187)];
    [self.view addSubview: label1];
    //
    label1 = [USUIViewTool createUILabel];
    label1.frame = label1.frame;
    label1.textAlignment = NSTextAlignmentCenter;
    label1.y = kAppHeight*0.8+label1.height;
    label1.width = kAppWidth;
    label1.x = 0;
    label1.text = @"《哇咔平台注册与领用协议》";
    [label1 setFont:[UIFont systemFontOfSize:12]];
    [label1 setTextColor:HYCTColor(131, 213, 206)];
    [self.view addSubview: label1];
    UIButton *agreementBg1 = [super createAgreementBt];
    agreementBg1.frame = label1.frame;
    [self.view addSubview: agreementBg1];
}
-(void)dissView{
    [self updateRespons];
}
-(void)updateRespons{
    [_oldPwdTF resignFirstResponder];
    [_pwdTF resignFirstResponder];
    [_dubelPwdTF resignFirstResponder];
}


-(void)modify{
    HYLog(@"modify");
    [self validate];
    if ([super commitFlag]) {
        [USWebTool POST:@"loginclient/updatePassword.action" showMsg:@"正在修改密码..."
               paramDic:@{@"id":_account.id,
                          @"old_pwd":_oldPwdTF.text,
                          @"new_pwd":_pwdTF.text} success:^(NSDictionary *dataDic) {
                              [USUserService logout];
                              [USUIViewTool chageWindowRootController:[[USMainUITabBarController alloc]init]];
               } failure:^(id data) {
                   
               }];
    }
}
-(void)validate{
    Validator *validator = [[Validator alloc] init];
    validator.delegate   = self;
    [validator putRule:[Rules checkIfPassWord:@"密码必须以字母开头,长度在6-18之间,只能包含字符、数字和下划线" forTextField:_oldPwdTF]];
    [validator putRule:[Rules checkIfPassWord:@"密码必须以字母开头,长度在6-18之间,只能包含字符、数字和下划线" forTextField:_pwdTF]];
    [validator putRule:[Rules checkIfPassWord:@"密码必须以字母开头,长度在6-18之间,只能包含字符、数字和下划线" forTextField:_dubelPwdTF]];
    [validator putRule:[Rules checkIfNotPasswordEqual:@"两次输入的密码不相等" forTextField1:_pwdTF forTextField2:_dubelPwdTF]];
    [validator putRule:[Rules checkIfNotPasswordEqual:@"两次输入的密码不相等" forTextField1:_dubelPwdTF forTextField2:_pwdTF]];
    [validator putRule:[Rules checkIfOldPasswordEqualNewPwd:@"新密码不能与旧密码相同" forTextField1:_oldPwdTF forTextField2:_dubelPwdTF]];
    [validator validate];
}
-(void)getValidcodeClick{
    HYLog(@"getValidcodeClick");
   
}
- (UIImageView *)createLogoView {
    
    return nil;
}
@end
