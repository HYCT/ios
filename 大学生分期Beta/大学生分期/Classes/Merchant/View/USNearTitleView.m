//
//  USNearTitleView.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/3.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USNearTitleView.h"
@interface USNearTitleView()
@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UIView *imageWrapView;
@end
@implementation USNearTitleView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, frame.size.width, kCommonFontSize_15)];
        _titleLabel = titleLabel;
        [titleLabel setFont:[UIFont systemFontOfSize:kCommonFontSize_15]];
        [titleLabel setTextAlignment:NSTextAlignmentLeft];
        [titleLabel setTextColor:HYCTColor(135, 135, 135)];
        [self addSubview:titleLabel];
        //
        _imageWrapView = [[UIView alloc]initWithFrame:CGRectMake(titleLabel.x, titleLabel.y+titleLabel.height+5, 20, frame.size.height/2-10)];
         [self addSubview:_imageWrapView];
        //
        _addressLabel = [USUIViewTool createUILabelWithTitle:@"云南师范大学" fontSize:kCommonFontSize_12 color:HYCTColor(120, 120, 120) heigth:kCommonFontSize_15];
        _addressLabel.frame = CGRectMake(_imageWrapView.width-20, _imageWrapView.y, kAppWidth-20, kCommonFontSize_15);
        _addressLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_addressLabel];
        //UIView *voteView = [[UIView alloc]initWithFrame:CGRectMake(frame.size.width*0.3, 5, frame.size.width*0.4,40)];
       // voteView.layer.cornerRadius = 10;
       // voteView.layer.masksToBounds = YES;
       // voteView.backgroundColor = HYCTColor(160,160, 160);
        
        _voteLabel = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.width*0.3, 5, frame.size.width*0.4,40)];
        _voteLabel.layer.cornerRadius = 10;
        _voteLabel.font = [UIFont systemFontOfSize:kCommonFontSize_12];
        _voteLabel.numberOfLines = 0;
        _voteLabel.layer.masksToBounds = YES;
        _voteLabel.backgroundColor = HYCTColor(160,160, 160);
        _voteLabel.text = @"打死老财...";
        [self addSubview:_voteLabel];
        
    }
    return self;
}
-(void)setPersonTitle:(NSString *)personTitle{
    _personTitle = personTitle;
    [_titleLabel setText:personTitle];
}
-(void)setImgeNames:(NSArray *)imgeNames{
    _imgeNames = imgeNames;
    if (imgeNames) {
        for (NSInteger i=0; i<imgeNames.count; i++) {
            UIImage *image = [UIImage imageNamed:imgeNames[i]];
            UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
            imageView.x = i*image.size.width;
            imageView.y = 0;
            if (i>0) {
                imageView.x +=0.2;
            }
            [_imageWrapView addSubview:imageView];
        }
    }
}
@end
