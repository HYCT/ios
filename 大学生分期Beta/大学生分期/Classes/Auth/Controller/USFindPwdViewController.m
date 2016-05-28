//
//  USFindPwdViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/13.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USFindPwdViewController.h"
#import "USTextFieldTool.h"
@interface USFindPwdViewController()
@property(nonatomic,strong)NSDictionary *navIcosDic;
@property(nonatomic,strong)UITextField *userNameTF;
@property(nonatomic,strong)UITextField *validCodeNameTF;
@property(nonatomic,strong)UITextField *myAskManTF;
@property(nonatomic,weak)UIView *navView;
@property(nonatomic,assign)PwdNavEnum currentNav;
@property(nonatomic,copy)NSString *code;
@property(nonatomic,copy)NSString *telCode;
@property(nonatomic,copy)NSString *pwd;
@property(nonatomic,strong)UILabel *tipAccount;
@end
@implementation USFindPwdViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找回密码";
    self.navigationController.navigationBar.translucent= NO;
    NSMutableDictionary *navIcosDic = [NSMutableDictionary dictionaryWithCapacity:3];
    NSArray *icosPhone = @[@"pwd_valid_phone_checked_ico",@"set_pwd_unchecked_ico",@"ok_unchecked_ico"];
    [navIcosDic setObject:icosPhone forKey:@"1"];
    NSArray *setPwdIco = @[@"pwd_valid_phone_checked_ico",@"set_pwd_checked_ico",@"ok_unchecked_ico"];
    [navIcosDic setObject:setPwdIco forKey:@"2"];
    NSArray *okIco = @[@"pwd_valid_phone_checked_ico",@"set_pwd_checked_ico",@"ok_checked_ico"];
    [navIcosDic setObject:okIco forKey:@"3"];
    _navIcosDic = navIcosDic;
    UIView *navView = [self createPwdNav:kpwdNav_1];
    _navView = navView;
    [self.view addSubview:navView];
    //
    [self initInputTextFields:10 y:navView.y+navView.height];
    _currentNav = kpwdNav_1;
   
}
-(void)initInputTextFields:(CGFloat)x y:(CGFloat)y{
    _userNameTF = [USTextFieldTool createTextFieldWithPlaceholder:@"输入你的手机号码" target:self leftImage:nil];
    _userNameTF.x = x;
    _userNameTF.y = y;
    [self.view addSubview:_userNameTF];
    //
    _validCodeNameTF = [USTextFieldTool createTextFieldWithPlaceholder:@"输入验证码" target:self leftImage:nil];
    _validCodeNameTF.y = _userNameTF.y+_userNameTF.height+15;
    super.getCodeBt = [USUIViewTool createButtonWith:@"获取验证码" imageName:@"pwd_getcode_bt_img"];

    super.getCodeBt.layer.masksToBounds = YES;
    super.getCodeBt.frame = _validCodeNameTF.frame;
    super.getCodeBt.width = 80;
    super.getCodeBt.height = _validCodeNameTF.height*0.7;
    super.getCodeBt.layer.cornerRadius = super.getCodeBt.height*0.5;
    super.getCodeBt.y = _validCodeNameTF.y+super.getCodeBt.height/5;
    super.getCodeBt.x = _validCodeNameTF.width - super.getCodeBt.width*0.95;
    super.getCodeBt.titleLabel.font =[UIFont systemFontOfSize:kCommonFontSize_12];
    [super.getCodeBt addTarget:self action:@selector(getValidcodeClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_validCodeNameTF];
    [self.view addSubview:super.getCodeBt];
    //
    
    //
    super.commonButton = [USUIViewTool createButtonWith:@"下一步" imageName:@"login_bt_img"];
    super.commonButton.frame = CGRectMake(10, _validCodeNameTF.y+_validCodeNameTF.height+20, kAppWidth-20, 35);
    [self.view addSubview: super.commonButton];
    super.commonButton.enabled = [self isCanCommite];
    [super.commonButton addTarget:self action:@selector(nextClick:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)getValidcodeClick:(UIButton *)getCodeBt{
    [self validate];
    if ([super commitFlag]) {
        _telCode = _userNameTF.text;
        getCodeBt.enabled = NO;
        self.code = [USStringTool validCode];
        [USUserService validTelephoneWithUrl:@"register/resetPwdRequestCode.action" telephone:_userNameTF.text code:self.code];
        [self startTimerWithSecond:60];
    }
    
}
-(void)validate{
    Validator *validator = [[Validator alloc] init];
    validator.delegate   = self;
    if (_currentNav == kpwdNav_1) {
        [validator putRule:[Rules checkIfPhoneNumberWithFailureString:@"请输入合法的手机号码!" forTextField:_userNameTF]];
        [validator validate];
        return;
    }
    if (_currentNav == kpwdNav_2) {
        [validator putRule:[Rules checkIfPassWord:@"密码必须以字母开头,长度在6-18之间,只能包含字符、数字和下划线" forTextField:_userNameTF]];
        [validator putRule:[Rules checkIfPassWord:@"密码必须以字母开头,长度在6-18之间,只能包含字符、数字和下划线" forTextField:_validCodeNameTF]];
        [validator putRule:[Rules checkIfNotPasswordEqual:@"两次输入的密码不相等" forTextField1:_userNameTF forTextField2:_validCodeNameTF]];
        [validator putRule:[Rules checkIfNotPasswordEqual:@"两次输入的密码不相等" forTextField1:_validCodeNameTF forTextField2:_userNameTF]];
        [validator validate];
        return;
    }
    if (_currentNav == kpwdNav_3) {
        [validator putRule:[Rules checkIfPassWord:@"密码必须以字母开头,长度在6-18之间,只能包含字符、数字和下划线" forTextField:_userNameTF]];
        [validator putRule:[Rules checkIfPassWord:@"密码必须以字母开头,长度在6-18之间,只能包含字符、数字和下划线" forTextField:_validCodeNameTF]];
        [validator putRule:[Rules checkIfNotPasswordEqual:@"两次输入的密码不相等" forTextField1:_userNameTF forTextField2:_validCodeNameTF]];
        [validator putRule:[Rules checkIfNotPasswordEqual:@"两次输入的密码不相等" forTextField1:_validCodeNameTF forTextField2:_userNameTF]];
        [validator validate];
        return;
    }
   
}
-(void)nextClick:(UIButton *)button{
    [self validate];
    if (![super commitFlag]) {
        return;
    }
    if (_currentNav==kpwdNav_2) {
       _pwd = _userNameTF.text;
        [USWebTool POST:@"loginclient/resetPassword.action" showMsg:@"正在找回密码..." paramDic:@{@"telephone":_telCode,@"new_pwd":_pwd} success:^(NSDictionary *dataDic) {
            USAccount *account = [USAccount accountWithDic:dataDic[@"data"]];
            _currentNav+=1;
            super.getCodeBt.hidden = _currentNav!=kpwdNav_1;
            [_navView removeFromSuperview];
            _navView = [self createPwdNav:_currentNav];
            [self.view addSubview:_navView];
            [self updateTextField:_currentNav];
            if (_currentNav == kpwdNav_3) {
                [button setHidden:YES];
                [button removeFromSuperview];
                _tipAccount.text = [NSString stringWithFormat:@"你的账号为:%@",account.name];
            }
            
        }];
    }else{
        _currentNav+=1;
        super.getCodeBt.hidden = _currentNav!=kpwdNav_1;
        [_navView removeFromSuperview];
        _navView = [self createPwdNav:_currentNav];
        [self.view addSubview:_navView];
        [self updateTextField:_currentNav];
        if (_currentNav == kpwdNav_3) {
            [button setHidden:YES];
            [button removeFromSuperview];
        }
    }
    
}
- (void)updateTextField:(PwdNavEnum)nav {
    if (nav == kpwdNav_2) {
        _userNameTF.text = @"";
        _validCodeNameTF.text = @"";
        _userNameTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入新密码" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:kCommonFontSize_15]}];
        _userNameTF.secureTextEntry = YES;
         _validCodeNameTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"重复新密码" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:kCommonFontSize_15]}];
        _validCodeNameTF.secureTextEntry = YES;
    }else{
        [_userNameTF removeFromSuperview];
        [_validCodeNameTF removeFromSuperview];
        UIView *succesView = [self createSuccesView];
        succesView.userInteractionEnabled = YES;
        [self.view addSubview:succesView];
    }
}
- (UIImageView *)createLogoView {
    
    return nil;
}
- (void)updateTipLable:(UILabel *)tipAccount {
    tipAccount.textAlignment = NSTextAlignmentCenter;
    tipAccount.x = 0;
    tipAccount.width = kAppWidth;
}

