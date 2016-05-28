//
//  USUpDownLabelView.m
//  大学生分期
//
//  Created by HeXianShan on 15/8/31.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USUpDownLabelView.h"
@interface USUpDownLabelView()

@end
@implementation USUpDownLabelView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.upLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height/2-5)];
        [self.upLabel setFont:[UIFont boldSystemFontOfSize:kCommonFontSize_18]];
        [self.upLabel setTextAlignment:NSTextAlignmentCenter];
        [self.upLabel setTextColor:HYCTColor(42, 42, 42)];
         self.downLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.upLabel.y+self.upLabel.height, frame.size.width, frame.size.height/2-5)];
        [self.downLabel setFont:[UIFont systemFontOfSize:kCommonFontSize_12]];
        [self.downLabel setTextAlignment:NSTextAlignmentCenter];
        [self.downLabel setTextColor:[UIColor grayColor]];
        [self addSubview:self.upLabel];
        [self addSubview:self.downLabel];
    }
    return  self;
}
-(void)setUpTitle:(NSString *)upTitle{
     [self.upLabel setText:upTitle];
}
-(void)setDownTitle:(NSString *)downTitle{
    [self.downLabel setText:downTitle];
}
-(void)setTextAlignment:(NSTextAlignment)textAlignment{
    self.upLabel.textAlignment = textAlignment;
    self.downLabel.textAlignment = textAlignment;

}
-(void)setFont:(UIFont *)font{
    self.upLabel.font = font;
    self.downLabel.font = font;
}
@end
