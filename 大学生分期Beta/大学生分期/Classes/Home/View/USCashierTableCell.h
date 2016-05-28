//
//  USSayHelloTableCell.h
//  大学生分期
//
//  Created by mac on 16/2/22.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface USCashierTableCell : UITableViewCell
//收银员名称
@property(nonatomic,strong)UILabel *nameLabel;


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
