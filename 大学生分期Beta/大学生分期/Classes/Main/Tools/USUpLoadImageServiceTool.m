//
//  USUpLoadImageServiceTool.m
//  大学生分期
//
//  Created by HeXianShan on 15/10/4.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USUpLoadImageServiceTool.h"

@implementation USUpLoadImageServiceTool
-(void)pickImage{
   _tipTitle = _tipTitle==nil?@"请选择头像来源":_tipTitle;
    UIActionSheet* actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:_tipTitle
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"照相机",/*@"摄像机",*/@"本地相簿",@"本地相册",nil];
    
    [actionSheet showInView:[[UIApplication sharedApplication].delegate window].rootViewController.view];
}


#pragma mark -
#pragma UIActionSheet Delegate isSourceTypeAvailable
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    switch (buttonIndex) {
        case 0://照相机
        {
           
            //imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera errorMsg:@"无法访问相机" tipMsg:@"请在iPhone的\"设置-隐私-相机\"中允许访问相机"];
            //[toVC presentViewController:imagePicker animated:YES completion:nil];
        }
            break;
//        case 1://摄像机
//        {
//            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
//            imagePicker.delegate = self;
//            imagePicker.allowsEditing = YES;
//            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
//            imagePicker.videoQuality = UIImagePickerControllerQualityTypeLow;
//            [toVC presentViewController:imagePicker animated:YES completion:nil];
//        }
//            break;
        case 1://本地相簿
        {
//            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
//            imagePicker.delegate = self;
//            imagePicker.allowsEditing = YES;
//            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //[toVC presentViewController:imagePicker animated:YES completion:nil];
             //[self isSourceTypeAvailable:imagePicker errorMsg:@"无法访问相册" tipMsg:@"请在iPhone的\"设置-隐私-相册\"中允许访问相册"];
             [self isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary errorMsg:@"无法访问相册" tipMsg:@"请在iPhone的\"设置-隐私-相册\"中允许访问相册"];
        }
            break;
        case 2://本地相簿
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
          //  [toVC presentViewController:imagePicker animated:YES completion:nil];
           // [self isSourceTypeAvailable:imagePicker errorMsg:@"无法访问相册" tipMsg:@"请在iPhone的\"设置-隐私-相册\"中允许访问相册"];
            [self isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum errorMsg:@"无法访问相册" tipMsg:@"请在iPhone的\"设置-隐私-相册\"中允许访问相册"];
        }
            break;
            
    }
    
}
-(void)isSourceTypeAvailable:(UIImagePickerControllerSourceType )sourceType errorMsg:(NSString *)errorMsg tipMsg:(NSString *)tipMsg{
    BOOL flag = [UIImagePickerController isSourceTypeAvailable:sourceType];
    if (flag&&(sourceType==UIImagePickerControllerSourceTypeCamera)) {
        flag = flag&& ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]||[UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]);
    }
    if (flag) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = sourceType;
      UIViewController *toVC = [[UIApplication sharedApplication].delegate window].rootViewController;
     [toVC presentViewController:imagePicker animated:YES completion:nil];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:errorMsg message:tipMsg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
    
    [self performSelector:@selector(saveImage:)  withObject:img afterDelay:0.5];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#warning 这里要上传图像
-(void)saveImage:(UIImage *)image{
    if (_saveImageBlock) {
       
             self.saveImageBlock(image);
        }else{
         
        }
        
    //}
}

@end
