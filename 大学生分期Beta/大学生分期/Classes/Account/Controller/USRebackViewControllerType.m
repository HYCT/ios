//
//  USRebackViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/9.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USRebackViewControllerType.h"
#import "USRebackTableViewCell.h"
#import "USBankCardListViewController.h"
#import "USMyTicketViewController.h"
#import "USCommonBankCardListViewController.h"
#define kMargin 5
#define kBase 10
@interface USRebackViewControllerType()
//现金
@property(nonatomic,strong)UILabel *cashLabel ;
//手续费
@property(nonatomic,strong)UILabel *thirdFeeLabel ;
@property(nonatomic,assign)CGFloat thirdMoney ;
//利息
@property(nonatomic,strong)UILabel *moneyFeeLabel ;
@property(nonatomic,assign)CGFloat moneyFee ;
//服务费
@property(nonatomic,strong)UILabel *chargeFeeLabel ;
@property(nonatomic,assign)CGFloat chargeFee ;
//总额
@property(nonatomic,strong)UILabel *sumMoneyLabel ;
@property(nonatomic,assign)CGFloat sumoney ;
//还款按钮
@property(nonatomic,strong)UIButton *btnreback ;
//优惠券按钮
@property(nonatomic,strong)UIButton *btnTicket ;
//删除券
@property(nonatomic,strong)UIButton *clearBtn;

@property(nonatomic,strong)NSDictionary * ticketData ;

@property(nonatomic,assign)CGFloat height ;


@end
@implementation USRebackViewControllerType
-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"还款明细费用";
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //本金
    [self createCash ] ;
    
    //分类费用
    [self createTypefee] ;
    
    //设值
    [self setIniValue] ;
    
    //还款按钮
    [self createReBackButton] ;
    
    //获取详情
    [self getPayDataDetail] ;
    
}

//创建还款本金
-(void)createCash{
    
    CGFloat bgHeight = 40 ;
    UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 20, kAppWidth, bgHeight) ];
    
    CGFloat labelHight = 14 ;
    //文本
    UILabel *label = [USUIViewTool createUILabelWithTitle:@"还款本金" fontSize:14 color:[UIColor blackColor] heigth:labelHight] ;
    [label setFrame:CGRectMake(10, (bgHeight-labelHight)/2, 60, labelHight )] ;
    [bgview addSubview:label] ;
    
    //分割线
    UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(label.x+label.width+5, 8, 1, bgHeight-16)];
    [lineview setBackgroundColor:HYCTColor(240,240,240)] ;
    [bgview addSubview:lineview] ;
    
    //金额
    _cashLabel= [USUIViewTool createUILabelWithTitle:@"0.00" fontSize:14 color:[UIColor blackColor] heigth:labelHight] ;
    [_cashLabel setFrame:CGRectMake(lineview.x+10, label.y, kAppWidth-label.x-label.width+lineview.x+lineview.width-lineview.x - _cashLabel.x, label.height)] ;
    [bgview addSubview:_cashLabel] ;
    
    
    [bgview setBackgroundColor:[UIColor whiteColor]] ;
    _height=bgview.height +bgview.y;
    [self.view addSubview:bgview] ;
}


/**
 创建分类型的费用
 **/
