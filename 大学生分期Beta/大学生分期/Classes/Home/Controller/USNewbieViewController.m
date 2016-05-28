//
//  USNewbieViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/1.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//
#import "USNewbieViewController.h"
#import "USGridView.h"
#import "UIImage+Extension.h"
#import "USTabBarView.h"
@interface USNewbieViewController ()<UIScrollViewDelegate,USGridCellViewDelegate>
@property(nonatomic,weak)UIScrollView *adsScollView;
@property(nonatomic,weak)UIPageControl *pageControl;
@end

@implementation USNewbieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"新手课堂";
    [self.view setBackgroundColor:HYCTColor(240,240,240)];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initAdsScollView];
    [self createTabBar];
}

-(void)initAdsScollView{
    
    [self createAdsScollView];
    
    CGFloat width = 0;
    for(NSInteger i =1;i<=3;i++){
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%li.jpg",(long)i]];
        image = [UIImage imageCompressForSize:image targetSize:CGSizeMake(_adsScollView.width, _adsScollView.height)];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.x = width;
        button.y = 0;
        button.width = _adsScollView.bounds.size.width;
        button.height = _adsScollView.bounds.size.height;
        [button setImage:image forState:UIControlStateNormal];
        [button setImage:image forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(clickScollImages:) forControlEvents:UIControlEventTouchUpInside];
        [_adsScollView addSubview: button];
        width += image.size.width ;
        
    }
    _adsScollView.contentSize = CGSizeMake(width, _adsScollView.height);
}


-(void)createAdsScollView{
    
    UIScrollView *adsScollView  = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kNavBarY, kAppWidth, kAppHeight*0.4)];
    _adsScollView = adsScollView;
    adsScollView.userInteractionEnabled = YES;
    adsScollView.delegate = self;
    _adsScollView.showsVerticalScrollIndicator = NO;
    _adsScollView.showsHorizontalScrollIndicator = NO;
    _adsScollView.backgroundColor = HYCTColor(68, 201, 190);
    _adsScollView.bounces = NO;
    _adsScollView.pagingEnabled = YES;
    [self.view addSubview:_adsScollView];
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    
    pageControl.numberOfPages = 3;
    pageControl.height = 10;
    pageControl.width = 50;
    pageControl.pageIndicatorTintColor = HYCTColor(145, 223, 217);
    pageControl.currentPageIndicatorTintColor = HYCTColor(254, 140, 0);
    _pageControl = pageControl;
    pageControl.x = (kAppWidth+pageControl.width)/2-pageControl.width;
    
    pageControl.y = (adsScollView.y+adsScollView.height)-20;
    
    [pageControl addTarget:self action:@selector(clickPage:) forControlEvents:UIControlEventValueChanged];
    UIView *view = [[UIView alloc]initWithFrame:pageControl.frame];
    [view setBackgroundColor:[UIColor clearColor]];
    view.width = pageControl.width*2;
    view.x = (view.x+view.width)/2;
    [self.view addSubview:view];
    [self.view addSubview:pageControl];
    [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(scrollToNextPage) userInfo:nil repeats:YES];
    
}

-(void)createTabBar{
    NSArray *titles = @[@"充值",@"借款",@"额度提升",@"还款",@"投资",@"保障",@"名词解释",@"账户常识"];
    NSArray *images = @[@"toobar_near",@"toobar_fianacing" ,@"toobar_newcourse",@"toobar_share",@"toobar_near",@"toobar_fianacing" ,@"toobar_newcourse",@"toobar_share"];
    USGridView *gridView = [[ USGridView alloc]initWithFrame:CGRectMake(0, _adsScollView.y+_adsScollView.height+20, kAppWidth, 120) itemTitles:titles itemImages:images rowCount:4 delegate:self];
    [gridView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:gridView];
    
}
-(void)didClickItem:(UIButton *)sender{
    HYLog(@"USNewbieViewController(idClickItem:(UIButton *)sender)______(%li)",(long)sender.tag);
    
}
-(void)scrollToNextPage {
    NSInteger pageNum = self.pageControl.currentPage+1;
    
    if ((self.pageControl.numberOfPages-1)<pageNum) {
        pageNum = 0;
    }
    CGPoint point = self.adsScollView.contentOffset;
    point.x = pageNum*kAppWidth;
    self.adsScollView.contentOffset = point;
    self.pageControl.currentPage = pageNum;
}
-(void)clickPage:(UIPageControl *)pageControl{
    CGFloat x = pageControl.currentPage*kAppWidth;
    CGPoint point = _adsScollView.contentOffset;
    point.x = x;
    _adsScollView.contentOffset = point;
    
}

-(void)clickScollImages:(UIButton *)sender{
    HYLog(@"%@",sender);
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat pageNum = scrollView.contentOffset.x/kAppWidth +0.5;
    _pageControl.currentPage = pageNum;
}
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    HYLog(@"-----%li---",item.tag);
}




@end
