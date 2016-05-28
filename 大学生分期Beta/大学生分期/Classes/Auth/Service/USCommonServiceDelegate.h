//
//  USCommonServiceDelegate.h
//  大学生分期
//
//  Created by HeXianShan on 15/9/20.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol USCommonServiceDelegate <NSObject>
@optional
-(void)didSuccessFinish;
-(void)didSuccessFinishWithDic:(NSDictionary *)dic;
-(void)didSuccessFinishWithArray:(NSArray *)array;
@end
