//
//  USScanCodeResultViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/12/12.
//  Copyright © 2015年 hongyunct. All rights reserved.
//

#import "USScanCodeResultViewController.h"
#import "USMainUITabBarController.h"
#import "USCashierListViewController.h"
#import "USMyTicketViewController.h"
@interface USScanCodeResultViewController ()<UIAlertViewDelegate,UITextFieldDelegate>
@property(nonatomic,assign) CGFloat height;
@property(nonatomic,strong)UILabel *shopLabel ;
@property(nonatomic,strong)NSDictionary *shopdata;
@property(nonatomic,strong)NSDictionary *cashdata;
@property(nonatomic,strong)NSDictionary *ticketdata;
//金额
@property(nonatomic,strong)UITextField *editMoneyTx ;
@property(nonatomic,strong)UIButton *btncashier;
@property(nonatomic,strong)UIButton *btnticket;
@property(nonatomic,strong)UIButton *clearBtn ;
@property(nonatomic,strong)UILabel *summoneLabel;
@property(nonatomic,strong)UILabel *ticketmoneLabel;
@property(nonatomic,strong)UILabel *realmoneLabel;
@property(nonatomic,strong)UIButton *btnPay ;


@property(nonatomic,assign)CGFloat sumMoney ;
@property(nonatomic,assign)CGFloat ticketMoney ;
@property(nonatomic,assign)CGFloat realMoney ;

//alertview
@property(nonatomic,strong)UIAlertView *inputAlertView;
@end

@implementation USScanCodeResultViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    _orderStr =@"b2dab47710852227bb981ff1066d2de1" ;
    self.navigationController.navigationBar.translucent= NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view setBackgroundColor:HYCTColor(240,240,240)];
    self.title = @"汪卡支付";
    HYLog(@"self.view.y:%g",self.view.y) ;
    //创建头部
    [self createTopView] ;
    
    //底部
    [self createBottom] ;
    //获取商铺信息
    [self getshopDetail] ;
    
}

