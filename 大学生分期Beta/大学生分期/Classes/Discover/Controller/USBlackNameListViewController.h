//
//  USBlackListViewController.h
//  大学生分期
//
//  Created by HeXianShan on 15/9/12.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USBaseViewController.h"

@interface USBlackNameListViewController : USBaseViewController <UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIView *dataTipView;
@property(nonatomic,strong)NSDictionary *param;
@property(nonatomic,copy)NSString *url;
@property(nonatomic,copy)NSString *msg;
@property(nonatomic,strong)NSMutableArray *dataArrayList;
@property(nonatomic,assign)int currentPage;
@property(nonatomic,assign)int totalPage;
@end
