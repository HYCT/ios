//
//  USMyInviteViewController.m
//  大学生分期
//
//  Created by HeXianShan on 16/1/9.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import "USMyInviteViewController.h"
#import "USUpImageDownLabelView.h"
#import "USUpLoadImageServiceTool.h"
#import "USMyInvitListViewController.h"
#import "USMyJoinIvitListViewController.h"
#import "USMyJoinIvitListViewController.h"
@interface USMyInviteViewController ()
@property(nonatomic,strong) USUpImageDownLabelView *upImgDownLBView;
@property(nonatomic,strong)USUpLoadImageServiceTool *upLoadImageService;
@property(nonatomic,strong)USAccount *account;
@property(nonatomic,strong) NSMutableArray *buttuns;
@property(nonatomic,strong)USMyInvitListViewController *mySendVC;
@property(nonatomic,strong)USMyJoinIvitListViewController *myJoinVC;
@property(nonatomic,strong)UIView  *buttunsView;
@end

@implementation USMyInviteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent= NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _account = [USUserService accountStatic];
    self.title = @"我的邀约";
    [self.view addSubview:[self createNearTopPersonView]];
    
    [self createButtons];
}

//头部
-(UIView *)createNearTopPersonView{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kAppWidth, 100)];
    topView.userInteractionEnabled = YES;
    //topView.backgroundColor = HYCTColor(168, 168, 168);
    USUpImageDownLabelView *upImgDownLBView = [[USUpImageDownLabelView alloc]initWithFrame:CGRectMake(0, 15, kAppWidth, 100)];
    _upImgDownLBView = upImgDownLBView;
    [upImgDownLBView setBackgroundColor:[UIColor clearColor]];
    upImgDownLBView.personImageView.size = CGSizeMake(57, 57);
    if (_account!=nil) {
        upImgDownLBView.personImageView.image = _account.headerImg;
        [upImgDownLBView.accountNameLabel setText:_account.name];
    }else{
        upImgDownLBView.personImageView.image = [UIImage imageNamed:@"account_seconde_image"];
        [upImgDownLBView.accountNameLabel setText:@"未知"];
    }
    //    UIButton *carmera = [USUIViewTool createButtonWith:@"" imageName:@"account_camera"];
    //    carmera.frame = CGRectMake(_upImgDownLBView.personImageView.width*0.80+_upImgDownLBView.personImageView.x, _upImgDownLBView.personImageView.height*0.9-kPhotoImageSize, kPhotoImageSize, kPhotoImageSize);
    //    [_upImgDownLBView addSubview:carmera];
    //    //[carmera addTarget:self action:@selector(carmera) forControlEvents:UIControlEventTouchUpInside];
    //
    upImgDownLBView.accountNameLabel.height = 25;
    [upImgDownLBView.accountNameLabel setTextColor:[UIColor blackColor]];
    [upImgDownLBView updateFrame];
    upImgDownLBView.accountNameLabel.y-=5;
    [topView addSubview:upImgDownLBView];
    return  topView;
}
//我发起,我参与
-(void)createButtons{
    UIView *buttonsBigView = [[UIView alloc]initWithFrame:CGRectMake(0, 110, kAppWidth, 40)];
    buttonsBigView.backgroundColor = [UIColor whiteColor];
    _buttunsView = buttonsBigView;
    NSArray *buttonTitles = @[@"我发起",@"我参与"];
    
    __block CGFloat width = kAppWidth/2;
    __block CGFloat x = (kAppWidth-width*2)*0.5;
    _buttuns = [NSMutableArray array];
    
    [buttonTitles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 5, width, kCommonFontSize_30);
        button.x = x+5;
        button.tag = idx;
        button.titleLabel.font = [UIFont systemFontOfSize:kCommonFontSize_16];
        [button setTitleColor:HYCTColor(168, 168, 168) forState:UIControlStateNormal];
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        
        [button setTitle:obj forState:UIControlStateNormal];
        [button setTitle:obj forState:UIControlStateHighlighted];
        if (idx == 0) {
            button.selected = true;
        }
        [buttonsBigView addSubview:button];
        x+=width+10;
        [_buttuns addObject:button];
        [button addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    }];
    
    [self.view addSubview:buttonsBigView];
    [self selectButton:[_buttuns firstObject]];
}
-(void)selectButton:(UIButton *)sender{
    [_buttuns enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *objbt = obj;
        objbt.selected = NO;
    }];
    sender.selected = !sender.selected;
    if (sender.tag==0) {
        if (_mySendVC==nil) {
            _mySendVC = [[USMyInvitListViewController alloc]init];
        }
        [self addChildViewController:_mySendVC];
        _mySendVC.view.y=120;
        _mySendVC.view.height=(kAppHeight-120);
        [_myJoinVC.view removeFromSuperview];
        [self.view addSubview:_mySendVC.view];
        [self.view addSubview:_buttunsView];
        
    }else{
        if (_myJoinVC==nil) {
            _myJoinVC = [[USMyJoinIvitListViewController alloc]init];
        }
        [self addChildViewController:_myJoinVC];
        _myJoinVC.view.y=120;
        _myJoinVC.view.height=(kAppHeight-120);
        [_mySendVC.view removeFromSuperview];
        [self.view addSubview:_myJoinVC.view];
        [self.view addSubview:_buttunsView];
    }
}
@end
