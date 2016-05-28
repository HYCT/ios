//
//  USMyAskTableViewCell.h
//  大学生分期
//
//  Created by HeXianShan on 15/9/3.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface USMyAskTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *nameLB;
@property(nonatomic,strong)UILabel *awardLB;
@property(nonatomic,strong)UIImageView *registerImageView;
@property(nonatomic,strong)UIImageView *identiyImageView;
-(void)setDataWithDic:(NSDictionary *)dataDic;
@end
/*
 @property(nonatomic,strong)UILabel *titleLabel;
 @property(nonatomic,strong)UILabel *subTitleLabel;
 @property(nonatomic,strong)UILabel *detailTitleLabel;
*/