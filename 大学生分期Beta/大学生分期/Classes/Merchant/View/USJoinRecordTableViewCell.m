//
//  USRecordTableViewCell.m
//  大学生分期
//
//  Created by HeXianShan on 16/1/6.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import "USJoinRecordTableViewCell.h"

@implementation USJoinRecordTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.y = 0;
        self.contentView.y = 0;
        _headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 50, 50)];
        _headerImageView.layer.cornerRadius = _headerImageView.height*0.5;
        _headerImageView.layer.masksToBounds = YES;
        _headerImageView.image= [UIImage imageNamed:@"near_table_cell_person_img"];
        [self.contentView addSubview:_headerImageView];
        //
        _nameLB = [USUIViewTool createUILabelWithTitle:@"飞飞" fontSize:kCommonFontSize_12 color:HYCTColor(65, 117, 246) heigth:kCommonFontSize_12];
        _nameLB.frame = CGRectMake(_headerImageView.x+_headerImageView.width+5, 5, kAppWidth-_headerImageView.x-_headerImageView.width-5, kCommonFontSize_12);
        [self.contentView addSubview:_nameLB];
        //
        _timeLB = [USUIViewTool createUILabelWithTitle:@"2016-01-06 11:03" fontSize:kCommonFontSize_12 color:[UIColor grayColor] heigth:kCommonFontSize_12];
        _timeLB.frame = CGRectMake(_headerImageView.x+_headerImageView.width+5, _nameLB.height+_nameLB.y+5, kAppWidth-_headerImageView.x-_headerImageView.width-5, kCommonFontSize_12);
        [self.contentView addSubview:_timeLB];
        //
        _tipLB = [USUIViewTool createUILabelWithTitle:@"参与了本次夺宝" fontSize:kCommonFontSize_12 color:[UIColor blackColor] heigth:kCommonFontSize_12];
        _tipLB.frame = CGRectMake(_headerImageView.x+_headerImageView.width+5, _timeLB.height+_timeLB.y+5, kAppWidth-_headerImageView.x-_headerImageView.width-5, kCommonFontSize_12);
        [self.contentView addSubview:_tipLB];
        UIView *line = [USUIViewTool createLineView];
        line.frame = CGRectMake(0, _timeLB.height+_tipLB.y+10, kAppWidth, 1);
        line.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:line];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
