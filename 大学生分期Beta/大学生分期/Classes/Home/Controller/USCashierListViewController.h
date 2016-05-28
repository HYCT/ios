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
#import "USScanCodeResultViewController.h"
@interface USCashierListViewController : USBaseViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,copy)NSString *shop_id ;
@property(nonatomic,strong)id<ScanDelegate> scanDelegate;
@end
