//
//  USCertificationViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/9.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USCertificationViewController.h"
#import "USTextFieldTool.h"
#import "USButton.h"
#import "USPickerDataViewController.h"
#import "USCertificationService.h"
#import "MBProgressHUD+MJ.h"
#import "USUserService.h"
#define kTextMargin 10

@interface USCertificationViewController ()
@property(nonatomic,strong) UITextField *userNameTF;
@property(nonatomic,strong) UITextField *idCardTF;
@property(nonatomic,strong) UITextField *classTF;
@property(nonatomic,strong) UITextField *inTimeTF;
@property(nonatomic,strong) UITextField *schoolRuleTF;
@property(nonatomic,strong) UITextField *professionTF;
@property(nonatomic,strong) UITextField *studentIdTF;
@property(nonatomic,strong) UITextField *adDetailTF;
@property(nonatomic,strong) UITextField *contactManTF;
@property(nonatomic,strong) UITextField *edtParentTel;
@property(nonatomic,strong) NSDictionary *tempParamDic;
@property(nonatomic,strong)NSMutableDictionary *paramDic;
@property(nonatomic,strong)NSMutableDictionary *certificationInfo;
@property(nonatomic,assign)BOOL canSelect;
@property(nonatomic,strong)USAccount *account;
@property(nonatomic,strong)UIScrollView *bgScorollView;
@property(nonatomic,strong)NSString *idcardPicpath;
@property(nonatomic,strong)NSString *idcardPicpath_reverse;
@property(nonatomic,strong)NSString *studentcardPicpath;
@end

