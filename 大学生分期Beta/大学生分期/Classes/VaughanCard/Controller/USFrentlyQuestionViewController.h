//
//  USFrentlyQuestionViewController.h
//  大学生分期
//
//  Created by HeXianShan on 15/9/13.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USBaseViewController.h"

@interface USFrentlyQuestionViewController : USBaseViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSString *code;
@end
