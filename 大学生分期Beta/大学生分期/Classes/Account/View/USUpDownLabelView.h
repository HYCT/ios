//
//  USUpDownLabelView.h
//  大学生分期
//
//  Created by HeXianShan on 15/8/31.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface USUpDownLabelView : UIView
@property(nonatomic,copy)NSString *upTitle;
@property(nonatomic,copy)NSString *downTitle;
@property(nonatomic,assign)NSTextAlignment textAlignment;
@property(nonatomic,strong)UILabel *upLabel;
@property(nonatomic,strong)UILabel *downLabel;
@property(nonatomic,assign)UIFont *font;
@end
