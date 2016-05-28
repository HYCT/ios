//
//  USUpLoadImageServiceTool.h
//  大学生分期
//
//  Created by HeXianShan on 15/10/4.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef  void(^SaveImageBlock) (UIImage *);
@interface USUpLoadImageServiceTool : NSObject<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
@property(nonatomic,copy)SaveImageBlock saveImageBlock;
@property(nonatomic,copy)NSString *tipTitle;
-(void)pickImage;
@end
