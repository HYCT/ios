//
//  HYHomeViewController.m
//  红云创投
//
//  Created by HeXianShan on 15/8/9.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USHomeViewController.h"
#import "USTabBarView.h"
#import "USGridView.h"
#import "USNewbieViewController.h"
#import "UIImage+Extension.h"
#import "USAccountCallForViewController.h"
#import "USNearViewController.h"
#import "USFinanceViewController.h"
#import "USBindBankCardViewController.h"
#import "USLoginViewController.h"
#import "USCertificationViewController.h"
#import "USActivitDetalViewController.h"
#import "USAccountViewController.h"
#import "USHomeService.h"
#import "USAnomalyView.h"
#import "USUserService.h"
#import "USWebTool.h"
#import "UIImageView+WebCache.h"
#import "LBXScanViewController.h"
#import "MyQRViewController.h"
#import "LBXScanView.h"
#import <objc/message.h>
#import "USBussResult.h"
#import "USGridBusinessView.h"
#define kBtmargin 10
#define kMerchantHeight 120
@interface USHomeViewController ()<UIScrollViewDelegate,USGridCellViewDelegate,USCommonServiceDelegate,USAnomalyViewDelegate,UIAlertViewDelegate>
@property(nonatomic,weak)UIScrollView *adsScollView;
@property(nonatomic,weak)UIPageControl *pageControl;
@property(nonatomic,weak)UIButton *fillAccountButton;
@property(nonatomic,weak)UIView *fillAccountButtonBg;
@property(nonatomic,strong)NSDictionary *buttonTitleActionDic;
@property(nonatomic,strong)USAccount *account;
@property(nonatomic,strong)USAnomalyView *myPikerView;
@property(nonatomic,strong)UILabel *currentBlance;
@property(nonatomic,strong)NSMutableArray  *activiArrayList;
@property(nonatomic,assign)CGFloat height;
@property(nonatomic,assign)USGridView *commerceView;

//签到图片
@property(nonatomic,strong)UIImageView *siginImageViw;
//签到label
@property(nonatomic,strong)UILabel *siginLabel;
//记录今天是否签到
@property(nonatomic,strong)NSString *isSignTaday ;
//位置定位
@property(atomic,strong)CLLocation *currentLocation;
@property(nonatomic,strong)NSMutableDictionary *paramDic;
//又上角的签到按钮
@property(nonatomic,strong)UIButton *rightBtn ;
@end

@implementation USHomeViewController

- (void)viewDidLoad {
    self.navigationItem.title = @"汪卡";
    self.navigationController.navigationBar.translucent= YES;
    [super viewDidLoad];
    _account = [USUserService account];
    [self.view setBackgroundColor:HYCTColor(240,240,240)];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initAdsScollView];
    
    _buttonTitleActionDic = @{@"0":@[@"home_load_bt_img",@"USFinanceLoanViewController"]//
                              ,@"1":@[@"home_reback_bt_img",@"USRebackListViewController"],//
                              @"2":@[@"home_bt_img",@"0.00",@"USAccountViewController"],//
                              @"我要赚钱":@[@"home_myworn_bt_img",@"USAccountEarnMoneyViewController"],//
                              @"3":@[@"home_wanshequ_bt_img",@"USCircleViewController"],//
                              @"4":@[@"home_duobaoqibin_bt_img",@"USSnatchViewController"],//
                              @"5":@[@"home_renqiban_bt_img",@"USXRankViewController"],//
                              @"6":@[@"home_yaoyue_bt_img",@"USInviteViewController"]};//
    [self initButtonsView:_adsScollView.y+_adsScollView.height];
    //社交部分隐藏
    //[self createBottomButtonsView:_height];
    
    //旧的网页
    // UIView *merchantView = [self createMerchantView:_height+10];
    //_height=merchantView.y+merchantView.height;
    
    //签到
    //[self createSignView:_height ] ;
    [self  initRightItemBar] ;
    //商铺分类
    [self createBussinessView:_height + 15];
    //
    UIScrollView *scrollVIew = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    scrollVIew.y = 0;
    scrollVIew.contentSize = CGSizeMake(kAppWidth, _height+50);
    scrollVIew.showsHorizontalScrollIndicator = NO;
    scrollVIew.bounces = NO;
    for (UIView *uiview in self.view.subviews) {
        [uiview removeFromSuperview];
        [scrollVIew addSubview:uiview];
    }
    [self.view addSubview:scrollVIew];
    
    //加载活动图
    [self loadFirstImages];
    
    //设置签到
    //[self setSignDays] ;
    
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [NSThread detachNewThreadSelector:@selector(updateData) toTarget:self withObject:nil];
    //[self performSelectorInBackground:@selector(updateData) withObject:nil];
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.translucent= YES;
}


