//
//  USAnomalyView.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/22.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USAnomalyView.h"
#define kMargin 2

@implementation USAnomalyView


-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title subTitle:(NSString *)subTitle
                 bgImageName:(NSString *)bgImageName{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        
        UIImage  *bgImage = [UIImage imageNamed: (bgImageName==nil?@"home_bt_img":bgImageName)];
        UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:frame];
        bgImageView.image = bgImage;
        CGRect innderFrame = CGRectMake(kMargin, kMargin, self.width-kMargin*2, self.height-kMargin*2);
        bgImageView.frame = innderFrame;
        [self addSubview:bgImageView];
        //
        if (bgImageName ==nil) {
            UILabel *titleLabel = [USUIViewTool createUILabelWithTitle:title fontSize:25 color:[UIColor whiteColor] heigth:36];
            [self updateTtitleLabel:titleLabel];
            titleLabel.y = self.height*2.0/4-titleLabel.height;
            [self addSubview:titleLabel];
            _titleLabel = titleLabel;
        }
        UILabel *subtitleLabel = [USUIViewTool createUILabelWithTitle:subTitle fontSize:kCommonFontSize color:[UIColor whiteColor] heigth:kCommonFontSize_20];
        _subtitleLabel = subtitleLabel;
        [self updateTtitleLabel:subtitleLabel];
        CGFloat subtitleY = self.height*3.0/4-15;
        if (subtitleY<self.height/2) {
            subtitleY = self.height*3.0/4-12;
        }
        subtitleLabel.y = subtitleY;
        [self addSubview:subtitleLabel];
        //
        UIButton *topbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        topbutton.frame = innderFrame;
        topbutton.backgroundColor = [UIColor clearColor];
        _topbutton = topbutton;
        //topbutton.alpha = 0.1;
        [topbutton addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:topbutton];
    }
    _title = title;
    _subTitle = subTitle;
    return self;
}
-(void)click{
    if (_clickBlock!=nil) {
        _clickBlock();
        if(!_logined)
        return;
    }
    if (self.delegate != nil) {
        if ([self.delegate respondsToSelector:@selector(didTopButtonClick:)]) {
            [self.delegate didTopButtonClick:self];
        }
    }
}
- (void)updateTtitleLabel:(UILabel *)titleLabel
{
    titleLabel.width = self.width;
    titleLabel.x = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
}
-(void)setTitle:(NSString *)title{
    _title = title;
    _titleLabel.text = title;
}
-(void)setSubTitle:(NSString *)subTitle{
    _subTitle = subTitle;
    _subtitleLabel.text = subTitle;
}
@end
