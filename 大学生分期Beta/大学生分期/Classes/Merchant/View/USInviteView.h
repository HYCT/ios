//
//  USInviteView.h
//  大学生分期
//
//  Created by HeXianShan on 16/1/9.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface USInviteView : UIView
@property(nonatomic,assign)CGFloat dyHeight;
@property(nonatomic,strong)UIViewController *superVC;
-(instancetype)initWithDic:(NSDictionary *)dic superVC:(UIViewController *)superVC;
@end
