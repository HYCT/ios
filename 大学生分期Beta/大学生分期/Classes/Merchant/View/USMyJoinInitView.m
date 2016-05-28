//
//  USMyJoinInitView.m
//  大学生分期
//
//  Created by HeXianShan on 16/1/10.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import "USMyJoinInitView.h"

@implementation USMyJoinInitView

-(instancetype)initWithDic:(NSDictionary    *)dic{
    self = [super init];
    if (self) {
        _dataDic = dic;
        self.frame =CGRectMake(0, 0,kAppWidth, 100);
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 70, 100)];
        _headerImgView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 10, 50, 50)];
        _headerImgView.layer.cornerRadius = _headerImgView.height*0.5;
        _headerImgView.layer.masksToBounds = YES;
        [_headerImgView sd_setImageWithURL:[NSURL URLWithString:HYWebDataPath(_dataDic[@"customer_headpic"])]];
        [headerView addSubview:_headerImgView];
        _nameLB = [USUIViewTool createUILabelWithTitle:_dataDic[@"customer_name"] fontSize:kCommonFontSize_12 color:[UIColor blackColor] heigth:kCommonFontSize_15];
        _nameLB.textAlignment = NSTextAlignmentCenter;
        _nameLB.frame = CGRectMake(0, _headerImgView.y+_headerImgView.height+5, headerView.width, kCommonFontSize_15);
         [headerView addSubview:_nameLB];
        //发布时间
        _releaseTimeLB = [USUIViewTool createUILabelWithTitle:_dataDic[@"publish_time"] fontSize:kCommonFontSize_12 color:[UIColor blackColor] heigth:kCommonFontSize_15];
        _releaseTimeLB.textAlignment = NSTextAlignmentCenter;
        _releaseTimeLB.frame = CGRectMake(5, _nameLB.y+_nameLB.height+5, headerView.width, kCommonFontSize_15);
        [headerView addSubview:_releaseTimeLB];
        [self addSubview:headerView];
        //
         UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(72, 0, kAppWidth-72-62, 100)];
          _themeLB = [USUIViewTool createUILabelWithTitle:_dataDic[@"theme_name"] fontSize:kCommonFontSize_12 color:[UIColor blackColor] heigth:kCommonFontSize_15];
          _themeLB.frame = CGRectMake(0, 10, contentView.width, kCommonFontSize_15);
            [contentView addSubview:_themeLB];
          _addressLB = [USUIViewTool createUILabelWithTitle:_dataDic[@"invit_address"]  fontSize:kCommonFontSize_12 color:[UIColor blackColor] heigth:kCommonFontSize_15];
          _addressLB.frame = CGRectMake(0, _themeLB.y+_themeLB.height+5, contentView.width, kCommonFontSize_15);
         [contentView addSubview:_addressLB];
        _timeLB =[USUIViewTool createUILabelWithTitle:_dataDic[@"invit_time"] fontSize:kCommonFontSize_12 color:[UIColor blackColor] heigth:kCommonFontSize_15];
        _timeLB.frame = CGRectMake(0, _addressLB.y+_addressLB.height+5, contentView.width, kCommonFontSize_15);
        [contentView addSubview:_timeLB];
        _zhifuLB = [USUIViewTool createUILabelWithTitle:_dataDic[@"invit_paybill_lable"]  fontSize:kCommonFontSize_12 color:[UIColor blackColor] heigth:kCommonFontSize_15];
        _zhifuLB.frame = CGRectMake(0, _timeLB.y+_timeLB.height+5, contentView.width, kCommonFontSize_15);
        [contentView addSubview:_zhifuLB];
        [self addSubview:contentView];
        //竖线
        UIView *line = [USUIViewTool createLineView];
        line.backgroundColor = HYCTColor(168, 168, 168);
        line.frame = CGRectMake(contentView.width+contentView.x+5, kMargin, 1, self.height-2*kMargin);
        
        [self addSubview:line];
        //状态
        _stateLB = [USUIViewTool createUILabelWithTitle:_dataDic[@"join_type_lable"] fontSize:kCommonFontSize_15 color:[UIColor whiteColor] heigth:kCommonFontSize_15];
        _stateLB.frame = CGRectMake(line.x+5, line.y+(line.height-40)/2, kAppWidth-line.x-10, 40);
        _stateLB.textAlignment = NSTextAlignmentCenter;
        _stateLB.backgroundColor = HYCTColor(168, 168, 168);
        if ([_dataDic[@"type"]integerValue]==2) {
            _stateLB.backgroundColor = [UIColor redColor];
        }else if ([_dataDic[@"type"]integerValue]==1){
            _stateLB.backgroundColor = [UIColor orangeColor];
        }
        [self addSubview:_stateLB];
        line = [USUIViewTool createLineView];
        line.backgroundColor = HYCTColor(168, 168, 168);
        line.frame = CGRectMake(5, self.height+5, kAppWidth-10, 1);
        [self addSubview:line];
    }
    return  self;
}

@end
