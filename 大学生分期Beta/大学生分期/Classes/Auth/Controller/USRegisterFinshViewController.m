//
//  USRegisterViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/6.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USRegisterFinshViewController.h"
#import "USTextFieldTool.h"
#import "USUserService.h"
#import "MBProgressHUD+MJ.h"
#import "USLoginViewController.h"
@interface USRegisterFinshViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UserServiceDelegate>
@property(nonatomic,strong)UITextField *passwordTF1;
@property(nonatomic,strong)UITextField *passwordTF2;
@property(nonatomic,strong)UIButton *nextButton;
@property(nonatomic,strong)UIButton *headerButton;
@property(nonatomic,strong)UITextField *nikeNameTF;
@property(nonatomic,strong)UIButton *finishButton;
@property(nonatomic,strong)UIImage *headerImage;
@end

@implementation USRegisterFinshViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"注册";
    //self.view.backgroundColor = HYCTColor(250, 250, 250);
    self.navigationController.navigationBar.translucent= NO;
    self.navigationItem.hidesBackButton = YES;
     UIView *headerView = [self createHeaderView];
    [self.view addSubview:headerView];
    _nikeNameTF = [USTextFieldTool createTextFieldWithPlaceholder:@"设置昵称" target:self leftImage:nil];
    _nikeNameTF.y = headerView.y+headerView.height+15;
    _nikeNameTF.text = @"张三";
    [self.view addSubview:_nikeNameTF];
    _passwordTF1 = [USTextFieldTool createTextFieldWithPlaceholder:@"设置登录密码" target:self leftImage:nil];
    _passwordTF1.secureTextEntry = YES;
    _passwordTF1.y = _nikeNameTF.y+_nikeNameTF.height+15;
    [self.view addSubview:_passwordTF1];
    //
    _passwordTF2 = [USTextFieldTool createTextFieldWithPlaceholder:@"重复登录密码" target:self leftImage:nil];
    _passwordTF2.y =  _passwordTF1.y+ _passwordTF1.height+15;
    _passwordTF2.secureTextEntry = YES;
    [self.view addSubview: _passwordTF2];
    //
    _nextButton = [USUIViewTool createButtonWith:@"注 册" imageName:@"login_bt_img"];
    _nextButton.frame = CGRectMake(10, _passwordTF2.y+_passwordTF2.height+15, kAppWidth-20, 35);
    [self.view addSubview: _nextButton];
    [_nextButton addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    //
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
    label1.y = kAppHeight*0.85+5;
    label1.width = kAppWidth;
    label1.x = 0;
    label1.text = @"《汪卡平台注册与领用协议》";
    [label1 setFont:[UIFont systemFontOfSize:12]];
    [label1 setTextColor:HYCTColor(131, 213, 206)];
    [self.view addSubview: label1];
    UIButton *agreementBg1 = [super createAgreementBt];
    agreementBg1.frame = label1.frame;
    [self.view addSubview: agreementBg1];
}
-(UIView *)createHeaderView{
    CGFloat width = 64.5;
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0,20, kAppWidth, width)];
    headerView.backgroundColor = [UIColor whiteColor];
    headerView.backgroundColor = [UIColor clearColor];
    _headerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _headerButton.frame = CGRectMake(headerView.width/2-width*0.5, 0, width, width);
    [_headerButton.layer setMasksToBounds:YES];
    [_headerButton.layer setCornerRadius:width*0.5];
    [_headerButton setBackgroundImage:[UIImage imageNamed:@"login_header"] forState:UIControlStateNormal];
    [_headerButton setBackgroundImage:[UIImage imageNamed:@"login_header"] forState:UIControlStateHighlighted];
    [_headerButton addTarget:self action:@selector(uploadHeaderImage) forControlEvents:UIControlEventTouchUpInside];
    UIButton *carmera = [USUIViewTool createButtonWith:@"" imageName:@"account_camera"];
    carmera.frame = CGRectMake(_headerButton.x+_headerButton.width-kPhotoImageSize, _headerButton.height*0.9-kPhotoImageSize, kPhotoImageSize, kPhotoImageSize);
   
    [carmera addTarget:self action:@selector(carmera) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:_headerButton];
    [headerView addSubview:carmera];
    return headerView;
}
-(void)next{
    [self validate];
   if ([super commitFlag])
    {
        if (_headerImage == nil) {
            [MBProgressHUD showError:@"你没有选择头像!"];
            return;
        }
       [USUserService registerWithTelePhone:_telPhone pwd:_passwordTF1.text inviter:_askCode name:_nikeNameTF.text uploadimgFilephoto:UIImagePNGRepresentation(_headerImage) delegate:self];
    }
}
-(void)carmera{
    [self uploadHeaderImage];
}
-(void)didSuccessFinish{
    USLoginViewController *loginVC = [[USLoginViewController alloc]init];
    loginVC.phoneCode = _telPhone;
    UINavigationController *navLoginVC = [[UINavigationController alloc]initWithRootViewController:loginVC];
    [USUIViewTool chageWindowRootController:navLoginVC];
}
-(void)dissView{
    [self updateRespons];
}
-(void)updateRespons{
    [_passwordTF1 resignFirstResponder];
    [_nikeNameTF resignFirstResponder];
    [_passwordTF2 resignFirstResponder];
}
-(void)validate{
    Validator *validator = [[Validator alloc] init];
    validator.delegate   = self;
    [validator putRule:[Rules checkRange: NSMakeRange(2, 15) withFailureString:@"请输入合法的昵称(长度为不小于3,不大于10的任意非空字符)" forTextField:_nikeNameTF]];
    [validator putRule:[Rules checkIfPassWord:@"密码必须以字母开头,长度在6-18之间,只能包含字符、数字和下划线" forTextField:_passwordTF1]];
    [validator putRule:[Rules checkIfPassWord:@"密码必须以字母开头,长度在6-18之间,只能包含字符、数字和下划线" forTextField:_passwordTF2]];
    [validator putRule:[Rules checkIfNotPasswordEqual:@"两次输入的密码不相等" forTextField1:_passwordTF1 forTextField2:_passwordTF2]];
    [validator putRule:[Rules checkIfNotPasswordEqual:@"两次输入的密码不相等" forTextField1:_passwordTF2 forTextField2:_passwordTF1]];
    [validator validate];
}
-(void)uploadHeaderImage{
    if (_upLoadImageService==nil) {
        _upLoadImageService = [[USUpLoadImageServiceTool alloc]init];
        __block UIButton *bt = _headerButton;
        _upLoadImageService.saveImageBlock = ^(UIImage *image){
            [bt setBackgroundImage:image forState:UIControlStateNormal];
            [bt setBackgroundImage:image forState:UIControlStateHighlighted];
            [bt setTitle:@"" forState:UIControlStateNormal];
            [bt setTitle:@"" forState:UIControlStateHighlighted];
            _headerImage = image;
        };
    }
    [_upLoadImageService pickImage];
}

@end