-(UIView *)createSuccesView{
    UIView *successBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 80, kAppWidth, 120)];
    UIButton *okBt = [USUIViewTool createButtonWith:@"重置密码成功"];
    okBt.enabled = NO;
    [okBt setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
    [okBt setImage:[UIImage imageNamed:@"pwd_success_ico"] forState:UIControlStateDisabled];
    okBt.frame = CGRectMake(0, 0, kAppWidth/2, 15);
    okBt.x = kAppWidth/2-kAppWidth/4;
    [successBgView addSubview:okBt];
    
    UILabel *tipAccount = [USUIViewTool createUILabelWithTitle:@"你的账号为:******" fontSize:kCommonFontSize_12 color:[UIColor blackColor] heigth:15];
    _tipAccount = tipAccount;
    [self updateTipLable:tipAccount];
    tipAccount.y = okBt.y+okBt.height+5;
    [successBgView addSubview:tipAccount];
    //
     UILabel *tipPwd = [USUIViewTool createUILabelWithTitle:@"请牢记你的新密码" fontSize:kCommonFontSize_12 color:[UIColor blackColor] heigth:15];
    [self updateTipLable:tipPwd];
    tipPwd.y = tipAccount.y+tipAccount.height;
    [successBgView addSubview:tipPwd];
    //
    UIButton *commonButton = [USUIViewTool createButtonWith:@"完成" imageName:@"pwd_getcode_bt_img"];
    commonButton.frame = CGRectMake(kAppWidth/3, tipPwd.y+tipPwd.height+15, kAppWidth/3, 35);
    commonButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [commonButton addTarget:self action:@selector(finish) forControlEvents:UIControlEventTouchUpInside];
    successBgView.userInteractionEnabled = YES;
    [successBgView addSubview: commonButton];
    return successBgView;
}
-(void)finish{
    [super pop];
}
-(void)dissView{
    [self updateRespons];
    super.commonButton.enabled = [self isCanCommite];
}
-(void)updateRespons{
    [_userNameTF resignFirstResponder];
    [_validCodeNameTF resignFirstResponder];
}
-(BOOL)isCanCommite{
    if(_currentNav==kpwdNav_1){
        BOOL flag = [_validCodeNameTF.text isEqualToString:_code];
        
        if (_validCodeNameTF.text.length>0&&!flag) {
            [MBProgressHUD showError:@"你输入的验证码有误..."];
        }
        return flag;
    }
    if(_currentNav==kpwdNav_2){
        BOOL flag = [[_userNameTF text] length]>0;
        return  flag&& [[_validCodeNameTF text] length]>0;
    }
    BOOL flag = [[_userNameTF text] length]>=kLength;
    return  flag&& [[_validCodeNameTF text] length]>=kLength;
}

