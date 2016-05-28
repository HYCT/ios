//
//  USAccountHistoryView.m
//  大学生分期
//
//  Created by HeXianShan on 15/8/31.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USAccountHistoryView.h"

@implementation USAccountHistoryView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        CGRect leftFrame = CGRectMake(0, frame.size.height*0.1, frame.size.width/2 - 5, frame.size.height);
        self.leftView = [[USUpDownLabelView alloc]initWithFrame:leftFrame];
        UIButton *leftBt = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftBt addTarget:self action:@selector(didLeftClick:) forControlEvents:UIControlEventTouchUpInside];
        leftBt.frame = leftFrame;
        self.leftView.userInteractionEnabled = YES;
        [self addSubview:self.leftView];
        
        UIView *view = [[UIView alloc]init];
        view.height = frame.size.height*0.6;
        view.y = frame.size.height*0.2;
        view.width = 0;
        [view setBackgroundColor:HYCTColor(224, 224, 224)];
        view.x = frame.size.width/2;
        [self addSubview:view];
         CGRect rightFrame = CGRectMake( view.x+5, frame.size.height*0.1, frame.size.width/2 - 5, frame.size.height);
        self.rightView = [[USUpDownLabelView alloc]initWithFrame:rightFrame];
        self.rightView.userInteractionEnabled = YES;
        UIButton *rightBt = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBt.frame = rightFrame;
        [rightBt addTarget:self action:@selector(didRightClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.rightView];
        rightBt.width = self.width;
        [self addSubview:rightBt];
        [self addSubview:leftBt];
        [self setBackgroundColor:[UIColor whiteColor]];
        self.userInteractionEnabled = YES;
    }
    return self;
}
-(void)didLeftClick:(UIButton *)button{
    [self.delegate didLeftClick:button];
}
-(void)didRightClick:(UIButton *)button{
    [self.delegate didRightClick:button];
}

@end
