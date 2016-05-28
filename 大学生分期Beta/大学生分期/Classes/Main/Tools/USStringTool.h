//
//  USStringTool.h
//  大学生分期
//
//  Created by HeXianShan on 15/9/19.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface USStringTool : NSObject
+(NSString *)validCode;
+(BOOL)isSuccess:(id)dic;
+(NSString *)getCurrencyStr:(CGFloat)currency;
+(NSString *)getBankCardNoString:(NSString *)bankCardno;
/**
 *
 *
 *  @param formatStr 指定内容的字符串
 *
 *  @return 会把指定内容的字符串从第2个字符到倒数第二个字符编程橘黄色
 */
+(NSMutableAttributedString *)createCountBlanceAttrStringWithFormat:(NSString *)formatStr;
+(NSMutableAttributedString *)createCountBlanceAttrString:(CGFloat)result;
+(NSString *)getFomaterTelNoStr:(NSString *)telNo;
+(CGSize)boundingRectWithSize:(CGSize)size content:(NSString *)content fontsize:(CGFloat)fontSize;
+(NSString *)geStarString:(NSString *)str lastCount:(NSInteger )count;
+(BOOL)compareDate;
@end
