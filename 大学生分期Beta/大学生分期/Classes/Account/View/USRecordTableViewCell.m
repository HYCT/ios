//
//  USRecordTableViewCell.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/5.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USRecordTableViewCell.h"
#define kWidth kAppWidth/3-20
@interface USRecordTableViewCell()
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *amountLabel;
@property(nonatomic,strong)UILabel *dateLabel;
@end
@implementation USRecordTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _nameLabel = [self createTitleLabel:@""];
        [self.contentView addSubview:_nameLabel];
        _amountLabel = [self createTitleLabel:@""];
        _amountLabel.x = kWidth+20;
        [self.contentView addSubview:_amountLabel];
        _dateLabel = [self createTitleLabel:@""];
        _dateLabel.x = _amountLabel.x+kWidth+20;
        [self.contentView addSubview:_dateLabel];
    }
    return  self;
}

-(UILabel *)createTitleLabel:(NSString *)title{
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, kAppWidth/3-20, 15)];
    titleLabel.y = titleLabel.height-5;
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setText:title];
    [titleLabel setFont:[UIFont systemFontOfSize:13]];
    [titleLabel setTextColor:HYCTColor(160, 160, 160)];
    return titleLabel;
}
-(void)setName:(NSString *)name amount:(NSString *)amount date:(NSString *)date{
    [_nameLabel setText:name];
    [_amountLabel setText:amount];
    
    CGSize size = [date sizeWithFont:_dateLabel.font constrainedToSize:CGSizeMake(kWidth,MAXFLOAT)lineBreakMode:UILineBreakModeWordWrap];
    _dateLabel.numberOfLines = 0;
    _dateLabel.width = size.width;
    _dateLabel.height = size.height;
    _dateLabel.y = 0;
    [_dateLabel setText:date];
}
@end
