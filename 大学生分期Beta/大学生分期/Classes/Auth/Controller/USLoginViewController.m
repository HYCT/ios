//
//  USLoginViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/6.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USLoginViewController.h"
#import "USRegisterFinshViewController.h"
#import "USTextFieldTool.h"
#import "USMainUITabBarController.h"
#import "USBaseAuthorViewController.h"
#import "USRegisterFirstViewController.h"
#import "USFindPwdViewController.h"
#import "USUserService.h"
#import "MBProgressHUD+MJ.h"
#import "USAccount.h"
#define kMargin 25
@interface USLoginViewController ()<UITextFieldDelegate,UserServiceDelegate>
@property(nonatomic,strong)UITextField *userNameTF;
@property(nonatomic,strong)UITextField *passwordTF;
@property(nonatomic,strong)UIImageView *headerView;
@end

@implementation USLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTabbarTopView];
    USAccount *account = [USUserService account];
    //
    UIImageView *headerView = [[UIImageView alloc]initWithFrame:CGRectMake(kAppWidth*0.5-40,15, 80, 80)];
    if (account.headerImg!=nil) {
       headerView.image = account.headerImg;
    }else{
      headerView.image = [UIImage imageNamed:@"login_header"];
    }
    if (account != nil) {
        [self logined];
    }
    _headerView = headerView;
    _headerView.layer.cornerRadius = headerView.width/2;
    _headerView.layer.masksToBounds = YES;
    [self.view addSubview:headerView];
    //
    _userNameTF = [USTextFieldTool createTextFieldWithPlaceholder:@"手机号码/昵称" target:self leftImage:nil];
    if (_phoneCode!=nil) {
        _userNameTF.text = _phoneCode;
    }else{
       _userNameTF.text = @"";
    }
    
    _userNameTF.y = headerView.y+headerView.height+25;
     [self.view addSubview:_userNameTF];
    _passwordTF = [USTextFieldTool createTextFieldWithPlaceholder:@"输入密码" target:self leftImage:nil];
    _passwordTF.text = @"";
    _passwordTF.y =  _userNameTF.y+ _userNameTF.height+15;
    _passwordTF.secureTextEntry = YES;
    [self.view addSubview: _passwordTF];
    //
    super.commonButton = [USUIViewTool createButtonWith:@"登  陆" imageName:@"login_bt_img"];
    super.commonButton.frame = CGRectMake(10, _passwordTF.y+_passwordTF.height+15, kAppWidth-20, 35);
    [self.view addSubview: super.commonButton];
    super.commonButton.enabled = [self isCanCommite];
    [super.commonButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    UIButton *forgetPwdBt = [USUIViewTool createButtonWith:@"忘记密码"];
    forgetPwdBt.backgroundColor = [UIColor clearColor];
    [forgetPwdBt setTitleColor:HYCTColor(72, 201, 190) forState:UIControlStateNormal];
    [forgetPwdBt setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    forgetPwdBt.frame = CGRectMake(kAppWidth-100, super.commonButton.y+super.commonButton.height+15, 100, 15);
    forgetPwdBt.titleLabel.textAlignment = NSTextAlignmentCenter;
    forgetPwdBt.titleLabel.font = [UIFont systemFontOfSize:kCommonFontSize_10];
    [self.view addSubview: forgetPwdBt];
    [forgetPwdBt addTarget:self action:@selector(forget) forControlEvents:UIControlEventTouchUpInside];
    
    //重新登录
    [self setReLogin] ;
}

//重新登录
-(void)setReLogin{
    
    if (_accountTelephone !=nil) {
        [ _userNameTF setText:_accountTelephone] ;
    }
    if (_accountPwd != nil) {
        [_passwordTF setText:_accountPwd] ;
    }
}

-(void)dissView{
    [self updateRespons];
    super.commonButton.enabled = [self isCanCommite];
}
-(void)updateRespons{
    [_userNameTF resignFirstResponder];
    [_passwordTF resignFirstResponder];
}
-(BOOL)isCanCommite{
    BOOL flag = [[_userNameTF text] length]>kLength;
    return  flag&& [[_passwordTF text] length]>kLength;
}
-(void)login{
    [self validate];
    if ([super commitFlag]) {
        [USUserService loginWithUserName:_userNameTF.text pwd:_passwordTF.text delegate:self]; 
    }
}
-(void)forget{
    USFindPwdViewController *findVC = [[USFindPwdViewController alloc]init];
    [self.navigationController pushViewController:findVC animated:YES];
}
- (void)logined {
    if (_nextDoblock!= nil) {
        _nextDoblock();
        return;
    }
    if (_nextViewController!=nil) {
        [super pop];
        return;
    }
    USMainUITabBarController *mainCV = [[USMainUITabBarController alloc]init];
    mainCV.selectedViewController = mainCV.accountnNavViewController;
    [USUIViewTool chageWindowRootController:mainCV];
}

//登录以后要保存登录的用户信息
-(void)didSuccessFinishWithDic:(NSDictionary *)dic{
    USAccount *account = [USAccount accountWithDic:dic[@"data"]];
    [USUserService saveAccount:account];
    if (account.headerImg!=nil) {
      _headerView.image = account.headerImg;
    }

    [self logined];
}


-(void)initTabbarTopView{
    self.title = @"登录";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent= NO;
    self.navigationItem.hidesBackButton = YES;
    //self.navigationItem.leftBarButtonItem =nil;
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.backgroundColor = [UIColor clearColor];
    UIFont *font = [UIFont systemFontOfSize:kCommonNavFontSize];
    [rightButton.titleLabel setFont:font];
    NSString *rightTitle = @"注册";
    [rightButton setTitle:rightTitle forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightButton.size = CGSizeMake(60, 24);
    [rightButton.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [rightButton addTarget:self action:@selector(registerAccount) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}

- (void)registerAccount {
    USRegisterFirstViewController *registerVC = [[USRegisterFirstViewController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
}
-(void)validate{
    Validator *validator = [[Validator alloc] init];
    validator.delegate   = self;
    [validator putRule:[Rules checkIfPhoneNumberWithFailureString:@"请输入合法的手机号码!" forTextField:_userNameTF]];
    [validator putRule:[Rules checkRange:NSMakeRange(3, 20) withFailureString:@"必须输入密码(长度为:6到20位)!" forTextField:_passwordTF]];
    [validator validate];
}
-(void)pop{
    if (_muslogin) {
         USMainUITabBarController *mainCV = [[USMainUITabBarController alloc]init];
        [USUIViewTool chageWindowRootController:mainCV];
    }else{
        [super pop];
    }
}
@end
