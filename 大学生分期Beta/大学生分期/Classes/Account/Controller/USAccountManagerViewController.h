//
//  USAccountSecondeViewController.h
//  大学生分期
//
//  Created by HeXianShan on 15/9/8.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USBaseViewController.h"

@interface USAccountManagerViewController : USBaseViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@end
