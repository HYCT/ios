//
//  USNearTopPersonView.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/29.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USNearTopPersonView.h"
#define kMargin 12
#import "USUpLoadImageServiceTool.h"
#import "AFNetworking.h"
@interface USNearTopPersonView ()
@property(nonatomic,strong)USUpLoadImageServiceTool *uploadService;
@property(nonatomic,strong) USAccount *account;
@property(nonatomic,strong) NSString *customerId;
@property(nonatomic,strong)UIButton *changeBgBt;
@property(nonatomic,strong)UIViewController *superVC;
@end
@implementation USNearTopPersonView

-(instancetype)initWithFrame:(CGRect)frame{
    return [self initWithFrame:frame noMotto:YES];
}
-(instancetype)initWithFrame:(CGRect)frame noMotto:(BOOL) noMotto{
    self = [super initWithFrame:frame];
    _noMotto = noMotto;
    USAccount *account = [USUserService accountStatic];
    _account = account;
    self.userInteractionEnabled = YES;
    //头部背景图
    _topBgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kAppWidth, frame.size.height*0.6)];
    [self addSubview:_topBgImageView];
    //默认图片
    UIImage *imagetop = [UIImage imageNamed:@"persontopbg.png"];
    if (nil != account.personnerpic  && account.personnerpic.length!=0) {
        imagetop = account.personnerpicImg ;
    }
    _topBgImageView.image = imagetop;
    UIButton *changeBgBt = [UIButton buttonWithType:UIButtonTypeCustom];
    changeBgBt.frame = _topBgImageView.frame;
    [changeBgBt addTarget:self action:@selector(changeBg) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:changeBgBt];
    //
    UIView *personButtonBg = [[UIView alloc]initWithFrame:CGRectMake(0, _topBgImageView.height*0.75, kAppWidth*0.35+2, kAppWidth*0.35+2)];
    personButtonBg.userInteractionEnabled = YES;
    personButtonBg.x = kAppWidth-kMargin-personButtonBg.width;
    personButtonBg.backgroundColor = [UIColor whiteColor];
    ////
    _personImagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _personImagButton.frame = CGRectMake(2, 2, personButtonBg.width-4, personButtonBg.height-4);
    [_personImagButton setImage:account.headerImg forState:UIControlStateNormal];
    [_personImagButton setImage:account.headerImg forState:UIControlStateHighlighted];
    [_personImagButton addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [personButtonBg addSubview:_personImagButton];
    [self addSubview:personButtonBg];
    
    //
    _nikeNameLB = [USUIViewTool createUILabelWithTitle:account.name fontSize:kCommonFontSize_15 color:HYCTColor(10, 10, 10) heigth:kCommonFontSize_15];
    _nikeNameLB.frame = CGRectMake(0, personButtonBg.y+personButtonBg.height*0.6, kAppWidth-kMargin*2-personButtonBg.width, kCommonFontSize_15);
    _nikeNameLB.textAlignment = NSTextAlignmentRight;
    [self addSubview:_nikeNameLB];
    //
    if (_noMotto) {
        _mottoLB = [USUIViewTool createUILabelWithTitle:account.sign fontSize:kCommonFontSize_15 color:HYCTColor(110, 110, 110) heigth:kCommonFontSize_15];
        _mottoLB.frame = CGRectMake(0, self.height-_mottoLB.height-kMargin*2, kAppWidth-kMargin, kCommonFontSize_15);
        _mottoLB.textAlignment = NSTextAlignmentRight;
        [self addSubview:_mottoLB];
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame noMotto:(BOOL) noMotto customeId:(NSString *)customeId supervc:(UIViewController *)superVC{
    self = [super initWithFrame:frame];
    _superVC = superVC;
    _noMotto = noMotto;
    _customerId = customeId;
    self.userInteractionEnabled = YES;
    _topBgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kAppWidth, frame.size.height*0.6)];
    [self addSubview:_topBgImageView];
    UIImage *image = [UIImage imageNamed:@"persontopbg.png"];
    _topBgImageView.image = image;
    UIButton *changeBgBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _changeBgBt = changeBgBt;
    changeBgBt.enabled = NO;
    changeBgBt.frame = _topBgImageView.frame;
    [changeBgBt addTarget:self action:@selector(changeBg) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:changeBgBt];
    //
    
    UIView *personButtonBg = [[UIView alloc]initWithFrame:CGRectMake(0, _topBgImageView.height*0.75, kAppWidth*0.35+2, kAppWidth*0.35+2)];
    personButtonBg.userInteractionEnabled = YES;
    personButtonBg.x = kAppWidth-kMargin-personButtonBg.width;
    personButtonBg.backgroundColor = [UIColor whiteColor];
    ////
    _personImagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _personImagButton.frame = CGRectMake(2, 2, personButtonBg.width-4, personButtonBg.height-4);
    _personImaView = [[UIImageView alloc]initWithFrame:CGRectMake(2, 2, personButtonBg.width-4, personButtonBg.height-4)];
    [personButtonBg addSubview:_personImaView];
    
    [_personImagButton addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [personButtonBg addSubview:_personImagButton];
    [self addSubview:personButtonBg];
    
    //
    _nikeNameLB = [USUIViewTool createUILabelWithTitle:@"" fontSize:kCommonFontSize_15 color:HYCTColor(10, 10, 10) heigth:kCommonFontSize_15];
    _nikeNameLB.frame = CGRectMake(0, personButtonBg.y+personButtonBg.height*0.6, kAppWidth-kMargin*2-personButtonBg.width, kCommonFontSize_15);
    _nikeNameLB.textAlignment = NSTextAlignmentRight;
    [self addSubview:_nikeNameLB];
    
    //
    if (_noMotto) {
        _mottoLB = [USUIViewTool createUILabelWithTitle:@"" fontSize:kCommonFontSize_15 color:HYCTColor(110, 110, 110) heigth:kCommonFontSize_15];
        _mottoLB.frame = CGRectMake(0, self.height-_mottoLB.height-kMargin*2, kAppWidth-kMargin, kCommonFontSize_15);
        _mottoLB.textAlignment = NSTextAlignmentRight;
        [self addSubview:_mottoLB];
    }
    
    [self loadData:_customerId];
    return self;
}
//加载customer
-(void)loadData:(NSString   *)customeId{
    USAccount *account = [USUserService accountStatic] ;
    if (customeId == account.id) {
        [self setCustomerInfo:account] ;
        return ;
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
        mgr.responseSerializer = [AFJSONResponseSerializer serializer];
        NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
        paramDic[@"id"] = customeId;
        _customerId = customeId;
        [mgr POST:HYWebDataPath(@"loginclient/getCustomerByid.action") parameters:paramDic success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
            if ([USStringTool isSuccess:responseObject]) {
                NSDictionary *dic = responseObject[@"data"];
                HYLog(@"accountdic:%@",dic) ;
                [self setCustomerInfoDic:dic] ;
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        }];
    });
}
//设置用户信息
-(void)setCustomerInfo:(USAccount *)account{
    _nikeNameLB.text = account.name;
    _superVC.title = account.name;
    _mottoLB.text = account.sign;
    [_topBgImageView sd_setImageWithURL:[NSURL URLWithString:HYWebDataPath(account.personnerpic)] placeholderImage:[UIImage imageNamed:@"persontopbg.png"] options:5];
    [_personImaView sd_setImageWithURL:[NSURL URLWithString:HYWebDataPath(account.headpic)] placeholderImage:[UIImage imageNamed:@"circle_default.png"] options:5];
    
}

