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
#import "USListCommonDelegate.h"
@interface USCommonListController : USBaseViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataList;
@property(nonatomic,strong)NSString *mytitle;
@property(nonatomic,strong)NSString *type;
-(void)changeListData:(NSDictionary *)data newData:(NSMutableDictionary *)newData  ;
//点击协议
@property(weak,nonatomic)id<USListCommonDelegate> ListCommonDelegate ;

@end
