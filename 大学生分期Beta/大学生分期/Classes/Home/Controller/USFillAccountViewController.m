//
//  USFillAccountViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/6.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USFillAccountViewController.h"

@interface USFillAccountViewController ()<UITextFieldDelegate,UIAlertViewDelegate>
@property(nonatomic,strong)UILabel *cardIdLabel;
@property(nonatomic,strong)UILabel *schoolAndStudentNameLabel;
@property(nonatomic,strong) UIView *topView;
@property(nonatomic,strong) UIView *fillAccountView;
@property(nonatomic,strong) UIButton *fillAccountButton;
@property(nonatomic,strong) UITextField *fillAccountTextFied;
@end

@implementation USFillAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"校园一卡通充值";
    self.navigationController.navigationBar.translucent= NO;
    [self.view setBackgroundColor:HYCTColor(240, 240, 240)];
    UIView *backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, kAppWidth, 60)];
    [backGroundView setBackgroundColor:[UIColor whiteColor]];
    //
    self.cardIdLabel = [USUIViewTool createUILabel];
    [self.cardIdLabel setFont:[UIFont boldSystemFontOfSize:14]];
    self.cardIdLabel.x = 10;
    self.cardIdLabel.y = 15;
    self.cardIdLabel.text = @"1473 8864 7721 6634 882";
    [backGroundView addSubview:self.cardIdLabel];
    //
    self.schoolAndStudentNameLabel = [USUIViewTool createUILabel];
    [self.schoolAndStudentNameLabel setFont:[UIFont boldSystemFontOfSize:10]];
    [self.schoolAndStudentNameLabel setTextColor:HYCTColor(170, 170, 170)];
    self.schoolAndStudentNameLabel.x = 10;
    self.schoolAndStudentNameLabel.y = self.cardIdLabel.y+self.cardIdLabel.height+5;
    self.schoolAndStudentNameLabel.text = @"李虹(云南大学)";
    [backGroundView addSubview:self.schoolAndStudentNameLabel];
    //
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button.titleLabel setTextAlignment:NSTextAlignmentRight];
    [button.titleLabel setFont:[UIFont boldSystemFontOfSize:12]];
    [button setTitleColor:HYCTColor(190, 190, 190) forState:UIControlStateNormal];
    [button setTitleColor:HYCTColor(190, 190, 190) forState:UIControlStateHighlighted];
    [button setTitle:@"修改 >" forState:UIControlStateNormal];
    [button setTitle:@"修改 >"forState:UIControlStateHighlighted];
    button.height = 15;
    button.width = 40;
    button.y = backGroundView.height/2-button.height/2;
    button.x = kAppWidth - button.width-self.cardIdLabel.x;
    [backGroundView addSubview:button];
    [self.view addSubview:backGroundView];
    //
    self.fillAccountView = [self createCommiteView:(button.y+button.height+30)];
    [self.view addSubview:self.fillAccountView];
    
}

-(UIView *)createCommiteView:(CGFloat)y{
    UIView *saveView = [[UIView alloc]initWithFrame:CGRectMake(0, y+30,kAppWidth , 35)];
    saveView.userInteractionEnabled = YES;
    [saveView setBackgroundColor:[UIColor clearColor]];
    UIButton *fillAccountButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _fillAccountButton = fillAccountButton;
    UITextField *fiilAccountTextFied = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, kAppWidth-70, 35)];
    _fillAccountTextFied = fiilAccountTextFied;
    [fiilAccountTextFied setBackground:[UIImage imageNamed:@"finance_fillaccount_input_bg"]];
    [fiilAccountTextFied setBorderStyle:UITextBorderStyleNone];
    fiilAccountTextFied.keyboardType = UIKeyboardTypeNumberPad;
    fiilAccountTextFied.text =@"";
    fiilAccountTextFied.delegate = self;
    fiilAccountTextFied.textAlignment = NSTextAlignmentCenter;
    fiilAccountTextFied.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入充值金额" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13]}];
    [saveView addSubview:fiilAccountTextFied];
    fillAccountButton.enabled = NO;
    fillAccountButton.frame = CGRectMake(kAppWidth-70, 0, 65, 35);
    [fillAccountButton setBackgroundImage:[UIImage imageNamed:@"finance_save_commit_bt_bg"] forState:UIControlStateNormal];
    [fillAccountButton setBackgroundImage:[UIImage imageNamed:@"finance_save_commit_bt_bg"] forState:UIControlStateHighlighted];
    [fillAccountButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [fillAccountButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [fillAccountButton setTitle:@"立即充值" forState:UIControlStateNormal];
    [fillAccountButton setTitle:@"立即充值" forState:UIControlStateHighlighted];
    [fillAccountButton setTitle:@"立即充值" forState:UIControlStateDisabled];
    [fillAccountButton addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
    [saveView addSubview:fillAccountButton];
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
    _fillAccountButton.enabled = [self isCanCommite];
    HYLog(@"dissView");
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    _fillAccountButton.enabled = [self isCanCommite];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    _fillAccountButton.enabled = [self isCanCommite];
    [_fillAccountTextFied resignFirstResponder];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    _fillAccountButton.enabled = [self isCanCommite];
}
-(BOOL)isCanCommite{
    [_fillAccountTextFied resignFirstResponder];
    return [_fillAccountTextFied.text length]>0&&([_fillAccountTextFied.text floatValue]>0);
}

@end
