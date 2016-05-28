//
//  USModifyExcPwdViweController.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/13.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USModifyExcPwdViweController.h"
#import "USTextFieldTool.h"
@interface USModifyExcPwdViweController()
@property(nonatomic,strong)UITextField *userNameTF;
@property(nonatomic,strong)UITextField *validCodeNameTF;
@property(nonatomic,strong)UITextField *nwPwdTF;
@property(nonatomic,strong)UITextField *decuNwPwdTF;
@property(nonatomic,weak)UIView *navView;
@end
@implementation USModifyExcPwdViweController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改交易密码";
    self.navigationController.navigationBar.translucent= NO;
    [self initInputTextFields];
}
-(void)initInputTextFields{
    _userNameTF = [USTextFieldTool createTextFieldWithPlaceholder:@"输入旧的密码" target:self leftImage:nil];
    _userNameTF.y = 15;
    _userNameTF.secureTextEntry = YES;
    [self.view addSubview:_userNameTF];
    //
    _nwPwdTF = [USTextFieldTool createTextFieldWithPlaceholder:@"输入新密码" target:self leftImage:nil];
    _nwPwdTF.y = _userNameTF.y+_userNameTF.height+15;
    _nwPwdTF.secureTextEntry  =YES;
    [self.view addSubview:_nwPwdTF];
    //
    _decuNwPwdTF = [USTextFieldTool createTextFieldWithPlaceholder:@"重复新密码" target:self leftImage:nil];
    _decuNwPwdTF.y = _nwPwdTF.y+_nwPwdTF.height+15;
    _decuNwPwdTF.secureTextEntry  =YES;
    [self.view addSubview:_decuNwPwdTF];
    //
    _validCodeNameTF = [USTextFieldTool createTextFieldWithPlaceholder:@"输入验证码" target:self leftImage:nil];
    _validCodeNameTF.y = _decuNwPwdTF.y+_decuNwPwdTF.height+15;
    super.getCodeBt = [USUIViewTool createButtonWith:@"获取验证码" imageName:@"pwd_getcode_bt_img"];
    super.getCodeBt.layer.cornerRadius = 8;
    super.getCodeBt.layer.masksToBounds = YES;
    super.getCodeBt.frame = _validCodeNameTF.frame;
    super.getCodeBt.width = 70;
    super.getCodeBt.height = _validCodeNameTF.height*0.8;
    super.getCodeBt.y = _validCodeNameTF.y+super.getCodeBt.height/8;
    super.getCodeBt.x = _validCodeNameTF.width - super.getCodeBt.width*0.9;
    [super.getCodeBt addTarget:self action:@selector(getValidcodeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_validCodeNameTF];
    [self.view addSubview:super.getCodeBt];
    super.commonButton = [USUIViewTool createButtonWith:@"确定" imageName:@"login_bt_img"];
    super.commonButton.frame = CGRectMake(10, _validCodeNameTF.y+_validCodeNameTF.height+15, kAppWidth-20, 35);
    [super.commonButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self.view addSubview: super.commonButton];
    [super.commonButton addTarget:self action:@selector(commit:) forControlEvents:UIControlEventTouchUpInside];
    
}
- (UIImageView *)createLogoView {
    
    return nil;
}
-(void)getValidcodeClick{
    HYLog(@"----getValidcodeClick-----");
}
-(void)commit:(UIButton *)button{
    
     HYLog(@"----commit-----");
   
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
    [_nwPwdTF resignFirstResponder];
    [_decuNwPwdTF resignFirstResponder];
}
-(BOOL)isCanCommite{
    BOOL flag = [[_userNameTF text] length]>=kLength;
    return  flag&& [[_validCodeNameTF text] length]>=kLength;
}
@end
