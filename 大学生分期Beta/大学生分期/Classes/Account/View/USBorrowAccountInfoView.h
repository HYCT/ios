//
//  USAccountBorrowView.h
//  大学生分期
//
//  Created by HeXianShan on 15/9/3.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface USBorrowAccountInfoView : UIView
@property(nonatomic,strong)UIImageView *personImageView;
@property(nonatomic,strong)UILabel *accountNameLabel;
@property(nonatomic,strong)UIView *backgroundView ;
@property(nonatomic,strong) UIImageView *bgImgeView;
@property(nonatomic,strong) UIView *personBgView;
-(void)updateFrame;
@end
