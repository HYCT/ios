//
//  USFinanceAssertsCell.h
//  大学生分期
//
//  Created by HeXianShan on 15/9/11.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface USFinanceAssertsCell : UITableViewCell
@property(nonatomic,strong)UILabel *assertNameLB;
@property(nonatomic,strong)UILabel *totalIncomeLB;
@property(nonatomic,strong)UILabel *lastIncomeLB;
@property(nonatomic,strong)UILabel *totalHandLB;
@property(nonatomic,assign)CGFloat rate;
@property(nonatomic,copy)NSString *rateName;
@property(nonatomic,strong)UIButton *todetailBt;
@end
