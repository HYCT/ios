//
//  USUSTryCacluteRebackPlanViewCell.h
//  大学生分期
//
//  Created by HeXianShan on 15/10/26.
//  Copyright © 2015年 hongyunct. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface USUSTryCacluteRebackPlanViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *perCountLB;
@property(nonatomic,strong)UILabel *montoRebackLB;
@property(nonatomic,strong)UILabel *freeLB;
@property(nonatomic,strong)UILabel *monthTotalRebackLB;
@property(nonatomic,strong)UILabel *limitDateLB;
-(void)setDataWithDic:(NSDictionary *)dataDic;
@end
