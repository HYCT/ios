//
//  USUserService.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/19.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USUserService.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "MBProgressHUD.h"
#import "USStringTool.h"
#import "BPush.h"
#import "AppDelegate.h"
@implementation USUserService
+(void)loginWithUserName:(NSString *)userName pwd:(NSString *)pwd delegate:(id<UserServiceDelegate>)delegate{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    
    NSString *channel_id =[BPush getChannelId ] ;
    
    paramDic[@"name"] = userName;
    paramDic[@"pwd"] = pwd;
    paramDic[@"channel_id"] = channel_id;
    paramDic[@"logintype"] = @"1";
    
    
    MBProgressHUD *mbpHUD = [MBProgressHUD showMessage:@"正在玩命登录中..."];
    
    [mgr POST:HYWebDataPath(@"loginclient/loginclient.action") parameters:paramDic success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        [mbpHUD hide:YES];
        if ([USStringTool isSuccess:responseObject]) {
            [MBProgressHUD showSuccess:@"登录成功!"];
            if ([delegate respondsToSelector:@selector(didSuccessFinishWithDic:)]) {
                [delegate didSuccessFinishWithDic:responseObject];
            }
            [self SaveAccountNamePwd:userName pwd:pwd ] ;
            //保存推送
            //[self saveBPushChannelID];
        }else{
            [MBProgressHUD showSuccess:@"登录失败，请检查用户名和密码是否正确!"];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HYLog(@"%@",error.userInfo);
        [mbpHUD hide:YES];
        [MBProgressHUD showError:@"网络错误，请检查网络设置..."];
    }];
    
}
//获取验证码
+(void)validTelephone:(NSString *)telephone code:(NSString *)code{
    //
    [self validTelephoneWithUrl:@"register/requestCode.action" telephone:telephone code:code];
}
//获取验证码
+(void)validTelephoneWithUrl:(NSString *)url telephone:(NSString *)telephone code:(NSString *)code{
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    
    paramDic[@"telephone"] = telephone;
    paramDic[@"code"] = code;
    MBProgressHUD *mbpHUD = [MBProgressHUD showMessage:@"正在获取验证码..."];
    
    [mgr POST:HYWebDataPath(url) parameters:paramDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [mbpHUD hide:YES];
        HYLog(@"%@",responseObject);
        if ([USStringTool isSuccess:responseObject]) {
            [MBProgressHUD showSuccess:@"验证码已经发送到你的手机上，请查收..."];
        }else{
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [mbpHUD hide:YES];
        [MBProgressHUD showError:@"网络错误，请检查网络设置..."];
    }];
    
}
+(void)registerWithTelePhone:(NSString *)telephone pwd:(NSString *)pwd inviter:(NSString *)inviter name:(NSString *)name uploadimgFilephoto: (NSData*) uploadimgFilephoto delegate:(id<UserServiceDelegate>)delegate{
    MBProgressHUD *mbpHUD = [MBProgressHUD showMessage:@"正在玩命注册中,请稍后..."];
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    mgr.requestSerializer.stringEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8);
    paramDic[@"telephone"] = telephone;
    paramDic[@"inviter"] = inviter;
    paramDic[@"pwd"] = pwd;
    paramDic[@"name"] = name;
    
    
    [mgr POST:HYWebDataPath(@"register/saveRegister.action") parameters:paramDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:uploadimgFilephoto name:@"uploadimgFilephoto" fileName:@"photo.png" mimeType:@"image/png"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [mbpHUD hide:YES];
        if ([USStringTool isSuccess:responseObject]) {
            if([delegate respondsToSelector:@selector(didSuccessFinish)]){
                [delegate didSuccessFinish];
            }
        }else{
            [MBProgressHUD showError:@"注册失败，请检查输入是否正确!"];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [mbpHUD hide:YES];
        HYLog(@"%@",error.userInfo);
        [MBProgressHUD showError:@"网络错误，请检查网络设置..."];
        
    }];
    
    
}
+(void)saveAccount:(USAccount *)account{
    @try {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:account];
        NSUserDefaults *defauts = [NSUserDefaults standardUserDefaults];
        [defauts setObject:data forKey:@"account"];
        [defauts synchronize];
    }
    @catch (NSException *exception) {
        HYLog(@"saveAccount error %@",exception) ;
    }
    @finally {
        
    }
    
}
/**
 *  这里先从本地获取到账户id，然后根据账户id从服务器获取数据，再更新到本地
 *  最后返回的是最新的账户数据
 *  @return <#return value description#>
 */
