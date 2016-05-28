//
//  USImageButton.h
//  大学生分期
//
//  Created by HeXianShan on 16/1/4.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ClickBlock)();
@interface USImageButton : UIView
@property(nonatomic,copy)ClickBlock clickBlock;
@property(nonatomic,strong) UIButton *topBt;
@property(nonatomic,strong) UILabel *titleLB;
-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title imageName:(NSString *)imageNmae;
@end
