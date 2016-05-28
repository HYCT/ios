//
//  USStringTool.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/19.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USStringTool.h"
static NSNumberFormatter *numFormatter;
@implementation USStringTool
+(NSString *)validCode{
    NSMutableString *mutabString = [NSMutableString string];
    for (NSInteger i = 0 ; i<6; i++) {
        NSString *chara = [NSString stringWithFormat:@"%d",arc4random()%10];
        [mutabString appendString:chara];
    }
    return mutabString;
}
+(BOOL)isSuccess:(id)dic{
   NSString *success = dic[@"result"];
    NSString *error = dic[@"error"];
    if ((error==nil||error.length==0)&&success!=nil) {
         success = [NSString stringWithFormat:@"%@",success];
        return [@"true" isEqualToString:success] || [@"1" isEqualToString:success];
    }
   
    return NO;
}
+(NSString *)getCurrencyStr:(CGFloat)currency{
    if (numFormatter==nil) {
        numFormatter = [[NSNumberFormatter alloc] init];
        [numFormatter setPositiveFormat:@"###,##0.00;"];
    }
    return [numFormatter stringFromNumber:[NSNumber numberWithFloat:currency]];
}
+(NSString *)getBankCardNoString:(NSString *)bankCardno{
    if (([bankCardno length] == 16)||([bankCardno length] == 15)||([bankCardno length] == 19)||([bankCardno length] == 18)) {
        NSMutableString *mutableString = [NSMutableString string];
        for (int i = 1;i<=(bankCardno.length); i++) {
            
            [mutableString appendString:@"*"];
            if (i>([bankCardno length]-5)) {
                [mutableString appendString:@" "];
                break;
            }
            if (i%4==0) {
                 [mutableString appendString:@" "];
            }
        }
        [mutableString appendString:[bankCardno substringFromIndex:[bankCardno length]-4]];
        return mutableString;
    }
    return bankCardno;
}
+(NSString *)geStarString:(NSString *)str lastCount:(NSInteger )count{
    if (str==nil||str.length<=count) {
        return str;
    }
    NSMutableString *mutableString = [NSMutableString string];
    for (int i = 1;i<=(str.length-count); i++) {
        
        [mutableString appendString:@"*"];
    }
    [mutableString appendString:[str substringFromIndex:[str length]-count]];
    return mutableString;
}
/**
 *
 *
 *  @param formatStr 指定内容的字符串
 *
 *  @return 会把指定内容的字符串从第2个字符到倒数第二个字符编程橘黄色
 */
+(NSMutableAttributedString *)createCountBlanceAttrStringWithFormat:(NSString *)formatStr{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:formatStr];
    [str addAttribute:NSForegroundColorAttributeName value:HYCTColor(170, 170, 170) range:NSMakeRange(0,str.length)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kCommonFontSize_18] range:NSMakeRange(0,str.length)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(2,str.length-3)];
    return str;
}
+(NSMutableAttributedString *)createCountBlanceAttrString:(CGFloat)result{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"已选%@元",[USStringTool getCurrencyStr:result]]];
    [str addAttribute:NSForegroundColorAttributeName value:HYCTColor(170, 170, 170) range:NSMakeRange(0,str.length)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kCommonFontSize_18] range:NSMakeRange(0,str.length)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(2,str.length-3)];
    return str;
}
+(NSString *)getFomaterTelNoStr:(NSString *)telNo{
    NSMutableString *mutableString = [NSMutableString string];
    for (int i = 0;i<telNo.length; i++) {
        if (i<3) {
            [mutableString appendString:[telNo substringWithRange:NSMakeRange(i,1)]];
        }else if (i>2&&i<8){
          [mutableString appendString:@"*"];
        }else if (i>7){
          [mutableString appendString:[telNo substringWithRange:NSMakeRange(i,1)]];
        }
    }
    return mutableString;
}
+(CGSize)boundingRectWithSize:(CGSize)size content:(NSString *)content fontsize:(CGFloat)fontSize{
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    CGSize retSize = [content boundingRectWithSize:size
                                           options:
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                        attributes:attribute
                                           context:nil].size;
    
    return retSize;
}
+(BOOL)compareDate{
    /**
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSDate *dt1 = [[NSDate alloc] init];
    NSDate *dt2 = [df dateFromString:@"2016-01-20"];
    dt1 = [df dateFromString:[df stringFromDate:dt1]];
    NSComparisonResult result = [dt1 compare:dt2];
    return result == NSOrderedAscending;
     **/
    return YES ;
//    switch (result)
//    {
//            //date02比date01大
//        case NSOrderedAscending: return YES;
//            //date02比date01小
//        case NSOrderedDescending: return NO;
//
//    }
//    return NO;
}


@end
