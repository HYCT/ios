//
//  USSegmentView.h
//  大学生分期
//
//  Created by HeXianShan on 15/9/24.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ClickBlock)(NSInteger);
@interface USSegmentView : UIView
-(instancetype)initWithTitles:(NSArray *)titles frame:(CGRect)frame;
@property(nonatomic,assign)  NSInteger selectedIndex;
@property(nonatomic,copy)ClickBlock clickBlock;
@end
