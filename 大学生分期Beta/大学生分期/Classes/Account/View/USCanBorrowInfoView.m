//
//  USCanBorrowInfoView.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/3.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USCanBorrowInfoView.h"
#define kLabelMargin 5
#define kBlanceMargin 20
#define kTipFont [UIFont boldSystemFontOfSize:12]
#define kTipLabelHeight 15
@interface USCanBorrowInfoView()

@end
@implementation USCanBorrowInfoView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        _backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kAppWidth,110)];
        _backgroundView.userInteractionEnabled = YES;
        UIImage *tipBgImage = [UIImage imageNamed:@"account_top_view_bg"];
        UIImageView *bgImgeView = [[UIImageView alloc]initWithImage:tipBgImage];
        [bgImgeView setBackgroundColor:[UIColor redColor]];
        bgImgeView.frame =  _backgroundView.bounds;
        _bgImgeView = bgImgeView;
        [_backgroundView addSubview:bgImgeView];
        //
        self.blanceTipLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, 120, kTipLabelHeight+5)];
        self.blanceTipLabel.centerX = self.width/2;
        [self.blanceTipLabel setTextAlignment:NSTextAlignmentCenter];
        [self.blanceTipLabel setText:@"剩余额度(元)"];
        [self.blanceTipLabel setTextColor:[UIColor whiteColor]];
        [self.blanceTipLabel setFont:kTipFont];
        [ _backgroundView addSubview:self.blanceTipLabel];
        //
        self.blanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.blanceTipLabel.y+self.blanceTipLabel.height, kAppWidth, 40)];
        [self.blanceLabel setText:@"0.00"];
        [self.blanceLabel setTextColor:HYCTColor(255, 255, 255)];
        [self.blanceLabel setFont:[UIFont systemFontOfSize:40]];
        [self.blanceLabel setTextAlignment:NSTextAlignmentCenter];
        [ _backgroundView addSubview:self.blanceLabel];
        //
        self.increamentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.increamentButton.height = 20;
        self.increamentButton.width = 80;
        [self.increamentButton.layer setCornerRadius:self.increamentButton.height/2] ;
        self.increamentButton.centerX = self.width/2;
        self.increamentButton.y = self.blanceLabel.y+self.blanceLabel.height+10;
        [self.increamentButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self.increamentButton.titleLabel setFont:[UIFont systemFontOfSize:10]];
        //[self.increamentButton setBackgroundImage:[UIImage imageNamed:@"finance_increament_button_bg"] forState:UIControlStateNormal];
        //[self.increamentButton setBackgroundImage:[UIImage imageNamed:@"finance_increament_button_bg"] forState:UIControlStateHighlighted];
        [self.increamentButton setBackgroundColor:[UIColor whiteColor]] ;
        [self.increamentButton setTitle:@"提升额度" forState:UIControlStateNormal];
        [self.increamentButton setTitle:@"提升额度" forState:UIControlStateHighlighted];
        [self.increamentButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [self.increamentButton addTarget:self action:@selector(didIncreament) forControlEvents:UIControlEventTouchUpInside];
        [ _backgroundView addSubview: self.increamentButton];
        [self addSubview: _backgroundView];
        self.height = _backgroundView.height;
    }
    return self;
}
-(void)didIncreament{
    [self.delegate didIncreament:self.blanceLabel];
}

@end
