//
//  USVUpImagDownTitleView.h
//  大学生分期
//
//  Created by HeXianShan on 16/1/8.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ClickBlock)();
@interface USVUpImagDownTitleView : UIView
@property(nonatomic,strong)UIImageView *vtopImageView;
@property(nonatomic,strong)UILabel *downTitle;
@property(nonatomic,copy)ClickBlock clickBlock;
-(instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)imageName downTitle:(NSString *)downTitle;
@end
