//
//  USNearTopPersonView.h
//  大学生分期
//
//  Created by HeXianShan on 15/9/29.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^NearTopButtonClickBlock)();
@interface USNearTopPersonView : UIView
@property(nonatomic,strong)UIImageView *topBgImageView;
@property(nonatomic,strong)UIButton *personImagButton;
@property(nonatomic,strong)UIImageView *personImaView;
@property(nonatomic,strong)UILabel *nikeNameLB;
@property(nonatomic,strong)UILabel *mottoLB;
@property(nonatomic,copy)NearTopButtonClickBlock nearTopButtonClickBlock;
@property(nonatomic,assign)BOOL noMotto;
-(instancetype)initWithFrame:(CGRect)frame noMotto:(BOOL) noMotto;
-(instancetype)initWithFrame:(CGRect)frame noMotto:(BOOL) noMotto customeId:(NSString *)customeId  supervc:(UIViewController *)superVC;
@end
