//
//  USSayHelloTableCell.m
//  大学生分期
//
//  Created by mac on 16/2/22.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import "USCommentTableCell.h"

@implementation USCommentTableCell
-(instancetype)initWithData:(NSDictionary *)data {
    self =[super init] ;
    if (self) {
        //默认头像
        _headPic = [UIImage imageNamed:@"near_table_cell_person_img"];
        self.frame = CGRectMake(0, 0, kAppWidth, 0);
        //头像
        self.leftImgeView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 40, 40)];
        self.leftImgeView.layer.cornerRadius =  self.leftImgeView.frame.size.width / 2.0;
        self.leftImgeView.clipsToBounds = YES;
        [self addSubview:self.leftImgeView];
        self.height =_leftImgeView.y+_leftImgeView.height ;
        if (data[@"headpic"]!=nil&&[NSNull null]!=data[@"headpic"]) {
            [_leftImgeView sd_setImageWithURL:[NSURL URLWithString:HYWebDataPath(data[@"headpic"])]];
        }else{
            _leftImgeView.image = _headPic;
        }
        //账户名称
        self.nameLabel = [USUIViewTool createUILabelWithTitle:data[@"customername"] fontSize:14 color:[UIColor blackColor]  heigth:20];
        self.nameLabel.frame=CGRectMake(self.leftImgeView.x+self.leftImgeView.width +10, self.leftImgeView.y + 2, 100, 20)  ;
        [self addSubview:self.nameLabel];
        
        //日期
        self.dateLabel =[USUIViewTool createUILabelWithTitle:data[@"comment_time"] fontSize:14 color:[UIColor grayColor]  heigth:0];
        self.dateLabel.frame=CGRectMake(self.nameLabel.x, self.nameLabel.y+self.nameLabel.height, 120, 20)  ;
        [self addSubview:self.dateLabel] ;
        
        //评论内容宽度
        CGFloat contentWidth = self.width-_dateLabel.x-5 ;
        //评论内容
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(_dateLabel.x, self.leftImgeView.y +self.leftImgeView.height+2, contentWidth, 0)];
        NSString *text = @"这是一个测试！！！adsfsaf时发生发勿忘我勿忘我勿忘我勿忘我勿忘我阿阿阿阿阿阿阿阿阿阿阿阿阿啊00000000阿什顿eeeeee";
        
        text=data[@"content"] ;
        
        self.contentLabel.text = text;
        [self.contentLabel setNumberOfLines:0];
        [self.contentLabel setTextColor:[UIColor grayColor]];
        [_contentLabel setFont:[UIFont systemFontOfSize:14]] ;
        [_contentLabel setLineBreakMode:NSLineBreakByTruncatingTail] ;
        CGSize maximumLabelSize = CGSizeMake(contentWidth, 9999);//labelsize的最大值
        //关键语句
        CGSize expectSize = [_contentLabel sizeThatFits:maximumLabelSize];
        _contentLabel.frame = CGRectMake(_dateLabel.x,self.leftImgeView.y +self.leftImgeView.height+2 , contentWidth, expectSize.height);
        [self addSubview:_contentLabel];
        self.height = _contentLabel.y+_contentLabel.height  ;
        
        //线条
        UIView *line = [USUIViewTool createLineView];
        _line = line;
        line.frame = CGRectMake(5, self.contentLabel.y+ self.contentLabel.height+5, kAppWidth -10, 1);
        line.backgroundColor = HYCTColor(227, 227, 227);
        self.height = _line.y+_line.height +10;
        [self addSubview:line];
    }
    return self;
}


@end
