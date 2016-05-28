//
//  USUpImageDownLabelView.h
//  大学生分期
//
//  Created by HeXianShan on 15/10/4.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^UpdateImageBlock)(UIImageView *);
@interface USUpImageDownLabelView : UIView
@property(nonatomic,strong)UILabel *accountNameLabel;
@property(nonatomic,strong)UIImageView *personImageView;
@property(nonatomic,copy)UpdateImageBlock updateImageBlock;
-(void)updateFrame;
-(void)updateImage;
@end