//右边签到
-(void)initRightItemBar{
    
    _rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtn.backgroundColor = [UIColor clearColor];
    UIFont *font = [UIFont systemFontOfSize:kCommonFontSize_14];
    [_rightBtn.titleLabel setFont:font];
    NSString *leftTitle = @"签到0天";
    [_rightBtn setTitle:leftTitle forState:UIControlStateNormal];
    [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _rightBtn.size = CGSizeMake(60, 24);
    _rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -24, 0, 0);
    _rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -24, 0, 0);
    [_rightBtn.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [_rightBtn addTarget:self action:@selector(signFun) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}


-(void)initAdsScollView{
    
    [self createAdsScollView];
}


-(void)createAdsScollView{
    
    UIScrollView *adsScollView  = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kNavBarY, kAppWidth, 150)];
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
    
    pageControl.numberOfPages = 0;
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
-(CGFloat)loadFirstImages{
    __block CGFloat width = 0;
    
    Failure failure = ^(id data){
        _pageControl.numberOfPages = 3;
        for(NSInteger i =1;i<=3;i++){
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%li.jpg",(long)i]];
            image = [UIImage imageCompressForSize:image targetSize:CGSizeMake(_adsScollView.width, _adsScollView.height)];
            UIImageView *temp = [[UIImageView alloc]initWithFrame:CGRectMake(width, 0, _adsScollView.width, _adsScollView.height)];
            
            UIGestureRecognizer *gesture = [[UIGestureRecognizer alloc]initWithTarget:self action:@selector(clickScollImages:)];
            [temp addGestureRecognizer:gesture];
            [_adsScollView addSubview:temp];
            width += image.size.width ;
            
        }
        _adsScollView.contentSize = CGSizeMake(width, _adsScollView.height);
    };
    //failure(nil);
    [USWebTool POST:@"firstpageimgcilent/imagelist.action" paramDic:nil success:^(NSDictionary *dic) {
        _activiArrayList = [NSMutableArray array];
        if ([dic[@"data"] count]>0) {
            [_activiArrayList addObjectsFromArray:dic[@"data"]];
        }else{
            return ;
        }
        if ([_activiArrayList count]>0) {
            width = 0;
            NSInteger count = [_activiArrayList count];
            for(NSInteger i = 0;i<count;i++){
                NSString *imagePath = HYWebDataPath(_activiArrayList[i][@"imgpath"]);
                // NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imagePath]];
                
                // UIImage *image = [UIImage imageWithData:data];
                
                // image = [UIImage imageCompressForSize:image targetSize:CGSizeMake(_adsScollView.width, _adsScollView.height)];
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.x = width;
                button.y = 0;
                button.tag = i;
                button.width = _adsScollView.bounds.size.width;
                button.height = _adsScollView.bounds.size.height;
                //[button setImage:image forState:UIControlStateNormal];
                //[button setImage:image forState:UIControlStateHighlighted];
                [button addTarget:self action:@selector(clickScollImages:) forControlEvents:UIControlEventTouchUpInside];
                
                UIImageView *temp = [[UIImageView alloc]initWithFrame:CGRectMake(width, 0, _adsScollView.width, _adsScollView.height)];
                [temp sd_setImageWithURL:[NSURL URLWithString:imagePath]];
                temp.userInteractionEnabled = YES;
                //temp.image = image;
                //UIGestureRecognizer *gesture = [[UIGestureRecognizer alloc]initWithTarget:self action:@selector(clickScollImages:)];
                // [temp addGestureRecognizer:gesture];
                [_adsScollView addSubview:temp];
                [_adsScollView addSubview: button];
                //width += image.size.width ;
                width += temp.width;
            }
            _pageControl.numberOfPages = _activiArrayList.count;
            _adsScollView.contentSize = CGSizeMake(width, _adsScollView.height);
        }
        
        
    } failure:nil];
    return width;
}
-(void)initButtonsView:(CGFloat)y{
    UIView *bgView = [self createCenterButtonsBgView:y];
    //UIView *centerView = [self createCenterButtonsView:_adsScollView.y+_adsScollView.height+10];
    //[self.view addSubview:centerView];
    UIView *scanCodeView = [self createUpImageDowntilteView:kBtmargin*3 imageNmae:@"home_scan_code_img" title:@"扫码支付"  action:@selector(scanBtClick:) tag:-100];
    scanCodeView.x = kBtmargin*2;
    [bgView addSubview:scanCodeView];
    //
    UIView *borrowView = [self createUpImageDowntilteView:kBtmargin*3 imageNmae:@"home_new_borrow_bt_img" title:@"我要借款"  action:@selector(borrowBtClick:) tag:0];
    borrowView.centerX = bgView.width/2;
    [bgView addSubview:borrowView];
    //
    UIView *rebackView = [self createUpImageDowntilteView:kBtmargin*3 imageNmae:@"home_new_reback_bt_img" title:@"我要还款"  action:@selector(rebackBtClick:) tag:1];
    rebackView.x = kAppWidth-rebackView.width-kBtmargin*2;
    [bgView addSubview:rebackView];
    [self.view addSubview:bgView];
    UIView *increateQutouView = [self createQutoButtonView:bgView.height+bgView.y height:kCommonFontSize_18];
    [self.view addSubview:increateQutouView];
    _height=increateQutouView.y+increateQutouView.height;
}
-(UIView *)createUpImageDowntilteView:(CGFloat)y imageNmae:(NSString *)imageNmae title:(NSString *)title action:(SEL)actio tag:(NSInteger )tag{
    CGFloat width = 50;
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, y, width*1.5, 70)];
    bgView.backgroundColor = [UIColor clearColor];
    UIButton *upbt = [USUIViewTool createButtonWith:@"" imageName:imageNmae];
    upbt.frame = CGRectMake(0, 0, width, width);
    upbt.centerX = bgView.width/2;
    upbt.tag = tag;
    [upbt addTarget:self action:actio forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:upbt];
    //
    UILabel *tipLB = [USUIViewTool createUILabelWithTitle:title fontSize:kCommonFontSize_15 color:[UIColor blackColor] heigth:kCommonFontSize_15];
    tipLB.font = [UIFont systemFontOfSize:kCommonFontSize_15];
    tipLB.frame = CGRectMake(0, upbt.y+upbt.height+kBtmargin, width*1.5, kCommonFontSize_15);
    tipLB.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:tipLB];
    return  bgView;
}
-(UIView *)createCenterButtonsBgView:(CGFloat)y{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, y, kAppWidth, 130)];
    bgView.backgroundColor = [UIColor whiteColor];
    return bgView;
}

