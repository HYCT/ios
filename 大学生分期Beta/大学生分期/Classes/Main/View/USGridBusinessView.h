//
//  USGridView.h
//  大学生分期
//
//  Created by HeXianShan on 15/9/1.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "USGridCellView.h"
@interface USGridBusinessView : UIView
-(instancetype)initWithFrame:(CGRect)frame itemTitles:(NSArray *)itemTitles
                  itemImages:(NSArray *)itemImageNames ids:(NSArray *)ids rowCount:(NSInteger) rowCount cellCount:(NSInteger) cellCount nav:(UINavigationController *)nav ;

@end
