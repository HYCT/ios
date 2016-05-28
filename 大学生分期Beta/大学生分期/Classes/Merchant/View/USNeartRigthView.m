//
//  USNeartRigthView.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/3.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USNeartRigthView.h"
@interface USNeartRigthView()
@property(nonatomic,strong)UILabel *distanceLabel;
@end
@implementation USNeartRigthView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *image = [UIImage imageNamed:@"map_fix_image"];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        imageView.x = 0;
        imageView.y = 0;
        [self addSubview:imageView];
        _distanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageView.width,0 , kAppWidth-10, imageView.height)];
        [_distanceLabel setFont:[UIFont systemFontOfSize:10]];
        [_distanceLabel setTextColor:HYCTColor(135, 135, 135)];
         [self addSubview:_distanceLabel];
    }
    return self;
}
-(void)setDistance:(NSString *)distance{
    _distance = distance;
    [_distanceLabel setText:distance];
}
@end
