//
//  USFourGridView.h
//  大学生分期
//
//  Created by HeXianShan on 16/1/8.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "USVUpImagDownTitleView.h"
@interface USFourGridView : UIView
@property(nonatomic,strong)UILabel *sendYyueCLB;
@property(nonatomic,strong)UILabel *joinYyueCLB;
@property(nonatomic,strong)UILabel *sortLB;
@property(nonatomic,strong)UILabel *joinCLB;
@property(nonatomic,strong)UILabel *succeSnaCLB;
@property(nonatomic,strong)UILabel *joinSnaCLB;
@property(nonatomic,strong)UILabel *scanCLB;
@property(nonatomic,strong)UILabel *voteCLB;
@property(nonatomic,strong)USVUpImagDownTitleView  *yaoyueView ;
@property(nonatomic,strong)UIButton  *yaoyueBtn ;
@property(nonatomic,strong)USVUpImagDownTitleView  *duobaoView ;
@property(nonatomic,strong)UIButton  *duobaoBtn ;
@property(nonatomic,strong)USVUpImagDownTitleView  *mysortView ;
@property(nonatomic,strong)UIButton  *mysortBtn ;
@property(nonatomic,strong)USVUpImagDownTitleView  *myfangkeView ;
@property(nonatomic,strong)UIButton  *myfangkeBtn ;
@end
