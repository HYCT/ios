//
//  USListDelegate.h
//  大学生分期
//
//  Created by mac on 16/5/31.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol USBankCardListCommonDelegate <NSObject>

@required
-(void)BankCardListClickReturn:(NSDictionary *)data type:(NSString *)type;
@end
