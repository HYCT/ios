//
//  USAccountFinanceRebackViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/4.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USAccountEarnMoneyViewController.h"
#import "USFinanceSaveTopView.h"
#import "USInvestRecordViewController.h"
@interface USAccountEarnMoneyViewController()<USFinanceSaveTopViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>
@property(nonatomic,strong) USFinanceSaveTopView *financeSaveTopView;
@property(nonatomic,strong) UIView *contentView;
@property(nonatomic,strong) UITextView *itemDesc;
@property(nonatomic,strong) UITextField *saveTotalTextFied;
@property(nonatomic,strong) UIButton *saveCommitButton;
@property(nonatomic,strong) UIView *topView;
@property(nonatomic,strong) USInvestRecordViewController *fianceInVestVC;
@end
@implementation USAccountEarnMoneyViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"我要赚钱";
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view setBackgroundColor:HYCTColor(240, 240, 240)];
    [self initFinanceSaveTopView];
    CGFloat y = _financeSaveTopView.height+_financeSaveTopView.y+10;
    _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, y, kAppWidth, kAppHeight-y)];
    [_contentView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_contentView];
    [_financeSaveTopView buttonClick];
    [self createSaveView:y];
}
-(void)initFinanceSaveTopView{
    _financeSaveTopView = [[USFinanceSaveTopView alloc]initWithFrame:CGRectMake(0, 0, kAppWidth, 140)];
    _financeSaveTopView.delagate = self;
    [self.view addSubview:_financeSaveTopView];
   
}
-(UIView *)createSaveView:(CGFloat)y{
    UIView *saveView = [[UIView alloc]initWithFrame:CGRectMake(0, kAppHeight-kNavBarY-70,kAppWidth , 50)];
    [saveView setBackgroundColor:[UIColor whiteColor]];
    UIButton *saveCommitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _saveCommitButton = saveCommitButton;
    UITextField *saveTotalTextFied = [[UITextField alloc]initWithFrame:CGRectMake(5, 7.5, kAppWidth-70, 35)];
    //textFied.layer.cornerRadius = textFied.width/20;
    [saveTotalTextFied setBackground:[UIImage imageNamed:@"finance_loan_input_bg"]];
    [saveTotalTextFied setBorderStyle:UITextBorderStyleNone];
    saveTotalTextFied.keyboardType = UIKeyboardTypeNumberPad;
    saveTotalTextFied.text =@"";
    saveTotalTextFied.delegate = self;
    saveTotalTextFied.textAlignment = NSTextAlignmentCenter;
    saveTotalTextFied.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入投资金额" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13]}];
    [saveView addSubview:saveTotalTextFied];
    _saveTotalTextFied = saveTotalTextFied;
    saveCommitButton.enabled = NO;
    saveCommitButton.frame = CGRectMake(kAppWidth-70, 7.5, 65, 35);
    [saveCommitButton setBackgroundImage:[UIImage imageNamed:@"finance_save_commit_bt_bg"] forState:UIControlStateNormal];
    [saveCommitButton setBackgroundImage:[UIImage imageNamed:@"finance_save_commit_bt_bg"] forState:UIControlStateHighlighted];
    [saveCommitButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [saveCommitButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [saveCommitButton setTitle:@"确定投资" forState:UIControlStateNormal];
    [saveCommitButton setTitle:@"确定投资" forState:UIControlStateHighlighted];
    [saveCommitButton setTitle:@"确定投资" forState:UIControlStateDisabled];
    [saveCommitButton addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
    [saveView addSubview:saveCommitButton];
    [self.view addSubview:saveView];
    return saveView;
}
-(void)commit{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确认投资?" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        HYLog(@"确认投资....");
    }
    [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
}

//点击return按钮时调用
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    UIView *topView = [[UIView alloc]initWithFrame:self.view.bounds];
    topView.backgroundColor = [UIColor clearColor];
    _topView = topView;
    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dissView)];
    
    [topView addGestureRecognizer:tapGesture];
    [self.view addSubview:topView];
    return YES;
}
-(void)dissView{
    [_topView removeFromSuperview];
    _saveCommitButton.enabled = [self isCanCommite];
    HYLog(@"dissView");
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    _saveCommitButton.enabled = [self isCanCommite];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    _saveCommitButton.enabled = [self isCanCommite];
    [_saveTotalTextFied resignFirstResponder];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    _saveCommitButton.enabled = [self isCanCommite];
}
-(BOOL)isCanCommite{
    [_saveTotalTextFied resignFirstResponder];
   return [_saveTotalTextFied.text length]>0&&([_saveTotalTextFied.text floatValue]>0);
}
///
-(UIView *)createTitleView{
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(5, 5, kAppWidth, 15)];
    [titleView addSubview:[self createTitleLabel:@"用户名"]];
    CGFloat width = kAppWidth/3-20;
    UILabel *title = [self createTitleLabel:@"金额"];
    title.x = width+20;
    [titleView addSubview:title];
    title = [self createTitleLabel:@"时间"];
    title.x = (width+20)*2;
    [titleView addSubview:title];
    return titleView;
}
-(UILabel *)createTitleLabel:(NSString *)title{
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kAppWidth/3-20, 15)];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setText:title];
    [titleLabel setFont:[UIFont systemFontOfSize:12]];
    
    return titleLabel;
}
-(void)updateView{
    [_contentView setBackgroundColor:[UIColor clearColor]];
    for (UIView *view in _contentView.subviews) {
        [view removeFromSuperview];
    }
}
-(void)didUpdateRecord:(UITableView *)tableView{
   [_contentView setBackgroundColor:[UIColor clearColor]];
    [self updateView];
    //
    if (_fianceInVestVC==nil) {
        _fianceInVestVC = [[USInvestRecordViewController alloc]init];
        [self addChildViewController:_fianceInVestVC];
    }
    UIView *titleView = [self createTitleView];
    [_contentView addSubview:titleView];
    _fianceInVestVC.view.x = titleView.x;
    _fianceInVestVC.view.y = titleView.y+titleView.height+10;
    [_contentView addSubview:_fianceInVestVC.view];
}

-(void)didUpdateInfo:(UITextView *)textView{
    [self updateView];
    NSString *htmlPath = [[NSBundle mainBundle]pathForResource:@"htmltestdata" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:htmlPath];
    NSString *htmlString =dic[@"item_desc"];
    //[NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    UITextView *tinfoTxtView = [[UITextView alloc]initWithFrame:CGRectMake(10, 10, kAppWidth, _contentView.height)];
    tinfoTxtView.scrollEnabled = YES;
    tinfoTxtView.userInteractionEnabled =YES;
    tinfoTxtView.editable=NO;
    tinfoTxtView.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
    //[tinfoTxtView setFont:[UIFont systemFontOfSize:13]];
    tinfoTxtView.font = [UIFont fontWithName:@"Arial" size:13.0];
    [tinfoTxtView setBackgroundColor:[UIColor clearColor]];
  //  CGSize constraintSize = CGSizeMake(kAppWidth, MAXFLOAT);
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    tinfoTxtView.attributedText = attributedString;
    //CGSize size = [tinfoTxtView sizeThatFits:constraintSize];
    [_contentView addSubview:tinfoTxtView];
}

@end
