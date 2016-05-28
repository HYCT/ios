//
//  USBaseSnatchViewController.m
//  大学生分期
//
//  Created by HeXianShan on 16/1/6.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import "USBaseSnatchViewController.h"
#import "USMySnatchViewController.h"
@interface USBaseSnatchViewController ()

@end

@implementation USBaseSnatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initRigtBarButton];
}

- (void)initRigtBarButton {
    UIImage *backImage = [[UIImage imageNamed:@"right_next_bg"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIButton *rightNextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightNextButton.backgroundColor = [UIColor clearColor];
    UIFont *font = [UIFont systemFontOfSize:kCommonNextFontSize];
    [rightNextButton.titleLabel setFont:font];
    NSString *leftTitle = @"我的";
    [rightNextButton setTitle:leftTitle forState:UIControlStateNormal];
    [rightNextButton setImage:backImage forState:UIControlStateNormal];
    [rightNextButton setImage:backImage forState:UIControlStateHighlighted];
    [rightNextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [rightNextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightNextButton.size = CGSizeMake(35, 15);
    rightNextButton.imageEdgeInsets = UIEdgeInsetsMake(0, 25, 0, 0);
    rightNextButton.titleEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 0);
    [rightNextButton.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [rightNextButton addTarget:self action:@selector(record) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightNextButton];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}
-(void)record{
    HYLog(@"record....");
    USMySnatchViewController *snatchVC = [[USMySnatchViewController alloc]init];
    snatchVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:snatchVC animated:YES];
}


@end
