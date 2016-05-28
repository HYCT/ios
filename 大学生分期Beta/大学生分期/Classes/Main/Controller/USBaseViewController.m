//
//  USBaseViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/2.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USBaseViewController.h"
#import "USGameViewController.h"
@implementation USBaseViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent= YES;
    [self initLeftItemBar];
    
    
}
-(void)initLeftItemBar{
    UIImage *backImage = [[UIImage imageNamed:@"nav_back_bg"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.backgroundColor = [UIColor clearColor];
    UIFont *font = [UIFont systemFontOfSize:kCommonNavFontSize];
    [leftButton.titleLabel setFont:font];
    NSString *leftTitle = @"返回";
    [leftButton setTitle:leftTitle forState:UIControlStateNormal];
    [leftButton setImage:backImage forState:UIControlStateNormal];
    [leftButton setImage:backImage forState:UIControlStateHighlighted];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //CGSize size = [leftTitle sizeWithFont:font];
    leftButton.size = CGSizeMake(60, 24);
    leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -24, 0, 0);
    leftButton.titleEdgeInsets = UIEdgeInsetsMake(0, -24, 0, 0);
    [leftButton.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [leftButton addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    [self.view setBackgroundColor:HYCTColor(240, 240, 240)];
}
- (void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}
-(UIButton *)createAgreementBt{
    UIButton  *bt = [USUIViewTool createButtonWith:@""];
    [bt addTarget:self action:@selector(openAgreement) forControlEvents:UIControlEventTouchUpInside];
    return bt;
}
-(void)openAgreement{
    USGameViewController *gameVC = [[USGameViewController alloc]init];
    gameVC.subtitle = @"汪卡平台注册与领用协议";
    gameVC.subUrl = kWangkaRigsterAgreement;
    [self.navigationController pushViewController:gameVC animated:YES];
}

//添加键盘bar
- (UIToolbar *)createCustomAccessoryView:(nullable SEL)action{
    if (!_customAccessoryView) {
        _customAccessoryView = [[UIToolbar alloc]initWithFrame:(CGRect){0,0,kAppWidth,40}];
        _customAccessoryView.barTintColor = HYCTColor(240, 240, 240) ;
        UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        _customAccessoryView.layer.borderWidth = 1 ;
        _customAccessoryView.layer.borderColor = [HYCTColor(244, 244, 244) CGColor];
        
        UIBarButtonItem *finish = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:action];
        NSMutableDictionary *navtitleTextAttri = [NSMutableDictionary dictionary];
        navtitleTextAttri[NSForegroundColorAttributeName] = HYCTColor(16, 129, 252);
        [finish setTitleTextAttributes:navtitleTextAttri forState:UIControlStateNormal];
        [_customAccessoryView setItems:@[space,space,finish]];
    }
    return _customAccessoryView;
}

@end
