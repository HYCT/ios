//
//  USFinanceInvestRecordViewController.h
//  大学生分期
//
//  Created by HeXianShan on 15/9/4.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "USRecordTableViewCell.h"
@interface USInvestRecordViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@end
