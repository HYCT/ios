//
//  USGameViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/12/13.
//  Copyright © 2015年 hongyunct. All rights reserved.
//

#import "USGameViewController.h"

@implementation USGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent= NO;
    self.title =_subtitle==nil? @"游戏":_subtitle;
    
    USHtmlLoadViewController *htmlLoadVC = [[USHtmlLoadViewController alloc]init];
    htmlLoadVC.htmlUrl = _subUrl==nil?HYWebDataPath(@"games/H5/Game2.html"):_subUrl;
    htmlLoadVC.showMsg = YES;
    [self addChildViewController:htmlLoadVC];
    [self.view addSubview:htmlLoadVC.view];
    
    
    

}


@end
