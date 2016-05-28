//
//  USCertificationViewController.h
//  大学生分期
//
//  Created by HeXianShan on 15/9/9.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USBaseViewController.h"
#import "USBaseAuthorViewController.h"
#import "USUpLoadImageServiceTool.h"
@interface USCertificationViewController : USBaseAuthorViewController<UIImagePickerControllerDelegate>
@property(nonatomic,strong)USUpLoadImageServiceTool *upLoadImageService;
@end
