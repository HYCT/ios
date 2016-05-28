//
//  USMyAskTableViewCell.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/3.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USMyAskTableViewCell.h"
#define kMargin 10
#define kPadding 5
#define kMarginTop 20
@implementation USMyAskTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _nameLB = [self createUILable:@"" width:kNameWidth];
        _nameLB.frame = CGRectMake(0, 0, kNameWidth, 40);
        [self.contentView addSubview:_nameLB];
        UIView *registerBgView = [[UIView alloc]initWithFrame: CGRectMake(_nameLB.x+_nameLB.width+kPadding, 0, kRegisterWidth, 40)];
        _registerImageView = [[UIImageView alloc]initWithFrame: CGRectMake(_nameLB.x+_nameLB.width+kPadding, 0, kRegisterWidth, 40)];
        UIImage *ticketImage = [UIImage imageNamed:@"account_ask_tickt_img"];
        _registerImageView.image = ticketImage;
        _registerImageView.size = CGSizeMake(34, 24);
        _registerImageView.x = registerBgView.width*0.5-_registerImageView.width*0.5;
        _registerImageView.y = registerBgView.height*0.5-_registerImageView.height*0.5;
        //_registerImageView.image = ticketImage;
        [registerBgView addSubview:_registerImageView];
        [self.contentView addSubview:registerBgView];
        UIView *identiyBgView = [[UIView alloc]initWithFrame: CGRectMake(registerBgView.x+registerBgView.width+kPadding, 0, kIdentityWidth, 40)];
        _identiyImageView = [[UIImageView alloc]initWithFrame: CGRectMake(registerBgView.x+registerBgView.width+kPadding, 0, kIdentityWidth, 40)];
        _identiyImageView.image = ticketImage;
        _identiyImageView.size = CGSizeMake(34, 24);
        _identiyImageView.x = identiyBgView.width*0.5-_identiyImageView.width*0.5;
        _identiyImageView.y = identiyBgView.height*0.5-_identiyImageView.height*0.5;
        [identiyBgView addSubview:_identiyImageView];
        [self.contentView addSubview:identiyBgView];
        _awardLB = [self createUILable:@"" width:kAwardWidth];
        _awardLB.frame = CGRectMake(identiyBgView.x+identiyBgView.width+kPadding, 0, kAwardWidth, 40);
        _awardLB.textColor = [UIColor orangeColor];
        _awardLB.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_awardLB];
    }
    return self;
}
-(void)setDataWithDic:(NSDictionary *)dataDic{
    _nameLB.text = [NSString stringWithFormat:@"   %@",dataDic[@"name"]];
    _awardLB.text = dataDic[@"reward_"];
    NSString *realnametype = [NSString stringWithFormat:@"%@",dataDic[@"realnametype"]];
   
    if (![realnametype isEqualToString:@"3"]) {
        _identiyImageView.hidden = YES;
    }
}
/*
 self.titleLabel = [self createLabel];
 self.detailTitleLabel = [self createLabel];
 [self.detailTitleLabel setTextAlignment:NSTextAlignmentRight];
 [self.detailTitleLabel setWidth:kAppWidth-self.detailTitleLabel.x*2];
 [self.contentView addSubview:self.titleLabel];
 [self.contentView addSubview:self.detailTitleLabel];
 self.subTitleLabel = [self createLabel];
 self.subTitleLabel.y = self.titleLabel.y+self.titleLabel.height+5;
 [self.subTitleLabel setTextAlignment:NSTextAlignmentRight];
 [self.subTitleLabel setWidth:kAppWidth-self.detailTitleLabel.x*2];
 [self.contentView addSubview:self.subTitleLabel];
 */
-(UILabel *)createUILable:(NSString *)title width:(CGFloat) width{
    UILabel *uiLB = [USUIViewTool createUILabelWithTitle:title fontSize:kCommonFontSize_18 color:HYCTColor(84, 84, 84) heigth:40];
    uiLB.width = width;
    //uiLB.backgroundColor = [UIColor redColor];
    return uiLB;
}
@end
