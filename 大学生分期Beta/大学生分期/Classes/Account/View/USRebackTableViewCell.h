//
//  USRebackTableViewCell.h
//  大学生分期
//
//  Created by HeXianShan on 15/9/9.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "USUpDownLabelView.h"
typedef enum {
   NoReback,
    NoReback_1,
   CurrentReback,
   PrePayReback,
   FreeReback
}RebackType;
@protocol USRebackTableViewCellDelegate<NSObject>
@optional
-(void)didSelectButton:(NSInteger)buttonTag flag:(Boolean)flag;
-(void)didCellSelect;
@end
@interface USRebackTableViewCell : UITableViewCell
@property(nonatomic,strong)UIView *leftView;
@property(nonatomic,strong)UIView *centerView;
@property(nonatomic,copy)NSString *upTitle;
@property(nonatomic,copy)NSString *downTitle;
@property(nonatomic,assign)RebackType rebackType;
@property(nonatomic,assign) NSInteger  checkButtonTag;
@property(nonatomic,strong) USUpDownLabelView *upDownLabelView;
@property(nonatomic,assign) id<USRebackTableViewCellDelegate>  delegate;
@property(nonatomic,strong)UIButton *accessoryBt;
-(void)updateFrame:(CGRect)frame;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(RebackType) rebackType;
-(void)setDataWithDic:(NSDictionary *)data;
-(void)checkedBox;
-(void)unCheckedBox;
@end
