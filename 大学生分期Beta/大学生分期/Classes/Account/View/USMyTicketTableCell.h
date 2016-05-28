//
//  USSayHelloTableCell.h
//  大学生分期
//
//  Created by mac on 16/2/22.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import <Foundation/Foundation.h>
//打招呼啊表单
@interface USMyTicketTableCell : UITableViewCell
//券名称
@property(nonatomic,strong)UILabel *titleLabel;
//金额
@property(nonatomic,strong)UILabel *moneyLabel;
//日期
@property(nonatomic,strong)UILabel *dateLabel;
//券类型名称
@property(nonatomic,strong)UILabel *typeLabel ;
//背景图
@property(nonatomic,strong)UIImageView *imgBgView ;



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier ;
/**
 设值
 **/
-(void)setData:(NSDictionary *)data;
@end
