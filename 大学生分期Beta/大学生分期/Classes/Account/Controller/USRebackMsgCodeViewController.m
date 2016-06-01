//
//  USBindBankCardViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/10.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USRebackMsgCodeViewController.h"
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
@interface USRebackMsgCodeViewController()<UIPickerViewDelegate>
@property(nonatomic,weak)UIButton *bindBtton;
@property(nonatomic,strong) UILabel    *nameTipLB;
@property(nonatomic,strong) UITextField *msgcodeField;
//短信验证码的订单
@property(nonatomic,strong) NSString *order_id ;
@property(nonatomic,strong) NSString *order_date ;
@property(nonatomic,strong) USAccount *account;
@end
@implementation USRebackMsgCodeViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"验证码";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent= NO;
    [self.view setBackgroundColor:HYCTColor(240, 241, 240)];
    _account = [USUserService accountStatic];
    [self createViews];
}

-(void)createViews{
    
    
    UIView *bgview1 = [[UIView alloc]initWithFrame:CGRectMake(0, kTopMargin, kAppWidth, kLabelHeight+kLabelPadding)];
    bgview1.backgroundColor = [UIColor whiteColor];
    UIView *line = [self createLine:0];
    [bgview1 addSubview:line];
    
    
    _nameTipLB = [self createTipUILabel:line.y+line.height+0.5*kLabelPadding title:@"验证码:"];
    CGFloat width = [self getLableStringWidth:_nameTipLB];
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
    UIButton *bindBtton = [USUIViewTool createButtonWith:@"确定"];
    bindBtton.frame = CGRectMake(10, bgview1.y+ bgview1.height+kTopMargin, kAppWidth-20, 35);
    [bindBtton setBackgroundColor: HYCTColor(0,170,237)] ;
    [bindBtton addTarget:self action:@selector(sureRepay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: bindBtton];
    _bindBtton = bindBtton;
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
/**
 确定支付
 **/
-(void)sureRepay{
    NSString *msgcode = _msgcodeField.text ;
    if(msgcode ==  nil || msgcode.length == 0 ){
        [MBProgressHUD showError:@"请填写验证码！"];
        return;
    }
    NSDictionary *params = @{@"borrow_id":_borrow_id,
                             @"repay_money":_repay_money,
                             @"ticket_id":_ticket_id,
                             @"bindcard_id": _bindcard_id,
                             @"sms_code": msgcode,
                             @"sms_order_date": _order_date,
                             @"sms_order_id": _order_id};
    HYLog(@"%@",params) ;
    [USWebTool POSTWIthTip:@"huiFuPayClientController/repayMoneyChongzhi.action" showMsg:@"正在支付..." paramDic:params success:^(NSDictionary * dic)  {
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSDictionary * dic) {
        
    }];
    
    
    
}


/**
 获取验证码
 **/
-(void)getValidcodeClick:(UIButton *)button{
    [USWebTool POSTWIthTip:@"huiFuPayClientController/sendMsgCode.action" showMsg:@"正在获取验证码..." paramDic:@{@"user_cust_id":_user_cust_id,@"user_mobile":_card_mobile,@"business_type":@"201"} success:^(NSDictionary * dic)  {
        //设置短信订单日期和订单号
        NSDictionary *data = dic[@"data"] ;
        _order_id = data[@"order_id"] ;
        _order_date = data[@"order_date"] ;
        button.enabled = NO;
        [self startTimerWithSecond:60];
    } failure:^(NSDictionary * dic) {
        
    }];
    
}


@end
