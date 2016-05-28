//
//  USToolBarView.h
//  大学生分期
//
//  Created by HeXianShan on 15/8/30.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import <UIKit/UIKit.h>
enum ItemEnums{
  ItemIndex_0 = 0,
  ItemIndex_1 = 1,
  ItemIndex_2 = 2,
  ItemIndex_3 = 3
};
@interface USTabBarView : UIView
@property(nonatomic,strong)UIToolbar *toobar;
@property(nonatomic,assign) id<UITabBarDelegate> delegate;
-(instancetype)initWithFrame:(CGRect)frame;
-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray*) titles images:(NSArray*)images selectedImages:(NSArray*)selectedImages deleagete:(id<UITabBarDelegate>) delegate;
@end
