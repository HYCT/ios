//
//  USGridCellView.h
//  大学生分期
//
//  Created by HeXianShan on 15/9/1.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol USGridCellViewDelegate<NSObject>
@optional
-(void)didClickItem:(UIButton *)sender;
@end
@interface USGridCellView : UIView
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *imageName;
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,assign)id<USGridCellViewDelegate> delegate;
@property(nonatomic,strong)UILabel *titelLabel;
-(void)settitleColor:(UIColor *)titleColor;
@end
