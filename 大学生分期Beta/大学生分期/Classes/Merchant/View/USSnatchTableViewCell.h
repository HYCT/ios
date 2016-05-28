//
//  USSnatchTableViewCell.h
//  大学生分期
//
//  Created by HeXianShan on 15/10/2.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "USUpDownLabelView.h"
@interface USSnatchTableViewCell : UITableViewCell
@property(nonatomic,strong) UIImageView *topImageView;
@property(nonatomic,strong) UILabel *nameLB;
@property(nonatomic,strong) UILabel *subTitleLB;
@property(nonatomic,strong) UIProgressView *progressView;
@property(nonatomic,strong) USUpDownLabelView *plandeUpDownView;
@property(nonatomic,strong) USUpDownLabelView *blanceDateUpDownView;

@end
