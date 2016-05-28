//
//  USRebackViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/9.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USRebackViewController.h"
#import "USRebackTableViewCell.h"
#import "USBankCardListViewController.h"
#import "USRebackViewControllerType.h"
#define kMargin 5
#define kBase 0
@interface USRebackViewController()
@property(nonatomic,strong) UILabel *loanTotalLB;
@property(nonatomic,strong) UILabel *loanDateTipLB;
@property(nonatomic,strong) UILabel *blanceTipLB;
@property(nonatomic,strong) UITextField *quotaField;
@property(nonatomic,strong) NSMutableArray *bttonsArray;
@property(nonatomic,assign) CGFloat amount;
@end
@implementation USRebackViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"还款明细";
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createRebackDetailView];
    [self loadData];
}
-(void)confirmReback{
    HYLog(@"确认还款");
}
-(void)iniView{
    
}
-(void)createRebackDetailView{
    UILabel *tipText =[[UILabel alloc]initWithFrame:CGRectMake(10, 5, kAppWidth-20, 100)];
    tipText.backgroundColor = [UIColor clearColor];
    //tipText.editable = NO;
    tipText.font = [UIFont systemFontOfSize:kCommonFontSize_14];
    tipText.text = @"友情提示:\n还款没有成功或者刷新的请等待至少5分钟后在刷新还款!\n还款总额=还款金额+利息+服务费+支付手续费";
    tipText.textColor = HYCTColor(175, 175, 175);
    [  tipText setNumberOfLines:10] ;
    [self.view addSubview:tipText];
    //
    UIView *centerView = [[UIView alloc]initWithFrame:CGRectMake(0, tipText.y+tipText.height+10, kAppWidth, 100)];
    CGFloat width = kAppWidth - centerView.x*2-kMargin*2;
    centerView.layer.borderColor = [HYCTColor(221, 221, 221) CGColor];
    centerView.layer.borderWidth = 0.8;
    [centerView setBackgroundColor:[UIColor whiteColor]];
     UILabel *tipLB = [USUIViewTool createUILabelWithTitle:@"本次应还:" fontSize:kCommonFontSize_15 color:HYCTColor(168, 168, 168) heigth:kCommonFontSize_15];
    [centerView addSubview:tipLB];
    tipLB.frame = CGRectMake(kMargin, kMargin+kCommonFontSize_32*0.5, 70, kCommonFontSize_15);
    _loanTotalLB = [USUIViewTool createUILabelWithTitle:@"00.00" fontSize:kCommonFontSize_32 color:[UIColor blackColor] heigth:kCommonFontSize_32];
    [_loanTotalLB setFont:[UIFont boldSystemFontOfSize:kCommonFontSize_32]];
    _loanTotalLB.frame = CGRectMake(tipLB.x+tipLB.width, kMargin*0.5+tipLB.height*0.6, width-tipLB.width, _loanTotalLB.height);
    _loanTotalLB.textAlignment = NSTextAlignmentRight;
    [centerView addSubview:_loanTotalLB];
    //
    
    tipLB = [USUIViewTool createUILabelWithTitle:@"借款日期:" fontSize:kCommonFontSize_15 color:HYCTColor(168, 168, 168) heigth:kCommonFontSize_15];
    tipLB.frame = CGRectMake(kMargin, _loanTotalLB.y+_loanTotalLB.height+kMargin*2, 70, kCommonFontSize_15);
    [centerView addSubview:tipLB];
    
    _loanDateTipLB = [USUIViewTool createUILabelWithTitle:@"" fontSize:kCommonFontSize_15 color:HYCTColor(168, 168, 168) heigth:kCommonFontSize_15];
    _loanDateTipLB.frame = tipLB.frame;
    _loanDateTipLB.width = width - tipLB.width;
    _loanDateTipLB.x = tipLB.width+tipLB.x;
    _loanDateTipLB.textAlignment = NSTextAlignmentRight;
    [centerView addSubview:_loanDateTipLB];
    //
    
    tipLB = [USUIViewTool createUILabelWithTitle:@"借款本金:" fontSize:kCommonFontSize_15 color:HYCTColor(168, 168, 168) heigth:kCommonFontSize_15];
    tipLB.frame = CGRectMake(kMargin, _loanDateTipLB.y+_loanDateTipLB.height+kMargin*2, 70, kCommonFontSize_15);
    [centerView addSubview:tipLB];
    _blanceTipLB = [USUIViewTool createUILabelWithTitle:@"" fontSize:kCommonFontSize_15 color:HYCTColor(168, 168, 168) heigth:kCommonFontSize_15];
    _blanceTipLB.frame = tipLB.frame;
    _blanceTipLB.width = width - tipLB.width;
    _blanceTipLB.x = tipLB.width+tipLB.x;
    _blanceTipLB.textAlignment = NSTextAlignmentRight;
    [centerView addSubview:_blanceTipLB];
    [self.view addSubview:centerView];
    
    //
    centerView = [[UIView alloc]initWithFrame:CGRectMake(0, centerView.y+centerView.height+20, kAppWidth, 50)];
    centerView.layer.borderColor = [HYCTColor(221, 221, 221) CGColor];
    centerView.layer.borderWidth = 0.8;
    [centerView setBackgroundColor:[UIColor whiteColor]];
    tipLB = [USUIViewTool createUILabelWithTitle:@"还款金额:" fontSize:kCommonFontSize_16 color:[UIColor blackColor] heigth:kCommonFontSize_16];
    tipLB.frame = CGRectMake(kMargin, (centerView.height-kCommonFontSize_16)*0.5, 90, kCommonFontSize_16);
    [centerView addSubview:tipLB];
    //
    UITextField *quotaField = [[UITextField alloc]init];
    quotaField.backgroundColor = [UIColor whiteColor];
    quotaField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 20)];
    quotaField.leftViewMode = UITextFieldViewModeAlways;
    quotaField.placeholder = @"输入还款金额";
    quotaField.keyboardType = UIKeyboardTypeNumberPad;
    quotaField.frame =  CGRectMake(tipLB.x+tipLB.width, tipLB.y, kAppWidth-tipLB.width, tipLB.height);
    quotaField.inputAccessoryView = [self createCustomAccessoryView:@selector(updateRespons)] ;
    //添加了自定义键盘不需要添加returnKeyType
    quotaField.returnKeyType =UIReturnKeyDone ;
    quotaField.delegate = self ;
    [centerView addSubview:quotaField];
    _quotaField = quotaField;
    _quotaField.enabled = YES;
    _quotaField.delegate = self;
    [self.view addSubview:centerView];
    
    //buttons
    _bttonsArray = [NSMutableArray arrayWithCapacity:1];
    UIButton *allBt = [USUIViewTool createButtonWith:@"确认还款"];
    allBt.backgroundColor = [UIColor orangeColor];
    allBt.frame = CGRectMake(kMargin*3, centerView.y+centerView.height+kMargin*3, (kAppWidth-kMargin*6), 40);
    allBt.tag = 0;
    allBt.layer.cornerRadius = 5 ;
    [allBt addTarget:self action:@selector(reback:) forControlEvents:UIControlEventTouchUpInside];
    [_bttonsArray addObject:allBt];
    [self.view addSubview:allBt];
    allBt.enabled = YES;
    /**
    //
    UIButton *partBt = [USUIViewTool createButtonWith:@"部分还款"];
    partBt.backgroundColor = HYCTColor(148, 148, 148);
    partBt.frame = CGRectMake(allBt.x+allBt.width, centerView.y+centerView.height+kMargin*3, (kAppWidth-kMargin*6)*0.5, 40);
    partBt.tag = 1;
    partBt.enabled = YES;
    [partBt addTarget:self action:@selector(reback:) forControlEvents:UIControlEventTouchUpInside];
    [_bttonsArray addObject:partBt];
    [self.view addSubview:partBt];
    **/
}
-(void)loadData{
    NSString *url = @"repaymoneycilent/getRepayMoneyDetail.action";
    [USWebTool POST:url showMsg:@"正在获取还款详情..." paramDic:@{@"id":_rebackId} success:^(NSDictionary *dataDic) {
        NSDictionary *data = dataDic[@"data"];
        _loanTotalLB.text = data[@"sum_total"];
        _blanceTipLB.text = data[@"sum_total"];
        _loanDateTipLB.text = data[@"fangkuan_time"];
        _amount = [data[@"sum_total"] floatValue];
        _quotaField.text = data[@"sum_total"];
        [self updateButtonStateWithBus:[data[@"sum_total"] floatValue]];
    }];
}
-(void)updateButtonState:(BOOL)state{
    for (UIButton *bt in _bttonsArray) {
        bt.enabled = state;
    }
}
-(void)updateButtonStateWithBus:(CGFloat )amount{
     [self updateButtonState:_quotaField.enabled];
    if (amount<kBase) {
        //((UIButton *)_bttonsArray[1]).enabled = YES;
        _quotaField.text =[NSString stringWithFormat:@"%.2f",amount];
        _quotaField.enabled = NO;
         ((UIButton *)_bttonsArray[0]).enabled = YES;
    }else{
        ((UIButton *)_bttonsArray[0]).enabled = YES;
        //((UIButton *)_bttonsArray[1]).enabled = YES;
    }
}
-(void)dissView{
    [self updateRespons];
}
-(void)updateRespons{
    [_quotaField resignFirstResponder];
}
-(BOOL)isCanCommite{
    if(_quotaField.text.length>0){
        return [_quotaField.text floatValue]>0;
    }
    return NO;
}

