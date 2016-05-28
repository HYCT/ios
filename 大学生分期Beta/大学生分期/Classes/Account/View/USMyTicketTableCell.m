//
//  USSayHelloTableCell.m
//  大学生分期
//
//  Created by mac on 16/2/22.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import "USMyTicketTableCell.h"
#import "USNearProfZoneViewController.h"

@implementation USMyTicketTableCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGFloat height=120 ;
        
        UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kAppWidth, height) ];
        [self.contentView addSubview:bgview] ;
       
        
        UIImage *img = [UIImage imageNamed:@"ticket_unanble"] ;
        
        _imgBgView = [[UIImageView alloc] initWithImage:img] ;
        [_imgBgView setFrame:CGRectMake(10, 5, bgview.width-20, bgview.height - 10)] ;
        [bgview addSubview:_imgBgView] ;
        
        CGFloat labelHeight = 22 ;
        
        UILabel *label = [USUIViewTool createUILabelWithTitle:@"¥" fontSize:kCommonFontSize_14 color:[UIColor whiteColor] x:_imgBgView.x + 5 y:_imgBgView.y + 20 width:10 heigth:labelHeight] ;
        
        [bgview addSubview:label] ;
        
        //金额
        _moneyLabel = [USUIViewTool createUILabelWithTitle:@"0.00" fontSize:kCommonFontSize_30 color:[UIColor whiteColor] heigth:kCommonFontSize_30] ;
        _moneyLabel.frame=CGRectMake(label.x+label.width+5, label.y-10, kAppWidth - label.x-label.width, kCommonFontSize_30) ;
        [bgview addSubview:_moneyLabel] ;
        
        
        //券名称
        _titleLabel = [USUIViewTool createUILabelWithTitle:@"服务费抵用券0" fontSize:kCommonFontSize_14 color:[UIColor whiteColor]  heigth:labelHeight];
        self.titleLabel.frame=CGRectMake(label.x, _moneyLabel.y + _moneyLabel.height +5, kAppWidth-label.x-label.width,labelHeight)  ;
        [bgview addSubview:self.titleLabel];
        
        
        label = [USUIViewTool createUILabelWithTitle:@"有效期至：" fontSize:kCommonFontSize_14 color:[UIColor whiteColor] x:_titleLabel.x  y:_titleLabel.y + _titleLabel.height + 5 width:70 heigth:labelHeight] ;
        [bgview addSubview:label] ;
        //日期
        _dateLabel = [USUIViewTool createUILabelWithTitle:@"日期" fontSize:14 color:[UIColor whiteColor] heigth:labelHeight] ;
        [_dateLabel setFrame:CGRectMake(label.x+label.width +5, label.y, 100, labelHeight)] ;
        [bgview addSubview:_dateLabel] ;
        
        
        //券类型
        
        _typeLabel =[USUIViewTool createUILabelWithTitle:@"现金券" fontSize:kCommonFontSize_20 color:[UIColor whiteColor] x:_imgBgView.width-1*_imgBgView.x-30 y:_imgBgView.y width:30 heigth:_imgBgView.height] ;
        _typeLabel.numberOfLines =[_typeLabel.text length] ;
        [bgview addSubview:_typeLabel] ;
        
        
    }
    return self;
}

/**
 设值
 **/
-(void)setData:(NSDictionary *)data{
    
    NSString *code = data[@"code"] ;
    NSString *used = [NSString stringWithFormat:@"%@",data[@"used"]] ;
    UIImage *img = nil ;
    if ([@"1" isEqualToString:used]) {
        img = [UIImage imageNamed:@"ticket_unanble"] ;
    }else{
        if([@"code_cash" isEqualToString:code] ){
            img = [UIImage imageNamed:@"ticket_xjq"] ;
        }
        if([@"code_full" isEqualToString:code] ){
            img = [UIImage imageNamed:@"ticket_mjq"] ;
        }
        if([@"code_fee" isEqualToString:code] ){
            img = [UIImage imageNamed:@"ticket_dkq"] ;
        }
    }

    _imgBgView.image = img ;
    _titleLabel.text = data[@"name"] ;
    _dateLabel.text = data[@"ticket_time"] ;
    _moneyLabel.text = data[@"money"] ;
    _typeLabel.text = data[@"type_name"] ;
}


@end
