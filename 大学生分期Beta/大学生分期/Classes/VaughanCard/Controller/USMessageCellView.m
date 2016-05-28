//
//  USMessageCellView.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/12.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USMessageCellView.h"
@interface USMessageCellView()
@property(nonatomic,assign)CGFloat height ;
@end

@implementation USMessageCellView
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier data:(NSDictionary *)data{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    _height = 0 ;
    if (self) {
        //标题
        self.titleLabel = [USUIViewTool createUILabelWithTitle:data[@"title"] fontSize:14 color:[UIColor blackColor]  heigth:22];
        self.titleLabel.frame=CGRectMake(10, 5, self.contentView.width-160, 22)  ;
        [self.contentView addSubview:self.titleLabel];
        _height =   _titleLabel.height + 5 ;
        //日期
        self.dateLabel =[USUIViewTool createUILabelWithTitle:data[@"message_time_label"] fontSize:12 color:[UIColor grayColor]  heigth:22];
        self.dateLabel.frame=CGRectMake(self.titleLabel.x+self.titleLabel.width +5 , self.titleLabel.y, 120, 22)  ;
        self.dateLabel.textAlignment = UITextAlignmentRight ;
        [self.contentView addSubview:self.dateLabel] ;
        //消息内容
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLabel.x, self.titleLabel.y +self.titleLabel.height+5, kAppWidth - 20 , 0)];
        [_contentLabel setTextColor:[UIColor grayColor]] ;
        NSString *text = data[@"content"] ;
        UIFont *font = [UIFont systemFontOfSize:14];
        [USUIViewTool setTextHeight:_contentLabel width:self.contentLabel.width content:text font:font] ;
        
        [self.contentView addSubview:self.contentLabel];
        _height = _height +_contentLabel.height+5 ;
        //线条
        UIView *line = [USUIViewTool createLineView];
        _line = line;
        line.frame = CGRectMake(self.contentLabel.x, self.contentLabel.y+ self.contentLabel.height+10, self.contentLabel.width, 1);
        line.backgroundColor = HYCTColor(227, 227, 227);
        _height = _height + _line.height + 10 ;
        self.contentView.height = _height ;
        [self.contentView addSubview:line];
    }
    return self;
}
@end
