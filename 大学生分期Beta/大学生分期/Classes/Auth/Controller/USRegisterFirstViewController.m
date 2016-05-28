//
//  USRegisterFirstViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/8.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USRegisterFirstViewController.h"
#import "USTextFieldTool.h"
#import "USRegisterFinshViewController.h"
#import "USUserService.h"
#import "USStringTool.h"
@interface USRegisterFirstViewController ()
@property(nonatomic,strong)UITextField *userNameTF;
@property(nonatomic,strong)UITextField *validCodeNameTF;
@property(nonatomic,strong)UITextField *myAskManTF;
@property(nonatomic,copy)NSString *code;
@property(nonatomic,strong)UIButton *checkBox;
@end

@implementation USRegisterFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent= NO;
    self.navigationItem.hidesBackButton = YES;
    [self initInputTextFields];
}

-(void)initInputTextFields{
    _userNameTF = [USTextFieldTool createTextFieldWithPlaceholder:@"手机号码" target:self leftImage:nil];
    _userNameTF.y = super.logoImageView.y+super.logoImageView.height+25;
    _userNameTF.keyboardType = UIKeyboardTypePhonePad;
    [self.view addSubview:_userNameTF];
    //
    _validCodeNameTF = [USTextFieldTool createTextFieldWithPlaceholder:@"验证码" target:self leftImage:nil];
    _validCodeNameTF.y = _userNameTF.y+_userNameTF.height+15;
    _validCodeNameTF.keyboardType = UIKeyboardTypeNumberPad;
    UIButton *getValiCodeButton = [USUIViewTool createButtonWith:@"获取验证码" imageName:@"validata_code_bt_img"];
    super.getCodeBt = getValiCodeButton;
    getValiCodeButton.layer.cornerRadius = getValiCodeButton.height*0.5;
    getValiCodeButton.layer.masksToBounds = YES;
    getValiCodeButton.frame = _validCodeNameTF.frame;
    getValiCodeButton.width = 70;
    getValiCodeButton.titleLabel.font = [UIFont systemFontOfSize:10];
    getValiCodeButton.height = _validCodeNameTF.height/2;
    getValiCodeButton.y = _validCodeNameTF.y+getValiCodeButton.height/2;
    getValiCodeButton.x = _validCodeNameTF.width - getValiCodeButton.width;
    [getValiCodeButton addTarget:self action:@selector(getValidcodeClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_validCodeNameTF];
    [self.view addSubview:getValiCodeButton];
    //
    //
    _myAskManTF = [USTextFieldTool createTextFieldWithPlaceholder:@"邀请人电话号码,没有可不填" target:self leftImage:nil];
    _myAskManTF.y = _validCodeNameTF.y+_validCodeNameTF.height+15;
    [self.view addSubview:_myAskManTF];
    //
    //UIButton *checkBox = [USUIViewTool createButtonWith:@"" imageName:@"register_unchecked_img"];
    UIButton *checkBox = [USUIViewTool createButtonWith:@"" imageName:@"register_unchecked_img"];
    checkBox.selected = YES;
    _checkBox = checkBox;
    [checkBox setImage:[UIImage imageNamed:@"checked_img"] forState:UIControlStateSelected];
    [checkBox addTarget:self action:@selector(updateCheckBoxstate:) forControlEvents:UIControlEventTouchUpInside];
    checkBox.frame =  CGRectMake(20, _myAskManTF.y+_myAskManTF.height+15, 10, 10);
    UILabel *label1 = [USUIViewTool createUILabel];
    label1.frame = checkBox.frame;
    label1.x = checkBox.x+checkBox.width+10;
    label1.width = 90;
    label1.text = @"我已阅读并同意";
    [label1 setFont:[UIFont systemFontOfSize:kCommonFontSize_12]];
    [label1 setTextColor:HYCTColor(187, 187, 187)];
    UILabel *label2 = [USUIViewTool createUILabel];
    label2.frame = label1.frame;
    label2.x = label1.x +label1.width;
    label2.width = 120;
    label2.text = @"《汪卡用户领用协议》";
    [label2 setFont:[UIFont systemFontOfSize:kCommonFontSize_12]];
    [label2 setTextColor:HYCTColor(131, 213, 206)];
    [self.view addSubview: checkBox];
    [self.view addSubview: label1];
    [self.view addSubview: label2];
    UIButton *agreementBg = [super createAgreementBt];
    agreementBg.frame = label2.frame;
    agreementBg.width =kAppWidth - label1.x-label1.width;
    label2.width = agreementBg.width;
     [self.view addSubview: agreementBg];
    //
    super.commonButton = [USUIViewTool createButtonWith:@"下一步" imageName:@"login_bt_img"];
    super.commonButton.frame = CGRectMake(10, checkBox.y+checkBox.height+15, kAppWidth-20, 35);
    [self.view addSubview: super.commonButton];
    super.commonButton.enabled = NO;
    [super.commonButton addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
    label1 = [USUIViewTool createUILabel];
    label1.frame =label2.frame;
    label1.textAlignment = NSTextAlignmentCenter;
    label1.y = kAppHeight*0.8;
    label1.width = kAppWidth;
     label1.x = 0;
    label1.text = @"点击下一步,即表示你同意";
    [label1 setFont:[UIFont systemFontOfSize:kCommonFontSize_12]];
    [label1 setTextColor:HYCTColor(187, 187, 187)];
    [self.view addSubview: label1];
    //
    label1 = [USUIViewTool createUILabel];
    label1.frame = label1.frame;
    label1.textAlignment = NSTextAlignmentCenter;
    label1.y = kAppHeight*0.85+5;
    label1.width = kAppWidth;
    label1.x = 0;
    label1.text = @"《汪卡用户领用协议》";
    [label1 setFont:[UIFont systemFontOfSize:kCommonFontSize_12]];
    [label1 setTextColor:HYCTColor(131, 213, 206)];
    [self.view addSubview: label1];
    UIButton *agreementBg1 = [super createAgreementBt];
    agreementBg1.frame = label1.frame;
    [self.view addSubview: agreementBg1];
}
-(void)updateCheckBoxstate:(UIButton *)checkBox{
    checkBox.selected = !checkBox.selected;
}
-(void)getValidcodeClick:(UIButton *)button{
    [self validate];
    if (!_checkBox.selected) {
        [MBProgressHUD showError:@"请选择同意协议!"];
        return;
    }
    if ([super commitFlag]) {
        button.enabled = NO;
        [self startTimerWithSecond:60];
        self.code = [USStringTool validCode];
        [USUserService validTelephone:_userNameTF.text code:self.code];
    }
   
}
-(void)nextClick{
    [self validate];
    if (!_checkBox.selected) {
        [MBProgressHUD showError:@"请选择同意协议!"];
        return;
    }
    if ([super commitFlag]) {
        
        USRegisterFinshViewController *setPwdVC = [[USRegisterFinshViewController alloc]init];
        setPwdVC.telPhone = self.userNameTF.text;
        setPwdVC.askCode = _myAskManTF.text;
        [self.navigationController pushViewController:setPwdVC animated:YES];
    }
   
}
-(void)dissView{
    [super.topView removeFromSuperview];
    [self updateRespons];
    super.commonButton.enabled = [self isCanCommite];
}
-(void)updateRespons{
    [_userNameTF resignFirstResponder];
    [_validCodeNameTF resignFirstResponder];
    [_myAskManTF resignFirstResponder];
}
-(BOOL)isCanCommite{
    BOOL result = [_validCodeNameTF.text isEqualToString:self.code];
    if (!result&&_validCodeNameTF.text.length>0) {
        [MBProgressHUD showError:@"你输入的验证码有误..."];
    }
    return result;
}
-(void)validate{
    Validator *validator = [[Validator alloc] init];
    validator.delegate   = self;
    [validator putRule:[Rules checkIfPhoneNumberWithFailureString:@"请输入合法的手机号码!" forTextField:_userNameTF]];
    [validator validate];
}



/**
 IViewController对象的视图已经加入到窗口时调用
 **/
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.translucent= NO;
}
@end
