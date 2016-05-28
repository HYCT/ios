//
//  USGridCellView.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/1.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USGridCellView.h"
@interface USGridCellView ()
@property(nonatomic,strong)UIButton *titelButton;

@property(nonatomic,strong)UIButton *topButton;
@end
@implementation USGridCellView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
       
        self.topButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.topButton.frame = frame;
        self.topButton.x = 0;
        self.topButton.y = 0;
        self.topButton.width = self.topButton.width-2;
        [self.topButton setBackgroundColor:[UIColor clearColor]];
        CGFloat height = (frame.size.height-2*2)/2;
        CGRect newFrame = CGRectMake(0, 5, frame.size.width, height);
        self.titelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.titelButton.frame = newFrame;
        [self.topButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        self.titelLabel = [[UILabel alloc]initWithFrame:newFrame];
        self.titelLabel.y = self.titelButton.height+self.titelButton.y;
        [self.titelLabel setFont:[UIFont systemFontOfSize:kCommonFontSize_15]];
        [self.titelLabel setTextColor:HYCTColor(172, 172, 172)];
        [self.titelLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.titelButton];
        [self addSubview:self.titelLabel];
        [self addSubview:self.topButton];
    }
    return  self;
}
-(void)buttonClick:(UIButton *)sender{
    [self.delegate didClickItem:sender];
}
-(void)setIndex:(NSInteger)index{
    self.topButton.tag = index;
}
-(void)setTitle:(NSString *)title{
    _title = title;
    [self.titelLabel setText:title];
    
}
-(void)setImageName:(NSString *)imageName
{
    _imageName = imageName;
    UIImage *image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [_titelButton setImage:image forState:UIControlStateNormal];
      [_titelButton setImage:image forState:UIControlStateHighlighted];
}
-(void)settitleColor:(UIColor *)titleColor{
    self.titelLabel.textColor = titleColor;
}
@end
