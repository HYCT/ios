//
//  USUSTryCacluteRebackPlanViewCell.m
//  大学生分期
//
//  Created by HeXianShan on 15/10/26.
//  Copyright © 2015年 hongyunct. All rights reserved.
//

#import "USUSTryCacluteRebackPlanViewCell.h"
#define kPadding 2
@implementation USUSTryCacluteRebackPlanViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *perCountLB = [self createUILable:@"期数" width:40];
        _perCountLB = perCountLB;
        perCountLB.frame = CGRectMake(-5, 0,40, 40);
        perCountLB.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:perCountLB];
        //
        UILabel *montoRebackLB = [self createUILable:@"月还本金" width:70];
        _montoRebackLB = montoRebackLB;
        montoRebackLB.frame = CGRectMake(perCountLB.x+perCountLB.width+kPadding, 0,70, 40);
        montoRebackLB.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:montoRebackLB];
        //
        UILabel *freeLB = [self createUILable:@"手续费" width:50];
        _freeLB = freeLB;
        freeLB.frame = CGRectMake(montoRebackLB.x+montoRebackLB.width+kPadding, 0,50, 40);
        freeLB.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:freeLB];
        //
        UILabel *monthTotalRebackLB = [self createUILable:@"月还总额" width:70];
        _monthTotalRebackLB = monthTotalRebackLB;
        monthTotalRebackLB.frame = CGRectMake(freeLB.x+freeLB.width+kPadding, 0,70, 40);
        monthTotalRebackLB.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:monthTotalRebackLB];
        //
        UILabel *limitDateLB = [self createUILable:@"月还总额" width:90];
        _limitDateLB = limitDateLB;
        limitDateLB.frame = CGRectMake(monthTotalRebackLB.x+monthTotalRebackLB.width+kPadding, 0,90, 40);
        limitDateLB.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:limitDateLB];
    }
    return self;
}

-(UILabel *)createUILable:(NSString *)title width:(CGFloat) width{
    UILabel *uiLB = [USUIViewTool createUILabelWithTitle:title fontSize:kCommonFontSize_15 color:HYCTColor(84, 84, 84) heigth:40];
    uiLB.width = width;
    uiLB.x = 0;
    uiLB.y = 0;
    return uiLB;
}
-(void)setDataWithDic:(NSDictionary *)dataDic{
    _perCountLB.text = [dataDic[@"month"]stringValue];
    _montoRebackLB.text = dataDic[@"repaymoney"];
    _freeLB.text = dataDic[@"repaymoney_rate"];
    _monthTotalRebackLB.text = dataDic[@"repay_sum_money"];
    _limitDateLB.text = dataDic[@"repaytimeformat"];
}
@end
