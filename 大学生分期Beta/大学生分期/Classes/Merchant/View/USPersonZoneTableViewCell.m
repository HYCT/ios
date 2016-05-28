//
//  USPersonZoneTableViewCell.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/29.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USPersonZoneTableViewCell.h"
#define kMargin 15
@interface USPersonZoneTableViewCell()
@property(nonatomic,strong)UILabel *dateLB;
@property(nonatomic,strong)UILabel *massegeLB;
@property(nonatomic,strong)UIImageView *leftImageView;
@end
@implementation USPersonZoneTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat margin = 10;
        _dateLB = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 50, 30)];
        _dateLB.textAlignment = NSTextAlignmentLeft;
        _dateLB.textColor = HYCTColor(30, 30, 30);
        _dateLB.text = @"今天";
        [self.contentView addSubview:_dateLB];
        //
        UIView *bgView = [[UIView alloc]init];
        bgView.backgroundColor = HYCTColor(240, 240, 240);
        bgView.frame = CGRectMake(_dateLB.width+_dateLB.x, 0, kAppWidth-_dateLB.width-kMargin, 100);
        ////
        _leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(margin, margin, bgView.height-margin*2, bgView.height-margin*2)];
        _leftImageView.image = [UIImage imageNamed:@"2.jpg"];
        [bgView addSubview:_leftImageView];
        ////
        _massegeLB = [[UILabel alloc]initWithFrame:_leftImageView.frame];
        _massegeLB.x = _leftImageView.width+margin*2;
        _massegeLB.textColor = HYCTColor(10, 10, 10);
        _massegeLB.numberOfLines = 0;
        NSString *title = @"听说，“星巴克，是一家以咖啡店为主题的照相馆；肯德基麦当劳，是以快餐店为主题的公共厕所；学校，是一所以学习为主题的婚姻介绍所。” 好像没什么不对...";
        CGSize size = CGSizeMake(bgView.width-_leftImageView.width-_leftImageView.x-margin*2, _massegeLB.height);
        _massegeLB.font = [UIFont systemFontOfSize:10];
        CGSize labelsize = [title sizeWithFont: _massegeLB.font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
        _massegeLB.text = title;
        _massegeLB.size = labelsize;
        [bgView addSubview:_massegeLB];
        [self.contentView addSubview:bgView];
        UIView *bottomView = [[UIView alloc]init];
        bottomView.frame = CGRectMake(kMargin, bgView.height, kAppWidth-2*kMargin, 10);
        bottomView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:bottomView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}
-(void)setDate:(NSString *)dateStr flag:(BOOL)flag{
    if (flag) {
        _dateLB.text = dateStr;
        _dateLB.font = [UIFont systemFontOfSize:20];
    }else{
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:dateStr];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, 2)];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(2, str.length-2)];
        _dateLB.attributedText = str;
    }
}
@end
