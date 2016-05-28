//
//  HYMyinfoViewController.m
//  红云创投
//
//  Created by HeXianShan on 15/8/9.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USVaughanCardViewController_.h"
#import "USAccountApproveView.h"
#import "USMoreTableViewController.h"
@interface USVaughanCardViewController_ ()
@property(nonatomic,strong)USAccountApproveView *aboutMeView;
@end

@implementation USVaughanCardViewController_

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"汪圈生活";
    [self.view setBackgroundColor:HYCTColor(240, 240, 240)];
    USMoreTableViewController *moreTableVC = [[USMoreTableViewController alloc]init];
    [self addChildViewController:moreTableVC];
    moreTableVC.view.y = 10;
    moreTableVC.view.x = 0;
    [self.view addSubview:moreTableVC.tableView];
}


-(void)layout{
    HYLog(@"----layout--");
}

@end
