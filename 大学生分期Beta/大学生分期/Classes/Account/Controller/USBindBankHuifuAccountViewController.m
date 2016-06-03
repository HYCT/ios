//
//  USBindBankCardViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/10.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USBindBankHuifuAccountViewController.h"
#import "USBankCardListViewController.h"
#import "USCertificationViewController.h"
#import "USUserService.h"
#import "USTextFieldTool.h"
#import "USAccount.h"
#define kTopMargin 20
#define kTipLeftMargin 25
#define kTipRightMargin 10
#define kLabelHeight 30
#define kLabelPadding 10
@interface USBindBankHuifuAccountViewController()<UIPickerViewDelegate>
@property(nonatomic,weak)UIButton *bindBtton;
@property(nonatomic,strong) UILabel    *nameTipLB;
@property(nonatomic,strong) UITextField *nameField;
@property(nonatomic,strong) UITextField *idCardField;
@property(nonatomic,strong) UITextField *telephoneField;
@property(nonatomic,strong) UITextField *msgcodeField;
//短信验证码的订单
@property(nonatomic,strong) NSString *order_id ;
@property(nonatomic,strong) NSString *order_date ;
@property(nonatomic,strong) USAccount *account;
@end
@implementation USBindBankHuifuAccountViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"申请绑卡";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent= NO;
    [self.view setBackgroundColor:HYCTColor(240, 241, 240)];
    _account = [USUserService accountStatic];
    [self createViews];
    [NSThread detachNewThreadSelector:@selector(check) toTarget:self withObject:nil];
}
-(void)check{
    dispatch_sync(dispatch_get_main_queue(), ^{
        UIViewController *toShowVC = nil;
        if (_account.realnametype == -1) {
            toShowVC = [[USCertificationViewController alloc]init];
            toShowVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:toShowVC animated:YES];
        }else if (_account.realnametype == 3){
            [self loadData];
        }else{
            [MBProgressHUD showError:@"你的实名认证还未审核完毕!"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    });
    
}
-(void)createViews{
    UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(0, kTopMargin, kAppWidth, kLabelHeight*2+kLabelPadding*2)];
    bgview.backgroundColor = [UIColor whiteColor];
    UIView *line = [self createLine:0];
    [bgview addSubview:line];
    _nameTipLB = [self createTipUILabel:line.y+line.height+0.5*kLabelPadding title:@"真实姓名:"];
    CGFloat width = [self getLableStringWidth:_nameTipLB];
    [bgview addSubview:_nameTipLB];
    // _nameLB = [self createUILabel:_nameTipLB.y title:@"*晓"];
    _nameField = [[UITextField alloc]initWithFrame:CGRectMake(kTipLeftMargin+width+5, _nameTipLB.y, kAppWidth-kTipLeftMargin-width-kTipRightMargin-5, kLabelHeight)];
    _nameField.delegate = self;
    _nameField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入姓名" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:kCommonFontSize_15]}];
    _nameField.textAlignment = NSTextAlignmentRight;
    _nameField.enabled = NO;
    [bgview addSubview:_nameField];
    line = [self createLine:_nameTipLB.y+_nameTipLB.height+kLabelPadding*0.5];
    line.frame = CGRectMake(kTipRightMargin, line.y, kAppWidth-kTipRightMargin*2, line.height);
    [bgview addSubview:line];
    //
    _nameTipLB = [self createTipUILabel:line.y+line.height+0.5*kLabelPadding title:@"身份证号:"];
    [bgview addSubview:_nameTipLB];
    _idCardField = [[UITextField alloc]initWithFrame:CGRectMake(kTipLeftMargin+width+5, _nameTipLB.y, kAppWidth-kTipLeftMargin-width-kTipRightMargin-5, kLabelHeight)];
    _idCardField.delegate = self;
    _idCardField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入身份证号码" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:kCommonFontSize_15]}];
    _idCardField.enabled = NO;
    _idCardField.textAlignment = NSTextAlignmentRight;
    [bgview addSubview:_idCardField];
    line = [self createLine:bgview.height-1];
    [bgview addSubview:line];
    [self.view addSubview:bgview];
    //
    
    UIView *bgview1 = [[UIView alloc]initWithFrame:CGRectMake(0, bgview.height+bgview.y+kTopMargin, kAppWidth, kLabelHeight*2+kLabelPadding*2)];
    bgview1.backgroundColor = [UIColor whiteColor];
    line = [self createLine:0];
    [bgview1 addSubview:line];
    
    //
    _nameTipLB = [self createTipUILabel:line.y+line.height+0.5*kLabelPadding title:@"电话号码:"];
    [bgview1 addSubview:_nameTipLB];
    
    _telephoneField = [[UITextField alloc]initWithFrame:CGRectMake(kTipLeftMargin+width+5, _nameTipLB.y, kAppWidth-kTipLeftMargin-width-kTipRightMargin-5, kLabelHeight)];
    _telephoneField.delegate = self;
    _telephoneField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入电话号码" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:kCommonFontSize_15]}];
    _telephoneField.enabled = NO ;
    _telephoneField.textAlignment = NSTextAlignmentRight;
    _telephoneField.keyboardType = UIKeyboardTypeNumberPad;
    [bgview1 addSubview:_telephoneField];
    
    line = [self createLine:_nameTipLB.y+_nameTipLB.height+kLabelPadding*0.5];
    line.frame = CGRectMake(kTipRightMargin, line.y, kAppWidth-kTipRightMargin*2, line.height);
    [bgview1 addSubview:line];
    
    
    _nameTipLB = [self createTipUILabel:line.y+line.height+0.5*kLabelPadding title:@"验证码:"];
    [bgview1 addSubview:_nameTipLB];
    _msgcodeField = [[UITextField alloc]initWithFrame:CGRectMake(kTipLeftMargin+width+5, _nameTipLB.y, kAppWidth-kTipLeftMargin-width-kTipRightMargin-90, kLabelHeight)];
    _msgcodeField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入验证码" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:kCommonFontSize_15]}];
    _msgcodeField.textAlignment = NSTextAlignmentRight;
    _msgcodeField.delegate = self ;
    _msgcodeField.keyboardType = UIKeyboardTypeNumberPad;
    //验证码
    UIButton *getValiCodeButton = [USUIViewTool createButtonWith:@"验证码"];
    [getValiCodeButton setBackgroundColor:HYCTColor(67, 201, 190)];
    super.getCodeBt = getValiCodeButton;
    getValiCodeButton.height = _msgcodeField.height-8;
    getValiCodeButton.width = 80;
    getValiCodeButton.y = _msgcodeField.y+4;
    getValiCodeButton.x = _msgcodeField.x+_msgcodeField.width +5 ;
    getValiCodeButton.layer.cornerRadius = getValiCodeButton.height*0.5;
    getValiCodeButton.layer.masksToBounds = YES;
    getValiCodeButton.titleLabel.font = [UIFont systemFontOfSize:10];
    [getValiCodeButton addTarget:self action:@selector(getValidcodeClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgview1 addSubview:_msgcodeField];
    [bgview1 addSubview:getValiCodeButton];
    
    
    line = [self createLine:bgview1.height-1];
    [bgview1 addSubview:line];
    [self.view addSubview:bgview1];
    //
    UIButton *bindBtton = [USUIViewTool createButtonWith:@"申请绑定" imageName:@"login_bt_img"];
    bindBtton.frame = CGRectMake(10, bgview1.y+ bgview1.height+kTopMargin, kAppWidth-20, 35);
    [bindBtton addTarget:self action:@selector(bind) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: bindBtton];
    _bindBtton = bindBtton;
}
-(void)loadData{
    [USWebTool POST:@"realnameclient/getRealNameObjData.action" showMsg:@"" paramDic:@{@"customer_id":_account.id} success:^(NSDictionary *dataDic) {
        dataDic = dataDic[@"data"];
        _nameField.text = dataDic[@"name"];
        _idCardField.text = dataDic[@"idcard"];
        _telephoneField.text=_account.telephone;
    } failure:nil];
}
-(CGFloat )getLableStringWidth:(UILabel *)lable{
    NSDictionary *attributes = @{NSFontAttributeName:lable.font};
    return [lable.text sizeWithAttributes:attributes].width;
}
-(UIView *)createLine:(CGFloat)y {
    UIView *line = [USUIViewTool createLineView];
    line.frame = CGRectMake(0, y, kAppWidth, 0.8);
    line.backgroundColor = HYCTColor(200, 200, 200);
    return line;
}
-(UILabel *)createTipUILabel:(CGFloat)y title:(NSString *)title {
    UILabel *label = [USUIViewTool createUILabelWithTitle:title fontSize:kCommonFontSize_15 color: HYCTColor(180, 180, 180) heigth:kLabelHeight];
    label.frame = CGRectMake(kTipLeftMargin, y, kAppWidth-kTipLeftMargin, kLabelHeight);
    return label;
}
-(UILabel *)createUILabel:(CGFloat)y title:(NSString *)title {
    UILabel *label = [USUIViewTool createUILabelWithTitle:title fontSize:kCommonFontSize_15 color: [UIColor blackColor] heigth:kLabelHeight];
    label.frame = CGRectMake(kTipLeftMargin, y, kAppWidth-kTipLeftMargin-kTipRightMargin, kLabelHeight);
    label.x = kAppWidth - label.width-kTipRightMargin;
    label.textAlignment = NSTextAlignmentRight;
    return label;
}
-(void)bind{
    
    NSString *name = _nameField.text ;
    if (name==nil||name==0||name.length==1) {
        [MBProgressHUD showError:@"姓名填写错误，必须是2个字符以上..."];
        return;
    }
    NSString *idcard =_idCardField.text ;
    if (idcard==nil||(idcard.length!=15&&idcard.length!=18)) {
        [MBProgressHUD showError:@"请填写合法的身份证号码..."];
        return;
    }
    NSString *telephone = _telephoneField.text ;
    if (telephone==nil||telephone.length<11) {
        [MBProgressHUD showError:@"请填写预留电话号码！"];
        return;
    }
    NSString *msgcode = _msgcodeField.text ;
    if(msgcode ==  nil || msgcode.length == 0 ){
        [MBProgressHUD showError:@"请填写验证码！"];
        return;
    }
    
    NSDictionary *params = @{@"customer_id":_account.id,
                             @"user_name":name,
                             @"idcard": idcard,
                             @"user_mobile": telephone,
                             @"sms_code": msgcode,
                             @"sms_order_date": _order_date,
                             @"sms_order_id": _order_id};
    HYLog(@"%@",params) ;
    [USWebTool POSTWIthTip:@"huiFuPayClientController/personApplyAccount.action" showMsg:@"正在申请..." paramDic:params success:^(NSDictionary * dic)  {
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSDictionary * dic) {
        
    }];

    
    
}


-(void)getValidcodeClick:(UIButton *)button{
    NSString *telephone = _telephoneField.text ;
    if ([telephone isEqualToString:@""]) {
        [MBProgressHUD showError:@"请填写电话号码！"];
        return ;
    }else {
        [USWebTool POSTWIthTip:@"huiFuPayClientController/sendMsgCode.action" showMsg:@"正在获取验证码..." paramDic:@{@"user_mobile":telephone,@"business_type":@"101"} success:^(NSDictionary * dic)  {
            //设置短信订单日期和订单号
            NSDictionary *data = dic[@"data"] ;
            _order_id = data[@"order_id"] ;
            _order_date = data[@"order_date"] ;
            button.enabled = NO;
            [self startTimerWithSecond:60];
        } failure:^(NSDictionary * dic) {
            
        }];
        
    }
    
    
}

-(void)dissView{
    [super.topView removeFromSuperview];
    [self updateRespons];
}
-(void)updateRespons{
    [_telephoneField resignFirstResponder];
    [_nameField resignFirstResponder];
    [_idCardField resignFirstResponder];
}





@end
