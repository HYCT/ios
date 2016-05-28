//
//  USIvitRecordViewController.h
//  大学生分期
//
//  Created by HeXianShan on 16/1/10.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import "USBaseViewController.h"

@interface USInvitRecordViewController : USBaseViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,copy)NSString  *inviter_id;
@end