//还款的各项费用分类
-(void)reback:(UIButton *)sender{
    sender.backgroundColor = [UIColor orangeColor];
    for (UIButton *bt in _bttonsArray) {
        if (sender!=bt&&bt.enabled) {
            bt.backgroundColor = HYCTColor(148, 148, 148);
        }
    }
    if (![self isCanCommite]) {
        [MBProgressHUD showError:@"输入的金额必须大于0"];
        return;
    }
    
    if (!([_quotaField.text floatValue]>=kBase)) {
        [MBProgressHUD showError:@"输入的金额必须大于等于0"];
        return;
    }else if (_amount<=kBase){
        _quotaField.text =[NSString stringWithFormat:@"%.2f",_amount];
    }

    
    //还款的各项费用分类
    USRebackViewControllerType *rebackTypecontroller = [USRebackViewControllerType alloc] ;
    //id
    rebackTypecontroller.rebackId = self.rebackId ;
    //金额
    rebackTypecontroller.money = [_quotaField.text floatValue];
    [self.navigationController pushViewController:rebackTypecontroller animated:YES];
}

//老的还款方法
-(void)rebackold:(UIButton *)sender{
    NSString *products = @"还款";
    sender.backgroundColor = [UIColor orangeColor];
    for (UIButton *bt in _bttonsArray) {
        if (sender!=bt&&bt.enabled) {
            bt.backgroundColor = HYCTColor(148, 148, 148);
        }
    }
    if (![self isCanCommite]) {
        [MBProgressHUD showError:@"输入的金额必须大于0"];
        return;
    }
    switch (sender.tag) {
        case 0:
        {
            _quotaField.text =[NSString stringWithFormat:@"%.2f",_amount];
            _quotaField.enabled = YES;
        }
            break;
            
        default:
        {
            _quotaField.enabled = YES;
            if (!([_quotaField.text floatValue]>=kBase)) {
                [MBProgressHUD showError:@"输入的金额必须大于等于0"];
                return;
            }else if (_amount<=kBase){
                _quotaField.text =[NSString stringWithFormat:@"%.2f",_amount];
            }
        }
            break;
    }
    //
    NSMutableString *urlStr = [NSMutableString stringWithString:kHuiChaoUrl];
    [urlStr appendString:[NSString stringWithFormat:@"id=%@&",_rebackId]];
    [urlStr appendString:[NSString stringWithFormat:@"repay_money=%@&",_quotaField.text]];
    [urlStr appendString:[NSString stringWithFormat:@"products=%@",products]];
    NSString *ulr = [(NSString *)urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:ulr]];
}

