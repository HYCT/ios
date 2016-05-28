//
//  USRecordTableViewController.h
//  大学生分期
//
//  Created by HeXianShan on 16/1/6.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface USRecordTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,copy)NSString *snatchId;
@end
