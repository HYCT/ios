//
//  USHomeService.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/20.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USHomeService.h"

@implementation USHomeService
+(void)fetchIndexImagesWithDelegate:(id<USCommonServiceDelegate>)delegate{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    
    [mgr POST:HYWebDataPath(@"firstpageimgcilent/imagelist.action") parameters:paramDic  success:^(AFHTTPRequestOperation *operation, id responseObject) {
         HYLog(@"%@",responseObject);
        if ([USStringTool isSuccess:responseObject]) {
            if([delegate respondsToSelector:@selector(didSuccessFinishWithArray:)]){
                [delegate didSuccessFinishWithArray:responseObject];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HYLog(@"%@",error.userInfo);
        [MBProgressHUD showError:@"网络错误，请检查网络设置..."];
      
    }];

}
@end
