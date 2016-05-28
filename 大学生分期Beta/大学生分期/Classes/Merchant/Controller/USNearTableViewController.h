//
//  USNearTableViewController.h
//  大学生分期
//
//  Created by HeXianShan on 15/9/3.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    NearType_Group,
} NearType;
 #import <CoreLocation/CoreLocation.h>
@interface USNearTableViewController :  UIViewController<UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate>
@property(nonatomic,assign)NearType nearType;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)CLLocationManager *locMgr;
@end
