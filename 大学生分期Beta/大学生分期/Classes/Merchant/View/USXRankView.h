//
//  USXRankView.h
//  大学生分期
//
//  Created by HeXianShan on 16/1/8.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "USSubXrankView.h"
@interface USXRankView : UIView
@property(nonatomic,strong)UIViewController *superVC;
@property(nonatomic,strong)NSMutableArray *subXrankViws;
@property(nonatomic,strong)NSArray *dataArray;
-(instancetype)initWithArray:(NSArray *)array superVC:(UIViewController *)superVC;
@end
