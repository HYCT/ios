//
//  HYMessageViewController.m
//  
//
//  Created by HeXianShan on 15/8/9.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USDiscoverViewController.h"
#import "USDiscoverTableViewController.h"
@interface USDiscoverViewController ()
@property(nonatomic,strong)NSMutableDictionary *titleControllerDic;
@property(nonatomic,strong)UITableView *currentTableView;
@end

@implementation USDiscoverViewController

- (void)viewDidLoad {
    self.navigationItem.title = @"发现";
    [super viewDidLoad];
   
     _titleControllerDic = [NSMutableDictionary dictionary];
     [self.view setBackgroundColor:HYCTColor(240, 241, 240)];
    USDiscoverTableViewController *discoverTableVC =  [[USDiscoverTableViewController alloc]init];
    discoverTableVC.view.x = 0;
    discoverTableVC.view.y =10;
    [self addChildViewController:discoverTableVC];
    [self.view addSubview:discoverTableVC.view];
}


@end
