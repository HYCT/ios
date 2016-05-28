//
//  USBindBankCardViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/10.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USBindBankCardViewController.h"
#import "USBankCardListViewController.h"
#import "USCertificationViewController.h"
#import "USUserService.h"
#import "USAccount.h"
#define kTopMargin 20
#define kTipLeftMargin 25
#define kTipRightMargin 10
#define kLabelHeight 30
#define kLabelPadding 10
@interface USBindBankCardViewController()<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,strong)UIPickerView *bankPickerView;
@property(nonatomic,strong)UIView *pickerBgView;
@property(nonatomic,weak)UIButton *bindBtton;
@property(nonatomic,strong) NSArray *bankArray;
@property(nonatomic,strong) UILabel    *nameTipLB;
@property(nonatomic,strong) UITextField *nameField;
@property(nonatomic,strong) UILabel    *bankNameLB;
@property(nonatomic,strong) UITextField *idCardField;
@property(nonatomic,strong) UITextField *bankNumField;
@property(nonatomic,assign) NSInteger currentIndex;
@property(nonatomic,strong) UIButton *accessoryView;
@property(nonatomic,strong) USAccount *account;
@property(nonatomic,strong) NSString *idCard;
@property(nonatomic,strong) NSString *name;
@end
@implementation USBindBankCardViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"添加银行卡";
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
    _nameTipLB = [self createTipUILabel:line.y+line.height+0.5*kLabelPadding title:@"开户姓名:"];
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
    _nameTipLB = [self createTipUILabel:line.y+line.height+0.5*kLabelPadding title:@"选择银行:"];
    [bgview1 addSubview:_nameTipLB];
    _bankNameLB = [self createUILabel:_nameTipLB.y title:@""];
    _bankNameLB.width = kAppWidth-kTipLeftMargin-width-kTipRightMargin-20;
    _bankNameLB.x = kTipLeftMargin+width+5;
    _bankNameLB.textAlignment = NSTextAlignmentCenter;
    [bgview1 addSubview:_bankNameLB];
    UIButton *topBt = [UIButton buttonWithType:UIButtonTypeCustom];
    topBt.frame = _bankNameLB.frame;
    [topBt addTarget:self action:@selector(bankNameClick) forControlEvents:UIControlEventTouchUpInside];
    [bgview1 addSubview:topBt];
    UIButton *accessoryView =  [USUIViewTool createButtonWith:@"" imageName:@"account_cell_down_arrow_ico"];
    _accessoryView = accessoryView;
    [accessoryView addTarget:self action:@selector(accessoryClick:) forControlEvents:UIControlEventTouchUpInside];
    accessoryView.size = CGSizeMake(11, 9);
    accessoryView.x = kAppWidth-accessoryView.width-kTipRightMargin;
    accessoryView.y = _nameTipLB.y+_nameTipLB.height*0.4;
    [bgview1 addSubview:accessoryView];
    line = [self createLine:_nameTipLB.y+_nameTipLB.height+kLabelPadding*0.5];
    line.frame = CGRectMake(kTipRightMargin, line.y, kAppWidth-kTipRightMargin*2, line.height);
    [bgview1 addSubview:line];
    //
    _nameTipLB = [self createTipUILabel:line.y+line.height+0.5*kLabelPadding title:@"银行卡号:"];
    [bgview1 addSubview:_nameTipLB];
    
    _bankNumField = [[UITextField alloc]initWithFrame:CGRectMake(kTipLeftMargin+width+5, _nameTipLB.y, kAppWidth-kTipLeftMargin-width-kTipRightMargin-5, kLabelHeight)];
    _bankNumField.delegate = self;
    _bankNumField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入银行卡号" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:kCommonFontSize_15]}];
    _bankNumField.textAlignment = NSTextAlignmentRight;
    [bgview1 addSubview:_bankNumField];
    line = [self createLine:bgview1.height-1];
    [bgview1 addSubview:line];
    [self.view addSubview:bgview1];
    //
    UIButton *bindBtton = [USUIViewTool createButtonWith:@"绑  定" imageName:@"login_bt_img"];
    bindBtton.frame = CGRectMake(10, bgview1.y+ bgview1.height+kTopMargin, kAppWidth-20, 35);
    [bindBtton addTarget:self action:@selector(bind) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: bindBtton];
    _bindBtton = bindBtton;
}
-(void)loadData{
    [USWebTool POST:@"realnameclient/getRealNameObjData.action" showMsg:@"" paramDic:@{@"customer_id":_account.id} success:^(NSDictionary *dataDic) {
        dataDic = dataDic[@"data"];
        _name = dataDic[@"name"];
        _nameField.text = [USStringTool geStarString:dataDic[@"name"] lastCount:1];
        _idCardField.text = [USStringTool getBankCardNoString:dataDic[@"idcard"]];
        _idCard = dataDic[@"idcard"];
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
    
    if (_name==nil||_name==0||_name.length==1) {
        [MBProgressHUD showError:@"姓名填写错误，必须是2个字符以上..."];
        return;
    }
    if (_idCard==nil||(_idCard.length!=15&&_idCard.length!=18)) {
        [MBProgressHUD showError:@"请填写合法的身份证号码..."];
        return;
    }
    if ([_bankArray count]==0) {
        [MBProgressHUD showError:@"请选择银行后填写卡号..."];
        return;
    }
    if (_bankNumField.text==nil||_bankNumField.text.length<16) {
        [MBProgressHUD showError:@"请填写合法银行卡号..."];
        return;
    }
    
    NSDictionary *params = @{@"name":_name,
                             @"bank_name":_bankArray[_currentIndex][@"name"],
                             @"idcard":_idCard,
                             @"bank_code":_bankArray[_currentIndex][@"code"],
                             @"card_num":_bankNumField.text,
                             @"customer_id":_account.id
                             };
    [USWebTool POST:@"bindbankcardcilent/saveCustomerBindBank.action" showMsg:@"正在绑定银行卡..." paramDic:params success:^(NSDictionary * dic) {
        _account.isbindbankcard = 1;
        [USUserService saveAccount:_account];
        //        USBankCardListViewController *bankCardListVC = [[USBankCardListViewController alloc]init];
        //        [self.navigationController pushViewController:bankCardListVC animated:YES];
        //        [self removeFromParentViewController];
        [self.navigationController popViewControllerAnimated:YES];
        [MBProgressHUD showSuccess:@"绑定银行卡成功..."];
    }];
    
    
}
-(void)dissView{
    [super.topView removeFromSuperview];
    [self updateRespons];
}
-(void)updateRespons{
    [_bankNumField resignFirstResponder];
    [_nameField resignFirstResponder];
    [_idCardField resignFirstResponder];
}
-(UIButton *)createPickerButtonWithTitle:(NSString *)title{
    UIButton *cancelBt = [USUIViewTool createButtonWith:title];
    [cancelBt.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [cancelBt setTitleColor:HYCTColor(163, 163, 163) forState:UIControlStateNormal];
    [cancelBt setTitleColor:HYCTColor(163, 163, 163) forState:UIControlStateHighlighted];
    cancelBt.frame = CGRectMake(0, 1, kAppWidth/4, 15);
    return cancelBt;
}
-(void)bankNameClick{
    [self accessoryClick:_accessoryView];
}
-(void)accessoryClick:(UIButton *)button{
    HYLog(@"-------accessoryClick-----");
    button.enabled = NO;
    if (!_pickerBgView) {
        _pickerBgView = [[UIView alloc]init];
        _pickerBgView.backgroundColor = HYCTColor(240, 241, 240);
        UIView *line = [USUIViewTool createLineView];
        line.backgroundColor = HYCTColor(218, 218, 218);
        [_pickerBgView addSubview:line];
        [self.view addSubview:_pickerBgView];
        UIButton *cancelBt = [self createPickerButtonWithTitle:@"取消"];
        cancelBt.y = 5;
        UIButton *confirmBt = [self createPickerButtonWithTitle:@"确定"];
        confirmBt.y = 5;
        confirmBt.x = kAppWidth-cancelBt.width;
        
        [_pickerBgView addSubview:cancelBt];
        [_pickerBgView addSubview:confirmBt];
        [cancelBt addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        [confirmBt addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
        _bankPickerView = [[UIPickerView alloc]init];
        [USWebTool POST:@"bindbankcardcilent/banklist.action" showMsg:@"正在玩命加载银行列表..." paramDic:nil success:^(NSDictionary * dic) {
            _bankArray = dic[@"data"];
            _bankPickerView.delegate = self;
            _bankPickerView.dataSource = self;
            [_bankPickerView setBackgroundColor:[UIColor whiteColor]];
            _bankPickerView.y = confirmBt.y+confirmBt.height+10;
            _bankPickerView.x = 0;
            [_pickerBgView addSubview: _bankPickerView];
            _pickerBgView.frame = CGRectMake(0, _bindBtton.y+_bindBtton.height+20, kAppWidth, kAppHeight-button.y-button.height);
        } failure:^(id data) {
            _pickerBgView = nil;
        }];
        
        
    }else{
        [self upAnimate];
    }
    
    
}
-(void)cancel{
    [self downAnimate];
    _accessoryView.enabled = YES;
}
-(void)confirm{
    HYLog(@"----%@----",_bankArray[_currentIndex]);
    [self downAnimate];
    _accessoryView.enabled = YES;
    _bankNameLB.text = _bankArray[_currentIndex][@"name"];
}
- (void)upAnimate {
    [UIView animateWithDuration:0.5 animations:^{
        _pickerBgView.y -= kAppHeight;
    }];
}
- (void)downAnimate {
    [UIView animateWithDuration:0.5 animations:^{
        _pickerBgView.y += kAppHeight;
    }];
}
#pragma mark - pickerview data source
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [_bankArray count];
}
-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [_bankArray objectAtIndex:row][@"name"];
}
#pragma mark - pickerview delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)componen{
    
    _currentIndex = row;
}
@end
