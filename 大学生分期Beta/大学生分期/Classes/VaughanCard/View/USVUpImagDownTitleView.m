//
//  USVUpImagDownTitleView.m
//  大学生分期
//
//  Created by HeXianShan on 16/1/8.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import "USVUpImagDownTitleView.h"

@implementation USVUpImagDownTitleView


-(instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)imageName downTitle:(NSString *)downTitle{
    self = [super initWithFrame:frame];
    if (self) {
        _vtopImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,  self.height*0.5, self.height*0.5)];
        _vtopImageView.centerX = self.width*0.5;
        _vtopImageView.image =[UIImage imageNamed:imageName];
        [self addSubview:_vtopImageView];
        _downTitle = [USUIViewTool createUILabelWithTitle:downTitle fontSize:kCommonFontSize_14 color:[UIColor whiteColor] heigth:kCommonFontSize_15];
        _downTitle.textAlignment = NSTextAlignmentCenter;
        _downTitle.frame = CGRectMake(0, _vtopImageView.height, self.width, self.height*0.5);
       [self addSubview:_downTitle];
        UIButton *topButton = [UIButton buttonWithType:UIButtonTypeCustom];
        topButton.frame = self.bounds;
        [self addSubview:topButton];
        [topButton addTarget:self action:@selector(topClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return  self;
}
-(void)topClick{
    if (_clickBlock!=nil) {
        _clickBlock();
    }
}
@end
