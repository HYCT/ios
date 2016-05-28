//
//  USCellTipView.h
//  大学生分期
//
//  Created by HeXianShan on 15/9/12.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "USAccount.h"
@interface USCellTipView : UIView
@property(nonatomic,strong)UIButton *accessoryBt;
@property(nonatomic,strong) UIView *contentViewBg;
-(instancetype)initWithFrame:(CGRect)frame dic:(NSDictionary *)dic;
@end
