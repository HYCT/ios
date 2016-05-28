//
//  USScanCodeResultViewController.h
//  大学生分期
//
//  Created by HeXianShan on 15/12/12.
//  Copyright © 2015年 hongyunct. All rights reserved.
//

#import "USBaseViewController.h"
#import "USBaseAuthorViewController.h"
@protocol ScanDelegate<NSObject>
-(void) didCashierClick:(NSDictionary *)data;
@end
@protocol TicketDelegate<NSObject>
-(void) didTicketClick:(NSDictionary *)data;
@end
@interface USScanCodeResultViewController : USBaseAuthorViewController<ScanDelegate,TicketDelegate>
@property(nonatomic,copy)NSString   *orderStr;

@end
