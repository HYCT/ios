//
//  USAccountBorrowView.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/3.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USBorrowAccountInfoView.h"
@interface USBorrowAccountInfoView()

@end
@implementation USBorrowAccountInfoView
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kAppWidth, 80)];
        //[_backgroundView setBackgroundColor:[UIColor redColor]];
        UIImage *tipBgImage = [UIImage imageNamed:@"account_top_view_bg"];
        UIImageView *bgImgeView = [[UIImageView alloc]initWithImage:tipBgImage];
        bgImgeView.frame =  _backgroundView.bounds;
        _bgImgeView = bgImgeView;
        [_backgroundView addSubview:bgImgeView];
        
        
        //头像
        UIImage *personImage = [UIImage imageNamed:@"account_image"];
        UIImageView *personImageView = [[UIImageView alloc]initWithImage:personImage];
        personImageView.size =  CGSizeMake(60, 60);
        personImageView.x = kAppWidth/2-personImageView.width/2;
        personImageView.y = 0;
        personImageView.layer.cornerRadius =  personImageView.frame.size.width / 2.0;
        personImageView.clipsToBounds = YES;
        _personBgView = [[UIView alloc]initWithFrame:personImageView.bounds];
        
        [_personBgView setBackgroundColor:[UIColor clearColor]];
        [_personBgView addSubview:personImageView];
        [_backgroundView addSubview:_personBgView];
        self.personImageView = personImageView;
        self.accountNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _personImageView.height+_personImageView.y+5, kAppWidth, 15)];
        [self.accountNameLabel setText:@"lyan***********"];
        [self.accountNameLabel setTextAlignment:NSTextAlignmentCenter];
        [self.accountNameLabel setTextColor:[UIColor whiteColor]];
        [self.accountNameLabel setFont:[UIFont systemFontOfSize:12]];
        [_backgroundView addSubview:self.accountNameLabel];
        [self addSubview:_backgroundView];
        self.width = kAppWidth;
        [self setBackgroundColor:[UIColor clearColor]];
        self.height = self.accountNameLabel.height+self.accountNameLabel.y;
    }
    return self;
}
-(void)updateFrame{
    _personImageView.x = kAppWidth/2-_personImageView.width/2;
    _personImageView.y = 0;
    _personImageView.layer.cornerRadius =  _personImageView.frame.size.width / 2.0;
    self.accountNameLabel.frame = CGRectMake(0, _personImageView.height+_personImageView.y+5, kAppWidth, 15);
    self.height = self.accountNameLabel.height+self.accountNameLabel.y;
}
@end
