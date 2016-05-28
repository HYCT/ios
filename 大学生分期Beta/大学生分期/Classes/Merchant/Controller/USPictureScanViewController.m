//
//  USPictureScanViewController.m
//  大学生分期
//
//  Created by HeXianShan on 16/1/9.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import "USPictureScanViewController.h"

@interface USPictureScanViewController ()
@property(nonatomic,strong)NSMutableArray *tempImgs;
@property(nonatomic,strong)UILabel *descView;
@end

@implementation USPictureScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent= NO;
    self.title = @"图组";
    [self.view setBackgroundColor:[UIColor blackColor]] ;
    [self initScollorViews];
    [self initTextView];
}

-(void)initScollorViews{
    _scollerPics = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kAppWidth, kAppHeight)];
    _scollerPics.backgroundColor = [UIColor blackColor];
    _scollerPics.userInteractionEnabled = YES;
    _scollerPics.showsVerticalScrollIndicator = NO;
    _scollerPics.showsHorizontalScrollIndicator = NO;
    _scollerPics.bounces = NO;
    _scollerPics.pagingEnabled = YES;
    [self.view addSubview:_scollerPics];
    CGFloat width = 0;
    for(NSInteger i = 0;i<_imgsUrl.count;i++){
        UIImageView *temp = [[UIImageView alloc]initWithFrame:CGRectMake(width, 0, kAppWidth, _scollerPics.height)];
        NSURL *imgur = _imgsUrl[i];
        [temp sd_setImageWithURL:imgur placeholderImage:[UIImage imageNamed:@"circle_default" ] options:5];
        width += temp.width;
        //自适应
        [USUIViewTool imagesSelfFit:temp] ;
        [_scollerPics addSubview:temp];
        
    }
    _scollerPics.contentSize = CGSizeMake(width, _scollerPics.height);
  
}

-(void)initTextView{
    
    UIView *bgview =[[UIView alloc] initWithFrame:CGRectMake(0, 0, kAppWidth, 0)] ;
    //透明
    UIColor *blackColor_apa = [UIColor colorWithWhite:0.5 alpha:0.8 ] ;
    [bgview setBackgroundColor:blackColor_apa] ;
    [self.view addSubview:bgview] ;
    
    _descView = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, kAppWidth-10, 0)];
    //_descView.backgroundColor = blackColor_apa;
    _descView.textColor = [UIColor whiteColor];
    UIFont *font = [UIFont systemFontOfSize:14];
    CGFloat height = [USUIViewTool setTextHeight:_descView width:kAppWidth-10 content:_desc font:font];
    [_descView setFrame:CGRectMake(5, 5, kAppWidth-10, height)] ;
    [bgview addSubview:_descView] ;
    bgview.height=_descView.y+height+5 ;
    bgview.y=kAppHeight-bgview.height-42 ;
    [self.view addSubview:bgview];
}

@end
