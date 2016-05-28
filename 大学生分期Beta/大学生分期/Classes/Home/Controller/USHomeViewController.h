//
//  HYHomeViewController.h
//  红云创投
//
//  Created by HeXianShan on 15/8/9.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface USHomeViewController :UIViewController<UITabBarDelegate,CLLocationManagerDelegate>
@property(nonatomic,strong)CLLocationManager *locMgr;
@end
