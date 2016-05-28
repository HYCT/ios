//
//  USAccountHistoryView.h
//  大学生分期
//
//  Created by HeXianShan on 15/8/31.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "USUpDownLabelView.h"
@protocol USAccountHistoryViewDelegate<NSObject>
@optional
-(void)didLeftClick:(UIButton *)button;
-(void)didRightClick:(UIButton *)button;
@end
@interface USAccountHistoryView : UIView
@property(nonatomic,strong) USUpDownLabelView *leftView;
@property(nonatomic,strong) USUpDownLabelView *rightView;
@property(nonatomic,assign)id<USAccountHistoryViewDelegate> delegate;
@end
