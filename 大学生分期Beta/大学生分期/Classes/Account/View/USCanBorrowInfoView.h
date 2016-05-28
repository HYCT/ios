//
//  USCanBorrowInfoView.h
//  大学生分期
//
//  Created by HeXianShan on 15/9/3.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol USCanBorrowInfoViewDelegate<NSObject>
@optional
-(void)didIncreament:(UILabel *)blanceLabel;
@end
@interface USCanBorrowInfoView : UIView
@property(nonatomic,strong)UILabel *blanceTipLabel;
@property(nonatomic,strong)UILabel *blanceLabel;
@property(nonatomic,strong)UIButton *increamentButton;
@property(nonatomic,assign)id<USCanBorrowInfoViewDelegate> delegate;
@property(nonatomic,strong) UIView *backgroundView ;
@property(nonatomic,strong)UIImageView *bgImgeView;
@end
