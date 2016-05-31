//
//  USListDelegate.h
//  大学生分期
//
//  Created by mac on 16/5/31.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol USListCommonDelegate <NSObject>

@required
-(void)listClickReturn:(NSDictionary *)data type:(NSString *)type;

// 可选实现的方法
@optional
- (void)other;
- (void)other2;
- (void)other3;
@end
