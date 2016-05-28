//
//  USSnatchContentView.h
//  大学生分期
//
//  Created by HeXianShan on 16/1/6.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "USSubSnatchView.h"
@interface USSnatchContentView : UIView
@property(nonatomic,strong)USSubSnatchView *leftView;
@property(nonatomic,strong)USSubSnatchView *rightView;
@property(nonatomic,assign)CGFloat dyHeight;
@property(nonatomic,strong)UIViewController *superVC;
-(instancetype)initWithArray:(NSArray *)array superVC:(UIViewController *)superVC;
@end