//创建头部
-(void)createTopView{
    CGFloat height =245 ;
    CGFloat leftMargin = 20 ;
    CGFloat labelHieght =14 ;
    CGFloat fontsize = 14 ;
    UIColor *gray = [UIColor grayColor] ;
    UIColor *black = [UIColor blackColor] ;
    UIView *bigview= [[UIView alloc]initWithFrame:CGRectMake(0, 20, kAppWidth, height)] ;
    [bigview setBackgroundColor:[UIColor whiteColor]] ;
    //label
    UILabel *label = [USUIViewTool createUILabelWithTitle:@"店铺信息：" fontSize:fontsize color:gray x:leftMargin y:20 width:70 heigth:labelHieght];
    [bigview addSubview:label] ;
    //店铺
    _shopLabel = [USUIViewTool createUILabelWithTitle:@"店铺名称" fontSize:fontsize color:black x:label.x+label.width + 5  y:label.y width:kAppWidth-label.x-label.width-10 heigth:labelHieght];
    [bigview addSubview:_shopLabel] ;
    
    //线条
    UIView *lineview = [USUIViewTool createLineView:0 y:_shopLabel.y+_shopLabel.height+15 width:kAppWidth] ;
    [bigview addSubview:lineview] ;
    
    //金额框
    UIView *borderview = [[UIView alloc]initWithFrame:CGRectMake(leftMargin+10, lineview.y+10, kAppWidth-2*(leftMargin+10), 40) ];
    borderview.layer.borderWidth = 1 ;
    borderview.layer.borderColor = [HYCTColor(251, 168, 169) CGColor];
    [bigview addSubview:borderview] ;
    
    label = [USUIViewTool createUILabelWithTitle:@"输入付款金额" fontSize:14 color:gray x:5 y:(borderview.height-labelHieght)/2 width:90 heigth:labelHieght] ;
    [borderview addSubview:label] ;
    //竖线
    UIView *borderLinevew = [[UIView alloc]initWithFrame:CGRectMake(label.x+label.width +5,5, 1, borderview.height-10)] ;
    [borderLinevew setBackgroundColor:HYCTColor(224, 224, 224)] ;
    [borderview addSubview:borderLinevew] ;
    //金额
    _editMoneyTx = [[UITextField alloc]initWithFrame:CGRectMake(borderLinevew.x+borderLinevew.width+5,borderLinevew.y,borderview.width-label.width -20 , borderLinevew.height)] ;
    [_editMoneyTx setTextColor:[UIColor blackColor]] ;
    [_editMoneyTx setTextAlignment:NSTextAlignmentCenter] ;
    //[_editMoneyTx setBackgroundColor:[UIColor orangeColor]] ;
    [_editMoneyTx setPlaceholder:@"0.00"];
    //[_editMoneyTx setText:@"0.00"] ;
    [_editMoneyTx setFont:[UIFont systemFontOfSize:14]] ;
    _editMoneyTx.keyboardType = UIKeyboardTypeDecimalPad;
    _editMoneyTx.leftViewMode = UITextFieldViewModeAlways;
    _editMoneyTx.inputAccessoryView = [self createCustomAccessoryView:@selector(updateRespons)] ;
    //添加了自定义键盘不需要添加returnKeyType
    //_editMoneyTx.returnKeyType = UIReturnKeyDone ;
    
    _editMoneyTx.enabled = YES ;
    _editMoneyTx.delegate=self;
    
    //_editMoneyTx.inputView = uiv
    [ _editMoneyTx addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged] ;
    [borderview addSubview:_editMoneyTx] ;
    
    
    //付款方式
    label = [USUIViewTool createUILabelWithTitle:@"付款方式：汪卡信用付款" fontSize:14 color:gray x:borderview.x y:borderview.y+borderview.height+10 width:borderview.width heigth:labelHieght] ;
    [label setTextAlignment:NSTextAlignmentRight] ;
    [bigview addSubview:label] ;
    
    
    //线条
    lineview = [USUIViewTool createLineView:10 y:label.y+label.height+20 width:kAppWidth-20] ;
    [bigview addSubview:lineview] ;
    
    CGFloat rowHeight =35;
    
    //收银员view
    UIView *cashView = [[UIView alloc]initWithFrame:CGRectMake(0, lineview.y + 10, kAppWidth, rowHeight)] ;
    //[cashView setBackgroundColor:[UIColor orangeColor]] ;
    label = [USUIViewTool createUILabelWithTitle:@"收银员" fontSize:14 color:gray x:leftMargin y:0 width:80 heigth:rowHeight] ;
    //[label setBackgroundColor:[UIColor blueColor]] ;
    [cashView addSubview:label] ;
    
    _btncashier = [USUIViewTool createButtonWith:@"选择收银员 >"] ;
    [_btncashier setFrame:CGRectMake(label.x+label.width +5, 0, kAppWidth-label.x-label.width-leftMargin, cashView.height)];
    [_btncashier setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight] ;
    [_btncashier setFont:[UIFont systemFontOfSize:14]] ;
    [_btncashier setTitleColor:gray forState:0] ;
    //[_btncashier setBackgroundColor:[UIColor redColor]] ;
    [cashView addSubview:_btncashier] ;
    [_btncashier addTarget:self action:@selector(getCashier) forControlEvents:UIControlEventTouchUpInside] ;
    [bigview addSubview:cashView] ;
    
    //线条
    lineview = [USUIViewTool createLineView:10 y:cashView.y+cashView.height+5 width:kAppWidth-20] ;
    [bigview addSubview:lineview] ;
    
    
    
    //优惠券view
    UIView *ticketView = [[UIView alloc]initWithFrame:CGRectMake(0, lineview.y + 10, kAppWidth, rowHeight)] ;
    //[ticketView setBackgroundColor:[UIColor orangeColor]] ;
    label = [USUIViewTool createUILabelWithTitle:@"优惠券" fontSize:14 color:gray x:leftMargin y:0 width:70 heigth:rowHeight] ;
    //[label setBackgroundColor:[UIColor blueColor]] ;
    [ticketView addSubview:label] ;
    
    
    //删除券
    _clearBtn = [USUIViewTool createButtonWith:@"删除券"] ;
    [_clearBtn setFrame:CGRectMake(label.x + label.width, (rowHeight-kCommonFontSize_22)/2, 70, kCommonFontSize_22)] ;
    [_clearBtn setFont:[UIFont systemFontOfSize:kCommonFontSize_12]] ;
    [_clearBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal] ;
    [_clearBtn setBackgroundColor:[UIColor orangeColor]] ;
    [_clearBtn.layer setCornerRadius:_clearBtn.height/2 ] ;
    [_clearBtn addTarget:self action:@selector(clearTicketFun) forControlEvents:UIControlEventTouchUpInside] ;
    [ticketView addSubview:_clearBtn] ;
    
    _btnticket = [USUIViewTool createButtonWith:@"选择优惠券 >"] ;
    [_btnticket setFrame:CGRectMake(_clearBtn.x+_clearBtn.width +5, 0, kAppWidth-_clearBtn.x -_clearBtn.width- leftMargin, cashView.height)];
    //[_btnticket setBackgroundColor:[UIColor blueColor]] ;
    [_btnticket setFont:[UIFont systemFontOfSize:14]] ;
    [_btnticket setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight] ;
    [_btnticket setTitleColor:gray forState:0] ;
    [_btnticket addTarget:self action:@selector(getTicket) forControlEvents:UIControlEventTouchUpInside] ;
    //[_btnticket setBackgroundColor:[UIColor redColor]] ;
    [ticketView addSubview:_btnticket] ;
    [bigview addSubview:ticketView] ;
    
    _height = height +bigview.y;
    [self.view addSubview:bigview] ;
    
}

