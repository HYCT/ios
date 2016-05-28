//
//  UIBarButtonItem+Extension.m
//  红云创投
//
//  Created by HeXianShan on 15/8/10.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)
+(UIBarButtonItem *)initWithTarget:(id)target action:(SEL)action   image:(NSString *)image   highImage:(NSString *)highImage{
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    [bt setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [bt setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [bt addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    CGSize size = bt.currentBackgroundImage.size;
    bt.frame = CGRectMake(0, 0, size.width, size.height);
    return [[UIBarButtonItem alloc]initWithCustomView:bt];
}
@end
