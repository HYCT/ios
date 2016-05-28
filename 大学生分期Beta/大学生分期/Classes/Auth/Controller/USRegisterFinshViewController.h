//
//  USRegisterViewController.h
//  大学生分期
//
//  Created by HeXianShan on 15/9/6.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//
#import "USBaseAuthorViewController.h"
#import "USUpLoadImageServiceTool.h"
#import "USUpLoadImageServiceTool.h"
@interface USRegisterFinshViewController : USBaseAuthorViewController
@property(nonatomic,copy)NSString *telPhone;
@property(nonatomic,copy)NSString *askCode;
@property(nonatomic,strong)USUpLoadImageServiceTool *upLoadImageService;
@end
