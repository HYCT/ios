//
//  HYAboutMeView.h
//  红云创投
//
//  Created by HeXianShan on 15/8/27.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol USAccountApproveViewDelegate<NSObject>
@optional
-(void)didApprove;
-(void)didUpdateImage:(UIImageView *)imageView;
@end
@interface USAccountApproveView : UIView
@property(nonatomic,strong)UILabel *accountNameLabel;
@property(nonatomic,strong)UIImage *personImage;
@property(nonatomic,strong)UIButton *settingButton;
@property(nonatomic,strong)UIImageView *personImageView;
@property(nonatomic,strong)id<USAccountApproveViewDelegate> deleage;
+(instancetype)accountApproveView;
@end
