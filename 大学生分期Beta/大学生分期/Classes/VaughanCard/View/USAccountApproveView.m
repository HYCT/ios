//
//  HYAboutMeView.m
//  红云创投
//
//  Created by HeXianShan on 15/8/27.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USAccountApproveView.h"
@interface USAccountApproveView()

@end
@implementation USAccountApproveView
+(instancetype)accountApproveView{
    return [[USAccountApproveView alloc]initWithFrame:CGRectZero];
}
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kAppWidth, 60)];
        UIImage *tipBgImage = [UIImage imageNamed:@"account_top_view_bg"];
        UIImageView *bgImgeView = [[UIImageView alloc]initWithImage:tipBgImage];
        _bgImgeView = bgImgeView;
        bgImgeView.frame =  _backgroundView.bounds;
        [_backgroundView addSubview:bgImgeView];
        
        
        //头像
        self.personImage = [UIImage imageNamed:@"account_image"];
        UIImageView *personImageView = [[UIImageView alloc]initWithImage:self.personImage];
        personImageView.size =  CGSizeMake(50, 50);
        personImageView.x = 15;
        personImageView.y = 0;
        personImageView.layer.cornerRadius =  personImageView.frame.size.width / 2.0;
        personImageView.clipsToBounds = YES;
        UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        imageButton.frame = personImageView.bounds;
        
        [imageButton addTarget:self action:@selector(updateImage) forControlEvents:UIControlEventTouchUpInside];
        [_backgroundView addSubview:personImageView];
        [_backgroundView addSubview:imageButton];
        self.personImageView = personImageView;
        //姓名
        UIView * nameView = [self createTextNameView];
        _nameView = nameView;
        nameView.frame = personImageView.bounds;
        nameView.x = nameView.x+personImageView.width+30;
        nameView.y = nameView.y+15;
         [_backgroundView addSubview:nameView];
        [self addSubview:_backgroundView];
        self.width = _backgroundView.width;
        self.height = _backgroundView.height;
    }
    return self;
}
-(UIView *)createTextNameView{
    UIView * view = [[UIView alloc]init];
    self.accountNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kAppWidth, 15)];
    [self.accountNameLabel setText:@"lyan***********"];
    [self.accountNameLabel setTextColor:[UIColor whiteColor]];
    [self.accountNameLabel setFont:[UIFont systemFontOfSize:12]];
    
    [view addSubview:self.accountNameLabel];
    self.settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.settingButton.x = 0;
    self.settingButton.y = self.accountNameLabel.y+self.accountNameLabel.height+5;
    self.settingButton.height = 12;
    self.settingButton.width = 45;
    [self.settingButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.settingButton.titleLabel setFont:[UIFont systemFontOfSize:10]];
    [self.settingButton setBackgroundImage:[UIImage imageNamed:@"approve_button_bg"] forState:UIControlStateNormal];
     [self.settingButton setBackgroundImage:[UIImage imageNamed:@"approve_button_bg"] forState:UIControlStateHighlighted];
    [self.settingButton setTitle:@"未认证" forState:UIControlStateNormal];
    [self.settingButton setTitle:@"未认证" forState:UIControlStateHighlighted];
    [self.settingButton addTarget:self action:@selector(approve) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.settingButton];
    return view;
}
-(void)approve{
    [self.deleage didApprove];
}
-(void)updateImage{
    [self.deleage didUpdateImage:self.personImageView];
}
@end
