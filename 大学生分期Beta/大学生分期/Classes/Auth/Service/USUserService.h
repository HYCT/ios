//
//  USUserService.h
//  大学生分期
//
//  Created by HeXianShan on 15/9/19.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "USAccount.h"
@protocol UserServiceDelegate<USCommonServiceDelegate>

@end

@interface USUserService : NSObject
+(void)loginWithUserName:(NSString *)userName pwd:(NSString *)pwd delegate:(id<UserServiceDelegate>)delegate;
+(void)validTelephone:(NSString *)telephone code:(NSString *)code;
+(void)validTelephoneWithUrl:(NSString *)url telephone:(NSString *)telephone code:(NSString *)code;
+(void)registerWithTelePhone:(NSString *)telephone pwd:(NSString *)pwd inviter:(NSString *)inviter name:(NSString *)name uploadimgFilephoto: (NSData*) uploadimgFilephoto delegate:(id<UserServiceDelegate>)delegate;

+(void)saveAccount:(USAccount *)account;
+(USAccount *)account;
+(USAccount *)accountStatic;
+(void)logout;
+(NSString *)realNameInfo;
+(NSString *)realNameInfo:(NSInteger)type;
//保存百度推送
+(void)saveBPushChannelID;


+(void)SaveAccountNamePwd:(NSString *)AccountTelephone pwd:(NSString *)AccountPwd;
+(NSString *)getAccountTelephone;
+(NSString *)getAccountPwd;
@end
