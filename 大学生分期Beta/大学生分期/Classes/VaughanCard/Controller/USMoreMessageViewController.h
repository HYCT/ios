//
//  USMoreMessageViewController.h
//  大学生分期
//
//  Created by HeXianShan on 15/9/12.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USBaseViewController.h"

@interface USMoreMessageViewController : USBaseViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@end
