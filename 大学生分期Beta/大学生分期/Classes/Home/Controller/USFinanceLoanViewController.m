//
//  USLoanViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/3.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USFinanceLoanViewController.h"
#import "USBindBankCardViewController.h"
#import "USBorrowAccountInfoView.h"
#import "USIncreateQuotaViewController.h"
#import "USMyLoadRebackListViewController.h"
#import "USTryCacluteRebackPlanViewController.h"
#import "USUserService.h"
#import "USHtmlLoadViewController.h"
#import "USLoadAgreementViewController.h"
#define kMargin 10
#define kLabelHeight 15
#define kBase 100
#define BOOKMARK_WORD_LIMIT 2
@interface USFinanceLoanViewController()
@property(nonatomic,strong)UILabel *loanUILabel;
@property(nonatomic,strong)UILabel *loanTotalUILabel;
@property(nonatomic,strong)UILabel *perMonthTipUILabel;
@property(nonatomic,strong)UILabel *perMonthUILabel;
@property(nonatomic,strong)UIView *loanView ;
@property(nonatomic,strong)UISlider *slider ;
@property(nonatomic,assign)CGFloat  maxLoanValue;
@property(nonatomic,assign)CGFloat  currentLoanValue;
@property(nonatomic,assign)NSInteger  currentMonthCount;
@property(nonatomic,strong)NSArray *sliderValues ;
@property(nonatomic,strong) USCanBorrowInfoView *canAccountView;
@property(nonatomic,strong) NSArray *dateButtons;
@property(nonatomic,strong) USAccount *account;
@property(nonatomic,strong)UIButton *loanButton;
@property(nonatomic,strong)UIButton *trayCaculateButton;
@property(nonatomic,strong)UIGestureRecognizer *gesture;
@property(nonatomic,strong)UITextView *useInfoTextView;
@property(nonatomic,strong) NSString *useInfo;
@property(nonatomic,strong) NSString *agreeHtmlTemplete;
@property(nonatomic,assign)int selectIndex;
@property(nonatomic,strong)USBorrowAccountInfoView *accountBrowView;
@end
@implementation USFinanceLoanViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent= NO;
    [self.view setBackgroundColor:HYCTColor(240, 240, 240)];
    self.title = @"申请借款";
    [self initRigtBarButton];
    _selectIndex = 0;
    _agreeHtmlTemplete = @"borrowcilent/wakaAgreement.action?customer_id=%@&borrow_money=%@&usage=%@";
    _useInfo = @"填写200字以内的用途说明";
    USBorrowAccountInfoView *accountBrowView = [[USBorrowAccountInfoView alloc]initWithFrame:CGRectZero];
    _accountBrowView = accountBrowView;
    
    [self.view addSubview:accountBrowView];
    USCanBorrowInfoView *canAccountView = [[USCanBorrowInfoView alloc]initWithFrame:CGRectMake(0, accountBrowView.y+accountBrowView.height, kAppWidth,90)];
    [self.view addSubview:canAccountView];
    
    canAccountView.delegate = self;
    _canAccountView = canAccountView;
    self.loanView = [self createLoanView];
    self.loanView.x = 0;
    self.loanView.y = canAccountView.y+canAccountView.height;
    [self.view addSubview: self.loanView];
    //
    UIScrollView *scrollVIew = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    scrollVIew.y = 0;
    scrollVIew.contentSize = CGSizeMake(kAppWidth, self.loanView.y+self.loanView.height+50);
    scrollVIew.showsHorizontalScrollIndicator = NO;
    scrollVIew.bounces = NO;
    for (UIView *uiview in self.view.subviews) {
        [uiview removeFromSuperview];
        [scrollVIew addSubview:uiview];
    }
    [self.view addSubview:scrollVIew];
    
    [self performSelectorInBackground:@selector(updateData) withObject:nil];
}
- (void)initRigtBarButton {
    // UIImage *backImage = [[UIImage imageNamed:@"right_next_bg"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIButton *rightNextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightNextButton.backgroundColor = [UIColor clearColor];
    UIFont *font = [UIFont systemFontOfSize:kCommonNextFontSize];
    [rightNextButton.titleLabel setFont:font];
    NSString *leftTitle = @"记录 >";
    [rightNextButton setTitle:leftTitle forState:UIControlStateNormal];
    // [rightNextButton setImage:backImage forState:UIControlStateNormal];
    // [rightNextButton setImage:backImage forState:UIControlStateHighlighted];
    [rightNextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [rightNextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //CGSize size = [leftTitle sizeWithFont:font];
    rightNextButton.size = CGSizeMake(30, 15);
    rightNextButton.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    rightNextButton.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [rightNextButton.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [rightNextButton addTarget:self action:@selector(toRecordList) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightNextButton];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}
-(void)toRecordList{
    USMyLoadRebackListViewController *myLoadRebackListVC = [[USMyLoadRebackListViewController alloc]init];
    _selectIndex = 1;
    myLoadRebackListVC.selectedIndex = _selectIndex;
    myLoadRebackListVC.loanUrl = @"borrowcilent/getMyBorrowMoneyListByCustomerid.action";
    myLoadRebackListVC.loanParam = @{@"customer_id":_account.id,@"pageSize":@(kPageSize),@"currentPage":@(1)};
    myLoadRebackListVC.loanMsg = @"正在玩命加载借款记录...";
    myLoadRebackListVC.rebackUrl = @"repaymoneycilent/getRepayMoneyListByCustomerid.action";
    myLoadRebackListVC.rebackParam = @{@"customer_id":_account.id,@"pageSize":@(kPageSize),@"currentPage":@(1)};
    myLoadRebackListVC.rebackMsg = @"正在玩命加载还款记录...";
    [self.navigationController pushViewController:myLoadRebackListVC animated:YES];
    
}
-(void)updateData{
    dispatch_async(dispatch_get_main_queue(), ^{
        USAccount *account = [USUserService accountStatic];
        _account = account;
        [_accountBrowView.accountNameLabel setText:account.name];
        if (account.headerImg!=nil) {
            _accountBrowView.personImageView.image = account.headerImg;
        }
        _canAccountView.blanceLabel.text = [USStringTool getCurrencyStr:account.surplusmoney];
        [self sliderSpinder:_account.surplusmoney];
        
    });
}
-(void)didIncreament:(UILabel *)blanceLabel{
    USIncreateQuotaViewController *increamentCV = [[USIncreateQuotaViewController alloc]init];
    [self.navigationController pushViewController:increamentCV animated:YES];
}
-(UIView *)createLoanView{
    UIView *backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kAppWidth, kAppHeight-_canAccountView.y-_canAccountView.height)];
    backGroundView.userInteractionEnabled = true;
    self.loanUILabel = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 15, 65, kLabelHeight)];
    [self.loanUILabel setText:@"申请金额:"];
    [self.loanUILabel setTextColor:HYCTColor(159, 159, 159)];
    [self.loanUILabel setFont:[UIFont systemFontOfSize:kCommonFontSize_14]];
    self.loanTotalUILabel = [[UILabel alloc]initWithFrame:CGRectMake(self.loanUILabel.x+self.loanUILabel.width-5, kLabelHeight, kAppWidth-15, kLabelHeight)];
    [self.loanTotalUILabel setText:@"￥0.00"];
    [self.loanTotalUILabel setTextColor:[UIColor orangeColor]];
    [self.loanTotalUILabel setFont:[UIFont systemFontOfSize:kCommonFontSize_14]];
    [backGroundView addSubview:self.loanUILabel];
    [backGroundView addSubview:self.loanTotalUILabel];
    self.slider = [[UISlider alloc]initWithFrame:CGRectMake(kMargin, self.loanTotalUILabel.y+self.loanTotalUILabel.height+5, kAppWidth-self.loanUILabel.x*2, 40)];
    self.slider.minimumValue = 0;
    [self.slider setThumbImage:[UIImage imageNamed:@"finance_slider_button_bg"]forState:UIControlStateNormal];
    self.slider.tintColor = HYCTColor(99, 205, 205);
    [self.slider addTarget:self action:@selector(sliderChanges:) forControlEvents:UIControlEventValueChanged];
    [backGroundView addSubview:self.slider];
    _loanView = backGroundView;
    //
    
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(self.slider.x, self.slider.y+self.slider.height+kMargin, kAppWidth-self.slider.x*2, 100)];
    textView.backgroundColor = HYCTColor(220, 220, 220);
    textView.textColor = [UIColor orangeColor];
    textView.textAlignment = NSTextAlignmentCenter;
    textView.text = _useInfo;
    textView.delegate = self;
    [textView.layer setCornerRadius:5] ;
    textView.userInteractionEnabled = NO;
    _useInfoTextView = textView;
    [backGroundView addSubview:textView];
    //textView.hidden = YES;
    //
    UIButton *caculateBt = [USUIViewTool createButtonWith:@"试算还款计划" imageName:@"finance_loan_button_bg"];
    caculateBt.frame = CGRectMake(self.perMonthTipUILabel.x, textView.y+textView.height+kMargin, 100, 20);
    caculateBt.titleLabel.font =[UIFont systemFontOfSize:kCommonFontSize_12];
    caculateBt.layer.cornerRadius = caculateBt.height*0.5;
    caculateBt.layer.masksToBounds = YES;
    _trayCaculateButton = caculateBt;
    _trayCaculateButton.enabled = NO;
    [caculateBt addTarget:self action:@selector(toTryCaculateVC) forControlEvents:UIControlEventTouchUpInside];
    [backGroundView addSubview:caculateBt];
    caculateBt.hidden = YES;
    //
    UIView *btUIview = [[UIView alloc]initWithFrame:CGRectMake(0,backGroundView.height-90, kAppWidth, 40)];
    [btUIview setBackgroundColor:[UIColor whiteColor]];
    UIButton *loanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _loanButton = loanButton;
    loanButton.frame = CGRectMake(kMargin,5, kAppWidth-kMargin*2, 30);
    [loanButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [loanButton setTitle:@"申请借款" forState:UIControlStateNormal];
    [loanButton setTitle:@"申请借款" forState:UIControlStateHighlighted];
    [loanButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loanButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    UIImage *image = [UIImage imageNamed:@"finance_loan_button_bg"];
    [loanButton setBackgroundImage:image forState:UIControlStateNormal];
    [loanButton setBackgroundImage:image forState:UIControlStateHighlighted];
    [loanButton addTarget:self action:@selector(didLoan:) forControlEvents:UIControlEventTouchUpInside];
    [btUIview addSubview:loanButton];
    [backGroundView addSubview:btUIview ];
    return backGroundView;
}

-(void)sliderChanges:(UISlider*)slider{
    NSInteger index = (NSInteger)(slider.value + 0.5);
    [slider setValue:index animated:NO];
    _currentLoanValue = [self.sliderValues[index]floatValue];
    [self.loanTotalUILabel setText:[NSString stringWithFormat:@"￥%.2f",_currentLoanValue]];
    [self updatePerMouthLabel];
    _loanButton.enabled = _currentLoanValue>0;
    _trayCaculateButton.enabled = _loanButton.enabled;
    _useInfoTextView.userInteractionEnabled = _loanButton.enabled;
}
-(void)clickDateButton:(UIButton *)button{
    button.enabled = NO;
    for (UIButton *bt in self.dateButtons){
        if (button!=bt) {
            bt.enabled = YES;
        }
    }
    _currentMonthCount = button.tag;
    _loanButton.enabled = _currentLoanValue>0;
    _trayCaculateButton.enabled = _loanButton.enabled;
    _useInfoTextView.userInteractionEnabled = _loanButton.enabled;
    [self updatePerMouthLabel];
}
-(void)toTryCaculateVC{
    USTryCacluteRebackPlanViewController *tryVC = [[USTryCacluteRebackPlanViewController alloc]init];
    tryVC.hidesBottomBarWhenPushed = YES;
    tryVC.brrowMoney = _currentLoanValue;
    tryVC.monthCount = _currentMonthCount;
    [self.navigationController pushViewController:tryVC animated:YES];
}
-(void)didLoan:(UIButton *)button{
    if(_useInfoTextView.text.length==0||[_useInfo isEqualToString:_useInfoTextView.text]){
        [MBProgressHUD showError:@"必须输入200字以内的用途说明..."];
        _useInfoTextView.layer.borderWidth =1;
        _useInfoTextView.layer.borderColor = [[UIColor redColor] CGColor];
        return;
    }
    
    USLoadAgreementViewController *htmlVC= [[USLoadAgreementViewController alloc] init];
    
    
    NSString *url = [NSString stringWithFormat:@"borrowcilent/wakaAgreement.action?customer_id=%@&borrow_money=%@&usage=%@&type=1",_account.id,@(_currentLoanValue),_useInfoTextView.text] ;
    
    url =  [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    htmlVC.htmlUrl = HYWebDataPath(url);
    htmlVC.title = @"汪卡借款协议";
    htmlVC.showMsg = YES;
    htmlVC.loadDelegate =self;
    htmlVC.usage = _useInfoTextView.text ;
    htmlVC.borrowmoney =_currentLoanValue ;
    [self.navigationController pushViewController:htmlVC animated:YES];
}
-(void)didActLoad{
    HYLog(@"didActLoad....");
}
-(void)updatePerMouthLabel{
    [self.perMonthUILabel setText:[NSString stringWithFormat:@"￥%.2f",_currentLoanValue/_currentMonthCount]];
}
-(void)sliderSpinder:(CGFloat)maxValue{
    if (maxValue==0) {
        _slider.enabled = NO;
        return ;
    }
    _loanButton.enabled = NO;
    self.maxLoanValue = maxValue;
    NSInteger count = (NSInteger)maxValue/kBase;
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i=0; i<=count; i++) {
        [array addObject: [NSString stringWithFormat:@"%li",i*kBase]];
    }
    if (((NSInteger)maxValue%kBase)!=0) {
        [array addObject: [NSString stringWithFormat:@"%f",maxValue]];
    }
    self.sliderValues = array;
    self.slider.maximumValue = [self.sliderValues count]-1;
}
-(void)createDateButtons:(CGFloat)x y:(CGFloat)y{
    NSMutableArray *buttons = [NSMutableArray array];
    NSArray *titlearrays = @[@"1个月",@"3个月",@"6个月",@"12个月"];
    NSInteger i = 1;
    for (NSString *title in titlearrays) {
        NSInteger index = 1;
        if (i>3) {
            index = [[title substringWithRange:NSMakeRange(0, 2)] intValue];
        }else{
            index = [[title substringWithRange:NSMakeRange(0, 1)] intValue];
        }
        
        UIButton *button =  [self createDateButton:title tag:index];
        if (i==1) {
            button.x = x;
        }else{
            button.x = x+button.width+5;
            x = button.x;
        }
        button.y = y;
        [self.loanView addSubview:button];
        button.hidden = YES;
        [buttons addObject:button];
        i++;
    }
    _dateButtons = buttons;
}
-(UIButton *)createDateButton:(NSString *)title tag:(NSInteger)tag{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.width = (kAppWidth-self.loanUILabel.x*2-5*3)/4;
    button.height = 25;
    button.tag = tag;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    [button setBackgroundImage:[UIImage imageNamed:@"finance_loan_date_button_bg"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"finance_loan_date_button_bg_h"] forState:UIControlStateHighlighted];
    [button setBackgroundImage:[UIImage imageNamed:@"finance_loan_date_button_bg_h"] forState:UIControlStateDisabled];
    [button addTarget:self action:@selector(clickDateButton:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

#pragma mark textViewDelegate
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    [super textViewShouldBeginEditing:textView];
    _useInfoTextView = textView;
    _useInfoTextView.layer.borderWidth = 0;
    if ([_useInfo isEqualToString:textView.text]) {
        textView.text = @"";
        textView.textAlignment = NSTextAlignmentLeft;
    }
    return YES;
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    [super textViewShouldEndEditing:textView];
    if (textView.text==nil||textView.text.length==0) {
        textView.text = _useInfo;
        textView.textAlignment = NSTextAlignmentCenter;
        return YES;
    }
    if (![_useInfo isEqualToString:textView.text]) {
        
    }
    return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    //判断加上输入的字符，是否超过界限
    NSString *str = [NSString stringWithFormat:@"%@%@", textView.text, text];
    //    if (str.length > BOOKMARK_WORD_LIMIT)
    //    {
    //        textView.text = [textView.text substringToIndex:BOOKMARK_WORD_LIMIT];
    //        [textView resignFirstResponder];
    //        [textView endEditing:YES];
    //        return NO;
    //    }
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        [textView endEditing:YES];
        return NO;
    }
    return true;
}
-(void)dissView{
    [_useInfoTextView resignFirstResponder];
}

//- (void)textViewDidChange:(UITextView *)textView
//{
//    //该判断用于联想输入
//    textView.text = [textView.text substringToIndex:BOOKMARK_WORD_LIMIT];
//}
@end