- (void)updateLine:(CGFloat)width line:(UIView *)line relate:(UIView *)relateView  deta:(CGFloat)deta{
    //
    line.width = width;
    line.height = 3;
    line.backgroundColor = HYCTColor(150, 150, 150);
    line.backgroundColor = [UIColor redColor];
    line.x = relateView.x+relateView.width*deta;
    line.y = relateView.height/5;
}

- (UIView *)createPwdNav:(PwdNavEnum)nav{
    UIView *pwdNavView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, kAppWidth, 60)];
    //pwdNavView.backgroundColor = [UIColor redColor];
    UIView *firstBtView = nil;
    UIView *secondeBtView = nil;
    UIView *thirdBtView = nil;
    NSArray *titles = @[@"验证手机",@"设置新密码",@"完成"];
    switch (nav) {
        case kpwdNav_1:
        {
            NSArray *icos= _navIcosDic[[NSString stringWithFormat:@"%i",kpwdNav_1]];
            firstBtView = [self createButtonViewWithTitle:titles[0] imageName:icos[0]];
            secondeBtView = [self createButtonViewWithTitle:titles[1] imageName:icos[1]];
            thirdBtView = [self createButtonViewWithTitle:titles[2] imageName:icos[2]];
        }
        break;
        case kpwdNav_2:
        {
            NSArray *icos= _navIcosDic[[NSString stringWithFormat:@"%i",nav]];
            firstBtView = [self createButtonViewWithTitle:titles[0] imageName:icos[0]];
            secondeBtView = [self createButtonViewWithTitle:titles[1] imageName:icos[1]];
            thirdBtView = [self createButtonViewWithTitle:titles[2] imageName:icos[2]];
        }
            break;
        case kpwdNav_3:
        {
            NSArray *icos= _navIcosDic[[NSString stringWithFormat:@"%i",nav]];
            firstBtView = [self createButtonViewWithTitle:titles[0] imageName:icos[0]];
            secondeBtView = [self createButtonViewWithTitle:titles[1] imageName:icos[1]];
            thirdBtView = [self createButtonViewWithTitle:titles[2] imageName:icos[2]];
        }
            break;
    }
    firstBtView.x = firstBtView.width;
    UIView *line = [USUIViewTool createLineView];
    CGFloat width = ((kAppWidth - firstBtView.width*3)/2)*0.8;
   
    [pwdNavView addSubview:firstBtView];
    [self updateLine:width line:line relate:firstBtView deta:0.8];
    [pwdNavView addSubview:line];
    //
    secondeBtView.x = line.x+line.width-secondeBtView.width*0.2;
    secondeBtView.width+=15;
    [pwdNavView addSubview:secondeBtView];
    //
    line = [USUIViewTool createLineView];
    [self updateLine:width line:line relate:secondeBtView deta:0.6];
    [pwdNavView addSubview:line];
    //
    thirdBtView.x = line.x+line.width*0.8;
    [pwdNavView addSubview:thirdBtView];
    //
    line = [USUIViewTool createLineView];
    line.y = pwdNavView.height -15;
    line.backgroundColor = HYCTColor(198, 175, 148);
    [pwdNavView addSubview:line];
    return pwdNavView;
}
-(UIView *)createButtonViewWithTitle:(NSString *)title imageName:(NSString *)imageName{
    
    UIView *updownView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 50)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,25 , 25)];
    imageView.image = [UIImage imageNamed:imageName];
    [updownView addSubview:imageView];
    UILabel *titleLB = [USUIViewTool createUILabelWithTitle:title fontSize:kCommonFontSize_10 color:[UIColor blackColor] heigth:kCommonFontSize_10];
     titleLB.font = [UIFont systemFontOfSize:8];
    titleLB.textAlignment = NSTextAlignmentCenter;
    titleLB.frame = CGRectMake(0, imageView.height, 40, 15);
    imageView.x = titleLB.width/2-imageView.width/2;
    [updownView addSubview:titleLB];
    return updownView;
}
@end
