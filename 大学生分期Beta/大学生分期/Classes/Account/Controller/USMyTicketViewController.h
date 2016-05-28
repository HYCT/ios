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
#import "USRebackViewControllerType.h"
@interface USMyTicketViewController : USBaseViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,copy)NSString *used;
@property(nonatomic,copy)NSString *typeCodeStr;
@property(nonatomic,copy)NSString *fullMoney;
//扫码支付的协议
@property(nonatomic,strong)id<TicketDelegate> ticketDelegate ;
//还款支付协议
@property(nonatomic,strong)id<RebackTicketDelegate> rebackTicketDelegate ;
@end
