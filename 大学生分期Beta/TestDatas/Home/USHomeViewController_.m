//
//  HYHomeViewController.m
//  红云创投
//
//  Created by HeXianShan on 15/8/9.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USHomeViewController_.h"
#import "USTabBarView.h"
#import "USGridView.h"
#import "USNewbieViewController.h"
#import "UIImage+Extension.h"
#import "USAccountCallForViewController.h"
#import "USNearViewController.h"
#import "USFinanceViewController.h"
#import "USBindCardViewController.h"
#import "USHomeService.h"
#import "USAnomalyView.h"
#import "USUserService.h"
@interface USHomeViewController_ ()<UIScrollViewDelegate,USGridCellViewDelegate,USCommonServiceDelegate,USAnomalyViewDelegate>
@property(nonatomic,weak)UIScrollView *adsScollView;
@property(nonatomic,weak)UIPageControl *pageControl;
@property(nonatomic,weak)UIButton *fillAccountButton;
@property(nonatomic,weak)UIView *fillAccountButtonBg;
@property(nonatomic,strong)NSDictionary *buttonTitleActionDic;
@end

@implementation USHomeViewController_

- (void)viewDidLoad {
    self.navigationItem.title = @"汪卡";
    self.navigationController.navigationBar.translucent= YES;
    [super viewDidLoad];
    
    [self.view setBackgroundColor:HYCTColor(240,240,240)];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initAdsScollView];
    _buttonTitleActionDic = @{@"我要借款":@[@"home_load_bt_img",@"USFinanceLoanViewController"]//
                          ,@"我要还款":@[@"home_reback_bt_img",@"USRebackListViewController"],//
                          @"我要提额":@[@"home_bt_img",@"0.00",@"USCertificationViewController"],//
                          @"我要赚钱":@[@"home_myworn_bt_img",@"USAccountEarnMoneyViewController"],//
                          @"旺社区":@[@"home_wanshequ_bt_img",@"USNearViewController"],//
                          @"夺宝奇兵":@[@"home_duobaoqibin_bt_img",@"USSnatchViewController"],//
                          @"人气榜":@[@"home_renqiban_bt_img"],//
                          @"邀约":@[@"home_yaoyue_bt_img"]};//
    /*
     _buttonTitleActionDic = @{@"我要借款":@[@"home_load_bt_img",@"USFinanceLoanViewController"]//
     ,@"我要还款":@[@"home_reback_bt_img",@"USRebackListViewController"],//
     @"我要提额":@[@"home_bt_img",@"0.00",@"USAccountViewController"],//
     @"我要赚钱":@[@"home_myworn_bt_img",@"USAccountEarnMoneyViewController"],//
     @"旺社区":@[@"home_wanshequ_bt_img",@"USNearViewController"],//
     @"夺宝奇兵":@[@"home_duobaoqibin_bt_img",@"USSnatchViewController"],//
     @"人气榜":@[@"home_renqiban_bt_img"],//
     @"邀约":@[@"home_yaoyue_bt_img"]};//
     */
    UIView *centerView = [self createCenterButtonsView:_adsScollView.y+_adsScollView.height+10];
    [self.view addSubview:centerView];
    //
    UIView *bottomView = [self createBottomButtonsView:centerView.y+centerView.height+10];
     [self.view addSubview:bottomView];
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

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.translucent= YES;
}
-(void)createAdsScollView{
    
    UIScrollView *adsScollView  = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kNavBarY, kAppWidth, 110)];
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
-(void)createFillAcountButton{
    
    UIImageView *background = [[UIImageView alloc]init];
    background.userInteractionEnabled = YES;
    [background setFrame:CGRectMake(30, _adsScollView.y+_adsScollView.height+30, kAppWidth*0.8, 40)];
    UIImage *bgImage = [UIImage imageNamed:@"fillaccount_button_bg"];
    background.image = bgImage;
    
    UIButton *fillAccountButton = [UIButton buttonWithType:UIButtonTypeCustom];
    fillAccountButton.x = 0;
    fillAccountButton.width = kAppWidth*0.8;
    fillAccountButton.height = 40;
    fillAccountButton.y = 0;
    [fillAccountButton setTitle:@"校园一卡通充值" forState:UIControlStateNormal];
    UIEdgeInsets imageInset = UIEdgeInsetsMake(0, -kAppWidth*0.28, 0, 0);
    [fillAccountButton setImageEdgeInsets:imageInset];
    [fillAccountButton setImage:[UIImage imageNamed:@"fillaccount_button"] forState:UIControlStateNormal];
    [fillAccountButton setImage:[UIImage imageNamed:@"fillaccount_button"] forState:UIControlStateHighlighted];
    [fillAccountButton addTarget:self action:@selector(fillAccount) forControlEvents:UIControlEventTouchUpInside];
    [background addSubview:fillAccountButton];
    [self.view addSubview:background];
    _fillAccountButton = fillAccountButton;
    _fillAccountButtonBg = background;
}
-(void)createTabBar{
    NSArray *titles = @[@"附件的人",@"金融服务",@"新手课堂",@"邀请有礼"];
    NSArray *images = @[@"toobar_near",@"toobar_fianacing" ,@"toobar_newcourse",@"toobar_share"];
    USGridView *gridView = [[ USGridView alloc]initWithFrame:CGRectMake(0, _fillAccountButtonBg.y+_fillAccountButtonBg.height+20, kAppWidth, 60) itemTitles:titles itemImages:images rowCount:4 delegate:self];
    [gridView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:gridView];
    
}
-(void)fillAccount{
    USBindCardViewController *bindCardVC = [[USBindCardViewController alloc]init];
    bindCardVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:bindCardVC animated:YES];
}
-(void)didClickItem:(UIButton *)sender{
    switch (sender.tag) {
        case ItemIndex_0:{
            USNearViewController *nearVC = [[USNearViewController alloc]init];
            nearVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:nearVC animated:YES];
            break;
        }
        case ItemIndex_1:
        {USFinanceViewController *financeView = [[USFinanceViewController alloc]init];
            financeView.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:financeView animated:YES];
        }
        break;
        case ItemIndex_2:
            {
                USNewbieViewController *newbieVC = [[USNewbieViewController alloc]init];
                newbieVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:newbieVC animated:YES];
            }
        break;
        case ItemIndex_3:
        {
            USAccountCallForViewController *callForVC = [[USAccountCallForViewController alloc]init];
            callForVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:callForVC animated:YES];
        }
            break;
    }
    
}
-(UIView *)createCenterButtonsView:(CGFloat)y{
    CGFloat margin = 52;
    CGFloat marginTop = 32;
    CGFloat width = (kAppWidth-margin*2)/2;
    CGFloat height = (kAppHeight - y - self.navigationController.navigationBar.height)*3.0/4;
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, y, kAppWidth, height-10)];
    height = height/2+10;
    [bgView setBackgroundColor:[UIColor clearColor]];
    //
    USAnomalyView *myLoadView = [[USAnomalyView alloc]initWithFrame:CGRectMake(40, 0, width, height) title:nil subTitle:@"我要借款" bgImageName:@"home_load_bt_img"];
    myLoadView.x = kAppWidth/2-myLoadView.width/2;
    myLoadView.delegate = self;
    [bgView addSubview:myLoadView];
    //
    USAnomalyView *myRebackView = [[USAnomalyView alloc]initWithFrame:CGRectMake(40, myLoadView.y+myLoadView.height-marginTop, width, height) title:nil subTitle:@"我要还款" bgImageName:@"home_reback_bt_img"];
    myRebackView.x = kAppWidth/2-myLoadView.width;
    myRebackView.delegate = self;
    [bgView addSubview:myRebackView];
    //
    USAnomalyView *myPickView = [[USAnomalyView alloc]initWithFrame:CGRectMake(40, myLoadView.y+myLoadView.height-marginTop, width, height) title:[NSString stringWithFormat:@"%.20f",[USUserService account].surplusmoney] subTitle:@"我要提额" bgImageName:nil];
    myPickView.x = kAppWidth/2;
    myPickView.delegate = self;
    __block USAnomalyView *blockPickView = myPickView;
    myPickView.clickBlock = ^(){
        blockPickView.logined = YES;
       
    };
    [bgView addSubview:myPickView];
    //
    USAnomalyView *myWornView = [[USAnomalyView alloc]initWithFrame:CGRectMake(40, myPickView.y+myPickView.height-marginTop-1, width, 36) title:nil subTitle:@"我要赚钱" bgImageName:@"home_myworn_bt_img"];
    myWornView.x = kAppWidth/2-myWornView.width/2;
    myWornView.delegate = self;
    [bgView addSubview:myWornView];
    return  bgView;
}
-(UIView *)createBottomButtonsView:(CGFloat)y{
    CGFloat margin = 5;
    CGFloat height = kAppHeight - y- self.navigationController.navigationBar.height+5;
    CGFloat width = (kAppWidth-margin*2)/4;
    NSArray *titlesArray = @[@"旺社区",@"夺宝奇兵",@"人气榜",@"邀约"];
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, y, kAppWidth, height)];
    CGFloat x = margin;
    CGFloat xmargin = margin*0.3;
    for (NSInteger i = 0; i<titlesArray.count; i++) {
        NSString *key = titlesArray[i];
        NSArray *innerArray = _buttonTitleActionDic[key];
        USAnomalyView *myWornView = [[USAnomalyView alloc]initWithFrame:CGRectMake(x, 0, width+xmargin, height) title:nil subTitle:key bgImageName:innerArray[0]];
        myWornView.x = x;
        x += width-xmargin;
        myWornView.delegate = self;
        [bgView addSubview:myWornView];
    }
    
    return  bgView;
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

