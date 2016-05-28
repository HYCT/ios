//
//  USMySnatchView.h
//  大学生分期
//
//  Created by HeXianShan on 16/1/6.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import <UIKit/UIKit.h>
@class USMySnatchView ;
@protocol USMySnatchViewDelegate<NSObject>
@optional
-(void)didDetailClick:(USMySnatchView *)detail;
@end
@interface USMySnatchView : UIView
@property(nonatomic,strong)UILabel *snactNameLB;
@property(nonatomic,assign)CGFloat dyHeight;
@property(nonatomic,strong)id<USMySnatchViewDelegate> snatchdDelegate;
-(instancetype)initWithDic:(NSDictionary *)dic;
@end
