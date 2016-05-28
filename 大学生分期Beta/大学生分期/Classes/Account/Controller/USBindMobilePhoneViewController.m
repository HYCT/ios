//
//  USBindMobilePhoneViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/9.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USBindMobilePhoneViewController.h"
#import "USBorrowAccountInfoView.h"
#import "USMainUITabBarController.h"
#import "USTextFieldTool.h"
#import "USUserService.h"
@interface USBindMobilePhoneViewController()
@property(nonatomic,strong)UITextField *userNameTF;
@property(nonatomic,strong)UITextField *validCodeNameTF;
@property(nonatomic,strong)USAccount *account;
@property(nonatomic,copy)NSString *code;
@end
@implementation USBindMobilePhoneViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"绑定手机号";
    _account = [USUserService accountStatic];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent= NO;
    USBorrowAccountInfoView *accountBrowView = [[USBorrowAccountInfoView alloc]initWithFrame:CGRectZero];
    accountBrowView.height = 90;
    accountBrowView.y = 30;
    [accountBrowView setBackgroundColor:[UIColor clearColor]];
    [accountBrowView.backgroundView setBackgroundColor:[UIColor clearColor]];
    accountBrowView.personImageView.size = CGSizeMake(80, 80);
    if (_account.headerImg==nil) {
        accountBrowView.personImageView.image = [UIImage imageNamed:@"account_seconde_image"];
    }else{
        accountBrowView.personImageView.image = _account.headerImg;
    }
   
    [accountBrowView.bgImgeView removeFromSuperview];
    [accountBrowView.accountNameLabel setTextColor:[UIColor orangeColor]];
    [accountBrowView.accountNameLabel setText:_account.name];
    [accountBrowView.accountNameLabel setFont:[UIFont systemFontOfSize:kCommonFontSize_12]];
    accountBrowView.accountNameLabel.y = accountBrowView.personImageView.y+accountBrowView.personImageView.height+30;
    [accountBrowView updateFrame];
    [self.view addSubview:accountBrowView];
    //
    UILabel *bindCode = [USUIViewTool createUILabel];
    bindCode.frame = CGRectMake(0, accountBrowView.y+accountBrowView.height+5, kAppWidth, 15);
    bindCode.textAlignment = NSTextAlignmentCenter;
    [bindCode setFont:[UIFont systemFontOfSize:kCommonFontSize_14]];
    [bindCode setTextColor:HYCTColor(187, 187, 187)];
    bindCode.text = [NSString stringWithFormat:@"你绑定的手机号码%@",_account.telephone];
     [self.view addSubview: bindCode];
    //
    _userNameTF = [USTextFieldTool createTextFieldWithPlaceholder:@"新手机号码" target:self leftImage:nil];
    _userNameTF.y = bindCode.y+bindCode.height+10;
    [self.view addSubview:_userNameTF];
    _validCodeNameTF = [USTextFieldTool createTextFieldWithPlaceholder:@"验证码" target:self leftImage:nil];
    _validCodeNameTF.y =  _userNameTF.y+ _userNameTF.height+15;
   
    [self.view addSubview: _validCodeNameTF];
   
    //
    UIButton *getValiCodeButton = [USUIViewTool createButtonWith:@"获取验证码" imageName:@"validata_code_bt_img"];
    getValiCodeButton.layer.cornerRadius = 8;
    getValiCodeButton.layer.masksToBounds = YES;
    getValiCodeButton.frame = _validCodeNameTF.frame;
    getValiCodeButton.width = 90;
    getValiCodeButton.titleLabel.font = [UIFont systemFontOfSize:kCommonFontSize_14];
    getValiCodeButton.height = _validCodeNameTF.height/2;
    getValiCodeButton.y = _validCodeNameTF.y+getValiCodeButton.height/2;
    getValiCodeButton.x = _validCodeNameTF.width - getValiCodeButton.width;
    [getValiCodeButton addTarget:self action:@selector(getValidcodeClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_validCodeNameTF];
    [self.view addSubview:getValiCodeButton];
    //
    super.commonButton = [USUIViewTool createButtonWith:@"确定修改" imageName:@"login_bt_img"];
    super.commonButton.frame = CGRectMake(10, _validCodeNameTF.y+_validCodeNameTF.height+60, kAppWidth-20, 35);
    [self.view addSubview: super.commonButton];
    super.commonButton.enabled = NO;
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
    [super.topView removeFromSuperview];
    [self updateRespons];
    super.commonButton.enabled = [self isCanCommite];
    HYLog(@"dissView");
}
-(void)updateRespons{
    [_userNameTF resignFirstResponder];
    [_validCodeNameTF resignFirstResponder];
}
-(BOOL)isCanCommite{
    BOOL result = [_validCodeNameTF.text isEqualToString:self.code];
    if (!result&&_validCodeNameTF.text.length>0) {
        [MBProgressHUD showError:@"你输入的验证码有误..."];
    }
    return result;
}

-(void)modify{
    [self validate];
    if ([super commitFlag]) {
        [USWebTool POST:@"register/updateCustomerBindTelephone.action" showMsg:@"正在修改手机号..." paramDic:@{@"customer_id":_account.id,@"old_telephone":_account.telephone,@"new_telephone":_userNameTF.text} success:^(id data) {
            [MBProgressHUD showSuccess:@"请重新登录..."];
            [USUserService logout];
            [USUIViewTool chageWindowRootController:[[USMainUITabBarController alloc]init]];
        }];
    }
    

}
-(void)getValidcodeClick:(UIButton *)button{
    [self validate];
    if ([super commitFlag]) {
        button.enabled = NO;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(60 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            button.enabled = YES;
        });
        self.code = [USStringTool validCode];
        [USUserService validTelephone:_userNameTF.text code:self.code];
    }

}
-(void)validate{
    Validator *validator = [[Validator alloc] init];
    validator.delegate   = self;
    [validator putRule:[Rules checkIfPhoneNumberWithFailureString:@"请输入合法的手机号码!" forTextField:_userNameTF]];
    [validator validate];
}
- (UIImageView *)createLogoView {
    
    return nil;
}
@end
