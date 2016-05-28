//
//  USTextField.m
//  TestAStextField
//
//  Created by HeXianShan on 15/10/2.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USTextField.h"

@implementation USTextField

- (CGRect)placeholderRectForBounds:(CGRect)bounds{
    return  CGRectMake(self.leftView.frame.origin.x+self.leftView.frame.size.width,_fontSize/2, bounds.size.width, bounds.size.height);
}
-(void)setAttributedPlaceholder:(NSAttributedString *)attributedPlaceholder{
    [super setAttributedPlaceholder:attributedPlaceholder];
    [self placeholderRectForBounds:self.bounds];
}
@end
