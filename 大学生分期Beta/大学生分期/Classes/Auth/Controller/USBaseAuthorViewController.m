//
//  USBaseAuthorViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/7.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USBaseAuthorViewController.h"
@interface USBaseAuthorViewController()
@property(nonatomic,assign)CGFloat keyBordHeight;
@property(nonatomic,assign)BOOL moveFlag;
@property(nonatomic,strong)UIView *editView;
@end
@implementation USBaseAuthorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent= YES;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
    _moveFlag = NO;
}

-(void) resignKeyboard
{
    
    [self.view endEditing:YES];
}

-(void)dissView{
    [self updateRespons];
    _commonButton.enabled = [self isCanCommite];
}
-(void)updateRespons{
    
}
-(BOOL)isCanCommite{
    return true;
}
//点击return按钮时调用
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dissView)];
    [self.view addGestureRecognizer:tapGesture];
    [self removeToolTipView];
    _editView = textField;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self dissView];
    _editView = nil;
    return YES;
}
#pragma 处理textView
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dissView)];
    [self.view addGestureRecognizer:tapGesture];
    [self resignKeyboard];
    [self removeToolTipView];
    _editView = textView;
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    [self dissView];
    _editView = nil;
}


-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    _editView = nil;
    return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
       return true;
}

- (void)textViewDidChange:(UITextView *)textView
{
    
}

- (void)removeToolTipView {
    if (_tooltipView != nil)
    {
        [_tooltipView removeFromSuperview];
        _tooltipView = nil;
    }
}

-(void)validate{
    [self resignKeyboard];
    [self removeToolTipView];
}

#pragma 键盘遮挡处理
-(void)keyboardWillAppear:(NSNotification *)notification
{
    CGRect currentFrame = self.view.frame;
    CGFloat change = [self keyboardEndingFrameHeight:[notification userInfo]];
    CGFloat eY = 0;
    if (_editView.tag>0) {
        eY = _editView.tag;
    }else{
      eY = _editView.y+_editView.height;
    }
    if ([_editView isKindOfClass:[UITextView class]]) {
        eY+=eY*0.5;
    }
     CGFloat detaY = currentFrame.size.height-change-eY;
    if (detaY<0) {
       currentFrame.origin.y = currentFrame.origin.y - change ;
       self.view.frame = currentFrame;
        _moveFlag = YES;
    }
}

-(void)keyboardWillDisappear:(NSNotification *)notification
{
    if (_moveFlag) {
        CGRect currentFrame = self.view.frame;
        CGFloat change = [self keyboardEndingFrameHeight:[notification userInfo]];
        currentFrame.origin.y = currentFrame.origin.y + change ;
        self.view.frame = currentFrame;
    }
     _editView = nil;
    _moveFlag = NO;
}
-(CGFloat)keyboardEndingFrameHeight:(NSDictionary *)userInfo//计算键盘的高度
{
    CGRect keyboardEndingUncorrectedFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
    CGRect keyboardEndingFrame = [self.view convertRect:keyboardEndingUncorrectedFrame fromView:nil];
    return keyboardEndingFrame.size.height;
}
#pragma ValidatorDelegate - Delegate methods
- (void)updateUItextFieldBorderColor
{
    for (UITextField *textField in self.view.subviews) {
        if ([textField isKindOfClass:[UITextField class]]) {
            textField.layer.borderColor=  [HYCTColor(163, 163, 163) CGColor];
            
        }
        
    }
}

- (void) preValidation
{
    //[self updateUItextFieldBorderColor];
    
}

- (void)onSuccess:(NSArray *)rules
{
    
    [self removeToolTipView];
    _commitFlag = true;
    [self updateUItextFieldBorderColor];
    
}

- (void)onFailure:(Rule *)failedRule
{
    failedRule.textField.layer.borderColor   = [[UIColor redColor] CGColor];
    
    CGPoint point = [failedRule.textField convertPoint:CGPointMake(0.0, failedRule.textField.frame.size.height - 4.0) toView:self.view];
    CGRect tooltipViewFrame = CGRectMake(6.0, point.y, 309.0, _tooltipView.frame.size.height);
    
    _tooltipView       = [[InvalidTooltipView alloc] init];
    _tooltipView.frame = tooltipViewFrame;
    _tooltipView.text  = [NSString stringWithFormat:@"%@",failedRule.failureMessage];
    _tooltipView.rule  = failedRule;
    _commitFlag = failedRule == nil;
    [self.view addSubview:_tooltipView];
}
-(void)startTimerWithSecond:(int)second{
    _seconde = second;
    _getCodeBtTitle = @"获取验证码";
    if (_timer == nil||![_timer isValid]) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerUpdateViews) userInfo:nil repeats:YES];
    }
}
-(void)timerUpdateViews{
    if (_seconde>0) {
        [_getCodeBt setTitle:[NSString stringWithFormat:@"%is后可重发",_seconde] forState:UIControlStateDisabled];
        _seconde--;
        return;
    }
    [_timer invalidate];
    _getCodeBt.enabled = YES;
    [_getCodeBt setTitle:_getCodeBtTitle forState:UIControlStateNormal];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
@end
