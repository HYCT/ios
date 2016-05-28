//
//  USSayHelloTableCell.m
//  大学生分期
//
//  Created by mac on 16/2/22.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import "USSayHelloTableCell.h"
#import "USNearProfZoneViewController.h"

@implementation USSayHelloTableCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //头像
        self.leftImgeView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 40, 40)];
        self.leftImgeView.layer.cornerRadius =  self.leftImgeView.frame.size.width / 2.0;
        self.leftImgeView.clipsToBounds = YES;
        [self.contentView addSubview:self.leftImgeView];
        //账户名称
        //self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.leftImgeView.x+self.leftImgeView.width +10, self.leftImgeView.y + (self.leftImgeView.height-22)/2, 100, 22) ] ;
        self.nameLabel = [USUIViewTool createUILabelWithTitle:@"账户" fontSize:14 color:[UIColor blackColor]  heigth:22];
        self.nameLabel.frame=CGRectMake(self.leftImgeView.x+self.leftImgeView.width +10, self.leftImgeView.y + (self.leftImgeView.height-22)/2, 100, 22)  ;
        [self.contentView addSubview:self.nameLabel];
        
        //日期
        self.dateLabel =[USUIViewTool createUILabelWithTitle:@"2016-01-01" fontSize:12 color:[UIColor grayColor]  heigth:22];
        self.dateLabel.frame=CGRectMake(self.nameLabel.width + self.nameLabel.x+10, self.nameLabel.y, self.contentView.width-self.leftImgeView.width -self.nameLabel.width-40, 22)  ;
        self.dateLabel.textAlignment = UITextAlignmentRight ;
        [self.contentView addSubview:self.dateLabel] ;
        //打招呼啊内容
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.leftImgeView.x + self.leftImgeView.width/2, self.leftImgeView.y +self.leftImgeView.height+5, self.contentView.width, 20)];
        NSString *text = @"这是一个测试！！！adsfsaf时发生发勿忘我勿忘我勿忘我勿忘我勿忘我阿阿阿阿阿阿阿阿阿阿阿阿阿啊00000000阿什顿。。。";
        
        self.contentLabel.text = text;
        
        [self.contentLabel setNumberOfLines:0];
        [self.contentLabel setTextColor:[UIColor grayColor]];
        UIFont *font = [UIFont systemFontOfSize:12];
        CGSize constraint = CGSizeMake(300, 20000.0f);
        CGSize size = [text sizeWithFont:font constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
        [self.contentLabel setFrame:CGRectMake(self.leftImgeView.x + self.leftImgeView.width/2, self.leftImgeView.y+self.leftImgeView.height +5, self.contentView.width, size.height)];
        [self.contentView addSubview:self.contentLabel];
        //线条
        UIView *line = [USUIViewTool createLineView];
        _line = line;
        line.frame = CGRectMake(self.leftImgeView.x, self.contentLabel.y+ self.contentLabel.height+5, kAppWidth -self.leftImgeView.x*2, 1);
        line.backgroundColor = HYCTColor(227, 227, 227);
        
        
        [self.contentView addSubview:line];
    }
    return self;
}

@end
