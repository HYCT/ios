//
//  USImageButton.m
//  大学生分期
//
//  Created by HeXianShan on 16/1/4.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import "USImageButton.h"
@interface USImageButton()

@end
@implementation USImageButton

-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title imageName:(NSString *)imageNmae{
    self.userInteractionEnabled = YES;
    self = [super initWithFrame:frame];
    self.layer.borderColor = [HYCTColor(168, 168, 168) CGColor];
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = self.height*0.5;
    self.layer.masksToBounds = YES;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(6, 0, 15, 15)];
    imageView.image = [UIImage imageNamed:imageNmae];
    imageView.y = self.height*0.2;
    [self addSubview:imageView];
    UILabel *titleLB = [USUIViewTool createUILabelWithTitle:title fontSize:kCommonFontSize_15 color:HYCTColor(168, 168, 168) heigth:kCommonFontSize_15];
    _titleLB = titleLB;
    titleLB.frame = CGRectMake(imageView.x+imageView.width, imageView.y, self.width-imageView.x-imageView.width-5, 20);
    titleLB.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLB];
    
    UIButton *topBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _topBt = topBt;
    [topBt addTarget:self action:@selector(didClick) forControlEvents:UIControlEventTouchUpInside];
    topBt.frame = CGRectMake(0, 0, self.width, self.height);
    [self addSubview:topBt];
    return self;
}
-(void)didClick{
    if (_clickBlock!=nil) {
        _clickBlock();
    }
}
@end
