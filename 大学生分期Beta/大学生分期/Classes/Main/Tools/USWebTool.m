//
//  USWebTool.m
//  大学生分期
//
//  Created by HeXianShan on 15/10/7.
//  Copyright © 2015年 hongyunct. All rights reserved.
//

#import "USWebTool.h"
#import "AFNetworking.h"
#import "USStringTool.h"

@implementation USWebTool
+(void)GET:(NSString *)url  paramDic:(NSDictionary *)paramDic success:(Success)success  failure:(Failure)failure{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
   
    
    [mgr GET:HYWebDataPath(url) parameters:paramDic success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        HYLog(@"%@",responseObject);
       
        if ([USStringTool isSuccess:responseObject]) {
            
            if (success!=nil) {
                success(responseObject);
            }
        }else if (failure!=nil){
            failure(nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HYLog(@"%@",error.userInfo);
        if (failure!=nil){
            failure(nil);
        }
    }];
    
}
+(void)GET:(NSString *)url showMsg:(NSString *)msg paramDic:(NSDictionary *)paramDic success:(Success)success{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    MBProgressHUD *mbpHUD = [MBProgressHUD showMessage:msg];
    
    [mgr GET:HYWebDataPath(url) parameters:paramDic success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        HYLog(@"%@",responseObject);
        [mbpHUD hide:YES];
        if ([USStringTool isSuccess:responseObject]) {
            //[MBProgressHUD showSuccess:responseObject[@"msg"]];
            if (success!=nil) {
                success(responseObject);
            }
        }else{
            //[MBProgressHUD showSuccess:responseObject[@"msg"]];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HYLog(@"%@",error.userInfo);
        [mbpHUD hide:YES];
        [MBProgressHUD showError:@"网络错误，请检查网络设置..."];
    }];
    
}
+(void)GET:(NSString *)url showMsg:(NSString *)msg paramDic:(NSDictionary *)paramDic success:(Success)success
   failure:(Failure)failure{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    MBProgressHUD *mbpHUD = [MBProgressHUD showMessage:msg];
    
    [mgr GET:HYWebDataPath(url) parameters:paramDic success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        HYLog(@"%@",responseObject);
        [mbpHUD hide:YES];
        if ([USStringTool isSuccess:responseObject]) {
            //[MBProgressHUD showSuccess:responseObject[@"msg"]];
            if (success!=nil) {
                success(responseObject);
            }
        }else{
            //[MBProgressHUD showSuccess:responseObject[@"msg"]];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HYLog(@"%@",error.userInfo);
        [mbpHUD hide:YES];
        [MBProgressHUD showError:@"网络错误，请检查网络设置..."];
    }];
    
}
/**
 *  没有提示信息，直接更新页面
 *
 *  @param url      相对url
 *  @param paramDic 参数，不可以上传文件
 *  @param success  在页面上要进行的更改
 */
+(void)POST:(NSString *)url  paramDic:(NSDictionary *)paramDic success:(Success)success failure:(Failure)failure{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    [mgr POST:HYWebDataPath(url) parameters:paramDic success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        HYLog(@"POST response :%@",responseObject);
            if ([USStringTool isSuccess:responseObject]) {
            if (success!=nil) {
                [self lock:success param:responseObject];
            }
            }else if (failure!=nil){
                failure(nil);
            }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HYLog(@"%@",error.userInfo);
        if (failure!=nil){
            failure(nil);
        }
    }];
    
}
+(void)POSTWithNoTip:(NSString *)url showMsg:(NSString *)msg paramDic:(NSDictionary *)paramDic success:(Success)success {
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    //MBProgressHUD *mbpHUD = [MBProgressHUD showMessage:msg];
    MBProgressHUD *mbpHUD = [MBProgressHUD showMessage:msg toView:nil];
    [mgr POST:HYWebDataPath(url) parameters:paramDic success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        HYLog(@"%@",responseObject);
        [mbpHUD hide:YES];
        if ([USStringTool isSuccess:responseObject]) {
            if (success!=nil) {
                [self lock:success param:responseObject];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HYLog(@"%@",error.userInfo);
        [mbpHUD hide:YES];
       
    }];
    
}
+(void)POST:(NSString *)url showMsg:(NSString *)msg paramDic:(NSDictionary *)paramDic success:(Success)success {
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    //MBProgressHUD *mbpHUD = [MBProgressHUD showMessage:msg];
    MBProgressHUD *mbpHUD = [MBProgressHUD showMessage:msg toView:nil];
    [mgr POST:HYWebDataPath(url) parameters:paramDic success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        HYLog(@"%@",responseObject);
        [mbpHUD hide:YES];
        if ([USStringTool isSuccess:responseObject]) {
            if ([responseObject[@"totalNum"]intValue]>0) {
                //[MBProgressHUD showSuccess:responseObject[@"msg"]];
            }
            if (success!=nil) {
                [self lock:success param:responseObject];
            }
        }else{
            //[MBProgressHUD showError:responseObject[@"msg"]];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HYLog(@"%@",error.userInfo);
        [mbpHUD hide:YES];
        [MBProgressHUD showError:@"网络错误，请检查网络设置..."];
    }];
    
}
+(void)lock:(Success)success param:(id)responseObject{
    success(responseObject);
}
+(void)POSTOrder:(NSString *)url showMsg:(NSString *)msg paramDic:(NSDictionary *)paramDic success:(Success)success
    failure:(Failure)failure{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    MBProgressHUD *mbpHUD = [MBProgressHUD showMessage:msg];
    
    [mgr POST:url parameters:paramDic success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        HYLog(@"%@",responseObject);
        [mbpHUD hide:YES];
        NSString *type = responseObject[@"type"];
        if ([@"success" isEqualToString:type]) {
            if (success!=nil) {
                success(responseObject);
            }
        }else{
            [MBProgressHUD showError:responseObject[@"msg"]];
            if (failure!=nil) {
                failure(responseObject);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HYLog(@"%@",error.userInfo);
        [mbpHUD hide:YES];
        [MBProgressHUD showError:@"网络错误，请检查网络设置..."];
        if (failure!=nil) {
            failure(nil);
        }
    }];
    
}

+(void)POST:(NSString *)url showMsg:(NSString *)msg paramDic:(NSDictionary *)paramDic success:(Success)success
    failure:(Failure)failure{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    MBProgressHUD *mbpHUD = [MBProgressHUD showMessage:msg toView:nil];
    //[MBProgressHUD showMessage:msg];
    [mgr POST:HYWebDataPath(url) parameters:paramDic success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        HYLog(@"%@",responseObject);
        [mbpHUD hide:YES];
        if ([USStringTool isSuccess:responseObject]) {
            if ([responseObject[@"totalNum"]intValue]>0) {
               //[MBProgressHUD showSuccess:responseObject[@"msg"]];
            }
            if (success!=nil) {
                success(responseObject);
            }
        }else{
            //[MBProgressHUD showError:responseObject[@"msg"]];
            if (failure!=nil) {
                failure(responseObject);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HYLog(@"%@",error.userInfo);
        [mbpHUD hide:YES];
        [MBProgressHUD showError:@"网络错误，请检查网络设置..."];
        if (failure!=nil) {
            failure(nil);
        }
    }];
    
}

+(void)POSTShowMsg:(NSString *)url showMsg:(NSString *)msg paramDic:(NSDictionary *)paramDic success:(Success)success
    failure:(Failure)failure{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    MBProgressHUD *mbpHUD = [MBProgressHUD showMessage:msg toView:nil];
    [mgr POST:HYWebDataPath(url) parameters:paramDic success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        HYLog(@"%@",responseObject);
        [mbpHUD hide:YES];
        if ([USStringTool isSuccess:responseObject]) {
             //[MBProgressHUD showSuccess:responseObject[@"msg"]];
            
            if (success!=nil) {
                success(responseObject);
            }
        }else{
            //[MBProgressHUD showSuccess:responseObject[@"msg"]];
            if (failure!=nil) {
                failure(responseObject);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HYLog(@"%@",error.userInfo);
        [mbpHUD hide:YES];
        [MBProgressHUD showError:@"网络错误，请检查网络设置..."];
        if (failure!=nil) {
            failure(nil);
        }
    }];
    
}

+(void)POST:(NSString *)url showMsg:(NSString *)msg paramDic:(NSDictionary *)paramDic success:(Success)success
    failure:(Failure)failure toView:(UIView *)toView{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    MBProgressHUD *mbpHUD = [MBProgressHUD showMessage:msg toView:toView];
    
    [mgr POST:HYWebDataPath(url) parameters:paramDic success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        HYLog(@"%@",responseObject);
        [mbpHUD hide:YES];
        if ([USStringTool isSuccess:responseObject]) {
            if ([responseObject[@"totalNum"]intValue]>0) {
               // [MBProgressHUD showSuccess:responseObject[@"msg"] toView:toView];
            }
            if (success!=nil) {
                success(responseObject);
            }
        }else{
            //[MBProgressHUD showError:responseObject[@"msg"] toView:toView];
            if (failure!=nil) {
                failure(responseObject);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HYLog(@"%@",error.userInfo);
        [mbpHUD hide:YES];
        [MBProgressHUD showError:@"网络错误，请检查网络设置..." toView:toView];
        if (failure!=nil) {
            failure(nil);
        }
    }];
    
}
+(void)POST:(NSString *)url  paramDiC:(NSMutableDictionary *)paramDic uploadimgFilephoto: (NSData*) uploadimgFilephoto success:(Success)success
    failure:(Failure)failure{
    //MBProgressHUD *mbpHUD = [MBProgressHUD showMessage:@"正在上传头像..."];
    MBProgressHUD *mbpHUD = [MBProgressHUD showMessage:@"正在上传头像..." toView:nil];
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    [mgr POST:HYWebDataPath(url) parameters:paramDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:uploadimgFilephoto name:@"uploadimgFilephoto" fileName:@"photddd.png" mimeType:@"image/png"];
        //[formData ap]
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [mbpHUD hide:YES];
        HYLog(@"%@",responseObject);
        if ([USStringTool isSuccess:responseObject]) {
            if (success!=nil) {
                success(responseObject);
            }
        }else{
            [MBProgressHUD showError:@"上传头像错误!"];
            if (failure!=nil) {
                failure(responseObject);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [mbpHUD hide:YES];
        HYLog(@"%@",error.userInfo);
        [MBProgressHUD showError:@"网络错误，请检查网络设置..."];
        if (failure!=nil) {
            failure(nil);
        }
    }];
}
+(void)POST:(NSString *)url showMsg:(NSString *)msg paramDiC:(NSDictionary *)paramDic fileParamDic: (NSDictionary *)fileParamDic success:(Success)success
           failure:(Failure)failure{
    MBProgressHUD *mbpHUD = [MBProgressHUD showMessage:msg];

    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
   
    [mgr POST:HYWebDataPath(url) parameters:paramDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [fileParamDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
          [formData appendPartWithFileData:obj name:key fileName:[NSString stringWithFormat:@"%@.png",key] mimeType:@"image/png"];
        }];
     
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [mbpHUD hide:YES];
        HYLog(@"%@",responseObject);
        if ([USStringTool isSuccess:responseObject]) {
            if (success!=nil) {
                success(responseObject);
            }
        }else{
            [MBProgressHUD showError:@"上传文件出错...!"];
            if (failure!=nil) {
                failure(responseObject);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [mbpHUD hide:YES];
         HYLog(@"%@",error.userInfo);
        [MBProgressHUD showError:@"网络错误，请检查网络设置..."];
        if (failure!=nil) {
            failure(nil);
        }
    }];
}
+(void)POST:(NSString *)url showMsg:(NSString *)msg paramDiC:(NSDictionary *)paramDic fileName:(NSString *)fileName dataArray:(NSArray *) datas success:(Success)success
    failure:(Failure)failure{
    MBProgressHUD *mbpHUD = [MBProgressHUD showMessage:msg];
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    [mgr POST:HYWebDataPath(url) parameters:paramDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        [fileParamDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//            [formData appendPartWithFileData:obj name:key fileName:[NSString stringWithFormat:@"%@.png",key] mimeType:@"image/png"];
//        }];
        [datas enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
          [formData appendPartWithFileData:obj name:fileName fileName:[NSString stringWithFormat:@"%@.png",fileName] mimeType:@"image/png"];
        }];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [mbpHUD hide:YES];
        HYLog(@"%@",responseObject);
        if ([USStringTool isSuccess:responseObject]) {
            if (success!=nil) {
                success(responseObject);
            }
        }else{
            [MBProgressHUD showError:@"上传文件出错...!"];
            if (failure!=nil) {
                failure(responseObject);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [mbpHUD hide:YES];
        HYLog(@"%@",error.userInfo);
        [MBProgressHUD showError:@"网络错误，请检查网络设置..."];
        if (failure!=nil) {
            failure(nil);
        }
    }];
}

/**
 **检查更新js
 **/
+(void)POSTJS:(NSString *)url  paramDic:(NSDictionary *)paramDic success:(Success)success failure:(Failure)failure{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    mgr.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"application/javascript", @"text/json", @"text/javascript",@"text/html", @"text/plain",nil];
    [mgr POST:HYWebDataPath(url) parameters:paramDic success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        HYLog(@"%@",responseObject);
        if ([USStringTool isSuccess:responseObject]) {
            if (success!=nil) {
                //[MBProgressHUD showError:@"检查版本更新正确!"];
                [self lock:success param:responseObject];
            }
        }else if (failure!=nil){
            //[MBProgressHUD showError:@"检查版本更新错误!"];
            failure(nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //[MBProgressHUD showError:@"检查版本更新错误!"];
        HYLog(@"%@",error.userInfo);
        if (failure!=nil){
            failure(nil);
        }
    }];
    
}


/**
 post 提交 已经做了提示信息，页面无需在做提示，只需要做其他处理
 **/
+(void)POSTWIthTip:(NSString *)url showMsg:(NSString *)msg paramDic:(NSDictionary *)paramDic success:(Success)success
           failure:(Failure)failure{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    MBProgressHUD *mbpHUD = [MBProgressHUD showMessage:msg toView:nil];
    //[MBProgressHUD showMessage:msg];
    [mgr POST:HYWebDataPath(url) parameters:paramDic success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        HYLog(@"%@",responseObject);
        [mbpHUD hide:YES];
        if ([USStringTool isSuccess:responseObject]) {
            [MBProgressHUD showSuccess:responseObject[@"msg"]];
            if (success!=nil) {
                success(responseObject);
            }
        }else{
            [MBProgressHUD showError:responseObject[@"msg"]];
            if (failure!=nil) {
                failure(responseObject);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HYLog(@"%@",error.userInfo);
        [mbpHUD hide:YES];
        [MBProgressHUD showError:@"网络错误，请检查网络设置..."];
        if (failure!=nil) {
            failure(nil);
        }
    }];
    
}
/**
 分页提交--------分页提交--------分页提交--------分页提交--------
 **/
+(void)POSTPageWIthTip:(NSString *)url showMsg:(NSString *)msg paramDic:(NSDictionary *)paramDic success:(Success)success
           failure:(Failure)failure{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    MBProgressHUD *mbpHUD = [MBProgressHUD showMessage:msg toView:nil];
    //[MBProgressHUD showMessage:msg];
    [mgr POST:HYWebDataPath(url) parameters:paramDic success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        HYLog(@"%@",responseObject);
        [mbpHUD hide:YES];
        if ([USStringTool isSuccess:responseObject]) {
            if([responseObject[@"totalNum"]intValue]<0){
              [MBProgressHUD showError:responseObject[@"暂时没有数据......"]];
            }
            if (success!=nil) {
                success(responseObject);
            }
        }else{
            [MBProgressHUD showError:responseObject[@"msg"]];
            if (failure!=nil) {
                failure(responseObject);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HYLog(@"%@",error.userInfo);
        [mbpHUD hide:YES];
        [MBProgressHUD showError:@"网络错误，请检查网络设置..."];
        if (failure!=nil) {
            failure(nil);
        }
    }];
    
}
@end
