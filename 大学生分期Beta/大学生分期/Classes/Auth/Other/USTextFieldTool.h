//
//  USTextFieldToo.h
//  大学生分期
//
//  Created by HeXianShan on 15/9/7.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "USTextField.h"
@interface USTextFieldTool : NSObject
+(UITextField *)createTextFieldWithPlaceholder:(NSString *)placeholder target:(id)target leftImage:(NSString *)leftImageName;

+(UITextField *)createTextFieldWithPlaceholder:(NSString *)placeholder target:(id)target leftImage:(NSString *)leftImageName imageFrame:(CGRect)frame;
@end
