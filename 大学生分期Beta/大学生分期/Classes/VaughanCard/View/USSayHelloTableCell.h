//
//  USSayHelloTableCell.h
//  大学生分期
//
//  Created by mac on 16/2/22.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import <Foundation/Foundation.h>
//打招呼啊表单
@interface USSayHelloTableCell : UITableViewCell
//头像
@property(nonatomic,strong)UIImageView *leftImgeView;
//账户名称
@property(nonatomic,strong)UILabel *nameLabel;
//日期
@property(nonatomic,strong)UILabel *dateLabel;
//打招呼内容
@property(nonatomic,strong)UILabel *contentLabel;
//横线
@property(nonatomic,strong)UIView *line ;


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
