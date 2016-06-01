//
//  USRebackViewController.h
//  大学生分期
//
//  Created by HeXianShan on 15/9/9.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USBaseViewController.h"
#import "USRebackTableViewCell.h"
#import "USBaseAuthorViewController.h"
#import "USBankCardListCommonDelegate.h"

@protocol RebackTicketDelegate<NSObject>
-(void) didTicketClick:(NSDictionary *)data;
@end
@interface USRebackViewControllerType : USBaseAuthorViewController<RebackTicketDelegate,USBankCardListCommonDelegate>
@property(nonatomic,copy)NSString *rebackId;
@property(nonatomic,assign)CGFloat money;
@end
