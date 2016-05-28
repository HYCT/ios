//
//  HYAccountTableViewTableViewController.h
//  红云创投
//
//  Created by HeXianShan on 15/8/26.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface USAccountTableViewController: UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,assign)CGFloat tableHeight;
@property(nonatomic,assign)CGFloat tableY;
@property(nonatomic,copy)NSString *myIncome;
@property(nonatomic,copy)NSString *dataFileUrl;
@end