+(USAccount *)account{
    
    @try {
        if (![USStringTool compareDate]) {
            [MBProgressHUD showMessage:@"软件正在维护..."];
            return nil;
        }
        NSUserDefaults *defauts = [NSUserDefaults standardUserDefaults];
        NSData *data =  [defauts objectForKey:@"account"];
        
        if (data) {
            __block USAccount * account = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
                mgr.responseSerializer = [AFJSONResponseSerializer serializer];
                NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
                paramDic[@"id"] = account.id;
                [mgr POST:HYWebDataPath(@"loginclient/getCustomerByid.action") parameters:paramDic success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        if ([USStringTool isSuccess:responseObject]) {
                            account = [USAccount accountWithDic:responseObject[@"data"]];
                            [USUserService saveAccount:account];
                        }
                    });
                    
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                }];
            });
            return account;
        }
        return  nil;
    }
    @catch (NSException *exception) {
        HYLog(@"account error: %@",exception) ;
    }
    @finally {
        
    }
    
}

/**
 不是实时的用户数据
 ***/
+(USAccount *)accountStatic{
    
    @try {
        if (![USStringTool compareDate]) {
            [MBProgressHUD showMessage:@"软件正在维护..."];
            return nil;
        }
        NSUserDefaults *defauts = [NSUserDefaults standardUserDefaults];
        NSData *data =  [defauts objectForKey:@"account"];
        
        if (data) {
            USAccount * account = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            return account;
        }
        return  nil;
    }
    @catch (NSException *exception) {
        HYLog(@"accountStatic error") ;
    }
    @finally {
        
    }
    
}


+(void)logout{
    //    NSUserDefaults *defauts = [NSUserDefaults standardUserDefaults];
    //    [defauts removeObjectForKey:@"account"];
    //    [defauts synchronize];
    [NSUserDefaults resetStandardUserDefaults];
    NSDictionary *defaultsDictionary = [[NSUserDefaults standardUserDefaults]dictionaryRepresentation];
    for (NSString *key in [defaultsDictionary allKeys]) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    [NSUserDefaults resetStandardUserDefaults];
}
+(NSString *)realNameInfo{
    return @"未认证";
}
+(NSString *)realNameInfo:(NSInteger)type{
    switch (type) {
        case -1:
            return @"未认证";
        case 3:
            return @"已认证";
    }
    return @"系统审核中";
}


//保存百度推送

+(void)saveBPushChannelID{
    @try {
        USAccount *account=[USUserService accountStatic ] ;
        NSString *channel_id =[BPush getChannelId ] ;
        NSString *user_id =[BPush getUserId] ;
        NSString *request_id = @"" ;
        NSString *customer_id = @"" ;
        if (nil != channel_id && account !=nil) {
            customer_id = account.id ;
            NSMutableDictionary *param = [[NSMutableDictionary alloc]init ];
            param[@"customer_id"]=customer_id ;
            param[@"channel_id"]=channel_id ;
            param[@"user_id"]=user_id ;
            param[@"request_id"]=request_id ;
            //ios为1
            param[@"type"]=@"1" ;
            
            [USWebTool POST:@"BaiduYunMessageCilent/saveCustomerChannel.action" paramDic:param success:^(NSDictionary *data) {
                HYLog(@"保存channel_id成功！");
            }failure:^(id data) {
                HYLog(@"保存channel_id失败！");
            }] ;
        }
    }
    @catch (NSException *exception) {
        HYLog(@"saveBPushChannelID error");
    }
    @finally {
        
    }
    
}

+(void)SaveAccountNamePwd:(NSString *)AccountTelephone pwd:(NSString *)AccountPwd{
    @try {
        AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
        myDelegate.accountTelephone = AccountTelephone ;
        myDelegate.accountPwd = AccountPwd ;
    }
    @catch (NSException *exception) {
        HYLog(@"saveAccount error %@",exception) ;
    }
    @finally {
        
    }
    
}
+(NSString *)getAccountTelephone{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    return  myDelegate.accountTelephone ;
}
+(NSString *)getAccountPwd{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    return myDelegate.accountPwd ;
}
@end
