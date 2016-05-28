//
//  USNearTableViewCell.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/3.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USNearTableViewCell.h"

@implementation USNearTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.leftImgeView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 60, 60)];
        [self.contentView addSubview:self.leftImgeView];
        self.nearTitleView = [[USNearTitleView alloc]initWithFrame:CGRectMake(self.leftImgeView.x+self.leftImgeView.width+10, self.leftImgeView.height*0.15, kAppWidth, 25)];
//        self.nearRightView = [[USNeartRigthView alloc]initWithFrame:CGRectMake(kAppWidth-self.nearTitleView.x*1.2, (self.leftImgeView.height+self.leftImgeView.y)/2-self.leftImgeView.y, kAppWidth, 25)];
        [self.contentView addSubview:self.nearTitleView];
        //[self.contentView addSubview: self.nearRightView];
        //
        UIView *line = [USUIViewTool createLineView];
        _line = line;
        line.frame = CGRectMake(self.leftImgeView.x,  self.leftImgeView.height+self.nearTitleView.y+2, kAppWidth -self.leftImgeView.x*2, 1);
        line.backgroundColor = HYCTColor(227, 227, 227);
        [self.contentView addSubview:line];
    }
    return self;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier nearType:(NearType) nearType{
    self = [self initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        if (nearType ==NearType_Person) {
//        }
        self.leftImgeView.layer.cornerRadius =  self.leftImgeView.frame.size.width / 2.0;
        self.leftImgeView.clipsToBounds = YES;

    }
    return self;
}
-(UIView *)createPersonInfoView{
    return nil;
}
@end
