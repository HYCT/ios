//
//  USTempData.h
//  大学生分期
//
//  Created by HeXianShan on 15/10/7.
//  Copyright © 2015年 hongyunct. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface USTempData : NSObject
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *name;
+(instancetype)dataWithId:(NSString *)_id name:(NSString *)name;
@end
