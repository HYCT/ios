//
//  USCirclListTableViewController.h
//  大学生分期
//
//  Created by HeXianShan on 16/1/4.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface USCirclListTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
//加载圈子的数据类型0：我的关注，1，我的粉丝，2我的朋友
@property(nonatomic,copy)NSString *type ;
@end
