//
//  USSubXrankView.m
//  大学生分期
//
//  Created by HeXianShan on 16/1/8.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import "USSubXrankView.h"
#define  kMargin 2
#define kWidth (kAppWidth - kMargin*4)*1.0/3.0
@implementation USSubXrankView

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kWidth)];
        [_topImageView sd_setImageWithURL:[NSURL URLWithString:HYWebDataPath(dic[@"pic_path"])] placeholderImage:[UIImage imageNamed:@"circle_default"] options:5];
        [self addSubview:_topImageView];
        self.frame = CGRectMake(0, 0, kWidth, kWidth);
        _seqLB = [self createUILB];
        _seqLB.x = kMargin*0.2;
        _seqLB.width-=kMargin*0.5;
        _seqLB.y = kWidth - _seqLB.height;
        [self addSubview:_seqLB];
        //
        _nameLB = [self createUILB];
        NSObject *obj = dic[@"name"];
        
        _nameLB.text = obj== [NSNull null]?@"":[obj description];
        _nameLB.x = _seqLB.x+_seqLB.width+kMargin*0.5;
        _nameLB.y = _seqLB.y;
        _nameLB.font = [UIFont systemFontOfSize:kCommonFontSize_8];
        _nameLB.width-=kMargin*0.5;
        [self addSubview:_nameLB];
        //
        _zangCountLB = [self createUILB];
        _zangCountLB.x = _nameLB.x+_nameLB.width+kMargin*0.5;
        _zangCountLB.y = _seqLB.y;
        _zangCountLB.width-=kMargin*0.5;
        
        _zangCountLB.text = [NSString stringWithFormat:@"%@",@([dic[@"zang"] integerValue])];
        [self addSubview:_zangCountLB];
        UIButton *topBt = [UIButton buttonWithType:UIButtonTypeCustom];
        topBt.frame = self.bounds;
        [topBt addTarget:self action:@selector(topClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:topBt];
        self.userInteractionEnabled = YES;
    }
    return  self;
}

-(UILabel *)createUILB{
    UILabel *label = [USUIViewTool createUILabelWithTitle:@"1" fontSize:kCommonFontSize_12 color:[UIColor whiteColor] heigth:kCommonFontSize_12];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.frame = CGRectMake(0, kWidth-kCommonFontSize_12, kWidth/3.0, kCommonFontSize_12);
    return label;
}
-(void)topClick{
    HYLog(@"topClick");
    if (_clickBlock!=nil) {
        _clickBlock();
    }
}
@end
