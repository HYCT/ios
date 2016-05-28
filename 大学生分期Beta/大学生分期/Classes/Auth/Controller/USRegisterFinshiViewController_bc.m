//
//  USRegisterFinshiViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/7.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USRegisterFinshiViewController_bc.h"
#import "USTextFieldTool.h"
#import "USMainUITabBarController.h"
#import "USUserService.h"
#import "MBProgressHUD+MJ.h"
@interface USRegisterFinshiViewController_bc ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UserServiceDelegate>
@property(nonatomic,strong)UIButton *headerButton;
@property(nonatomic,strong)UITextField *nikeNameTF;
@property(nonatomic,strong)UIButton *finishButton;
@property(nonatomic,strong)UIImage *headerImage;
@end

@implementation USRegisterFinshiViewController_bc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    [super initLeftItemBar];
    UIView *headerView = [self createHeaderView];
    [self initHeaderButton];
    //
      _nikeNameTF = [USTextFieldTool createTextFieldWithPlaceholder:@"设置昵称" target:self leftImage:nil];
    _nikeNameTF.y = headerView.y+headerView.height+50;
     [self.view addSubview:_nikeNameTF];
    //
    _finishButton = [USUIViewTool createButtonWith:@"完  成" imageName:@"login_bt_img"];
    _finishButton.frame = CGRectMake(10, _nikeNameTF.y+_nikeNameTF.height+15, kAppWidth-20, 35);
    [self.view addSubview: _finishButton];
    _finishButton.enabled = [self isCanCommite];
    [_finishButton addTarget:self action:@selector(finish) forControlEvents:UIControlEventTouchUpInside];
}
-(void)finish{
    HYLog(@"----finish--");
    //
    [USUserService registerWithTelePhone:_telphone pwd:_pwd inviter:_askCode name:_nikeNameTF.text uploadimgFilephoto:UIImagePNGRepresentation(_headerImage) delegate:self];
   
}
-(void)didSuccessFinish{
    [MBProgressHUD showSuccess:@"注册成功!"];
    USMainUITabBarController *mainCV = [[USMainUITabBarController alloc]init];
    mainCV.selectedViewController = mainCV.accountnNavViewController;
    [[[UIApplication sharedApplication] delegate] window].rootViewController = mainCV;
    [self removeFromParentViewController];
}
-(void)uploadHeaderImage{
    UIActionSheet* actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"请选择文件来源"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"照相机",@"摄像机",@"本地相簿",nil];
    [actionSheet showInView:self.view];
}
-(void)initHeaderButton{
   
}
-(void)dissView{
    [super.topView removeFromSuperview];
    [self updateRespons];
    _finishButton.enabled = [self isCanCommite];
    HYLog(@"dissView");
}
-(void)updateRespons{
    [_nikeNameTF resignFirstResponder];
}
-(BOOL)isCanCommite{
     BOOL flag = _headerImage != nil;
    return  flag&& [_nikeNameTF.text length]>1;

}
-(UIView *)createHeaderView{
   
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0,super.logoImageView.y+ super.logoImageView.height+20, kAppWidth, 50)];
    _headerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _headerButton.frame = CGRectMake(headerView.width/2-headerView.width/4/2, 0, headerView.width/4, headerView.width/4);
    [_headerButton.layer setMasksToBounds:YES];
    [_headerButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_headerButton setBackgroundImage:[UIImage imageNamed:@"register_header"] forState:UIControlStateNormal];
     [_headerButton setBackgroundImage:[UIImage imageNamed:@"register_header"] forState:UIControlStateHighlighted];
    [_headerButton.layer setCornerRadius:_headerButton.frame.size.width/2];
     [_headerButton setTitle:@"上传头像" forState:UIControlStateNormal];
     [_headerButton setTitle:@"上传头像" forState:UIControlStateHighlighted];
    [_headerButton addTarget:self action:@selector(uploadHeaderImage) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:_headerButton];
    [self.view addSubview:headerView];
    return headerView;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self dissView];
}
#pragma mark -
#pragma UIActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0://照相机
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
            break;
        case 1://摄像机
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.videoQuality = UIImagePickerControllerQualityTypeLow;
            //            [self presentModalViewController:imagePicker animated:YES];
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
            break;
        case 2://本地相簿
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //            [self presentModalViewController:imagePicker animated:YES];
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
            break;
       
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
    //    [picker dismissModalViewControllerAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)saveImage:(UIImage *)image{
    [_headerButton setBackgroundImage:image forState:UIControlStateNormal];
    [_headerButton setBackgroundImage:image forState:UIControlStateHighlighted];
    [_headerButton setTitle:@"" forState:UIControlStateNormal];
    [_headerButton setTitle:@"" forState:UIControlStateHighlighted];
    _headerImage = image;
}
@end