-(void)iniView1{
    _formatString = @"金额   %@元";
    [self initCardView];
    UIView   *centerView = [self createCenterView];
    [self.view addSubview:centerView];
    UIButton *rebackBt = [USUIViewTool createButtonWith:@"确认还款" imageName:@"account_reback_bt_ico"];
    [rebackBt addTarget:self action:@selector(confirmReback) forControlEvents:UIControlEventTouchUpInside];
    rebackBt.height = 30;
    [rebackBt.titleLabel setFont:[UIFont systemFontOfSize:14]];
    
    rebackBt.y = centerView.y+centerView.height+10;
    rebackBt.x = 10;
    rebackBt.width = kAppWidth-rebackBt.x*2;
    [self.view addSubview:rebackBt];
}
-(void)initCardView{
    USRebackTableViewCell *cardView = [[USRebackTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ID"];
    cardView.height = 65;
    cardView.y = 15;
    cardView.backgroundColor = [UIColor whiteColor];
    for (UIView *view in [cardView.leftView subviews]) {
        [view removeFromSuperview];
    }
    cardView.leftView.width = kAppWidth*0.25;
    cardView.leftView.height = cardView.height*0.5;
    NSString *title = @"中国建设银行借记卡***4452";
    [cardView setUpTitle:title];
    [cardView setDownTitle:@"可还款交易"];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bank_ico"]];
    imageView.size = cardView.leftView.size;
     cardView.leftView.y = cardView.height*0.5- cardView.leftView.height*0.5;
    [cardView.leftView addSubview:imageView];
    [cardView updateFrame:cardView.leftView.frame];
    [self.view addSubview:cardView];
    _cardView = cardView;
    [self.view addSubview:_rebackTotalLB];
    [_cardView.accessoryBt addTarget:self action:@selector(toBankCardList) forControlEvents:UIControlEventTouchUpInside];
}
-(UIView *)createCenterView{
    UIView *centerView = [[UIView alloc]initWithFrame:CGRectMake(0, _cardView.y+_cardView.height+10, kAppWidth, 60)];
    [centerView setBackgroundColor:[UIColor whiteColor]];
    UILabel *rebackTotalLB = [USUIViewTool createUILabel];
    rebackTotalLB.height = centerView.height;
    rebackTotalLB.y = 0;
    rebackTotalLB.backgroundColor = [UIColor clearColor];
    rebackTotalLB.font = [UIFont systemFontOfSize:14];
    rebackTotalLB.textColor = [UIColor grayColor];
    rebackTotalLB.attributedText =  [USStringTool createCountBlanceAttrStringWithFormat:[NSString stringWithFormat:_formatString,[USStringTool getCurrencyStr:_totalMoney]]];
    _rebackTotalLB = rebackTotalLB;
    [centerView addSubview:rebackTotalLB];
    return centerView;
    
}
-(void)toBankCardList{
    HYLog(@"toBankCardList.....");
    USBankCardListViewController *listVC = [[USBankCardListViewController alloc]init];
    [self.navigationController pushViewController:listVC animated:YES];
}


/**
 完成以后,键盘消失
 **/
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