/**
 创建底部
 **/
-(void)createBottom{
    
    CGFloat height =160 ;
    CGFloat leftMargin = 20 ;
    CGFloat rowHeight = 25 ;
    UIColor *gray = [UIColor grayColor] ;
    UIView *bgview= [[UIView alloc]initWithFrame:CGRectMake(0, kAppHeight-height-30, kAppWidth, height)] ;
    [bgview setBackgroundColor:[UIColor whiteColor]] ;
    
    
    //消费总额view
    UIView *rowView = [[UIView alloc]initWithFrame:CGRectMake(0,   10, kAppWidth, rowHeight)] ;
    //[rowView setBackgroundColor:[UIColor orangeColor]] ;
    UILabel *label = [USUIViewTool createUILabelWithTitle:@"消费总额" fontSize:14 color:gray x:leftMargin y:0 width:80 heigth:rowHeight] ;
    //[label setBackgroundColor:[UIColor blueColor]] ;
    [rowView addSubview:label] ;
    
    CGFloat summoney = 0.00;
    NSString *defaultStr = [NSString stringWithFormat:@"¥ %.2f",summoney] ;
    _summoneLabel = [USUIViewTool createUILabel] ;
    [_summoneLabel setFrame:CGRectMake(label.x+label.width +5, 0, kAppWidth-label.x-label.width-leftMargin, rowHeight)];
    [_summoneLabel setFont:[UIFont systemFontOfSize:14]] ;
    [_summoneLabel setText:defaultStr] ;
    [_summoneLabel setTextAlignment:NSTextAlignmentRight] ;
    [_summoneLabel setTextColor:[UIColor redColor]] ;
    //[_summoneLabel setBackgroundColor:[UIColor redColor]] ;
    
    [rowView addSubview:_summoneLabel] ;
    [bgview addSubview:rowView] ;
    
    //优惠view
    rowView = [[UIView alloc]initWithFrame:CGRectMake(0,  _summoneLabel.y+_summoneLabel.height + 10, kAppWidth, rowHeight)] ;
    //[rowView setBackgroundColor:[UIColor orangeColor]] ;
    label = [USUIViewTool createUILabelWithTitle:@"-优惠" fontSize:14 color:gray x:leftMargin y:0 width:80 heigth:rowHeight] ;
    //[label setBackgroundColor:[UIColor blueColor]] ;
    [rowView addSubview:label] ;
    
    
    _ticketmoneLabel = [USUIViewTool createUILabel] ;
    [_ticketmoneLabel setFrame:CGRectMake(label.x+label.width +5, 0, kAppWidth-label.x-label.width-leftMargin, rowHeight)];
    [_ticketmoneLabel setFont:[UIFont systemFontOfSize:14]] ;
    [_ticketmoneLabel setText:defaultStr] ;
    [_ticketmoneLabel setTextAlignment:NSTextAlignmentRight] ;
    [_ticketmoneLabel setTextColor:[UIColor redColor]] ;
    //[_summoneLabel setBackgroundColor:[UIColor redColor]] ;
    
    [rowView addSubview:_ticketmoneLabel] ;
    [bgview addSubview:rowView] ;
    
    
    //线条
    UIView *lineview = [USUIViewTool createLineView:10 y:rowView.y+rowView.height+5 width:kAppWidth-20] ;
    [bgview addSubview:lineview] ;
    
    
    rowView = [[UIView alloc]initWithFrame:CGRectMake(0,  lineview.y+lineview.height + 10, kAppWidth, rowHeight)] ;
    //[rowView setBackgroundColor:[UIColor orangeColor]] ;
    label = [USUIViewTool createUILabelWithTitle:@"实付金额" fontSize:14 color:gray x:leftMargin y:0 width:80 heigth:rowHeight] ;
    //[label setBackgroundColor:[UIColor blueColor]] ;
    [rowView addSubview:label] ;
    
    
    _realmoneLabel = [USUIViewTool createUILabel] ;
    [_realmoneLabel setFrame:CGRectMake(label.x+label.width +5, 0, kAppWidth-label.x-label.width-leftMargin, rowHeight)];
    [_realmoneLabel setFont:[UIFont systemFontOfSize:14]] ;
    [_realmoneLabel setText:defaultStr] ;
    [_realmoneLabel setTextAlignment:NSTextAlignmentRight] ;
    [_realmoneLabel setTextColor:[UIColor redColor]] ;
    //[_summoneLabel setBackgroundColor:[UIColor redColor]] ;
    
    [rowView addSubview:_realmoneLabel] ;
    [bgview addSubview:rowView] ;
    
    //确认按钮
    _btnPay = [USUIViewTool createButtonWith:@"确认付款"] ;
    [_btnPay setBackgroundColor:[UIColor redColor]] ;
    [_btnPay setFrame:CGRectMake(0, rowView.y+rowView.height +10, kAppWidth, 40)] ;
    [_btnPay setTitleColor:[UIColor whiteColor] forState:0] ;
    [_btnPay setFont:[UIFont systemFontOfSize:14]] ;
    [_btnPay addTarget:self action:@selector(surePay:) forControlEvents:UIControlEventTouchUpInside] ;
    [bgview addSubview:_btnPay] ;
    
    
    _height = height +bgview.y;
    [self.view addSubview:bgview] ;
    
}