@implementation USCertificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _account = [USUserService accountStatic];
    self.title = @"实名认证";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent= NO;
    _paramDic = [NSMutableDictionary dictionary];
    _userNameTF = [USTextFieldTool createTextFieldWithPlaceholder:@"输入你的真实姓名" target:self leftImage:@"account_certi_name_left_img" imageFrame:CGRectMake(12, 5, 20, 20)];
    _userNameTF.y = 15;
    [self.view addSubview:_userNameTF];
    //
    _idCardTF = [USTextFieldTool createTextFieldWithPlaceholder:@"输入身份证号" target:self leftImage:@"account_certi_cardid_left_img" imageFrame:CGRectMake(12, 5, 20, 20)];
    //_idCardTF.text = @"370802940221002";
    _idCardTF.text = @"";
    _idCardTF.y=_userNameTF.y+_userNameTF.height+kTextMargin;
    [self.view addSubview:_idCardTF];
    //
    _classTF = [USTextFieldTool createTextFieldWithPlaceholder:@"学校" target:self leftImage:@"account_certi_class_left_img" imageFrame:CGRectMake(12, 8, 20, 20)];
    _classTF.y=_idCardTF.y+_idCardTF.height+kTextMargin;
    _classTF.enabled = NO;
    [self.view addSubview:_classTF];
    ///////////
    [self createButtonWithUITextField:_classTF tableTitle:@"请选择学校" dataRalateUrl:@"schoolclient/schoolList.action" msg:@"正在玩命加载学校..." paramsDic:nil makeParamDic:nil makeViewBlock:nil];
    //////
    //
    _inTimeTF =  [USTextFieldTool createTextFieldWithPlaceholder:@"入学时间" target:self leftImage:@"account_certi_intime_left_img" imageFrame:CGRectMake(12, 8, 20, 20)];
    _inTimeTF.y=_classTF.y+_classTF.height+kTextMargin;
    _inTimeTF.enabled = NO;
    [self.view addSubview:_inTimeTF];
    ///////////
    [self createButtonWithUITextField:_inTimeTF tableTitle:@"请选择入学时间" dataRalateUrl:nil makeParamDic:nil makeViewBlock:^(UIViewController *vc) {
        // USPickerDataViewController *pickVC = vc;
        UIDatePicker *datePicker = [self createUIDatePicker];
        USPickerDataViewController *pickVC = (USPickerDataViewController *)vc;
        pickVC.datePicker = datePicker;
        [pickVC.tableView removeFromSuperview];
        [pickVC.view addSubview:datePicker];
        [datePicker addTarget:pickVC action:@selector(datePick:) forControlEvents:UIControlEventValueChanged ];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(15, datePicker.y+datePicker.height+15, kAppWidth-30, 30);
        button.backgroundColor = [UIColor orangeColor];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:kCommonFontSize_15];
        [button setTitle:@"确定" forState:UIControlStateNormal];
        [button setTitle:@"确定" forState:UIControlStateHighlighted];
        [button addTarget:pickVC action:@selector(datePickButtonClick) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.textColor = [UIColor whiteColor];
        button.layer.cornerRadius = button.height*0.5;
        button.layer.masksToBounds = YES;
        [pickVC.view addSubview:button];
    }];
    //////
    //
    _schoolRuleTF = [USTextFieldTool createTextFieldWithPlaceholder:@"学制" target:self leftImage:@"account_certi_rule_left_img" imageFrame:CGRectMake(12, 5, 20, 20)];
    _schoolRuleTF.y=_inTimeTF.y+_inTimeTF.height+kTextMargin;
    [self.view addSubview:_schoolRuleTF];
    _schoolRuleTF.enabled = NO;
    ///////////
    [self createButtonWithUITextField:_schoolRuleTF tableTitle:@"请选择学制" dataRalateUrl:nil makeParamDic:nil makeViewBlock:^(UIViewController *vc) {
        
        USPickerDataViewController *pickVC = (USPickerDataViewController *)vc;
        pickVC.dataList = [NSMutableArray array];
        [pickVC.dataList addObject:[USTempData dataWithId:nil name:@"三年"]];
        [pickVC.dataList addObject:[USTempData dataWithId:nil name:@"四年"]];
        [pickVC.dataList addObject:[USTempData dataWithId:nil name:@"五年"]];
        
    }];
    //////
    //
    _professionTF = [USTextFieldTool createTextFieldWithPlaceholder:@"专业" target:self leftImage:@"account_certi_profession_left_img" imageFrame:CGRectMake(12, 5, 20, 20)];
    _professionTF.y=_schoolRuleTF.y+_schoolRuleTF.height+kTextMargin;
    [self.view addSubview:_professionTF];
    //
    _studentIdTF = [USTextFieldTool createTextFieldWithPlaceholder:@"学号" target:self leftImage:@"account_certi_cardid_left_img" imageFrame:CGRectMake(12, 5, 20, 20)];
    _studentIdTF.y=_professionTF.y+_professionTF.height+kTextMargin;
    [self.view addSubview:_studentIdTF];
    //
    _adDetailTF = [USTextFieldTool createTextFieldWithPlaceholder:@"宿舍" target:self leftImage:@"account_certi_adress_left_img"];
    _adDetailTF.y=_studentIdTF.y+_studentIdTF.height+kTextMargin;
    [self.view addSubview:_adDetailTF];
    //尽调员
    _contactManTF = [USTextFieldTool createTextFieldWithPlaceholder:@"尽调员" target:self leftImage:@"account_certi_catman_left_img" imageFrame:CGRectMake(12, 5, 20, 20)];
    _contactManTF.y=_adDetailTF.y+_adDetailTF.height+kTextMargin;
    _contactManTF.enabled = NO;
    [self.view addSubview:_contactManTF];
    ///////////
    [self createButtonWithUITextField:_contactManTF tableTitle:@"请选择尽调员" dataRalateUrl:@"userclient/getUserListBySchoolCode.action" msg:@"正在玩命加载尽调员..." paramsDic:[NSMutableDictionary dictionary] makeParamDic:^(NSMutableDictionary *paramDic){
        if (_tempParamDic!=nil&&_tempParamDic[@"schoolcode"]!=nil) {
            _canSelect = YES;
            if (paramDic==nil) {
                paramDic = [NSMutableDictionary dictionary];
            }
            [paramDic setObject:_tempParamDic[@"schoolcode"] forKey:@"schoolcode"];
        }else{
            _canSelect = NO;
            [MBProgressHUD showError:@"请先选择学校!"];
        }
        
    } makeViewBlock:nil];
    
    //选择身份证
    UITextField *commenttex =[USTextFieldTool createTextFieldWithPlaceholder:@"选择身份证（正）" target:self leftImage:@"account_certi_catman_left_img" imageFrame:CGRectMake(12, 5, 20, 20)];
    commenttex.y=_contactManTF.y+_contactManTF.height+kTextMargin;
    commenttex.enabled = NO;
    commenttex.text = @"选择身份证（正）" ;
    [self.view addSubview:commenttex];
    UIButton *btn =[self createButtonWithUITextFieldReturn:commenttex tableTitle:@"" dataRalateUrl:nil msg:nil paramsDic:nil makeParamDic:nil makeViewBlock:nil tag:0] ;
    //设置tag
    btn.tag =0 ;
    [btn addTarget:self action:@selector(uploadImage:) forControlEvents:UIControlEventTouchUpInside] ;
    
    
    //选择身份证(反)
    UITextField  *commenttex1 =[USTextFieldTool createTextFieldWithPlaceholder:@"选择身份证（反）" target:self leftImage:@"account_certi_catman_left_img" imageFrame:CGRectMake(12, 5, 20, 20)];
    commenttex1.y=commenttex.y+commenttex.height+kTextMargin;
    commenttex1.enabled = NO;
    commenttex1.text = @"选择身份证（反）" ;
    [self.view addSubview:commenttex1];
    UIButton *btn1 =[self createButtonWithUITextFieldReturn:commenttex1 tableTitle:@"" dataRalateUrl:nil msg:nil paramsDic:nil makeParamDic:nil makeViewBlock:nil tag:1] ;
    //设置tag
    btn1.tag =1 ;
    [btn1 addTarget:self action:@selector(uploadImage:) forControlEvents:UIControlEventTouchUpInside] ;
    
    
    //选择学生证
    UITextField *commenttex2 =[USTextFieldTool createTextFieldWithPlaceholder:@"选择学生证" target:self leftImage:@"account_certi_catman_left_img" imageFrame:CGRectMake(12, 5, 20, 20)];
    commenttex2.y=commenttex1.y+commenttex1.height+kTextMargin;
    commenttex2.enabled = NO;
    commenttex2.text = @"选择学生证" ;
    [self.view addSubview:commenttex2];
    UIButton *btn2 =[self createButtonWithUITextFieldReturn:commenttex2 tableTitle:@"" dataRalateUrl:nil msg:nil paramsDic:nil makeParamDic:nil makeViewBlock:nil tag:2] ;
    //设置tag
    btn2.tag =2 ;
    [btn2 addTarget:self action:@selector(uploadImage:) forControlEvents:UIControlEventTouchUpInside] ;
    //父母电话
    _edtParentTel = [USTextFieldTool createTextFieldWithPlaceholder:@"父母电话" target:self leftImage:@"account_certi_name_left_img" imageFrame:CGRectMake(12, 5, 20, 20)];
    _edtParentTel.y = commenttex2.y+commenttex2.height+kTextMargin;
    [self.view addSubview:_edtParentTel];
    
    //////
    //login_bt_img
    // super.commonButton = [USUIViewTool createButtonWith:@"确定" imageName:@"account_certi_commit_bt_img"];
    super.commonButton = [USUIViewTool createButtonWith:@"确定" imageName:@"login_bt_img"];
    super.commonButton.y = _edtParentTel.y+_edtParentTel.height+kTextMargin+kTextMargin;
    super.commonButton.x = 10;
    super.commonButton.width = kAppWidth -super.commonButton.x*2;
    super.commonButton.height = 35;
    super.commonButton.layer.cornerRadius = super.commonButton.height*0.5;
    super.commonButton.layer.masksToBounds = YES;
    [super.commonButton.titleLabel setFont:[UIFont systemFontOfSize:kCommonButtonTitleSize]];
    [super.commonButton addTarget:self action:@selector(commit:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: super.commonButton];
    UIScrollView *bgScorollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    bgScorollView.showsHorizontalScrollIndicator = NO;
    bgScorollView.backgroundColor = [UIColor clearColor];
    bgScorollView.bounces = NO;
    bgScorollView.scrollsToTop = NO;
    _bgScorollView = bgScorollView;
    CGFloat height = super.commonButton.y+super.commonButton.height;
    bgScorollView.contentSize = CGSizeMake(kAppWidth, height+80);
    NSArray *childViews = self.view.subviews;
    for (UIView *subView in childViews) {
        [subView removeFromSuperview];
        [bgScorollView addSubview:subView];
    }
    [self.view addSubview:bgScorollView];
    if (_account!=nil) {
        [self loadData];
    }
}
-(void)loadData{
    [USWebTool POST:@"realnameclient/getRealNameObjData.action" showMsg:@"正在加载......" paramDic:@{@"customer_id":_account.id} success:^(NSDictionary *dataDic) {
        dataDic = dataDic[@"data"];
        _userNameTF.text = dataDic[@"name"];
        _idCardTF.text = dataDic[@"idcard"];
        _classTF.text = dataDic[@"schoolname"];
        _inTimeTF.text = dataDic[@"studytime"];
        _schoolRuleTF.text = dataDic[@"xuezhi"];
        _professionTF.text = dataDic[@"zhuanye"];
        _studentIdTF.text = dataDic[@"xuehao"];
        _adDetailTF.text = dataDic[@"sushe"];
        _contactManTF.text = dataDic[@"jdy_name"];
        _edtParentTel.text =dataDic[@"parent_telephone"] ;
        
        
        [_paramDic setObject:dataDic[@"xuezhi"] forKey:@"xuezhi"];
        
        [_paramDic setObject:dataDic[@"studytime"] forKey:@"studytime"];
        
        [_paramDic setObject:dataDic[@"schoolname"] forKey:@"schoolname"];
        [_paramDic setObject:dataDic[@"schoolcode"] forKey:@"schoolcode"];
        
        [_paramDic setObject:dataDic[@"jdy_name"] forKey:@"jdy_name"];
        [_paramDic setObject:dataDic[@"jdy_id"] forKey:@"jdy_id"];
        
        
    } failure:nil];
}