-(void)createTypefee{
    CGFloat bgHeight = 165 ;
    UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(0, _height+20, kAppWidth, bgHeight) ];
    [bgview setBackgroundColor:[UIColor whiteColor]] ;
    //手续费
    CGFloat labelHight = 14 ;
    NSString *defaultvalue = [NSString stringWithFormat:@"¥ %.2f",0.00] ;
    //文本
    UILabel *label = [USUIViewTool createUILabelWithTitle:@"手续费：" fontSize:14 color:HYCTColor(137, 138, 145) heigth:labelHight] ;
    [label setX:10] ;
    [label setY:10] ;
    [label setWidth:80] ;
    [bgview addSubview:label] ;
    
    _thirdFeeLabel = [USUIViewTool createUILabelWithTitle:defaultvalue fontSize:14 color:[UIColor blackColor] heigth:labelHight];
    [_thirdFeeLabel setX:label.x +label.width +5 ] ;
    [_thirdFeeLabel setY:label.y];
    [_thirdFeeLabel setWidth:kAppWidth-label.x-label.width -20] ;
    [_thirdFeeLabel setTextAlignment:NSTextAlignmentRight] ;
    [bgview addSubview:_thirdFeeLabel] ;
    
    //利息
    label = [USUIViewTool createUILabelWithTitle:@"利息：" fontSize:14 color:HYCTColor(137, 138, 145) heigth:labelHight] ;
    [label setX:10] ;
    [label setY:_thirdFeeLabel.y+_thirdFeeLabel.height+ 10] ;
    [label setWidth:80] ;
    [bgview addSubview:label] ;
    
    _moneyFeeLabel = [USUIViewTool createUILabelWithTitle:defaultvalue fontSize:14 color:[UIColor blackColor] heigth:labelHight];
    [_moneyFeeLabel setX:_thirdFeeLabel.x] ;
    [_moneyFeeLabel setY:label.y];
    [_moneyFeeLabel setWidth:_thirdFeeLabel.width] ;
    [_moneyFeeLabel setTextAlignment:NSTextAlignmentRight] ;
    [bgview addSubview:_moneyFeeLabel] ;
    
    
    //服务费
    label = [USUIViewTool createUILabelWithTitle:@"服务费：" fontSize:14 color:HYCTColor(137, 138, 145) heigth:labelHight] ;
    [label setX:10] ;
    [label setY:_moneyFeeLabel.y+_moneyFeeLabel.height+ 10] ;
    [label setWidth:80] ;
    [bgview addSubview:label] ;
    
    _chargeFeeLabel = [USUIViewTool createUILabelWithTitle:defaultvalue fontSize:14 color:[UIColor blackColor] heigth:labelHight];
    [_chargeFeeLabel setX:_thirdFeeLabel.x] ;
    [_chargeFeeLabel setY:label.y];
    [_chargeFeeLabel setWidth:_thirdFeeLabel.width] ;
    [_chargeFeeLabel setTextAlignment:NSTextAlignmentRight] ;
    [bgview addSubview:_chargeFeeLabel] ;
    
    
    //线条
    UIView *lineview = [USUIViewTool createLineView] ;
    [lineview setWidth:kAppWidth-20] ;
    [lineview setX:10] ;
    [lineview setY:_chargeFeeLabel.y+_chargeFeeLabel.height +20] ;
    [bgview addSubview:lineview] ;
    
    
    //优惠券
    label = [USUIViewTool createUILabelWithTitle:@"优惠券：" fontSize:16 color:HYCTColor(137, 138, 145) heigth:labelHight] ;
    [label setX:10] ;
    [label setY:lineview.y+lineview.height+ 10] ;
    [label setWidth:70] ;
    [bgview addSubview:label] ;
    
    //删除券
    _clearBtn = [USUIViewTool createButtonWith:@"删除券"] ;
    [_clearBtn setFrame:CGRectMake(label.x + label.width, label.y-5, 70, labelHight+10)] ;
    [_clearBtn setFont:[UIFont systemFontOfSize:kCommonFontSize_12]] ;
    [_clearBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal] ;
    [_clearBtn setBackgroundColor:[UIColor orangeColor]] ;
    [_clearBtn.layer setCornerRadius:_clearBtn.height/2 ] ;
    [_clearBtn addTarget:self action:@selector(clearTicketFun) forControlEvents:UIControlEventTouchUpInside] ;
    [bgview addSubview:_clearBtn] ;
    
    _btnTicket = [USUIViewTool createButtonWith:@"选择优惠券 >"] ;
    [_btnTicket setFrame:CGRectMake(_clearBtn.x + _clearBtn.width, _clearBtn.y, kAppWidth - _clearBtn.x -_clearBtn.width -10, labelHight+10)] ;
    //[_btnTicket setBackgroundColor:[UIColor blueColor]] ;
    [_btnTicket setTitle:@"选择优惠券 >" forState:0] ;
    [_btnTicket setFont:[UIFont systemFontOfSize:kCommonFontSize_14]] ;
    [_btnTicket setTitleColor:HYCTColor(137, 138, 145) forState:0] ;
    [_btnTicket.titleLabel setTextAlignment:NSTextAlignmentRight] ;
    [_btnTicket setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight] ;
    [_btnTicket addTarget:self action:@selector(selectTicket:) forControlEvents:UIControlEventTouchUpInside] ;
    [bgview addSubview:_btnTicket] ;
    
    
    //线条
    lineview = [USUIViewTool createLineView] ;
    [lineview setWidth:kAppWidth-20] ;
    [lineview setX:10] ;
    [lineview setY:label.y+label.height +10] ;
    [bgview addSubview:lineview] ;
    
    //还款总额
    label = [USUIViewTool createUILabelWithTitle:@"还款总额：" fontSize:16 color:HYCTColor(137, 138, 145) heigth:labelHight] ;
    [label setX:10] ;
    [label setY:lineview.y+lineview.height+ 10] ;
    [label setWidth:80] ;
    [bgview addSubview:label] ;
    
    _sumMoneyLabel = [USUIViewTool createUILabelWithTitle:defaultvalue fontSize:16 color:[UIColor redColor] heigth:labelHight];
    [_sumMoneyLabel setWidth:_thirdFeeLabel.width ] ;
    [_sumMoneyLabel setX:_thirdFeeLabel.x] ;
    [_sumMoneyLabel setY:label.y];
    [_sumMoneyLabel setTextAlignment:NSTextAlignmentRight] ;
    [bgview addSubview:_sumMoneyLabel] ;
    
    _height = bgview.height +bgview.y;
    [self.view addSubview:bgview] ;
}


