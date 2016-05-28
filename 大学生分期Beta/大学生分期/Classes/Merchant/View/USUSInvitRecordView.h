//
//  USUSInvitRecordView.h
//  大学生分期
//
//  Created by HeXianShan on 16/1/10.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface USUSInvitRecordView : UIView
@property(nonatomic,strong) UIImageView *headerImgView;
@property(nonatomic,strong) UILabel *timeLB;
@property(nonatomic,strong) UILabel *nameLB;
@property(nonatomic,strong) UILabel *telLB;
@property(nonatomic,strong) NSDictionary *dataDic;
-(instancetype)initWithDic:(NSDictionary    *)dic;
@end
