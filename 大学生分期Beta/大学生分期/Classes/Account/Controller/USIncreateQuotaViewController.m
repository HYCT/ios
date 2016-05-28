//
//  USIncreateQuotaViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/8.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USIncreateQuotaViewController.h"
#import "USCanBorrowInfoView.h"
#import "USTextFieldTool.h"
#import "USBorrowAccountInfoView.h"
@interface USIncreateQuotaViewController ()
@property(strong,nonatomic) UILabel *currentQuota;
@property(strong,nonatomic) UITextField *quotaField;
@property(strong,nonatomic) UIButton *increamBt;
@property(strong,nonatomic) USAccount *account;
@property(strong,nonatomic) UIView *increaseView ;
@end

@implementation USIncreateQuotaViewController

- (void)viewDidLoad {
   
    [super viewDidLoad];
    self.title = @"信用额度";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent= NO;
    _account = [USUserService accountStatic];
    [self initView];
    //键盘事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardwasShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardwasHidden:) name:UIKeyboardDidHideNotification object:nil];
}


//键盘显示时候
-(void)keyboardwasShown:(NSNotification *) notify{
    CGRect frame = [self.view frame];
    if ([[notify name]isEqualToString:UIKeyboardDidShowNotification]) {
        [UIView animateWithDuration:0.3 animations:^{
            self.view.frame = frame;
        }completion:^(BOOL finished) {
            //
        }];
    }
    
    NSDictionary *info = [notify userInfo];
    NSValue *aValue = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    
    CGSize keyBoardSize = [aValue CGRectValue].size;
    
    CGRect rect = _increaseView.frame;
    rect.origin.y = self.view.frame.size.height - keyBoardSize.height -2*_increaseView.height+20;
    _increaseView.frame = rect;
    
}
//键盘消失
-(void) keyboardwasHidden:(NSNotification *) notify{
   
    CGRect rect = _increaseView.frame;
    rect.origin.y = self.view.frame.size.height - rect.size.height;
    _increaseView.frame = rect;
}
- (void)increamentQuota {
    HYLog(@"increamentQuota");
    [USWebTool POST:@"increaseMoneyClient/applyIncreaseMylimitMoney.action" showMsg:@"正在玩命申请额度..." paramDic:@{@"customer_id":_account.id} success:^(NSDictionary *data) {
        [MBProgressHUD showSuccess:@"申请额度成功，等待审核..."];
        [self.navigationController popToRootViewControllerAnimated:YES];
    } failure:^(id data){
        [MBProgressHUD showError:data[@"msg"]];
        //[MBProgressHUD showError:@"申请额度失败，请重新提交..."];
    }];
}
-(void)initView{
    USBorrowAccountInfoView *accountBrowView = [[USBorrowAccountInfoView alloc]initWithFrame:CGRectZero];
    
    accountBrowView.height = 90;
    accountBrowView.y = 30;
    accountBrowView.personImageView.size = CGSizeMake(60, 60);
    
    accountBrowView.personImageView.image = [UIImage imageNamed:@"account_incream_quto_image"];
    if (_account.headerImg!=nil) {
        accountBrowView.personImageView.image = _account.headerImg;
    }
    accountBrowView.personImageView.x = 0;
    //[accountBrowView setBackgroundColor:[UIColor redColor]];
    [accountBrowView.bgImgeView removeFromSuperview];
    [accountBrowView.accountNameLabel setText:_account.name];
    [accountBrowView.accountNameLabel setTextColor:[UIColor blackColor]];
    [accountBrowView updateFrame];
    accountBrowView.accountNameLabel.size = CGSizeMake(accountBrowView.accountNameLabel.width, kCommonFontSize_16);
    [accountBrowView.accountNameLabel setFont:[UIFont boldSystemFontOfSize:kCommonFontSize_16]];
    accountBrowView.personImageView.x = 10;
    accountBrowView.accountNameLabel.y = accountBrowView.personBgView.y+10;
    accountBrowView.accountNameLabel.x += accountBrowView.personImageView.x+accountBrowView.personImageView.width+10;
    accountBrowView.accountNameLabel.textAlignment = NSTextAlignmentLeft;
    UILabel *currentQuota = [USUIViewTool createUILabelWithTitle:@"当前额度为:" fontSize:kCommonFontSize_16 color:HYCTColor(168, 168, 168) heigth:kCommonFontSize_20];
    currentQuota.frame = accountBrowView.accountNameLabel.frame;
    currentQuota.y+= accountBrowView.accountNameLabel.height+10;
    currentQuota.x = accountBrowView.personImageView.x+accountBrowView.personImageView.width+10;
    [accountBrowView.personBgView addSubview:currentQuota];
    currentQuota.width = 85;
    _currentQuota =  [USUIViewTool createUILabelWithTitle:[NSString stringWithFormat:@"%.2f",_account.limitmoney] fontSize:kCommonFontSize_16 color:[UIColor orangeColor] heigth:kCommonFontSize_20];
    [_currentQuota setFont:[UIFont boldSystemFontOfSize:kCommonFontSize_16]];
    _currentQuota.frame = currentQuota.frame;
    _currentQuota.x = currentQuota.x+currentQuota.width;
    _currentQuota.width = kAppWidth - currentQuota.x-currentQuota.width;
    [accountBrowView.personBgView addSubview:_currentQuota];
    [self.view addSubview:accountBrowView];
    //
    UIView *tipBack = [[UIView alloc]initWithFrame:CGRectMake(10, accountBrowView.height+accountBrowView.y+5, kAppWidth-20, 120)];
    tipBack.layer.cornerRadius = 10;
    tipBack.layer.masksToBounds = YES;
    [tipBack setBackgroundColor:HYCTColor(226, 226, 226)];
    //
    UITextView  *tipText = [[UITextView alloc]initWithFrame:tipBack.bounds];
    tipText.width -=30;
    tipText.x = 15;
    tipText.text = @"提额说明:\n用户行为达到提额条件后,由用户申请调整,由汪卡平台审批后更新合同;\n用户逾期行为过多，由汪卡平台降低其额度,并通知用户。";
    tipText.backgroundColor = HYCTColor(226, 226, 226);
    [tipText setTextColor:HYCTColor(146, 146, 146)];
    [tipText setFont:[UIFont systemFontOfSize:kCommonFontSize_15]];
    tipText.editable = NO;
    [tipBack addSubview:tipText];
    [self.view addSubview:tipBack];
    
    CGFloat increaseHeight=60 ;
    _increaseView = [[UIView alloc]initWithFrame:CGRectMake(0, kAppHeight-2*increaseHeight+20 , kAppWidth, increaseHeight)];
    [_increaseView setBackgroundColor:[UIColor whiteColor]] ;
    [self.view addSubview:_increaseView] ;
    //
    UIButton *increamBt = [USUIViewTool createButtonWith:@"提交申请" imageName:@"account_reback_bt_ico"];
    [increamBt addTarget:self action:@selector(increamentQuota) forControlEvents:UIControlEventTouchUpInside];
    increamBt.height = increaseHeight;
    [increamBt.titleLabel setFont:[UIFont systemFontOfSize:kCommonFontSize_20]];
    increamBt.width = 90;
    increamBt.y = 0 ;
    increamBt.x = kAppWidth - increamBt.width;
    _increamBt = increamBt;
    _increamBt.enabled = NO;
    [_increaseView addSubview:increamBt];
    //
    UITextField *quotaField = [[UITextField alloc]init];
    quotaField.backgroundColor = [UIColor whiteColor];
    quotaField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    quotaField.leftViewMode = UITextFieldViewModeAlways;
    quotaField.placeholder = @" 输入申请额度";
    quotaField.keyboardType = UIKeyboardTypeDecimalPad;
    quotaField.frame =  CGRectMake(0, increamBt.y, kAppWidth-increamBt.width, increamBt.height);
    [_increaseView addSubview:quotaField];
    _quotaField = quotaField;
    _quotaField.delegate = self;
}
-(void)dissView{
    //[self updateRespons];
    _increamBt.enabled = [self isCanCommite];
}
-(void)updateRespons{
    //[_quotaField resignFirstResponder];
}
-(BOOL)isCanCommite{
    if(_quotaField.text.length>0){
        return [_quotaField.text floatValue]>0;
    }
    return NO;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [NSThread detachNewThreadSelector:@selector(check) toTarget:self withObject:nil];
}
-(void)check{
    dispatch_async(dispatch_get_main_queue(), ^{
        _account = [USUserService accountStatic];
        if (_account.realnametype == -1) {
            [MBProgressHUD showError:@"你未进行实名认证！"];
            [self.navigationController popViewControllerAnimated:YES];
        }else if (_account.realnametype != 3){
            [MBProgressHUD showError:@"你的实名认证还未审核完毕!"];
            [self.navigationController popViewControllerAnimated:YES];
        }else if (!_account.isbindbankcard){
            [MBProgressHUD showError:@"未绑定银行卡!"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    });
    
}
@end