//还款按钮
-(void) createReBackButton{
    CGFloat bgHeight = 100 ;
    UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(0, _height+20, kAppWidth, bgHeight) ];
    _btnreback = [USUIViewTool createButtonWith:@"确认还款"] ;
    [_btnreback setTitleColor:[UIColor whiteColor] forState:0] ;
    [_btnreback setBackgroundColor:HYCTColor(0,170,237)] ;
    [_btnreback.layer setCornerRadius:2] ;
    [_btnreback setFont:[UIFont systemFontOfSize:14]] ;
    [_btnreback setFrame:CGRectMake(20, 10, kAppWidth-40, 40)] ;
    [_btnreback addTarget:self action:@selector(reback:) forControlEvents:UIControlEventTouchUpInside] ;
    [ bgview addSubview:_btnreback];
    
    _height = bgview.height +bgview.y;
    [self.view addSubview:bgview] ;
    
}

//设置初始值
-(void)setIniValue{
    _cashLabel.text = [NSString stringWithFormat:@"%.2f",_money];
}

-(void)confirmReback{
    HYLog(@"确认还款");
}
-(void)iniView{
    
}

//获取还款详细费用
-(void)getPayDataDetail{
    NSString *url = @"repaymoneycilent/getRepayMoneyDetailType.action";
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    param[@"borrow_id"]= _rebackId ;
    param[@"repayMoney"] =_cashLabel.text ;
    
    [USWebTool POSTWIthTip:url showMsg:@"正在查询数据..." paramDic:param success:^(NSDictionary *dic) {
        NSDictionary *da = dic[@"data"];
        
        //利息
        _moneyFee = [da[@"repaymoney_rate"] floatValue] ;
        _moneyFeeLabel.text = [NSString stringWithFormat:@"¥ %@",da[@"repaymoney_rate"]] ;
        //手续费
        _thirdMoney = [da[@"third_fee_rate"] floatValue] ;
        _thirdFeeLabel.text = [NSString stringWithFormat:@"¥ %@",da[@"third_fee_rate"]] ;
        //服务费
        _chargeFee = [da[@"borrow_charge_rate"] floatValue] ;
        _chargeFeeLabel.text = [NSString stringWithFormat:@"¥ %@",da[@"borrow_charge_rate"]];
        //总金额
        _sumoney = [da[@"sum_total"] floatValue] ;
        _sumMoneyLabel.text=[NSString stringWithFormat:@"¥ %@",da[@"sum_total"]];
        
    } failure:^(id data) {
        
    }];
    
}


/**
 的还款
 **/

-(void)reback:(UIButton *)sender{
    //
    NSString *products=@"还款";
    NSMutableString *urlStr = [NSMutableString stringWithString:kHuiChaoUrl];
    [urlStr appendString:[NSString stringWithFormat:@"id=%@&",_rebackId]];
    [urlStr appendString:[NSString stringWithFormat:@"repay_money=%@&",_cashLabel.text]];
    [urlStr appendString:[NSString stringWithFormat:@"products=%@&",products]];
    //加优惠券
    if(_ticketData != nil){
        [urlStr appendString:[NSString stringWithFormat:@"ticketId=%@",_ticketData[@"id"]]];
    }
    
    USCommonBankCardListViewController *controller = [[USCommonBankCardListViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES] ;
    
    
}

-(void)senderback:(UIButton *)sender{
    //
    NSString *products=@"还款";
    NSMutableString *urlStr = [NSMutableString stringWithString:kHuiChaoUrl];
    [urlStr appendString:[NSString stringWithFormat:@"id=%@&",_rebackId]];
    [urlStr appendString:[NSString stringWithFormat:@"repay_money=%@&",_cashLabel.text]];
    [urlStr appendString:[NSString stringWithFormat:@"products=%@&",products]];
    //加优惠券
    if(_ticketData != nil){
      [urlStr appendString:[NSString stringWithFormat:@"ticketId=%@",_ticketData[@"id"]]];
    }
        
    NSString *ulr = [(NSString *)urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:ulr]];
}

//协议
-(void) didTicketClick:(NSDictionary *)data{
    _ticketData = data ;
    if (_ticketData != nil) {
        [self changeValues] ;
    }
}

//清除
-(void)clearTicketFun{
    _ticketData = nil ;
    [self changeValues] ;
}


/**
 改变值
 **/
-(void)changeValues{
    
    NSString *name = @"选择优惠券 >" ;
    CGFloat ticketMoney = 0.00 ;
    CGFloat surplus = 0.00 ;
    
    if (_ticketData != nil) {
        name = [NSString stringWithFormat:@"%@ >",_ticketData[@"name"]] ;
        ticketMoney = [_ticketData[@"money"] floatValue] ;
    }
    surplus = _thirdMoney + _chargeFee + _moneyFee - ticketMoney ;
    if (surplus < 0) {
        surplus = 0 ;
    }
    _sumoney = _money +surplus ;
    
    NSString *sumStr = [NSString stringWithFormat:@"¥ %.2f",_sumoney] ;
    [_sumMoneyLabel setText:sumStr] ;
    [  _btnTicket setTitle:name forState:0] ;
}

/**
 选择优惠券
 **/
-(void)selectTicket:(UIButton *)sender{
    USMyTicketViewController *controller = [[USMyTicketViewController alloc]init] ;
    controller.used = @"0";
    controller.typeCodeStr =@"code_fee" ;
    controller.rebackTicketDelegate = self ;
    [self.navigationController pushViewController:controller animated:YES] ;
    
}


@end
