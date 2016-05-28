//
//  USMessageCellView.h
//  大学生分期
//
//  Created by HeXianShan on 15/9/12.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface USMessageCellView : UITableViewCell
//标题
@property(nonatomic,strong)UILabel *titleLabel;
//日期
@property(nonatomic,strong)UILabel *dateLabel;
//内容
@property(nonatomic,strong)UILabel *contentLabel;
//横线
@property(nonatomic,strong)UIView *line ;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier data:(NSDictionary *)data ;
@end
