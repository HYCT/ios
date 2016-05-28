//
//  USHomeService.h
//  大学生分期
//
//  Created by HeXianShan on 15/9/20.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "USBaseService.h"
@interface USHomeService : NSObject
+(void)fetchIndexImagesWithDelegate:(id<USCommonServiceDelegate>)delegate;
@end
