//
//  USFinanceAssertsCell.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/11.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USFinanceAssertsCell.h"
@interface USFinanceAssertsCell()
@property(nonatomic,strong) UIButton *rateBt;
@end
@implementation USFinanceAssertsCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       // HYLog(@"-----%@----",NSStringFromCGRect(self.contentView.frame));
        [self setBackgroundColor:[UIColor clearColor]];
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, kAppWidth-20, 130)];
        [bgView setBackgroundColor:[UIColor whiteColor]];
        bgView.layer.cornerRadius = 5;
        bgView.layer.masksToBounds = YES;
        //
        _assertNameLB = [USUIViewTool createUILabel];
        CGFloat width = bgView.width - 20;
        _assertNameLB.frame = CGRectMake(10, 10, width*2/3, 15);
        _assertNameLB.text = @"日息宝(第二期)";
         [bgView addSubview:_assertNameLB];
        //
        UIButton *todetailBt = [USUIViewTool createButtonWith:@"交易明细>"];
        todetailBt.frame = _assertNameLB.frame;
        _todetailBt = todetailBt;
//        todetailBt.backgroundColor = [UIColor redColor];
        todetailBt.titleLabel.textAlignment = NSTextAlignmentRight;
        [todetailBt setTitleColor:HYCTColor(187, 187, 187) forState:UIControlStateNormal];
        [todetailBt setTitleColor:HYCTColor(187, 187, 187) forState:UIControlStateHighlighted];
        todetailBt.width = width/3;
        todetailBt.titleLabel.font = _assertNameLB.font;
        todetailBt.x =bgView.width-todetailBt.width+_assertNameLB.x;
        [bgView addSubview:todetailBt];
        //
        UIView *line = [USUIViewTool createLineView];
        line.x = _assertNameLB.x;
        line.width = width;
        line.y = todetailBt.y+todetailBt.height+5;
        [bgView addSubview:line];
        //
        UIButton *rateBt = [USUIViewTool createButtonWith:@"9%"];
        rateBt.frame = CGRectMake(80, line.y+10, 60, 60);
        rateBt.x = rateBt.width/2;
        rateBt.layer.cornerRadius = rateBt.width/2;
        rateBt.layer.masksToBounds = YES;
        rateBt.titleLabel.font = [UIFont boldSystemFontOfSize:40];
        rateBt.backgroundColor = [UIColor orangeColor];
        [self updateButton:rateBt];
         [bgView addSubview:rateBt];
        _rateBt = rateBt;
        //
        UILabel *rateNameLB = [USUIViewTool createUILabel];
        rateNameLB.text = @"年化";
        rateNameLB.frame = rateBt.frame;
        rateNameLB.height = 15;
        rateNameLB.font = [UIFont boldSystemFontOfSize:15];
        rateNameLB.y = _rateBt.y+_rateBt.height+5;
        rateNameLB.textColor = HYCTColor(187, 187, 187);
        rateNameLB.textAlignment = NSTextAlignmentCenter;
        [bgView addSubview:rateNameLB];
        //
        UIView *titlesView = [self createTitlesViewWithWidth:width+10];
        titlesView.y = rateBt.y;
        [bgView addSubview:titlesView];
        [self addSubview:bgView];
    }
    return  self;
}
-(UIView *)createTitlesViewWithWidth:(CGFloat)width{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, 90)];
     _totalIncomeLB = [USUIViewTool createUILabel];
    _totalIncomeLB.width = width;
    _totalIncomeLB.y = 5;
    _totalIncomeLB.x = 0;
    _totalIncomeLB.tag = 5;
    _totalIncomeLB.text = @"累计收益: +66.44";
    [self updateUILabel:_totalIncomeLB];
    [bgView addSubview:_totalIncomeLB];
    //
    _lastIncomeLB = [USUIViewTool createUILabel];
    _lastIncomeLB.y = _totalIncomeLB.y+_totalIncomeLB.height+15;
    _lastIncomeLB.x = 0;
    _lastIncomeLB.width = width;
    _lastIncomeLB.tag = 5;
    _lastIncomeLB.text = @"昨日收益: +0.676";
    [self updateUILabel:_lastIncomeLB];
    [bgView addSubview:_lastIncomeLB];
    //
    _totalHandLB = [USUIViewTool createUILabel];
    _totalHandLB.width = width;
    _totalHandLB.y = _lastIncomeLB.y+_lastIncomeLB.height+15;
    _totalHandLB.x = 0;
    _totalHandLB.tag = 5;
    _totalHandLB.text = @" 总持有: 1066.44";
    [self updateUILabel:_totalHandLB];
    [bgView addSubview:_totalHandLB];
    return bgView;
}
-(void)updateUILabel:(UILabel*)lable{
    lable.font = [UIFont systemFontOfSize:12];
    if (lable.text.length>lable.tag) {
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:lable.text];
        [str addAttribute:NSForegroundColorAttributeName value:HYCTColor(187, 187, 187) range:NSMakeRange(0,lable.tag)];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(lable.tag+1,lable.text.length -(lable.tag+1))];
        lable.attributedText = str;
    }
       lable.textAlignment = NSTextAlignmentRight;
}
-(void)updateButton:(UIButton *)button{

        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:button.titleLabel.text];
        [str addAttribute:NSForegroundColorAttributeName value:HYCTColor(255, 255, 255) range:NSMakeRange(0,button.titleLabel.text.length-1)];
        [str addAttribute:NSForegroundColorAttributeName value:HYCTColor(255, 255, 255) range:NSMakeRange(button.titleLabel.text.length-1,1)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(button.titleLabel.text.length-1,1)];
        button.titleLabel.attributedText = str;
  
}

@end
