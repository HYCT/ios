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
#import "USCommonListController.h"
#import "USHtmlLoadViewInsideController.h"
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
@property(nonatomic,strong) UILabel    *labelTipLB;
@property(nonatomic,strong) UILabel    *bankNameLB;
@property(nonatomic,strong) UITextField *bankNumField;
@property(nonatomic,strong) UITextField *telephoneField ;
@property(nonatomic,assign) NSInteger currentIndex;
@property(nonatomic,strong) UIButton *accessoryView;
@property(nonatomic,strong) USAccount *account;
@property(nonatomic,strong) UITextField *provinceField;
@property(nonatomic,strong) NSString *pro_code ;
@property(nonatomic,strong) UITextField *areaidField;
@property(nonatomic,strong) NSString *area_code ;

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
}

-(void)createViews{
    
    UIView *bgview1 = [[UIView alloc]initWithFrame:CGRectMake(0, kTopMargin, kAppWidth, kLabelHeight*3+kLabelPadding*3)];
    bgview1.backgroundColor = [UIColor whiteColor];
    UIView *line= [self createLine:0];
    [bgview1 addSubview:line];
    _labelTipLB = [self createTipUILabel:line.y+line.height+0.5*kLabelPadding title:@"选择银行:"];
    CGFloat width = [self getLableStringWidth:_labelTipLB];
    [bgview1 addSubview:_labelTipLB];
    _bankNameLB = [self createUILabel:_labelTipLB.y title:@""];
    _bankNameLB.width = kAppWidth-kTipLeftMargin-width-kTipRightMargin-20;
    _bankNameLB.x = kTipLeftMargin+width+5;
    _bankNameLB.textAlignment = NSTextAlignmentCenter;
    [bgview1 addSubview:_bankNameLB];
    //按钮
    UIButton *topBt = [UIButton buttonWithType:UIButtonTypeCustom];
    topBt.frame = _bankNameLB.frame;
    [topBt addTarget:self action:@selector(bankNameClick) forControlEvents:UIControlEventTouchUpInside];
    [bgview1 addSubview:topBt];
    UIButton *accessoryView =  [USUIViewTool createButtonWith:@"" imageName:@"account_cell_down_arrow_ico"];
    _accessoryView = accessoryView;
    [accessoryView addTarget:self action:@selector(accessoryClick:) forControlEvents:UIControlEventTouchUpInside];
    accessoryView.size = CGSizeMake(11, 9);
    accessoryView.x = kAppWidth-accessoryView.width-kTipRightMargin;
    accessoryView.y = _labelTipLB.y+_labelTipLB.height*0.4;
    [bgview1 addSubview:accessoryView];
    line = [self createLine:_labelTipLB.y+_labelTipLB.height+kLabelPadding*0.5];
    line.frame = CGRectMake(kTipRightMargin, line.y, kAppWidth-kTipRightMargin*2, line.height);
    [bgview1 addSubview:line];
    //
    _labelTipLB = [self createTipUILabel:line.y+line.height+0.5*kLabelPadding title:@"银行卡号:"];
    [bgview1 addSubview:_labelTipLB];
    
    _bankNumField = [[UITextField alloc]initWithFrame:CGRectMake(kTipLeftMargin+width+5, _labelTipLB.y, kAppWidth-kTipLeftMargin-width-kTipRightMargin-5, kLabelHeight)];
    _bankNumField.delegate = self;
    _bankNumField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入银行卡号" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:kCommonFontSize_15]}];
    _bankNumField.textAlignment = NSTextAlignmentRight;
    _bankNumField.keyboardType = UIKeyboardTypeNumberPad ;
    [bgview1 addSubview:_bankNumField];
    
    
    line = [self createLine:_labelTipLB.y+_labelTipLB.height+kLabelPadding*0.5];
    line.frame = CGRectMake(kTipRightMargin, line.y, kAppWidth-kTipRightMargin*2, 0.5);
    [bgview1 addSubview:line];
    //预留电话
    _labelTipLB = [self createTipUILabel:line.y+line.height+0.5*kLabelPadding title:@"预留电话:"];
    [bgview1 addSubview:_labelTipLB];
    _telephoneField= [[UITextField alloc]initWithFrame:CGRectMake(kTipLeftMargin+width+5, _labelTipLB.y, kAppWidth-kTipLeftMargin-width-kTipRightMargin-5, kLabelHeight)];
    _telephoneField.delegate = self;
    _telephoneField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入预留电话" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:kCommonFontSize_15]}];
    _telephoneField.textAlignment = NSTextAlignmentRight;
    _telephoneField.keyboardType= UIKeyboardTypePhonePad ;
    [bgview1 addSubview:_telephoneField];
    
    
    line = [self createLine:bgview1.height-1];
    [bgview1 addSubview:line];
    [self.view addSubview:bgview1];
    
    
    
    UIView *bgview2 = [[UIView alloc]initWithFrame:CGRectMake(0, bgview1.y+bgview1.height +kTopMargin, kAppWidth, kLabelHeight*2+kLabelPadding*2)];
    bgview2.backgroundColor = [UIColor whiteColor];
    line =[self createLine:0];
    [bgview2 addSubview:line];
    _labelTipLB = [self createTipUILabel:line.y+line.height+0.5*kLabelPadding title:@"开户省份："];
    [bgview2 addSubview:_labelTipLB];
    // _nameLB = [self createUILabel:_nameTipLB.y title:@"*晓"];
    
    
    _provinceField = [[UITextField alloc]initWithFrame:CGRectMake(kTipLeftMargin+width+5, _labelTipLB.y, kAppWidth-kTipLeftMargin-width-kTipRightMargin-5, kLabelHeight)];
    
    //按钮选择
    UIButton *provinceBtn =  [USUIViewTool createButtonWithRightImg:@"" imageName:@"account_cell_down_arrow_ico" width:_provinceField.width];
    provinceBtn.frame = _provinceField.frame ;
    [provinceBtn addTarget:self action:@selector(selectProvince:) forControlEvents:UIControlEventTouchUpInside] ;
    [bgview2 addSubview:provinceBtn];
    
    _provinceField.width = _provinceField.width - 15 ;
    _provinceField.delegate = self;
    _provinceField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请选择" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:kCommonFontSize_15]}];
    _provinceField.textAlignment = NSTextAlignmentRight;
    _provinceField.enabled = NO;
    //[_provinceField setBackgroundColor:[UIColor greenColor]] ;
    [bgview2 addSubview:_provinceField];
    
    
    
    
    line = [self createLine:_labelTipLB.y+_labelTipLB.height+kLabelPadding*0.5];
    line.frame = CGRectMake(kTipRightMargin, line.y, kAppWidth-kTipRightMargin*2, line.height);
    [bgview2 addSubview:line];
    //
    _labelTipLB = [self createTipUILabel:line.y+line.height+0.5*kLabelPadding title:@"所属地区:"];
    [bgview2 addSubview:_labelTipLB];
    _areaidField = [[UITextField alloc]initWithFrame:CGRectMake(kTipLeftMargin+width+5, _labelTipLB.y, kAppWidth-kTipLeftMargin-width-kTipRightMargin-5, kLabelHeight)];
    
    //按钮选择
    UIButton *areaBtn =  [USUIViewTool createButtonWithRightImg:@"" imageName:@"account_cell_down_arrow_ico" width:_areaidField.width];
    areaBtn.frame = _areaidField.frame ;
    [areaBtn addTarget:self action:@selector(selectArea:) forControlEvents:UIControlEventTouchUpInside] ;
    [bgview2 addSubview:areaBtn];
    
    _areaidField.width = _areaidField.width - 15 ;
    _areaidField.delegate = self;
    _areaidField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请选择" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:kCommonFontSize_15]}];
    _areaidField.enabled = NO;
    _areaidField.textAlignment = NSTextAlignmentRight;
    //[_areaidField setBackgroundColor:[UIColor greenColor]] ;
    
    [bgview2 addSubview:_areaidField];
    line = [self createLine:bgview2.height-1];
    [bgview2 addSubview:line];
    [self.view addSubview:bgview2];
    //
    
    
    //
    UIButton *bindBtton = [USUIViewTool createButtonWith:@"绑  定" imageName:@"login_bt_img"];
    bindBtton.frame = CGRectMake(10, bgview2.y+ bgview2.height+kTopMargin, kAppWidth-20, 35);
    [bindBtton addTarget:self action:@selector(bind) forControlEvents:UIControlEventTouchUpInside];
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
 选择省
 **/
-(void) selectProvince:(UIButton *)btn{
    [USWebTool POSTWIthTip:@"bindbankcardcilent/getBindProvinceList.action" showMsg:@"正在查询..." paramDic:nil success:^(NSDictionary * dic) {
        USCommonListController *controller = [[USCommonListController alloc]init] ;
        controller.dataList = dic[@"data"] ;
        controller.mytitle =@"选择省份";
        controller.ListCommonDelegate = self ;
        controller.type =@"0" ;
        [self.navigationController pushViewController:controller animated:YES];
        
    } failure:^(NSDictionary * dic) {
        
    }];
    
}

/**
 选择区域
 **/
-(void) selectArea:(UIButton *)btn{
    if ([_pro_code isEqualToString:@""]|| _pro_code == nil) {
        [MBProgressHUD showError:@"请先选择省份！"];
        return;
    }
    NSDictionary *params = @{@"city_code":_pro_code};
    [USWebTool POSTWIthTip:@"bindbankcardcilent/getBindAreaList.action" showMsg:@"正在查询..." paramDic:params success:^(NSDictionary * dic) {
        USCommonListController *controller = [[USCommonListController alloc]init] ;
        controller.dataList = dic[@"data"] ;
        controller.mytitle =@"选择地区";
        controller.ListCommonDelegate = self ;
        controller.type =@"1" ;
        [self.navigationController pushViewController:controller animated:YES];
        
    } failure:^(NSDictionary * dic) {
        
    }];
}


-(void)bind{
    if ([_bankArray count]==0) {
        [MBProgressHUD showError:@"请选择银行后填写卡号..."];
        return;
    }
    if (_bankNumField.text==nil||_bankNumField.text.length<16) {
        [MBProgressHUD showError:@"请填写合法银行卡号..."];
        return;
    }
    NSString *telephone=_telephoneField.text ;
    
    if ([telephone isEqualToString:@""] || nil == telephone) {
        [MBProgressHUD showError:@"请填写电话号码！"];
        return;
    }
    
    
    if ([_pro_code isEqualToString:@"" ]|| nil == _pro_code) {
        [MBProgressHUD showError:@"请选择开户省份！"];
        return;
    }
    
    if ([_area_code isEqualToString:@"" ]|| nil == _area_code) {
        [MBProgressHUD showError:@"请选择开户地区！"];
        return;
    }
    
    
    USHtmlLoadViewInsideController *controller = [[USHtmlLoadViewInsideController alloc]init ] ;
    controller.hidesBottomBarWhenPushed = YES ;
    NSMutableString *urlStr = [NSMutableString stringWithString:@"huiFuPayClientController/BindCardForm.action?"];
    [urlStr appendString:[NSString stringWithFormat:@"customer_id=%@&",_account.id]];
    [urlStr appendString:[NSString stringWithFormat:@"card_no=%@&",_bankNumField.text]];
    [urlStr appendString:[NSString stringWithFormat:@"bank_id=%@&",_bankArray[_currentIndex][@"code"]]];
    [urlStr appendString:[NSString stringWithFormat:@"card_mobile=%@&",telephone]];
    [urlStr appendString:[NSString stringWithFormat:@"card_prov=%@&",_pro_code]];
    [urlStr appendString:[NSString stringWithFormat:@"card_area=%@&",_area_code]];
    controller.htmlUrl = HYWebDataPath(urlStr) ;
    controller.htmlTitle = @"银行卡绑定" ;
    controller.loadMsg =@"正在加载......";
    controller.showMsg=true ;
    HYLog(@"htmlurl%@",HYWebDataPath(urlStr) ) ;
    [self.navigationController pushViewController:controller animated:YES] ;
    
    
}




-(void)dissView{
    [super.topView removeFromSuperview];
    [self updateRespons];
}
-(void)updateRespons{
    [_bankNumField resignFirstResponder];
    //[_nameField resignFirstResponder];
    //[_idCardField resignFirstResponder];
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

//共用list返回
-(void)listClickReturn:(NSDictionary *)data type:(NSString *)type{
    HYLog(@"listClickReturn:%@,type:%@",data,type) ;
    if ([type isEqualToString:@"0"]) {
        _pro_code = data[@"city_code"] ;
        _provinceField.text=data[@"city_name"] ;
        
        _area_code = @"" ;
        _areaidField.text = @"";
    }
    if ([type isEqualToString:@"1"]) {
        _area_code = data[@"area_code"] ;
        _areaidField.text = data[@"area_name"] ;
    }
}

@end
