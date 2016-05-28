//
//  USUpImageDownLabelView.m
//  大学生分期
//
//  Created by HeXianShan on 15/10/4.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USUpImageDownLabelView.h"
@interface USUpImageDownLabelView()
@property(nonatomic,strong) UIView *backgroundView ;
@property(nonatomic,strong)UIButton *imageButton;
@end
@implementation USUpImageDownLabelView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.userInteractionEnabled = YES;
    if (self) {
        _backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _backgroundView.userInteractionEnabled = YES;
        //头像
        UIImage *personImage = [UIImage imageNamed:@"account_image"];
        UIImageView *personImageView = [[UIImageView alloc]initWithImage:personImage];
        personImageView.size =  CGSizeMake(57, 57);
        personImageView.x = self.width*0.5-personImageView.width*0.5;
        personImageView.y = 0;
        personImageView.layer.cornerRadius =  personImageView.frame.size.width*0.5;
        personImageView.clipsToBounds = YES;
        self.personImageView = personImageView;
        UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        imageButton.frame = personImageView.frame;
        imageButton.layer.cornerRadius = imageButton.width*0.5;
        imageButton.clipsToBounds = YES;
        [imageButton addTarget:self action:@selector(updateImage) forControlEvents:UIControlEventTouchUpInside];
        _imageButton = imageButton;
        _imageButton.backgroundColor = [UIColor clearColor];
        [_backgroundView addSubview:personImageView];
       
        _accountNameLabel = [USUIViewTool createUILabelWithTitle:@"" fontSize:kCommonFontSize_18 color:[UIColor blackColor] heigth:kCommonFontSize_18];
        _accountNameLabel.textAlignment = NSTextAlignmentCenter;
        _accountNameLabel.y = imageButton.y+imageButton.height+15;
        _accountNameLabel.frame = CGRectMake(0, imageButton.y+imageButton.height+15, kAppWidth, kCommonFontSize_18);
        [_backgroundView addSubview:_accountNameLabel];
        [_backgroundView addSubview:imageButton];
        [self addSubview:_backgroundView];
        self.width = _backgroundView.width;
        self.height = _backgroundView.height;
    }
    return self;
}
-(void)updateImage{
    if (_updateImageBlock != nil) {
        _updateImageBlock(_personImageView);
    }
}
-(void)updateFrame{
    _personImageView.x = _backgroundView.width*0.5-_personImageView.width*0.5;
    _personImageView.layer.cornerRadius =  _personImageView.frame.size.width*0.5;
    _imageButton.frame = _personImageView.frame;
    _imageButton.layer.cornerRadius = _imageButton.width*0.5;
    _imageButton.clipsToBounds = YES;
    self.accountNameLabel.frame = CGRectMake(0, _personImageView.height+_personImageView.y+5, kAppWidth, self.accountNameLabel.height);
    self.height = self.accountNameLabel.height+self.accountNameLabel.y;
}
@end
