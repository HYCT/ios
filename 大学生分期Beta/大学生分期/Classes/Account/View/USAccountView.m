//
//  HYAccountTipView.m
//  红云创投
//
//  Created by HeXianShan on 15/8/26.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USAccountView.h"
#define kLabelMargin 5
#define kBlanceMargin 20
#define kTipFont [UIFont boldSystemFontOfSize:12]
#define kTipLabelHeight 15
@interface USAccountView()

@end
@implementation USAccountView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = true;
        _backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kAppWidth, frame.size.height)];
          UIImage *tipBgImage = [UIImage imageNamed:@"account_top_view_bg"];
        UIImageView *bgImgeView = [[UIImageView alloc]initWithImage:tipBgImage];
              [bgImgeView setBackgroundColor:[UIColor redColor]];
        bgImgeView.frame =  _backgroundView.bounds;
        _backgroundView.userInteractionEnabled = true;
        [_backgroundView addSubview:bgImgeView];
               //
        self.blanceTipLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, 100, kTipLabelHeight)];
        self.blanceTipLabel.centerX = self.width/2;
        [self.blanceTipLabel setTextAlignment:NSTextAlignmentCenter];
        [self.blanceTipLabel setText:@"剩余额度(元)"];
        [self.blanceTipLabel setTextColor:[UIColor whiteColor]];
        [self.blanceTipLabel setFont:kTipFont];
        [ _backgroundView addSubview:self.blanceTipLabel];
        //
        self.blanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.blanceTipLabel.y+self.blanceTipLabel.height, kAppWidth, 40)];
        [self.blanceLabel setText:@"00.00"];
        [self.blanceLabel setTextColor:HYCTColor(255, 255, 255)];
        [self.blanceLabel setFont:[UIFont systemFontOfSize:40]];
        [self.blanceLabel setTextAlignment:NSTextAlignmentCenter];
        [ _backgroundView addSubview:self.blanceLabel];
        //
        self.totalBlanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,  self.blanceLabel.y+ self.blanceLabel.height+5, kAppWidth, kTipLabelHeight)];
        [self.totalBlanceLabel setText:@"总额度0(元)"];
        //self.totalBlanceLabel.width = [self.totalBlanceLabel.text sizeWithFont:kTipFont].width;
       // self.totalBlanceLabel.centerX = self.width/2;
        [self.totalBlanceLabel setTextAlignment:NSTextAlignmentCenter];
        [self.totalBlanceLabel setTextColor:[UIColor whiteColor]];
        [self.totalBlanceLabel setFont:kTipFont];
        [ _backgroundView addSubview:self.totalBlanceLabel];
        //
        self.borrowingButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.borrowingButton.height = 15;
        self.borrowingButton.width = 60;
        self.borrowingButton.centerX = self.width/2;
        self.borrowingButton.y = self.totalBlanceLabel.y+self.totalBlanceLabel.height+10;
        [self.borrowingButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self.borrowingButton.titleLabel setFont:[UIFont systemFontOfSize:10]];
        [self.borrowingButton setBackgroundImage:[UIImage imageNamed:@"account_borrowing_button_bg"] forState:UIControlStateNormal];
        [self.borrowingButton setBackgroundImage:[UIImage imageNamed:@"account_borrowing_button_bg"] forState:UIControlStateHighlighted];
        [self.borrowingButton setTitle:@"我要借款" forState:UIControlStateNormal];
        [self.borrowingButton setTitle:@"我要借款" forState:UIControlStateHighlighted];
        [self.borrowingButton addTarget:self action:@selector(borrowing) forControlEvents:UIControlEventTouchUpInside];
         [ _backgroundView addSubview: self.borrowingButton];
        [self addSubview: _backgroundView];
        self.height = _backgroundView.height;
    }
    return self;
}
-(void)borrowing{
    [self.delegate didBorrowing];
}

-(void)setTotalBlance:(NSString *)totalBlance{
    _totalBlanceLabel.text = [NSString stringWithFormat:@"总额度%@(元)",totalBlance];
    // self.totalBlanceLabel.width = [self.totalBlanceLabel.text sizeWithFont:kTipFont].width;
}
@end
