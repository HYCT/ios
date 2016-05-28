//
//  USTempData.m
//  大学生分期
//
//  Created by HeXianShan on 15/10/7.
//  Copyright © 2015年 hongyunct. All rights reserved.
//

#import "USTempData.h"

@implementation USTempData
+(instancetype)dataWithId:(NSString *)_id name:(NSString *)name{
    USTempData *data = [[USTempData alloc]init];
    data.id = _id;
    data.name = name;
    return data;
}
@end
