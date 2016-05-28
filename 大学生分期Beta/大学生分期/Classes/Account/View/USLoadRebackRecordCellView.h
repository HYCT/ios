//
//  USMyLoadRebackRecordCellView.h
//  大学生分期
//
//  Created by HeXianShan on 15/9/25.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import <UIKit/UIKit.h>
 enum LoanRebackrRecordCellType{
  LoanType,
  RebackType
};
@interface USLoadRebackRecordCellView : UITableViewCell
@property(nonatomic,assign) enum LoanRebackrRecordCellType cellType;
@property(nonatomic,copy)NSString *rebackName;
@property(nonatomic,copy)NSString *rebackDate;
@property(nonatomic,copy)NSString *rebackMsg;
@property(nonatomic,copy)NSString *rebackCount;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(enum LoanRebackrRecordCellType)type;
-(void)setDataWithDic:(NSDictionary *)dataDic;
@end
