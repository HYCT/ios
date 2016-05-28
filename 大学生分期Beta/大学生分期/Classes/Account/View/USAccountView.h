//
//  HYAccountTipView.h
//  红云创投
//
//  Created by HeXianShan on 15/8/26.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol USAccountViewDelegate<NSObject>
@optional
-(void)didBorrowing;
@end
@interface USAccountView : UIView
@property(nonatomic,strong)UILabel *blanceTipLabel;
@property(nonatomic,strong)UILabel *blanceLabel;
@property(nonatomic,strong)UILabel *totalBlanceLabel;
@property(nonatomic,strong)UILabel *incomedLabel;
@property(nonatomic,strong)UIButton *borrowingButton;
@property(nonatomic,assign)id<USAccountViewDelegate> delegate;
@property(nonatomic,strong) UIView *backgroundView ;
-(void)setTotalBlance:(NSString *)totalBlance;
@end