//设置用户信息
-(void)setCustomerInfoDic:(NSDictionary *)dic{
    
    _nikeNameLB.text = dic[@"name"];
    _superVC.title = dic[@"name"];
    _mottoLB.text = dic[@"sign"];
    [_topBgImageView sd_setImageWithURL:[NSURL URLWithString:HYWebDataPath(dic[@"personnerpic"])] placeholderImage:[UIImage imageNamed:@"persontopbg.png"] options:5];
    [_personImaView sd_setImageWithURL:[NSURL URLWithString:HYWebDataPath(dic[@"headpic"])] placeholderImage:[UIImage imageNamed:@"circle_default.png"] options:5];
}


//上传图片
-(void)changeBg{
    __block UIImageView *imgView = _topBgImageView;
    __block USAccount *account = _account;
    if (_uploadService==nil) {
        USUpLoadImageServiceTool *uploadService = [[USUpLoadImageServiceTool alloc]init];
        _uploadService = uploadService;
        _uploadService.tipTitle = @"请选择背景图片来源";
        _uploadService.saveImageBlock = ^(UIImage *image){
            //_topBgImageView.image = image;
            [USWebTool POST:@"wangkaClientController/updateCustomerHeadBackground.action" showMsg:@"正在修改背景图片..." paramDiC:@{@"customer_id":account.id} fileParamDic:@{@"uploadimgFilephoto":UIImagePNGRepresentation(image)} success:^(id data) {
                imgView.image = image;
            } failure:^(id data) {
                [MBProgressHUD showError:@"修改背景图片出错，请检查..."];
            }];
        };
    }
    
    [_uploadService pickImage];
}
-(void)click{
    if (_nearTopButtonClickBlock) {
        _nearTopButtonClickBlock();
    }
}

@end
