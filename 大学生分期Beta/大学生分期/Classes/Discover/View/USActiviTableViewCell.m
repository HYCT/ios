//
//  USActiviTableViewCell.m
//  大学生分期
//
//  Created by HeXianShan on 15/10/28.
//  Copyright © 2015年 hongyunct. All rights reserved.
//

#import "USActiviTableViewCell.h"

@implementation USActiviTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    _activiImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, kAppWidth-10, 120)];
    [self.contentView addSubview:_activiImageView];
    
    return self;
}

@end
