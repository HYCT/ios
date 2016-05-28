//
//  USWebTool.h
//  大学生分期
//
//  Created by HeXianShan on 15/10/7.
//  Copyright © 2015年 hongyunct. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD+MJ.h"
typedef void (^Success)(id );
typedef void (^Failure)(id );
@interface USWebTool : NSObject
+(void)GET:(NSString *)url  paramDic:(NSDictionary *)paramDic success:(Success)success  failure:(Failure)failure;
+(void)GET:(NSString *)url showMsg:(NSString *)msg paramDic:(NSDictionary *)paramDic success:(Success)success;
+(void)POST:(NSString *)url  paramDic:(NSDictionary *)paramDic success:(Success)success failure:(Failure)failure;
+(void)GET:(NSString *)url showMsg:(NSString *)msg paramDic:(NSDictionary *)paramDic success:(Success)success
   failure:(Failure)failure;
+(void)POSTWithNoTip:(NSString *)url showMsg:(NSString *)msg paramDic:(NSDictionary *)paramDic success:(Success)success;
+(void)POST:(NSString *)url showMsg:(NSString *)msg paramDic:(NSDictionary *)paramDic success:(Success)success;
+(void)POST:(NSString *)url showMsg:(NSString *)msg paramDic:(NSDictionary *)paramDic success:(Success)success
    failure:(Failure)failure;
+(void)POST:(NSString *)url showMsg:(NSString *)msg paramDic:(NSDictionary *)paramDic success:(Success)success
    failure:(Failure)failure toView:(UIView *)toView;
+(void)POST:(NSString *)url paramDiC:(NSMutableDictionary *)paramDic uploadimgFilephoto: (NSData*) uploadimgFilephoto success:(Success)success failure:(Failure)failure;
+(void)POST:(NSString *)url showMsg:(NSString *)msg paramDiC:(NSDictionary *)paramDic fileParamDic: (NSDictionary *)fileParamDic success:(Success)success
    failure:(Failure)failure;
+(void)POSTOrder:(NSString *)url showMsg:(NSString *)msg paramDic:(NSDictionary *)paramDic success:(Success)success
         failure:(Failure)failure;
+(void)POSTShowMsg:(NSString *)url showMsg:(NSString *)msg paramDic:(NSDictionary *)paramDic success:(Success)success
           failure:(Failure)failure;
+(void)POST:(NSString *)url showMsg:(NSString *)msg paramDiC:(NSDictionary *)paramDic fileName:(NSString *)fileName dataArray:(NSArray *) datas success:(Success)success
    failure:(Failure)failure;
//检查更新
+(void)POSTJS:(NSString *)url  paramDic:(NSDictionary *)paramDic success:(Success)success failure:(Failure)failure;
/**
 post 提交 已经做了提示信息，页面无需在做提示，只需要做其他处理
 **/
+(void)POSTWIthTip:(NSString *)url showMsg:(NSString *)msg paramDic:(NSDictionary *)paramDic success:(Success)success
           failure:(Failure)failure;

/**
 分页提交--------分页提交--------分页提交--------分页提交--------
 **/
+(void)POSTPageWIthTip:(NSString *)url showMsg:(NSString *)msg paramDic:(NSDictionary *)paramDic success:(Success)success
               failure:(Failure)failure;
@end
