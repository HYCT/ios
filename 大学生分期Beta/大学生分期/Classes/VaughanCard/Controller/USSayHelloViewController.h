//
//  USSayHelloViewController.h
//  大学生分期
//
//  Created by mac on 16/2/22.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

//打招呼信息
#import <Foundation/Foundation.h>
#import "USBaseViewController.h"
@interface USSayHelloViewController : USBaseViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@end
