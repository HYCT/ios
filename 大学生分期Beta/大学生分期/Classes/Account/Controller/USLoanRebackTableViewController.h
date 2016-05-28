//
//  USLoanRebackTableViewController.h
//  大学生分期
//
//  Created by HeXianShan on 15/10/19.
//  Copyright © 2015年 hongyunct. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "USSegmentView.h"
@interface USLoanRebackTableViewController:UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,assign)enum LoanRebackrRecordCellType cellType;
@property(nonatomic,strong)NSDictionary *param;
@property(nonatomic,copy)NSString *url;
@property(nonatomic,copy)NSString *msg;
@property(nonatomic,strong)NSMutableArray *dataArrayList;
@property(nonatomic,assign)int currentPage;
@property(nonatomic,assign)int totalPage;
@property(nonatomic,assign)CGFloat y;
@end
