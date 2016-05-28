//
//  USSnatchDetailTopView.m
//  大学生分期
//
//  Created by HeXianShan on 16/1/6.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import "USSnatchDetailTopView.h"
#define  kMargin 10
#define  kHeight 200
#define  kLabelFontSize 12
@implementation USSnatchDetailTopView
//-(instancetype)initWithFrame:(CGRect)frame dataDic:(NSDictionary *)dataDic;
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor whiteColor];
        self.frame = CGRectMake(0, 0, kAppWidth, kHeight);
        _topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kMargin, kMargin, kAppWidth-2*kMargin, kHeight*0.75)];
        _topImageView.image = [UIImage imageNamed:@"2.jpg"];
        [self addSubview:_topImageView];
        
        //
        UIButton *toDetailBt = [UIButton buttonWithType:UIButtonTypeCustom];
        _toDetailBt = toDetailBt;
        toDetailBt.frame = CGRectMake(_topImageView.x, _topImageView.height+kMargin+_topImageView.y-kMargin*0.5, 40, 20);
        toDetailBt.layer.borderColor = [HYCTColor(226, 120, 104) CGColor];
        toDetailBt.layer.borderWidth = 1;
        toDetailBt.layer.cornerRadius = 5;
        toDetailBt.layer.masksToBounds = YES;
        toDetailBt.titleLabel.font = [UIFont systemFontOfSize:kCommonFontSize_12];
        [toDetailBt setTitle:@"进行中" forState:UIControlStateNormal];
        [toDetailBt setTitleColor:HYCTColor(226, 120, 104) forState:UIControlStateNormal];
        [self addSubview:toDetailBt];
        //
        _nameLB = [self createUILabelWithTitle:@"好博瑞护眼利眠健康眼镜" color:[UIColor blackColor]];
        _nameLB.x = kMargin*2;
        _nameLB.width = kAppWidth-_nameLB.x;
        _nameLB.textAlignment = NSTextAlignmentCenter;
        _nameLB.y = _topImageView.height+kMargin+_topImageView.y;
        [self addSubview:_nameLB];
        //
        _progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.frame = CGRectMake(kMargin, _nameLB.y+_nameLB.height+kMargin,self.width-kMargin*2, 30);
        CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 3.0f);
        _progressView.transform = transform;
        [_progressView setProgress:3680.0/6288.0 animated:YES];
        [_progressView setTrackTintColor:HYCTColor(204, 204, 204)];
        [_progressView setProgressTintColor:HYCTColor(255, 140, 1)];
        [self addSubview:_progressView];
        //
        _subTitleLB = [self createUILabelWithTitle:@"总需3288人次" color:[UIColor grayColor]];
        _subTitleLB.x = kMargin;
        _subTitleLB.width = kAppWidth-_subTitleLB.x*2;
        _subTitleLB.y = _progressView.y+_progressView.height+2;
        [self addSubview:_subTitleLB];
        //
        _progressLB = [USUIViewTool createUILabelWithTitle:@"" fontSize:kCommonFontSize_12 color:HYCTColor(177, 177, 177) heigth:kCommonFontSize_12];
        _progressLB.frame = CGRectMake(_progressView.x, _progressView.y+_progressView.height+2, 100, kCommonFontSize_12);
        _progressLB.textAlignment = NSTextAlignmentRight;
        [self updatProgressLb:@"40%"];
        _progressLB.x=kAppWidth - _progressLB.x-_progressLB.width;
        [self addSubview:_progressLB];
        //
        
        _dyHeight = _progressLB.height+_progressLB.y+30;
        if (_dyHeight<self.height) {
            _dyHeight = self.height;
        }else{
            self.height = _dyHeight;
        }
    }
    return self;
}
-(void)setDataDic:(NSDictionary *)dataDic{
    
    //[_topImageView sd_setImageWithURL:[NSURL URLWithString:HYWebDataPath(dataDic[@"title_img_path"])]];
    [_topImageView sd_setImageWithURL:[NSURL URLWithString:HYWebDataPath(dataDic[@"title_img_path"])] placeholderImage:[UIImage imageNamed:@"circle_default"] options:5];
    _nameLB.text = dataDic[@"title"];
    _subTitleLB.text = [NSString stringWithFormat:@"总需%@人次", dataDic[@"max_count"]];
    [_progressView setProgress: [dataDic[@"join_count"] integerValue]*1.0/[dataDic[@"max_count"] integerValue]*1.0 animated:YES];
    [self updatProgressLb:dataDic[@"startProgress"]];
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
@end