-(UIView *)createQutoButtonView:(CGFloat)y height:(CGFloat) height{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0,y, kAppWidth,height+20)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.borderColor = [HYCTColor(220, 220, 220) CGColor];
    bgView.layer.borderWidth = 0.5;
    //
    _currentBlance =  [USUIViewTool createUILabelWithTitle:@"00.00" fontSize:kCommonFontSize_15 color:HYCTColor(250, 90, 100) heigth:kCommonFontSize_18];
    _currentBlance.frame = CGRectMake(10, 10, bgView.width, kCommonFontSize_20);
    //
    UIButton *increameBt = [USUIViewTool createButtonWith:@"我要提额>"];
    increameBt.width = 70;
    _currentBlance.frame = CGRectMake(10, 10, bgView.width-increameBt.width, kCommonFontSize_15);
    [bgView addSubview:_currentBlance];
    increameBt.titleLabel.font =[UIFont systemFontOfSize:kCommonFontSize_15];
    [increameBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    increameBt.frame= CGRectMake(kAppWidth-increameBt.width-kBtmargin*1.5, 10, increameBt.width, kCommonFontSize_15);
    increameBt.tag = 2;
    [increameBt addTarget:self action:@selector(increameBtClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:increameBt];
    
    return bgView;
}
//扫码支付
-(void)scanBtClick:(UIButton *)button{
    if (_account == nil) {
        USLoginViewController *loginVC =[[USLoginViewController alloc]init];
        loginVC.hidesBottomBarWhenPushed = YES;
        loginVC.nextDoblock = ^(){
            USBussResult *result = [self bussness:nil];
            UIViewController *nextShowVC = result.resultView;
            if (nextShowVC==nil) {
                return ;
            }
            if (nextShowVC!=nil) {
                [USUIViewTool createMainNavController:nextShowVC];
                return;
            }
        };
        [self.navigationController pushViewController:loginVC animated:YES];
    }else {
        USBussResult *result = [self bussness:nil];
        UIViewController *nextShowVC = result.resultView;
        if (nextShowVC==nil) {
            return ;
        }
        if (nextShowVC!=nil) {
            [USUIViewTool createMainNavController:nextShowVC];
            return;
        }
    }
    
}
//我要借款
-(void)borrowBtClick:(UIButton *)button{
    if (_account == nil) {
        USLoginViewController *loginVC =[[USLoginViewController alloc]init];
        loginVC.hidesBottomBarWhenPushed = YES;
        loginVC.nextDoblock = ^(){
            USBussResult *result = [self bussness:button];
            UIViewController *nextShowVC = result.resultView;
            if (nextShowVC==nil) {
                return ;
            }
            if (nextShowVC!=nil) {
                [USUIViewTool createMainNavController:nextShowVC];
                return;
            }
        };
        [self.navigationController pushViewController:loginVC animated:YES];
    }else {
        USBussResult *result = [self bussness:button];
        UIViewController *nextShowVC = result.resultView;
        if (nextShowVC!=nil) {
            [USUIViewTool createMainNavController:nextShowVC];
            return;
        }
    }
}
//我要还款
-(void)rebackBtClick:(UIButton *)button{
    if (_account == nil) {
        USLoginViewController *loginVC =[[USLoginViewController alloc]init];
        loginVC.hidesBottomBarWhenPushed = YES;
        loginVC.nextDoblock = ^(){
            USBussResult *result = [self bussness:button];
            UIViewController *nextShowVC = result.resultView;
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
        USBussResult *result = [self bussness:button];
        UIViewController *nextShowVC = result.resultView;
        if (nextShowVC!=nil) {
            if ([nextShowVC isKindOfClass:[USAccountViewController class]]) {
                self.tabBarController.selectedIndex = 1;
                return;
            }
            nextShowVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:nextShowVC animated:YES];
        }
    }
}

-(void)increameBtClick:(UIButton *)button{
    [self didLogin:button];
}

-(UIView *)createMerchantView:(CGFloat)y{
    USHtmlLoadViewController *h5VC = [[USHtmlLoadViewController alloc]init];
    [self addChildViewController:h5VC];
    h5VC.htmlUrl = kMerchantUrl;
    h5VC.view.frame = CGRectMake(0, y, kAppWidth, kMerchantHeight);
    h5VC.webView.height = kMerchantHeight;
    h5VC.webView.frame = h5VC.view.bounds;
    h5VC.webView.scrollView.scrollEnabled = NO;
    h5VC.webView.scrollView.bounces = NO;
    h5VC.webView.scrollView.contentSize = CGSizeMake(kAppWidth, kMerchantHeight);
    [self.view addSubview:h5VC.view];
    return h5VC.view;
}


//社交部分
-(UIView *)createBottomButtonsView:(CGFloat)y{
    CGFloat height = 80;
    _height+=height;
    NSArray *titles = @[@"圈子",@"夺宝奇兵",@"人气榜",@"邀约"];
    NSArray *images = @[@"home_wanshequ_bt_img",@"home_duobaoqibin_bt_img",@"home_renqiban_bt_img",@"home_yaoyue_bt_img"];
    USGridView *commerceView = [[ USGridView alloc]initWithFrame:CGRectMake(0,y+5, kAppWidth, height) itemTitles:titles itemImages:images rowCount:4 delegate:self];
    [commerceView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:commerceView];
    return  commerceView;
}
-(void)didClickItem:(UIButton *)sender{
    NSArray *btsArray = _buttonTitleActionDic[[NSString stringWithFormat:@"%li",(long)(sender.tag+3)]];
    if ([btsArray count]>=2) {
        UIViewController  *viewController= [[NSClassFromString([btsArray lastObject]) alloc] init];
        viewController.hidesBottomBarWhenPushed = YES;
        
        if (_account == nil) {
            [MBProgressHUD showError:@"还没有登录，请先登录..."];
            USLoginViewController *loginVC = [[USLoginViewController alloc]init];
            loginVC.muslogin = YES;
            loginVC.hidesBottomBarWhenPushed = YES;
            loginVC.nextViewController = viewController;
            [self.navigationController pushViewController:loginVC animated:YES];
            return;
        }else{
            [self.navigationController pushViewController:viewController animated:YES];
        }
        
    }
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
    USActivitDetalViewController *detalVC = [[USActivitDetalViewController alloc]init];
    detalVC.hidesBottomBarWhenPushed = YES;
    detalVC.msg = @"正在加载活动详情...";
    detalVC.title = _activiArrayList[sender.tag][@"title"];
    detalVC.param = @{@"id":_activiArrayList[sender.tag][@"id"]};
    [self.navigationController pushViewController:detalVC animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat pageNum = scrollView.contentOffset.x/kAppWidth +0.5;
    _pageControl.currentPage = pageNum;
}


- (void)didLogin:(UIButton *)blockPickView {
    if (_account == nil) {
        USLoginViewController *loginVC =[[USLoginViewController alloc]init];
        loginVC.hidesBottomBarWhenPushed = YES;
        loginVC.nextDoblock = ^(){
            USBussResult *result = [self bussness:blockPickView];
            UIViewController *nextShowVC = result.resultView;
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
        USBussResult *result = [self bussness:blockPickView];
        UIViewController *nextShowVC = result.resultView;
        if (nextShowVC!=nil) {
            if ([nextShowVC isKindOfClass:[USAccountViewController class]]) {
                self.tabBarController.selectedIndex = 1;
                return;
            }
            [USUIViewTool createMainNavController:nextShowVC];
        }
    }
}

-(USBussResult *)bussness:(UIButton *)button{
    _account = [USUserService accountStatic];
    USBussResult *result = [[USBussResult alloc]init];
    UIViewController *toShowVC = nil;
    if (_account.realnametype == -1) {
        toShowVC = [[USCertificationViewController alloc]init];
        toShowVC.hidesBottomBarWhenPushed = YES;
        result.resultView = toShowVC;
        result.canNext = YES;
    }else if (_account.realnametype == 3){
        result = [self getCommonNextVC:button];
    }else{
        [MBProgressHUD showError:@"你的实名认证还未审核完毕!"];
    }
    return result;
}
- (USBussResult *)getCommonNextVC:(UIButton *)button {
    USBussResult *result = [[USBussResult alloc]init];
    if (button==nil&&_account.isbindbankcard) {
        LBXScanViewController *nextShowVC = [[LBXScanViewController alloc]init];
        nextShowVC.actionType = 1;
        nextShowVC.hidesBottomBarWhenPushed = YES;
        result.canNext = YES;
        result.resultView = nextShowVC;
        return  result;
    }else if (button==nil&&!_account.isbindbankcard){
        UIViewController *nextShowVC = [[USBindBankCardViewController alloc]init];
        nextShowVC.hidesBottomBarWhenPushed = YES;
        result.resultView = nextShowVC;
        result.canNext = YES;
        return  result;
    }
    NSArray *btsArray = _buttonTitleActionDic[[NSString stringWithFormat:@"%li",(long)button.tag]];
    if ([btsArray count]>=2&&_account.isbindbankcard) {
        UIViewController  *viewController= [[NSClassFromString([btsArray lastObject]) alloc] init];
        viewController.hidesBottomBarWhenPushed = YES;
        result.resultView = viewController;
        result.canNext = YES;
        return result;
    }else if ([btsArray count]>=2&&!_account.isbindbankcard){
        UIViewController *nextShowVC = [[USBindBankCardViewController alloc]init];
        nextShowVC.hidesBottomBarWhenPushed = YES;
        result.resultView = nextShowVC;
        result.canNext = YES;
    }
    return result;
}



//创建签到
-(UIView *)createSignView:(CGFloat)y{
    
    
    
    CGFloat height = 80;
    _height+=height;
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, y, kAppWidth, height) ];
    [self.view addSubview:bgView] ;
    //签到
    CGFloat sign_width =120 ;
    CGFloat sign_height =30 ;
    
    UIView *signView = [[UIView alloc]initWithFrame:CGRectMake((kAppWidth-sign_width)/2, (height-sign_height)/2, sign_width, sign_height)];
    signView.userInteractionEnabled = YES;
    signView.backgroundColor = [UIColor orangeColor];
    signView.layer.cornerRadius = signView.height*0.5;
    signView.layer.masksToBounds = YES;
    [bgView addSubview:signView] ;
    //签到按钮
    UIButton *noteBt = [UIButton buttonWithType:UIButtonTypeCustom];
    noteBt.frame = signView.bounds;
    [noteBt addTarget:self action:@selector(signFun) forControlEvents:UIControlEventTouchUpInside];
    [signView addSubview:noteBt];
    //签到勾
    UIImage *siginImg = [UIImage imageNamed:@"home_sign"];
    UIImageView *siginImageViw = [[UIImageView alloc]init];
    siginImageViw.frame = CGRectMake(10, (sign_height-15)/2, 15, 15);
    siginImageViw.image = siginImg;
    _siginImageViw = siginImageViw;
    [signView addSubview:siginImageViw];
    
    //签到标签
    _siginLabel = [USUIViewTool createUILabelWithTitle:@"已签到0天" fontSize:kCommonFontSize_12 color:[UIColor whiteColor] heigth:15];
    _siginLabel.frame = CGRectMake(siginImageViw.x+siginImageViw.width+5, siginImageViw.y, sign_width-siginImageViw.width-siginImageViw.x-30, 15);
    //_noteLB.backgroundColor = [UIColor redColor];
    _siginLabel.textAlignment = NSTextAlignmentCenter;
    [signView addSubview:_siginLabel];
    
    return bgView;
    
}

//签到操作
-(void)signFun{
    if (_account ==nil) {
        [MBProgressHUD showSuccess:@"你还没有登录哦！"];
        return ;
    }
    if ([_isSignTaday isEqualToString:@"1"]) {
        [MBProgressHUD showSuccess:@"今天已签到，明天继续加油哦！"];
        return ;
    }
    [USWebTool POSTWIthTip:@"signclient/signIn.action" showMsg:@"正在签到..." paramDic:@{@"customer_id":_account.id} success:^(NSDictionary *dataDic) {
        USAccount *account = [USAccount accountWithDic:dataDic[@"data"]];
        [USUserService saveAccount:account];
        _account = account ;
        [self updateSignOptionsStatic] ;
        
    } failure:^(id data) {
        
    }];
}

//重设签到数据
-(void) updateSignOptionsStatic{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.account = [USUserService accountStatic];
        if (_account==nil) {
            return;
        }
        //设置汪币和数据
        [self setSignDays] ;
    });
}

