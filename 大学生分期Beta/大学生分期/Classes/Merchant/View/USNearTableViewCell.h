//
//  USNearTableViewCell.h
//  大学生分期
//
//  Created by HeXianShan on 15/9/3.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "USNearTableViewController.h"
#import "USNearTitleView.h"
#import "USNeartRigthView.h"
@interface USNearTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *leftImgeView;
@property(nonatomic,strong)USNearTitleView *nearTitleView;
@property(nonatomic,strong)USNeartRigthView *nearRightView;
@property(nonatomic,strong)UIView *line ;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier nearType:(NearType) nearType;
@end
