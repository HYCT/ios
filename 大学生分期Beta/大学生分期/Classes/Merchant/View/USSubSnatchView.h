//
//  USSubSnatchView.h
//  大学生分期
//
//  Created by HeXianShan on 16/1/6.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ClickBlock)();
@interface USSubSnatchView : UIView
@property(nonatomic,strong) UIImageView *topImageView;
@property(nonatomic,strong) UILabel *nameLB;
@property(nonatomic,strong) NSDictionary *dataDic;
@property(nonatomic,strong) UILabel *subTitleLB;
@property(nonatomic,strong) UILabel *progressLB;
@property(nonatomic,strong) UIProgressView *progressView;
@property(nonatomic,assign)CGFloat dyHeight;
@property(nonatomic,copy)ClickBlock clickBlock;
@property(nonatomic,strong)UIButton *toDetailBt;
-(instancetype)initWithDic:(NSDictionary *)dic;
@end