//设置签到
-(void)setSignDays{
    if (_account !=nil) {
        //获取签到数据
        [USWebTool POST:@"signclient/getsignDays.action" paramDic:@{@"customer_id":_account.id} success:^(NSDictionary *dataDic) {
            _isSignTaday = [NSString stringWithFormat:@"%@",dataDic[@"data"][@"is_sign_taday"]];
            NSString *singstr =[NSString stringWithFormat:@"签到%@天", dataDic[@"data"][@"sign_days"]];
            [_rightBtn setTitle:singstr forState:UIControlStateNormal];
            /**
             _siginLabel.text = [NSString stringWithFormat:@"已签到%@", dataDic[@"data"][@"sign_days"]];
             if ([_isSignTaday isEqualToString:@"1"]) {
             _siginImageViw.hidden = NO;
             }else{
             _siginImageViw.hidden = YES;
             }
             **/
            
        } failure:^(id data) {
            
        }];
        
    }
    
}


//商铺分类部分
-(UIView *)createBussinessView:(CGFloat)y{
    CGFloat height = 170;
    _height+=height+30;
    NSArray *titles = @[@"美食",@"酒水",@"水果",@"超市",@"网吧",@"服饰",@"造型",@"更多"];
    NSArray *images = @[@"home_business_ms",@"home_business_js",@"home_business_sg",@"home_business_cs",@"home_business_wb",@"home_business_fs",@"home_business_zx",@"home_business_more"];
    NSArray *ids = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8"] ;
    USGridBusinessView *commerceView = [[ USGridBusinessView alloc]initWithFrame:CGRectMake(0,y, kAppWidth, height) itemTitles:titles itemImages:images ids:ids rowCount:2 cellCount:4 nav:self.navigationController];
    [commerceView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:commerceView];
    return  commerceView;
}