-(void)didTopButtonClick:(USAnomalyView *)anomarlyView{
   
    NSArray *btsArray = _buttonTitleActionDic[anomarlyView.title];
    if ([btsArray count]>=2) {
        UIViewController  *viewController= [[NSClassFromString([btsArray lastObject]) alloc] init];
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

-(void)test{
    /* -(UIView *)createCenterButtonsView:(CGFloat.)y{
     CGFloat margin = 52;
     CGFloat marginTop = 32;
     CGFloat width = (kAppWidth-margin*2)/2;
     CGFloat height = (kAppHeight - y - self.navigationController.navigationBar.height)*3.0/4;
     UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, y, kAppWidth, height-10)];
     height = height/2+10;
     [bgView setBackgroundColor:[UIColor clearColor]];
     //
     USAnomalyView *myLoadView = [[USAnomalyView alloc]initWithFrame:CGRectMake(40, 0, width, height) title:nil subTitle:@"我要借款" bgImageName:@"home_load_bt_img"];
     myLoadView.x = kAppWidth/2-myLoadView.width/2;
     myLoadView.delegate = self;
     __block USAnomalyView *blockMyLoadView = myLoadView;
     myLoadView.clickBlock = ^(){
     blockMyLoadView.logined = NO;
     if (_account == nil) {
     USLoginViewController *loginVC =[[USLoginViewController alloc]init];
     loginVC.hidesBottomBarWhenPushed = YES;
     loginVC.nextDoblock = ^(){
     UIViewController *nextShowVC = nil;
     if (!_account.isbindbankcard) {
     nextShowVC = [[USBindBankCardViewController alloc]init];
     nextShowVC.hidesBottomBarWhenPushed = YES;
     }else{
     nextShowVC = [self bussness:blockMyLoadView];
     }
     if (nextShowVC!=nil) {
     [USUIViewTool createMainNavController:nextShowVC];
     }else{
     [self.navigationController popViewControllerAnimated:YES];
     }
     };
     [self.navigationController pushViewController:loginVC animated:YES];
     }else {
     UIViewController *nextShowVC = nil;
     if (!_account.isbindbankcard) {
     nextShowVC = [[USBindBankCardViewController alloc]init];
     nextShowVC.hidesBottomBarWhenPushed = YES;
     }else{
     nextShowVC = [self bussness:blockMyLoadView];
     }
     [self.navigationController pushViewController:nextShowVC animated:YES];
     //            if (nextShowVC!=nil) {
     //                [USUIViewTool createMainNavController:nextShowVC];
     //            }
     }
     };
     [bgView addSubview:myLoadView];
     //
     USAnomalyView *myRebackView = [[USAnomalyView alloc]initWithFrame:CGRectMake(40, myLoadView.y+myLoadView.height-marginTop, width, height) title:nil subTitle:@"我要还款" bgImageName:@"home_reback_bt_img"];
     myRebackView.x = kAppWidth/2-myLoadView.width;
     myRebackView.delegate = self;
     __block USAnomalyView *blockMyRebackView = myRebackView;
     myRebackView.clickBlock = ^(){
     blockMyRebackView.logined = NO;
     
     };
     [bgView addSubview:myRebackView];
     //
     USAnomalyView *myPickView = [[USAnomalyView alloc]initWithFrame:CGRectMake(40, myLoadView.y+myLoadView.height-marginTop, width, height) title:@"0.00" subTitle:@"我要提额" bgImageName:nil];
     myPickView.x = kAppWidth/2;
     myPickView.delegate = self;
     __block USAnomalyView *blockPickView = myPickView;
     myPickView.clickBlock = ^(){
     [self didLogin:blockPickView];
     };
     _myPikerView = myPickView;
     [bgView addSubview:myPickView];
     //
     USAnomalyView *myWornView = [[USAnomalyView alloc]initWithFrame:CGRectMake(40, myPickView.y+myPickView.height-marginTop-1, width, 36) title:nil subTitle:@"我要赚钱" bgImageName:@"home_myworn_bt_img"];
     myWornView.x = kAppWidth/2-myWornView.width/2;
     myWornView.topbutton.width *=0.6;
     myWornView.topbutton.height*=0.9;
     myWornView.topbutton.y+=myWornView.topbutton.height*0.2;
     myWornView.topbutton.x+=myWornView.topbutton.width*0.3;
     myWornView.delegate = self;
     // __block USAnomalyView *blockWornView = myWornView;
     myWornView.clickBlock = ^(){
     //[self didLogin:blockWornView];
     [MBProgressHUD showError:@"暂未开放该功能..."];
     };
     [bgView addSubview:myWornView];
     return  bgView;
     }
     */
}
/*
-(void)didTopButtonClick:(USAnomalyView *)anomarlyView{
 
    UIViewController *viewController = [self getCommonNextVC:anomarlyView];
    if (viewController!=nil) {
        [self.navigationController pushViewController:viewController animated:YES];
    }
 
}
- (void)didLogin:(USAnomalyView *)blockPickView {
    blockPickView.logined = NO;
    if (_account == nil) {
        USLoginViewController *loginVC =[[USLoginViewController alloc]init];
        loginVC.hidesBottomBarWhenPushed = YES;
        loginVC.nextDoblock = ^(){
            UIViewController *nextShowVC = [self bussness:blockPickView];
            if (nextShowVC!=nil) {
                if ([nextShowVC isKindOfClass:[USAccountViewController class]]) {
                    nextShowVC = nil;
                    self.tabBarController.selectedIndex = 1;
                    return;
                }
                [USUIViewTool createMainNavController:nextShowVC];
            }else{
                [self.navigationController popViewControllerAnimated:YES];
            }
        };
        [self.navigationController pushViewController:loginVC animated:YES];
    }else {
        UIViewController *nextShowVC = [self bussness:blockPickView];
        if (nextShowVC!=nil) {
            if ([nextShowVC isKindOfClass:[USAccountViewController class]]) {
                self.tabBarController.selectedIndex = 1;
                return;
            }
            [USUIViewTool createMainNavController:nextShowVC];
        }
    }
}

-(UIViewController *)bussness:(USAnomalyView *)anomarlyView{
    _account = [USUserService account];
    UIViewController *toShowVC = nil;
    if (_account.realnametype == -1) {
        toShowVC = [[USCertificationViewController alloc]init];
    }else if (_account.realnametype == 3){
        toShowVC = [self getCommonNextVC:anomarlyView];
    }else{
        [MBProgressHUD showError:@"你的实名认证还未审核完毕!"];
    }
    toShowVC.hidesBottomBarWhenPushed = YES;
    return toShowVC;
}
- (UIViewController *)getCommonNextVC:(USAnomalyView *)anomarlyView {
    NSArray *btsArray = _buttonTitleActionDic[anomarlyView.subTitle];
    if ([btsArray count]>=2) {
        UIViewController  *viewController= [[NSClassFromString([btsArray lastObject]) alloc] init];
        viewController.hidesBottomBarWhenPushed = YES;
        return viewController;
    }
    return nil;
}*/
@end
