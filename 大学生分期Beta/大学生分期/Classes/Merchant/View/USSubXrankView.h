//
//  USSubXrankView.h
//  大学生分期
//
//  Created by HeXianShan on 16/1/8.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ClickBlock)();
@interface USSubXrankView : UIView
-(instancetype)initWithDic:(NSDictionary *)dic;
@property(nonatomic,copy)ClickBlock clickBlock;
@property(nonatomic,strong) UIImageView *topImageView;
@property(nonatomic,strong) UILabel *nameLB;
@property(nonatomic,strong) UILabel *seqLB;
@property(nonatomic,strong) UILabel *zangCountLB;
@end
