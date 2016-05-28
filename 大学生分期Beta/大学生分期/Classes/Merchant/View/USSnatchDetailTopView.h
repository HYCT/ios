//
//  USSnatchDetailTopView.h
//  大学生分期
//
//  Created by HeXianShan on 16/1/6.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface USSnatchDetailTopView : UIView
@property(nonatomic,strong) UIImageView *topImageView;
@property(nonatomic,strong) UILabel *nameLB;
@property(nonatomic,strong) UILabel *subTitleLB;
@property(nonatomic,strong) UILabel *progressLB;
@property(nonatomic,strong) UIProgressView *progressView;
@property(nonatomic,assign)CGFloat dyHeight;
@property(nonatomic,strong)UIButton *toDetailBt;
//-(instancetype)initWithFrame:(CGRect)frame dataDic:(NSDictionary *)dataDic;
-(void)setDataDic:(NSDictionary *)dataDic;
@end
