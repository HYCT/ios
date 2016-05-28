//
//  HYMainViewController.m
//  红云创投
//
//  Created by HeXianShan on 15/8/9.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USMainUITabBarController.h"
#import "USHomeViewController.h"
#import "USDiscoverViewController.h"
#import "USVaughanCardViewController.h"
#import "USAccountViewController.h"
#import "USNavigationController.h"
#import "USLoginViewController.h"
@interface USMainUITabBarController()
@property(nonatomic,strong)USAccount *account;

@end
@implementation USMainUITabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    _account = [USUserService accountStatic];
    USHomeViewController *homeVC = [[USHomeViewController alloc]init];
    [self addChildWithViewController:homeVC title:@"首页" image:@"home" hightImge:@"home_selected"];
    USAccountViewController *accountVC =  [[USAccountViewController alloc]init];
    
   _accountnNavViewController =  [self addChildWithViewController:accountVC title:@"账户" image:@"account" hightImge:@"account_selected"];
    
    USDiscoverViewController *discoverVC = [[USDiscoverViewController alloc]init];
    [self addChildWithViewController:discoverVC title:@"发现" image:@"discover" hightImge:@"discover_selected"];
   
    USVaughanCardViewController *moreVC = [[USVaughanCardViewController alloc]init];
    [self addChildWithViewController:moreVC title:@"个人中心" image:@"vaughan_card" hightImge:@"vaughan_card_selected"];
    [self.tabBar setBarStyle:UIBarStyleDefault];
    
   
    
}

-(USNavigationController *)addChildWithViewController:(UIViewController *) controller title:(NSString *)title image:(NSString *)image
                        hightImge:(NSString *)highImage{
    controller.tabBarItem.title=title;
    controller.navigationItem.title = title;
    controller.tabBarItem.image =[[UIImage imageNamed:image]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.selectedImage = [[UIImage imageNamed:highImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSMutableDictionary *titleTextSelectedAttri = [NSMutableDictionary dictionary];
    
    titleTextSelectedAttri[NSForegroundColorAttributeName]= [UIColor orangeColor];
    
    NSMutableDictionary *titleTextAttri = [NSMutableDictionary dictionary];
    
    titleTextAttri[NSForegroundColorAttributeName]= HYCTColor(kTarbarTitleColor,kTarbarTitleColor,kTarbarTitleColor);
    [controller.tabBarItem setTitleTextAttributes:titleTextAttri forState:UIControlStateNormal];
    [controller.tabBarItem setTitleTextAttributes:titleTextSelectedAttri forState:UIControlStateSelected];
    USNavigationController *navigation = [[USNavigationController alloc] initWithRootViewController:controller];
    navigation.title = title;
    
    [self addChildViewController:navigation];
    return navigation;
}


-(void)setSelectedIndex:(NSUInteger)selectedIndex{
    [super setSelectedIndex:selectedIndex];
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}





@end
