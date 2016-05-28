//
//  HYNavigationController.m
//  红云创投
//
//  Created by HeXianShan on 15/8/10.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USNavigationController.h"

@interface USNavigationController ()

@end

@implementation USNavigationController
+(void)initialize{
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    NSMutableDictionary *textAttri = [NSMutableDictionary dictionary];
    textAttri[NSForegroundColorAttributeName] = [UIColor whiteColor];
    textAttri[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [item setTitleTextAttributes:textAttri forState:UIControlStateNormal];
    NSMutableDictionary *disabletextAttri = [NSMutableDictionary dictionary];
    disabletextAttri[NSForegroundColorAttributeName] = [UIColor grayColor];
    disabletextAttri[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [item setTitleTextAttributes:disabletextAttri forState:UIControlStateDisabled];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [super pushViewController:viewController animated:animated];
    if (self.viewControllers.count>1) {
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"---" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    }
    
}
                                                                                                         
 -(void)back{
     [self popViewControllerAnimated:YES];
 }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
