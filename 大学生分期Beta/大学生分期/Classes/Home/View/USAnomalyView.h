//
//  USAnomalyView.h
//  大学生分期
//
//  Created by HeXianShan on 15/9/22.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ClickBlock)();
@class USAnomalyView;
@protocol USAnomalyViewDelegate<NSObject>
@optional
-(void)didTopButtonClick:(USAnomalyView *)anomarlyView;
@end
@interface USAnomalyView : UIView
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *subTitle;
@property(nonatomic,copy)ClickBlock clickBlock;
@property(nonatomic,assign)BOOL logined;
@property(nonatomic,copy)UIButton *topbutton;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *subtitleLabel;
@property(nonatomic,assign)id<USAnomalyViewDelegate> delegate;
-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title subTitle:(NSString *)subTitle
                 bgImageName:(NSString *)bgImageName;
@end
