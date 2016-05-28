//
//  USNearBaseViewCellViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/28.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USMerchantBaseViewController.h"
#import "USSendMessageViewController.h"
#import "USUpLoadImageServiceTool.h"
@interface USMerchantBaseViewController ()
@property(nonatomic,strong)USUpLoadImageServiceTool *uploadService;
@end

@implementation USMerchantBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationController.navigationBar.translucent= NO;
}




-(void)initRightButton{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.backgroundColor = [UIColor clearColor];
    UIFont *font = [UIFont systemFontOfSize:kCommonNavFontSize];
    [rightButton.titleLabel setFont:font];
    NSString *rightTitle = @"注册";
    [rightButton setTitle:rightTitle forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightButton.size = CGSizeMake(60, 24);
    [rightButton.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [rightButton addTarget:self action:@selector(right) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}

-(void)initRightImgButton{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.backgroundColor = [UIColor clearColor];
    UIImage *carmerImage = [UIImage imageNamed:@"carmer_right_bg"];
    rightButton.size = carmerImage.size;
    [rightButton setImage:carmerImage forState:UIControlStateNormal];
    [rightButton setImage:carmerImage forState:UIControlStateHighlighted];
    [rightButton addTarget:self action:@selector(right) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}
-(void)pop{
   NSArray *childs = [self.navigationController childViewControllers];
    NSInteger index = -1;
    for (NSInteger i =0;i<childs.count ; i++) {
        if ([childs[i] isKindOfClass:[USSendMessageViewController class]]) {
            index = i;
        }
    }
    if ((index-1)>=0) {
         UIViewController *vc = childs[index-1];
        [self.navigationController popToViewController:vc animated:YES];
        [childs[index] removeFromParentViewController];
    }else{
       [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)right{
    if (_uploadService==nil) {
        USUpLoadImageServiceTool *uploadService = [[USUpLoadImageServiceTool alloc]init];
        _uploadService = uploadService;
        __block UIViewController *blockVC = self;
        _uploadService.tipTitle = @"请选择要发布的图片来源";
        _uploadService.saveImageBlock = ^(UIImage *image){
            USSendMessageViewController *sendVC = [[USSendMessageViewController alloc]init];
            sendVC.selectedImage = image;
            [blockVC.navigationController pushViewController:sendVC animated:YES];
        };
    }
   
    [_uploadService pickImage];
   
}
@end
