//
//  USPersonZoneView.h
//  大学生分期
//
//  Created by HeXianShan on 16/1/5.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "USCircleImageView.h"
@interface USPersonZoneView : UIView
@property(nonatomic,strong)NSDictionary *dataDic;
@property(nonatomic,assign)CGFloat dyHeight;
@property(nonatomic,strong)USCircleImageView *leftImageView;
@property(nonatomic,strong)NSString *monthStr;
-(instancetype)initWithDic:(NSDictionary *)dic;
-(void)setDate:(NSString *)dateStr flag:(BOOL)flag;
@end