//获取用户位置
-(void)setUerlocation{
    if ([CLLocationManager locationServicesEnabled]) {
        if ([[[UIDevice currentDevice] systemVersion] doubleValue] > 8.0)
        {
            //设置定位权限 仅ios8有意义
            [self.locMgr requestWhenInUseAuthorization];// 前台定位
            
            [self.locMgr requestAlwaysAuthorization];// 前后台同时定位
        }
        //开始定位用户的位置
        //每隔多少米定位一次（这里的设置为任何的移动）
        self.locMgr.distanceFilter= kCLLocationAccuracyNearestTenMeters;
        //设置定位的精准度，一般精准度越高，越耗电（这里设置为精准度最高的，适用于导航应用）
        self.locMgr.desiredAccuracy=kCLLocationAccuracyBestForNavigation;
        [self.locMgr startUpdatingLocation];
        _currentLocation = [self.locMgr location];
        
        
        if (_currentLocation == nil) {
            
            return;
        }
        if (_currentLocation!=nil && _account !=nil) {
            //_paramDic[@"x"]=_currentLocation.altitude;
            //维度：loc.coordinate.latitude
            //经度：loc.coordinate.longitude
            _paramDic =[NSMutableDictionary dictionary] ;
            _paramDic[@"y"]=@(_currentLocation.coordinate.latitude);
            _paramDic[@"x"]=@(_currentLocation.coordinate.longitude);
            _paramDic[@"h"]=@"0";
            _paramDic[@"customer_id"] = _account.id;
            
            [USWebTool POST:@"wangkaNearByClientcontroller/saveNearbyCustomerPoint.action" paramDic:_paramDic success:^(NSDictionary *dic) {
                
                
            } failure:^(id data) {
                
            }];
            
        }
    }else
    {
        [[[UIAlertView alloc] initWithTitle:@"提示：" message:@"请去设置-隐私-位置 开启位置服务..." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
        
    }
}


//
-(void)initLocMgr
{
    if (_locMgr==nil) {
        //1.创建位置管理器（定位用户的位置）
        self.locMgr=[[CLLocationManager alloc]init];
        //2.设置代理
        self.locMgr.delegate=self;
    }
}


#pragma mark-CLLocationManagerDelegate

/**
 *  当定位到用户的位置时，就会调用（调用的频率比较频繁）
 */
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //locations数组里边存放的是CLLocation对象，一个CLLocation对象就代表着一个位置
    _currentLocation = [locations firstObject];
    
    NSLog(@"locationManager") ;
    
    
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    [MBProgressHUD showError:@"获取位置失败..."];
}

//重新加载
-(void)updateData{
    //初始化地理位置
    [self initLocMgr] ;
    //定义位置
    [self setUerlocation] ;
    //签到
    [self setSignDays] ;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        _account = [USUserService accountStatic];
        if (_account!=nil) {
            _currentBlance.text = [NSString stringWithFormat:@"%.02f",_account.surplusmoney];
        }
    });
    
    
}
@end
