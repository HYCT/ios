//
//  USBankCardCell.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/9.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USBankCardCell.h"
#define kMargin 10
#define kDeta  5
@interface USBankCardCell()
@property(nonatomic,strong)UILabel *bankNameLB;
@property(nonatomic,copy)UILabel *cardTypeLB;
@property(nonatomic,copy)UILabel *cardIdLB;
@property(nonatomic,copy)UILabel *cardManLB;
@end
@implementation USBankCardCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
         self.accessoryType = UITableViewCellAccessoryNone;
        [self setBackgroundColor:[UIColor clearColor]];
        [self.contentView setBackgroundColor:[UIColor clearColor]];
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kAppWidth-kMargin*2, 120)];
        view.layer.cornerRadius = kDeta;
        view.layer.masksToBounds = YES;
        [view setBackgroundColor:HYCTColor(14, 172, 212)];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"account_bank_bg_img"]];
     
       [view addSubview:imageView];
       //
        _bankNameLB = [self createUILabelWithTitle:@"中国建设银行" fontSize:kCommonFontSize_15 color: [UIColor whiteColor] heigth:kCommonFontSize_15];
        [view addSubview:_bankNameLB];
        //
        _cardTypeLB = [self createUILabelWithTitle:@"借记卡" fontSize:kCommonFontSize_15*0.75 color: [UIColor blackColor] heigth:kCommonFontSize_15*0.75];
        _cardTypeLB.y = _bankNameLB.y+_bankNameLB.height+kMargin;
        [view addSubview:_cardTypeLB];
        //
        _cardIdLB = [self createUILabelWithTitle:@"**** **** **** 8863" fontSize:kCommonFontSize_29 color: [UIColor whiteColor] heigth:kCommonFontSize_30];
        _cardIdLB.y = _cardTypeLB.y+_cardTypeLB.height+kMargin+kDeta;
        _cardIdLB.textAlignment = NSTextAlignmentRight;
        
        [view addSubview:_cardIdLB];
        //
        _cardManLB = [self createUILabelWithTitle:@"李晓" fontSize:kCommonFontSize_15*0.75 color: [UIColor blackColor] heigth:kCommonFontSize_15*0.75];
        _cardManLB.y = view.height-_cardManLB.height- kMargin;
        [view addSubview:_cardManLB];
       [self.contentView addSubview:view];
        
    }
    return self;
}
-(UILabel*)createUILabelWithTitle:(NSString *)title fontSize:(CGFloat)size color:(UIColor *)color heigth:(CGFloat)heigth{
    UILabel *label = [USUIViewTool createUILabel];
    label.frame = CGRectMake(kMargin, kMargin, kAppWidth-kMargin*4, heigth);
    [label setFont:[UIFont systemFontOfSize:size]];
    [label setTextColor:color];
    label.text = title;
    return label;
}
-(void)setDateWithDic:(NSDictionary *)data{
    _bankNameLB.text = data[@"bank_name"];
#warning 银行卡类型没有
    _cardTypeLB.text = @"借记卡";
    _cardIdLB.text = [USStringTool getBankCardNoString:data[@"card_num"]];
    _cardManLB.text = data[@"name"];
}
@end
