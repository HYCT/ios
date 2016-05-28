//
//  USMyLoadRebackListViewController.h
//  大学生分期
//
//  Created by HeXianShan on 15/9/25.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USBaseViewController.h"

@interface USMyLoadRebackListViewController :USBaseViewController
@property(nonatomic,assign)NSInteger selectedIndex;
@property(nonatomic,strong)NSDictionary *loanParam;
@property(nonatomic,copy)NSString *loanUrl;
@property(nonatomic,copy)NSString *loanMsg;
@property(nonatomic,strong)NSDictionary *rebackParam;
@property(nonatomic,copy)NSString *rebackUrl;
@property(nonatomic,copy)NSString *rebackMsg;
@end
