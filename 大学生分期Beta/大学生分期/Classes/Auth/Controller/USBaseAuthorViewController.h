//
//  USBaseAuthorViewController.h
//  大学生分期
//
//  Created by HeXianShan on 15/9/7.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USBaseViewController.h"
#define kLength 0
@interface USBaseAuthorViewController : USBaseViewController<UITextFieldDelegate,ValidatorDelegate,UITextViewDelegate>
@property(nonatomic,strong)UIImageView *logoImageView;
@property(nonatomic,strong) UIView *topView;
@property(nonatomic,strong) UIButton *commonButton;
@property(nonatomic,strong) TooltipView   *tooltipView;
@property(nonatomic,assign)BOOL commitFlag;
@property(nonatomic,assign)int seconde;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,strong)UIButton *getCodeBt;
@property(nonatomic,strong)NSString *getCodeBtTitle;
-(void)validate;
- (void)removeToolTipView;
-(void)startTimerWithSecond:(int)second;
-(void)timerUpdateViews;
@end
