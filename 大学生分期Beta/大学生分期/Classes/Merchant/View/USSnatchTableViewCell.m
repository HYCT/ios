//
//  USSnatchTableViewCell.m
//  大学生分期
//
//  Created by HeXianShan on 15/10/2.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USSnatchTableViewCell.h"
#define  kMargin 10
#define  kLabelFontSize 12
@implementation USSnatchTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(kMargin, 0, kAppWidth-2*kMargin, kAppHeight*0.75)];
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.userInteractionEnabled = YES;
        _topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, bgView.width, 200)];
        _topImageView.image = [UIImage imageNamed:@"2.jpg"];
        [bgView addSubview:_topImageView];
        //
        _nameLB = [self createUILabelWithTitle:@"好博瑞护眼利眠健康眼镜" color:HYCTColor(53, 142, 219)];
        _nameLB.y = _topImageView.height+kMargin;
        [bgView addSubview:_nameLB];
        //[self.contentView addSubview:_nameLB];
        //
        _subTitleLB = [self createUILabelWithTitle:@"改善睡眠、提高睡眠质量、带......" color:HYCTColor(96,96, 96)];
        _subTitleLB.y = _nameLB.height+kMargin+_nameLB.y;
        [bgView addSubview:_subTitleLB];
        //[self.contentView addSubview:_subTitleLB];
        //
        
        _progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.frame = CGRectMake(kMargin*2, _subTitleLB.y+_subTitleLB.height+kMargin*2,_subTitleLB.width-kMargin*4, 30);
        CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 3.0f);
        _progressView.transform = transform;
        [_progressView setProgress:3680.0/6288.0 animated:YES];
        [_progressView setTrackTintColor:HYCTColor(204, 204, 204)];
        [_progressView setProgressTintColor:HYCTColor(255, 140, 1)];
        [bgView addSubview:_progressView];
        // [self.contentView addSubview:_progressView];
        //
        _plandeUpDownView = [[USUpDownLabelView alloc]initWithFrame:CGRectMake(_progressView.x, _progressView.y+_progressView.height+kMargin, _nameLB.width/2, 70)];
        [self updateView:_plandeUpDownView];
        [_plandeUpDownView.upLabel setText:@"3680.0/6288.0"];
        [_plandeUpDownView.downLabel setText:@"已筹"];
        //[self.contentView addSubview:_plandeUpDownView];
        [bgView addSubview:_plandeUpDownView];
        //
        UIView *line = [USUIViewTool createLineView];
        line.frame = CGRectMake(_plandeUpDownView.x+_plandeUpDownView.width+kMargin, _plandeUpDownView.y+kMargin*0.8, 1, _plandeUpDownView.height*0.6);
        //[self.contentView addSubview:line];
        [bgView addSubview:line];
        //
        _blanceDateUpDownView = [[USUpDownLabelView alloc]initWithFrame:CGRectMake(line.x+kMargin*2, _plandeUpDownView.y, _nameLB.width/2, 70)];
        [self updateView:_blanceDateUpDownView];
        [_blanceDateUpDownView.upLabel setText:@"36天"];
        [_blanceDateUpDownView.downLabel setText:@"剩余天数"];
        //[self.contentView addSubview:_blanceDateUpDownView];
        [bgView addSubview:_blanceDateUpDownView];
        //
        UIButton *bt = [USUIViewTool createButtonWith:@"支付一元,马上朵宝" imageName:@""];
        bt.backgroundColor = HYCTColor(235, 104, 119);
        bt.frame = _progressView.frame;
        bt.height = 50;
        bt.layer.cornerRadius = bt.height*0.1;
        bt.y = _blanceDateUpDownView.y+_blanceDateUpDownView.height-kMargin;
        [bt addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
        self.userInteractionEnabled = YES;
        [bgView addSubview:bt];
        [self.contentView addSubview:bgView];
        //[self.contentView addSubview:bt];
    }
    return  self;
}
-(void)test{
    HYLog(@"......TEST......");
}
-(void)updateView:(USUpDownLabelView *)view{
    view.font = [UIFont systemFontOfSize:18];
    view.textAlignment = NSTextAlignmentLeft;
    view.upLabel.textColor = HYCTColor(30, 30, 30);
    view.downLabel.textColor = HYCTColor(160, 160, 160);
    view.downLabel.y -= kMargin*0.85;
}
-(UILabel*)createUILabelWithTitle:(NSString *)title  color:(UIColor *)color{
    UILabel *label = [USUIViewTool createUILabel];
    label.font = [UIFont systemFontOfSize:kLabelFontSize];
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = CGRectMake(kMargin, kMargin, kAppWidth-2*kMargin, kLabelFontSize);
    [label setTextColor:color];
    label.text = title;
    return label;
}

@end
