//
//  USAddBankCardViewController.h
//  大学生分期
//
//  Created by HeXianShan on 15/9/9.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USBaseViewController.h"
@interface USCommonBankCardListViewController : USBaseViewController<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,UIAlertViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@end

