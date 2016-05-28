//
//  USSayHelloTableCell.m
//  大学生分期
//
//  Created by mac on 16/2/22.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import "USCashierTableCell.h"

@implementation USCashierTableCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
        //账户名称
        //self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.leftImgeView.x+self.leftImgeView.width +10, self.leftImgeView.y + (self.leftImgeView.height-22)/2, 100, 22) ] ;
        self.nameLabel = [USUIViewTool createUILabelWithTitle:@"账户" fontSize:14 color:[UIColor blackColor]  heigth:22];
        self.nameLabel.frame=CGRectMake( 20, 10, kAppWidth-40, 22)  ;
        [self.contentView addSubview:self.nameLabel];
        
        
        //线条
        UIView *line = [USUIViewTool createLineView];
        line.frame = CGRectMake(_nameLabel.x, _nameLabel.y + _nameLabel.height+10, _nameLabel.width,1);
        line.backgroundColor = HYCTColor(227, 227, 227);
        
        [self.contentView addSubview:line];
    }
    return self;
}

@end
