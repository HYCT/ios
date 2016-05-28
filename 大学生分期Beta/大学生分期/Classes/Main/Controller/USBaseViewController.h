//
//  USBaseViewController.h
//  大学生分期
//
//  Created by HeXianShan on 15/9/2.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import <UIKit/UIKit.h>
@class USGameViewController;
@interface USBaseViewController : UIViewController
@property (nonatomic, strong) UIToolbar *customAccessoryView;
-(void)initLeftItemBar;
- (void)pop;
-(UIButton *)createAgreementBt;
//添加键盘bar
- (UIToolbar *)createCustomAccessoryView:(nullable SEL)action;

@end
