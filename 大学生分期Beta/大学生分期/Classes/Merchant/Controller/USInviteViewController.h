//
//  USInviteViewController.h
//  大学生分期
//
//  Created by HeXianShan on 16/1/9.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import "USBaseSnatchViewController.h"

@interface USInviteViewController : USBaseSnatchViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;

@end
