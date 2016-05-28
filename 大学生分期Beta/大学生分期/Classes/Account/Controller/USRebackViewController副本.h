//
//  USRebackViewController.h
//  大学生分期
//
//  Created by HeXianShan on 15/9/9.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USBaseViewController.h"
#import "USRebackTableViewCell.h"
#import "USBaseAuthorViewController.h"
@interface USRebackViewController : USBaseAuthorViewController
@property(nonatomic,strong)UILabel *rebackTotalLB;
@property(nonatomic,assign)CGFloat totalMoney;
@property(nonatomic,strong)NSString *formatString;
@property(nonatomic,copy)NSString *rebackId;
@property(nonatomic,strong) USRebackTableViewCell *cardView;
@property(nonatomic,strong)NSMutableDictionary *paramDic;
@end