-(void)validate{
    Validator *validator = [[Validator alloc] init];
    validator.delegate   = self;
    [validator putRule:[Rules checkRange:NSMakeRange(2, 20) withFailureString:@"请输入姓名!" forTextField:_userNameTF]];
    [validator putRule:[Rules checkIfIDCardNumberWithFailureString:@"请输入15位或18位身份证号码!" forTextField:_idCardTF]];
    [validator putRule:[Rules checkRange:NSMakeRange(1, 30) withFailureString:@"你没有选择学校!" forTextField:_classTF]];
    [validator putRule:[Rules checkRange:NSMakeRange(1, 30) withFailureString:@"你没有选择入学时间!" forTextField:_inTimeTF]];
    [validator putRule:[Rules checkRange:NSMakeRange(1, 30) withFailureString:@"你没有选择学制!" forTextField:_schoolRuleTF]];
    [validator putRule:[Rules checkRange:NSMakeRange(2, 40) withFailureString:@"请输入专业名称!" forTextField:_professionTF]];
    [validator putRule:[Rules checkRange:NSMakeRange(3, 30) withFailureString:@"请输入学号(至少4个字符)!" forTextField:_studentIdTF]];
    [validator putRule:[Rules checkRange:NSMakeRange(3, 252) withFailureString:@"请输入宿舍地址(至少4个字符)!" forTextField:_adDetailTF]];
    [validator putRule:[Rules checkRange:NSMakeRange(1, 20) withFailureString:@"请选择尽调员!" forTextField:_contactManTF]];
    
    [validator putRule:[Rules checkRange:NSMakeRange(2, 100) withFailureString:@"请填写父母电话!" forTextField:_edtParentTel]];
    [validator validate];
}
-(UIDatePicker *)createUIDatePicker{
    UIDatePicker *datePicker = [ [ UIDatePicker alloc] init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中
    datePicker.locale = locale;
    datePicker.datePickerMode = UIDatePickerModeDate;
    NSDate* minDate = [[NSDate alloc]initWithTimeIntervalSince1970:0];
    NSDate* maxDate = [[NSDate alloc]init];
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSCalendarUnitYear|NSCalendarUnitDay;
    
    NSDateComponents *d = [cal components:unitFlags fromDate:maxDate];//把要从date中获取的unitFlags标示的日期元素存放在NSDateComponents类型的d里面；
    //然后就可以从d中获取具体的年月日了；
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSInteger year = [d year];
    NSString *dateStr = [NSString stringWithFormat:@"%li-12-31",(long)year];
    maxDate = [dateFormat dateFromString:dateStr];
    datePicker.minimumDate = minDate;
    datePicker.maximumDate = maxDate;
    return datePicker;
}

- (UIImageView *)createLogoView {
    
    return nil;
}
/**
 *  @property(nonatomic,copy)MakeViewBlock makeViewBlock;
 *
 *  @param textField     <#textField description#>
 *  @param tableTitle    <#tableTitle description#>
 *  @param dataRalateUrl <#dataRalateUrl description#>
 *  @param makeParamDic  <#makeParamDic description#>
 */
-(void)createButtonWithUITextField:(UITextField *)textField tableTitle:(NSString *)tableTitle dataRalateUrl:(NSString *)dataRalateUrl makeParamDic:(MakeParamDic)makeParamDic makeViewBlock:(MakeViewBlock) makeViewBlock{
    [self createButtonWithUITextField:textField tableTitle:tableTitle dataRalateUrl:dataRalateUrl msg:nil paramsDic:nil makeParamDic:makeParamDic makeViewBlock:makeViewBlock];
}


/**
 *
 *
 *  @param textField     <#textField description#>
 *  @param tableTitle    <#tableTitle description#>
 *  @param dataRalateUrl <#dataRalateUrl description#>
 *  @param msg           在数据加载的时候显示的提示信息
 *  @param makeParamDic  <#makeParamDic description#>
 *  @param makeViewBlock <#makeViewBlock description#>
 */
-(void)createButtonWithUITextField:(UITextField *)textField tableTitle:(NSString *)tableTitle dataRalateUrl:(NSString *)dataRalateUrl msg:(NSString *)msg paramsDic:(NSMutableDictionary *)paramsDic makeParamDic:(MakeParamDic)makeParamDic makeViewBlock:(MakeViewBlock) makeViewBlock{
    textField.enabled = NO;
    USButton *selectDataBt = [USButton buttonWithType:UIButtonTypeCustom];
    selectDataBt.frame = textField.frame;
    selectDataBt.toModifyTextField = textField;
    selectDataBt.width = 35;
    selectDataBt.msg = msg;
    selectDataBt.paramsDic = paramsDic;
    selectDataBt.dataUrl = dataRalateUrl;
    selectDataBt.y -= 2;
    selectDataBt.makeViewBlock = makeViewBlock;
    selectDataBt.tableTitle = tableTitle;
    selectDataBt.makeParamDic = makeParamDic;
    selectDataBt.height = selectDataBt.height;
    selectDataBt.x = kAppWidth-selectDataBt.width-textField.x*2;
    selectDataBt.titleLabel.font = [UIFont systemFontOfSize:kCommonFontSize*2];
    selectDataBt.titleLabel.textAlignment = NSTextAlignmentCenter;
    [selectDataBt setTitle:@">" forState:UIControlStateNormal];
    [selectDataBt setTitle:@">" forState:UIControlStateHighlighted];
    [selectDataBt setTitleColor:HYCTColor(155, 155, 155) forState:UIControlStateNormal];
    [selectDataBt setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    [selectDataBt addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectDataBt];
}

/**
 返回button不带事件
 **/
-(UIButton *)createButtonWithUITextFieldReturn:(UITextField *)textField tableTitle:(NSString *)tableTitle dataRalateUrl:(NSString *)dataRalateUrl msg:(NSString *)msg paramsDic:(NSMutableDictionary *)paramsDic makeParamDic:(MakeParamDic)makeParamDic makeViewBlock:(MakeViewBlock) makeViewBlock tag:(int )tag{
    textField.enabled = NO;
    USButton *selectDataBt = [USButton buttonWithType:UIButtonTypeCustom];
    selectDataBt.frame = textField.frame;
    selectDataBt.toModifyTextField = textField;
    selectDataBt.width = 35;
    selectDataBt.msg = msg;
    selectDataBt.tag = tag ;
    selectDataBt.paramsDic = paramsDic;
    selectDataBt.dataUrl = dataRalateUrl;
    selectDataBt.y -= 2;
    selectDataBt.makeViewBlock = makeViewBlock;
    selectDataBt.tableTitle = tableTitle;
    selectDataBt.makeParamDic = makeParamDic;
    selectDataBt.height = selectDataBt.height;
    selectDataBt.x = kAppWidth-selectDataBt.width-textField.x*2;
    selectDataBt.titleLabel.font = [UIFont systemFontOfSize:kCommonFontSize*2];
    selectDataBt.titleLabel.textAlignment = NSTextAlignmentRight;
    [selectDataBt setTitle:@">" forState:UIControlStateNormal];
    [selectDataBt setTitle:@">" forState:UIControlStateHighlighted];
    [selectDataBt setTitleColor:HYCTColor(155, 155, 155) forState:UIControlStateNormal];
    [selectDataBt setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    //[selectDataBt addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectDataBt];
    return selectDataBt ;
}


/**
 提交
 **/
-(void)commit:(USButton *)button{
    
    
    NSInteger realnametype = _account.realnametype;
    if (3== realnametype) {
        [MBProgressHUD showError:@"认证已通过审核，不能修改！"] ;
        return ;
    }
    
    [self validate];
    if ([super commitFlag]) {
        _paramDic[@"name"] =_userNameTF.text;
        _paramDic[@"idcard"] =_idCardTF.text;
        _paramDic[@"zhuanye"] =_professionTF.text;
        _paramDic[@"xuehao"] =_studentIdTF.text;
        _paramDic[@"sushe"] =_adDetailTF.text;
        _paramDic[@"customerid"] =_account.id;
        _paramDic[@"idcardPicpath"] = _idcardPicpath ;
        _paramDic[@"idcardPicpath_reverse"] = _idcardPicpath_reverse ;
        _paramDic[@"studentcardPicpath"] = _studentcardPicpath ;
        _paramDic[@"parent_tel"] = _edtParentTel.text ;
        
        
        [USWebTool POST:@"realnameclient/applyrealname.action" showMsg:@"正在进行实名认证..." paramDic:_paramDic success:^(NSDictionary *dic) {
            [USUserService saveAccount:[USAccount accountWithDic:dic[@"data"]]];
            [self.navigationController popViewControllerAnimated:YES];
            NSString *msg = dic[@"msg"] ;
            [MBProgressHUD showSuccess:msg] ;
            
        } failure:^(NSDictionary *dic) {
            NSString *msg = dic[@"msg"] ;
            [MBProgressHUD showError:msg] ;
            // [MBProgressHUD showMessage:msg];
        }];
    }
}
-(void)didClickButton:(USButton *)button{
    _canSelect = YES;
    [super removeToolTipView];
    if (button.makeParamDic!=nil) {
        button.makeParamDic(button.paramsDic);
    }
    if (!_canSelect) {
        return;
    }
    USPickerDataViewController *pickDataVC = [[USPickerDataViewController alloc]init];
    pickDataVC.title = button.tableTitle;
    pickDataVC.paramDic = button.paramsDic;
    pickDataVC.url = button.dataUrl;
    if (button.makeViewBlock == nil) {
        __block USPickerDataViewController *blockPickerVC = pickDataVC;
        pickDataVC.fetchDataBlock = ^(NSDictionary *paramDic,NSString *url){
            if (button.paramsDic!=nil) {
                [button.paramsDic setValuesForKeysWithDictionary:paramDic];
            }else{
                if (paramDic!=nil) {
                    button.paramsDic = [NSMutableDictionary dictionary];
                    [button.paramsDic setValuesForKeysWithDictionary:paramDic];
                }
                
            }
            [USWebTool POST:url showMsg:button.msg paramDic:button.paramsDic success:^(NSDictionary *responseObject) {
                NSArray *datas = responseObject[@"data"];
                blockPickerVC.dataList = [NSMutableArray arrayWithCapacity:[datas count]];
                for (NSDictionary *data in datas) {
                    USTempData *tempData = [[USTempData alloc]init];
                    tempData.name = data[@"name"];
                    if (data[@"code"]!=nil||([data[@"code"] length] > 0)) {
                        tempData.id = data[@"code"];
                    }else{
                        tempData.id = data[@"id"];
                    }
                    [blockPickerVC.dataList addObject:tempData];
                }
                
                [blockPickerVC.tableView reloadData];
            }];
        };
    }else{
        pickDataVC.makeViewBlock = button.makeViewBlock;
    }
    
    pickDataVC.didSelectDataBlock = ^(USTempData *tempData){
        button.toModifyTextField.text = tempData.name;
        if (button.toModifyTextField==_classTF) {
            _contactManTF.text = nil;
            [_paramDic setObject:tempData.id forKey:@"schoolcode"];
            [_paramDic setObject:tempData.name forKey:@"schoolname"];
            _tempParamDic = @{@"schoolcode":tempData.id};
            return ;
        }
        if (button.toModifyTextField==_inTimeTF) {
            [_paramDic setObject:tempData.name forKey:@"studytime"];
            return ;
        }
        if (button.toModifyTextField==_schoolRuleTF) {
            [_paramDic setObject:tempData.name forKey:@"xuezhi"];
            return ;
        }
        if (button.toModifyTextField==_contactManTF) {
            [_paramDic setObject:tempData.name forKey:@"jdy_name"];
            [_paramDic setObject:tempData.id forKey:@"jdy_id"];
            return ;
        }
    };
    [self.navigationController pushViewController:pickDataVC animated:YES];
}
-(void)updateRespons{
    [_userNameTF resignFirstResponder];
    [_idCardTF resignFirstResponder];
    [_classTF resignFirstResponder];
    [_schoolRuleTF resignFirstResponder];
    [_professionTF resignFirstResponder];
    [_adDetailTF resignFirstResponder];
    [_contactManTF resignFirstResponder];
    [_studentIdTF resignFirstResponder];
}
-(BOOL)isCanCommite{
    return  true;
}



//上传图片
-(void)uploadImage:(UIButton *)btn{
    
    __block long tag = btn.tag ;
    _upLoadImageService= [[USUpLoadImageServiceTool alloc]init];
    _upLoadImageService.tipTitle = @"请选择背景图片来源";
    _upLoadImageService.saveImageBlock = ^(UIImage *image){
        
        [USWebTool POST:@"FilesClientController/uploadSingleFiles.action" showMsg:@"正在上传..." paramDiC:nil fileParamDic:@{@"uploadimgFilephoto":UIImagePNGRepresentation(image)} success:^(NSDictionary *dic) {
            [MBProgressHUD showSuccess:dic[@"msg"]];
            NSDictionary *data =dic[@"data"] ;
            HYLog(@"tag:%lu",tag) ;
            switch (tag) {
                case 0:
                    _idcardPicpath =data[@"savepath"];
                    
                    break;
                case 1:
                    _idcardPicpath_reverse =data[@"savepath"];
                    
                    break;
                case 2:
                    _studentcardPicpath =data[@"savepath"];
                    
                    break;
                    
                default:
                    break;
            }
            
        } failure:^(id data) {
            [MBProgressHUD showError:@"上传出错!"];
        }];
    };
    
    
    [_upLoadImageService pickImage];
}

//上传图片
-(void)upIdcardloadImageFan:(UIButton *)btn{
    
    _upLoadImageService= [[USUpLoadImageServiceTool alloc]init];
    _upLoadImageService.tipTitle = @"请选择背景图片来源";
    _upLoadImageService.saveImageBlock = ^(UIImage *image){
        
        [USWebTool POST:@"FilesClientController/uploadSingleFiles.action" showMsg:@"正在上传..." paramDiC:nil fileParamDic:@{@"uploadimgFilephoto":UIImagePNGRepresentation(image)} success:^(NSDictionary *dic) {
            [MBProgressHUD showSuccess:dic[@"msg"]];
            NSDictionary *data =dic[@"data"] ;
            _idcardPicpath_reverse =data[@"savepath"];
            
        } failure:^(id data) {
            [MBProgressHUD showError:@"上传出错!"];
        }];
    };
    
    
    [_upLoadImageService pickImage];
}

//上传图片
-(void)uploadStudentslImage:(UIButton *)btn{
    
    //if (_upLoadImageService==nil) {
    _upLoadImageService= [[USUpLoadImageServiceTool alloc]init];
    _upLoadImageService.tipTitle = @"请选择图片来源";
    _upLoadImageService.saveImageBlock = ^(UIImage *image){
        
        [USWebTool POST:@"FilesClientController/uploadSingleFiles.action" showMsg:@"正在上传..." paramDiC:nil fileParamDic:@{@"uploadimgFilephoto":UIImagePNGRepresentation(image)} success:^(NSDictionary *dic) {
            [MBProgressHUD showSuccess:dic[@"msg"]];
            NSDictionary *data =dic[@"data"] ;
            _studentcardPicpath =data[@"savepath"];
            
        } failure:^(id data) {
            [MBProgressHUD showError:@"上传出错!"];
        }];
    };
    //}
    
    [_upLoadImageService pickImage];
}


@end