/**
 获取商铺信息
 **/
-(void)getshopDetail{
    if (_orderStr != nil) {
        NSString *url = @"shopClient/getShopDataInfo.action" ;
        NSMutableDictionary *para = [[NSMutableDictionary alloc]init] ;
        para[@"md5id"] = _orderStr ;
        [USWebTool POSTWIthTip:url showMsg:@"正在查询商铺信息..." paramDic:para success:^(NSDictionary *dic) {
            _shopdata = dic[@"data"] ;
            _shopLabel.text = _shopdata[@"name"] ;
        } failure:^(id data) {
            //退出
            [self.navigationController popViewControllerAnimated:true] ;
        }];
    }
}

//获取收银员
-(void)getCashier{
    if (_shopdata != nil) {
        USCashierListViewController *cashController = [USCashierListViewController alloc];
        cashController.shop_id = _shopdata[@"id"];
        cashController.scanDelegate = self;
        [self.navigationController pushViewController:cashController animated:true] ;
    }
    
}

/**
 收银员返回
 **/
-(void)didCashierClick:(NSDictionary *)data{
    _cashdata = data ;
    NSString *tex=[NSString stringWithFormat:@"%@ >",_cashdata[@"name"]] ;
    [_btncashier setTitle:tex forState:0];
    
    [self changeValue] ;
}

-(void)getTicket{
    
     NSString *edtStr = [NSString stringWithFormat:@"%@",_editMoneyTx.text];
    if (edtStr==nil || [@"" isEqualToString:edtStr]) {
         [MBProgressHUD showError:@"请先输入金额！"] ;
        return;
    }else{
        CGFloat edtMoney = [edtStr floatValue] ;
        if (edtMoney <=0) {
            [MBProgressHUD showError:@"金额必须大于0！"] ;
            return;
        }
    }
    
    USMyTicketViewController *controller = [USMyTicketViewController alloc];
    controller.ticketDelegate = self;
    controller.used = @"0" ;
    //是否接受优惠券
    NSString *id_coupon = [NSString stringWithFormat:@"%@",_shopdata[@"id_coupon"]] ;
    if ([@"1" isEqualToString:id_coupon ]) {
        controller.typeCodeStr = @"code_cash,code_full" ;
        controller.fullMoney = edtStr;
    }else{
      controller.typeCodeStr = @"code_cash" ;
    }
    //HYLog(@"id_coupon:%@",_shopdata[@"id_coupon"]) ;
    [self.navigationController pushViewController:controller animated:true] ;
}

//优惠券回调
-(void) didTicketClick:(NSDictionary *)data{
    _ticketdata = data ;
    NSString *tex=[NSString stringWithFormat:@"%@ >",_ticketdata[@"name"]] ;
    [_btnticket setTitle:tex forState:0];
    
    [self changeValue] ;
    //HYLog(@"------------") ;
}

//jin
-(void)textFieldDidChange:(id)sender
{
    _ticketdata = nil;
    [self changeValue] ;
    
}

/**
 清除券
 **/
-(void)clearTicketFun{
    _ticketdata = nil ;
    [self changeValue] ;
}

