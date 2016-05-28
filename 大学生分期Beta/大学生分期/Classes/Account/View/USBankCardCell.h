//
//  USBankCardCell.h
//  大学生分期
//
//  Created by HeXianShan on 15/9/9.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface USBankCardCell : UITableViewCell
@property(nonatomic,copy)NSString *bankName;
@property(nonatomic,copy)NSString *cardType;
@property(nonatomic,copy)NSString *cardId;
@property(nonatomic,copy)NSString *cardMan;
-(void)setDateWithDic:(NSDictionary *)data;
@end
