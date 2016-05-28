//
//  USCellTipView.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/12.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USCellTipView.h"
@interface USCellTipView()
@property(nonatomic,strong)UILabel *left1;
@property(nonatomic,strong)UILabel *left2;
@property(nonatomic,strong)UILabel *left3;
@property(nonatomic,strong)UILabel *right1;
@property(nonatomic,strong)UILabel *right2;
@property(nonatomic,strong)UILabel *right3;

@end
@implementation USCellTipView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *arrowImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"account_cell_indictor"]];
        arrowImageView.x = 60;
        arrowImageView.y = 0;
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:arrowImageView];
        UIView *contentViewBg = [[UIView alloc]initWithFrame:frame];
        _contentViewBg = contentViewBg;
        contentViewBg.y = arrowImageView.height;
        contentViewBg.x = 0;
        contentViewBg.height = 60;
        contentViewBg.backgroundColor = HYCTColor(240, 240, 240);
        //
        UILabel *left1 = [USUIViewTool createUILabelWithTitle:@"产生收益资金:" fontSize:12 color:HYCTColor(194, 194, 194) heigth:12];
        left1.frame = CGRectMake(10, 5, contentViewBg.width, 12);
        [contentViewBg addSubview:left1];
        UILabel *right1 = [USUIViewTool createUILabelWithTitle:@"￥1022.23" fontSize:12 color:HYCTColor(194, 194, 194) heigth:12];
        right1.frame = left1.frame;
        right1.width = left1.width - left1.x*2;
        right1.textAlignment = NSTextAlignmentRight;
        [contentViewBg addSubview:left1];
        [contentViewBg addSubview:right1];
        //
        UILabel *left2 = [USUIViewTool createUILabelWithTitle:@"年化:" fontSize:12 color:HYCTColor(194, 194, 194) heigth:12];
       
        left2.frame = CGRectMake(10, right1.y+right1.height+5, contentViewBg.width, 12);
        [contentViewBg addSubview:left2];
        UILabel *right2 = [USUIViewTool createUILabelWithTitle:@"9%" fontSize:12 color:HYCTColor(194, 194, 194) heigth:12];
        right2.frame = left2.frame;
        right2.width = left2.width - left2.x*2;
        right2.textAlignment = NSTextAlignmentRight;
        [contentViewBg addSubview:left2];
        [contentViewBg addSubview:right2];
        //
        UILabel *left3= [USUIViewTool createUILabelWithTitle:@"收益金额:" fontSize:12 color:HYCTColor(194, 194, 194) heigth:12];
        left3.frame = CGRectMake(10, right2.y+right2.height+5, contentViewBg.width, 12);
        [contentViewBg addSubview:left3];
        UILabel *right3 = [USUIViewTool createUILabelWithTitle:@"￥1.11" fontSize:12 color:HYCTColor(194, 194, 194) heigth:12];
        right3.frame = left3.frame;
        right3.width = left3.width - left3.x*2;
        right3.textAlignment = NSTextAlignmentRight;
        [contentViewBg addSubview:left3];
        [contentViewBg addSubview:right3];
        //
         _left1 = left1;
        _left2 = left2;
        _left3 = left3;
        _right1 = right1;
        _right2 = right2;
        _right3 = right3;
         [self addSubview:contentViewBg];
        
        self.height =contentViewBg.height+arrowImageView.height;
    }
    return  self;
}
-(instancetype)initWithFrame:(CGRect)frame dic:(NSDictionary *)dic{
    self = [self initWithFrame:frame ];
    NSArray *keys =  dic.allKeys;
    _left1.text = keys[0];
    _left2.text = keys[1];
    _left3.text = keys[2];
     _right1.text = dic[_left1.text];
     _right2.text = dic[_left2.text];
     _right3.text = dic[_left3.text];
    return self;
}
@end
