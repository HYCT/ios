//
//  HYMainViewController.h
//  红云创投
//
//  Created by HeXianShan on 15/8/9.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "USNavigationController.h"
#import <CoreLocation/CoreLocation.h>
@interface USMainUITabBarController: UITabBarController<CLLocationManagerDelegate>
@property(nonatomic,weak)USNavigationController *accountnNavViewController;

@end
