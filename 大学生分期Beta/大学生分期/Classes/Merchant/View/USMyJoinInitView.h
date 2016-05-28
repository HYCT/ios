//
//  USMyJoinInitView.h
//  大学生分期
//
//  Created by HeXianShan on 16/1/10.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kMargin 20
@interface USMyJoinInitView : UIView

@property(nonatomic,strong) UILabel    *releaseTimeLB;
@property(nonatomic,strong) UILabel    *themeLB;
@property(nonatomic,strong) UILabel    *addressLB;
@property(nonatomic,strong) UILabel    *dateLB;
@property(nonatomic,strong) UILabel    *zhifuLB;
@property(nonatomic,strong) UILabel    *descLB;
@property(nonatomic,strong) UILabel    *stateLB;
@property(nonatomic,strong) UIImageView *headerImgView;
@property(nonatomic,strong) UILabel *timeLB;
@property(nonatomic,strong) UILabel *nameLB;
@property(nonatomic,strong) NSDictionary *dataDic;
-(instancetype)initWithDic:(NSDictionary    *)dic;

@end