/**
 改变值
 **/
-(void)changeValue{
    NSString *title= @"选择优惠券 >" ;
    NSString *edtStr = [NSString stringWithFormat:@"%@",_editMoneyTx.text];
    if (edtStr.length <=0) {
        edtStr = @"0.00" ;
    }
    _sumMoney = [edtStr floatValue] ;
    if (_ticketdata !=nil) {
        _ticketMoney = [_ticketdata[@"money"] floatValue];
        title = _ticketdata[@"name"] ;
        
    }else{
        _ticketMoney = 0.00 ;
    }
    _realMoney = _sumMoney - _ticketMoney ;
    NSString *sumstr = [NSString stringWithFormat:@"¥ %.2f",_sumMoney] ;
    NSString *realstr = [NSString stringWithFormat:@"¥ %.2f",_realMoney] ;
    NSString *ticketstr = [NSString stringWithFormat:@"¥ %.2f",_ticketMoney] ;
    [_summoneLabel setText:sumstr] ;
    [_realmoneLabel setText:realstr] ;
    [_ticketmoneLabel setText:ticketstr] ;
    [_btnticket setTitle:title forState:UIControlStateNormal] ;
    
}


/**
 验证密码
 **/
-(void)showAlertView{
    
    _inputAlertView = [[UIAlertView alloc] initWithTitle:@""
                                                 message:@"请输入密码"
                                                delegate:self
                                       cancelButtonTitle:@"取消"
                                       otherButtonTitles:@"确定", nil];
    _inputAlertView.alertViewStyle = UIAlertViewStyleSecureTextInput;
    
    [_inputAlertView show];
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
            //提交
            [self savePayPost] ;
            
        } failure:^(id data) {
            [self showAlertView] ;
        }];
    }
}

/**
 提交
 **/
-(void)surePay:(id)sender{
    NSString *edtStr = [NSString stringWithFormat:@"%@",_editMoneyTx.text];
    if (edtStr.length <=0) {
        [MBProgressHUD showError:@"请输入金额！"] ;
        return ;
    }
    if (_sumMoney <0 ) {
        [MBProgressHUD showError:@"金额不能小于0！"] ;
        return ;
    }
    
    if(_shopdata == nil){
        [MBProgressHUD showError:@"商铺不存在！"] ;
        return ;
    }
    if(_cashdata == nil){
        [MBProgressHUD showError:@"请选择收银员！"] ;
        return ;
    }
    USAccount *account =  [USUserService accountStatic] ;
    if (account == nil) {
        [MBProgressHUD showError:@"你还没有登录，请登录！"] ;
        return ;
    }
    //弹出密码框
    [self showAlertView] ;

    
}


//提交服务
-(void)savePayPost{
     USAccount *account =  [USUserService accountStatic] ;
    NSString *url = @"scanCodeCilentController/scanPayMoneyWangka.action" ;
    NSMutableDictionary *para = [[NSMutableDictionary alloc]init] ;
    para[@"customer_id"] = account.id ;
    para[@"shop_id"] = _shopdata[@"id"];
    para[@"cashier_id"] = _cashdata[@"id"];
    para[@"ticket_id"] = _ticketdata[@"id"];
    para[@"sumMoney"] = [NSString stringWithFormat:@"%.2f",_sumMoney] ;
    para[@"realMoney"] = [NSString stringWithFormat:@"%.2f",_realMoney] ;
    para[@"ticketMoney"] = [NSString stringWithFormat:@"%.2f",_ticketMoney] ;
    
    [USWebTool POSTWIthTip:url showMsg:@"正在支付..." paramDic:para success:^(NSDictionary *dic) {
        NSDictionary *data = dic[@"data"] ;
        //发送微信商户确认
        [self sendweixinPayMoney:data] ;
    } failure:^(id data) {
        
    }];

}

/**
 发送微信商户确认
 **/
-(void)sendweixinPayMoney:(NSDictionary *)parama{
    HYLog(@"paydata:%@",parama) ;
    NSString *url = @"scanCodeCilentController/sendweixinPayMoney.action" ;
    [USWebTool POSTWIthTip:url showMsg:@"正在发送微信商户确认..." paramDic:parama success:^(NSDictionary *dic) {
        [self.navigationController popViewControllerAnimated:YES] ;
    } failure:^(id data) {
        
    }];
}

/**
 完成以后,键盘消失
 **/
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


-(void)dissView{
    [self updateRespons];
}
-(void)updateRespons{
    [_editMoneyTx resignFirstResponder];
}


@end
