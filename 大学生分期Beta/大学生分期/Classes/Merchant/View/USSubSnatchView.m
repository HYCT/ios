//
//  USSubSnatchView.m
//  大学生分期
//
//  Created by HeXianShan on 16/1/6.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import "USSubSnatchView.h"
#define  kMargin 10
#define  kHeight 150
#define  kLabelFontSize 12
@implementation USSubSnatchView

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
        _dataDic = dic;
        self.backgroundColor = [UIColor whiteColor];
        self.frame = CGRectMake(0, 0, kAppWidth*0.5-kMargin, kHeight);
        _topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kMargin, kMargin, self.width-kMargin*2, kHeight*0.5)];
        //_topImageView.image = [UIImage imageNamed:@"2.jpg"];
        //[_topImageView sd_setImageWithURL:[NSURL URLWithString:HYWebDataPath(_dataDic[@"title_img_path"])]];
        [_topImageView sd_setImageWithURL:[NSURL URLWithString:HYWebDataPath(_dataDic[@"title_img_path"])] placeholderImage:[UIImage imageNamed:@"circle_default"] options:5];
        [self addSubview:_topImageView];
        //
        _nameLB = [self createUILabelWithTitle:_dataDic[@"title"] color:HYCTColor(96,96, 96)];
        _nameLB.y = _topImageView.height+kMargin+_topImageView.y;
        [self addSubview:_nameLB];
        //[self.contentView addSubview:_nameLB];
        //
        //_subTitleLB = [self createUILabelWithTitle:@"改善睡眠、提高睡眠质量" color:HYCTColor(96,96, 96)];
        //_subTitleLB.y = _nameLB.height+_nameLB.y;
        //[self addSubview:_subTitleLB];
        //
        _progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
        //_progressView.frame = CGRectMake(kMargin, _subTitleLB.y+_subTitleLB.height+kMargin,self.width-kMargin*6, 30);
        _progressView.frame = CGRectMake(kMargin, _nameLB.y+_nameLB.height+kMargin,self.width-kMargin*6, 30);
        CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 3.0f);
        _progressView.transform = transform;
        [_progressView setProgress: [_dataDic[@"join_count"] integerValue]*1.0/[_dataDic[@"max_count"] integerValue]*1.0 animated:YES];
        [_progressView setTrackTintColor:HYCTColor(204, 204, 204)];
        [_progressView setProgressTintColor:HYCTColor(255, 140, 1)];
        [self addSubview:_progressView];
        //
        _progressLB = [USUIViewTool createUILabelWithTitle:@"" fontSize:kCommonFontSize_12 color:HYCTColor(177, 177, 177) heigth:kCommonFontSize_12];
        _progressLB.frame = CGRectMake(_progressView.x, _progressView.y+_progressView.height+2, _progressView.width, kCommonFontSize_12);
        [self updatProgressLb:_dataDic[@"startProgress"]];
        [self addSubview:_progressLB];
        //
        UIButton *toDetailBt = [UIButton buttonWithType:UIButtonTypeCustom];
        _toDetailBt = toDetailBt;
        toDetailBt.frame = CGRectMake(_progressView.x+_progressView.width+2, _progressView.y-5, 45, 25);
        toDetailBt.layer.borderColor = [HYCTColor(226, 120, 104) CGColor];
        toDetailBt.layer.borderWidth = 1;
        toDetailBt.layer.cornerRadius = 5;
        toDetailBt.layer.masksToBounds = YES;
        [toDetailBt setTitle:@"详情" forState:UIControlStateNormal];
        [toDetailBt setTitleColor:HYCTColor(226, 120, 104) forState:UIControlStateNormal];
        [toDetailBt addTarget:self action:@selector(didClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:toDetailBt];
        _dyHeight = toDetailBt.height+toDetailBt.y;
        if (_dyHeight<self.height) {
            _dyHeight = self.height;
        }else{
            self.height = _dyHeight;
        }
    }
    return self;
}
-(void)updatProgressLb:(NSString *)progress{
    NSString *tip = [NSString stringWithFormat:@"开奖进度 %@",progress];
    NSInteger len = @"开奖进度 ".length;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:tip];
    
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kCommonFontSize_12] range:NSMakeRange(0, str.length)];
    [str addAttribute:NSForegroundColorAttributeName value:HYCTColor(77, 124, 246) range:NSMakeRange(len, str.length-len)];
    _progressLB.attributedText = str;
}
-(UILabel*)createUILabelWithTitle:(NSString *)title  color:(UIColor *)color{
    UILabel *label = [USUIViewTool createUILabel];
    label.font = [UIFont systemFontOfSize:kLabelFontSize];
    label.textAlignment = NSTextAlignmentLeft;
    label.frame = CGRectMake(kMargin, 0, kAppWidth-2*kMargin, kLabelFontSize);
    [label setTextColor:color];
    label.text = title;
    return label;
}
-(void)didClick{
    HYLog(@"FFDFFF");
    if (_clickBlock!=nil) {
        _clickBlock();
    }
}
@end
