//
//  USHomeViewController_1.m
//  大学生分期
//
//  Created by HeXianShan on 15/12/12.
//  Copyright © 2015年 hongyunct. All rights reserved.
//

#import "USHomeViewController_1.h"

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
@interface USHomeViewController_1 ()<UIScrollViewDelegate,USGridCellViewDelegate,USCommonServiceDelegate,USAnomalyViewDelegate>
@property(nonatomic,weak)UIScrollView *adsScollView;
@property(nonatomic,weak)UIPageControl *pageControl;
@property(nonatomic,weak)UIButton *fillAccountButton;
@property(nonatomic,weak)UIView *fillAccountButtonBg;
@property(nonatomic,strong)NSDictionary *buttonTitleActionDic;
@property(nonatomic,strong)USAccount *account;
@property(nonatomic,strong)USAnomalyView *myPikerView;
@property(nonatomic,strong)UILabel *currentBlance;
@property(nonatomic,strong)NSMutableArray  *activiArrayList;
@end

@implementation USHomeViewController_1

- (void)viewDidLoad {
    self.navigationItem.title = @"哇咔";
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
                              @"旺社区":@[@"home_wanshequ_bt_img",@"USNearViewController"],//
                              @"夺宝奇兵":@[@"home_duobaoqibin_bt_img",@"USSnatchViewController"],//
                              @"人气榜":@[@"home_renqiban_bt_img"],//
                              @"邀约":@[@"home_yaoyue_bt_img"]};//
    UIView *centerView = [self createCenterButtonsView:_adsScollView.y+_adsScollView.height+10];
    [self.view addSubview:centerView];
    //
    // UIView *bottomView = [self createBottomButtonsView:centerView.y+centerView.height+10];
    //  [self.view addSubview:bottomView];
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
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%i.jpg",i]];
            image = [UIImage imageCompressForSize:image targetSize:CGSizeMake(_adsScollView.width, _adsScollView.height)];
            UIImageView *temp = [[UIImageView alloc]initWithFrame:CGRectMake(width, 0, _adsScollView.width, _adsScollView.height)];
            /*UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
             button.x = width;
             button.y = 0;
             button.width = _adsScollView.bounds.size.width;
             button.height = _adsScollView.bounds.size.height;
             [button setImage:image forState:UIControlStateNormal];
             [button setImage:image forState:UIControlStateHighlighted];
             [button addTarget:self action:@selector(clickScollImages:) forControlEvents:UIControlEventTouchUpInside];
             [_adsScollView addSubview: button];
             
             */
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
-(UIView *)createCenterButtonsView:(CGFloat)y{
    CGFloat height = (kAppHeight - y - self.navigationController.navigationBar.height);
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, y, kAppWidth, height)];
    bgView.backgroundColor = [UIColor clearColor];
    //
    UIButton *borrowBt = [USUIViewTool createButtonWith:@"" imageName:@"home_new_borrow_bt_img"];
    borrowBt.frame = CGRectMake(0, 10, 70, 70);
    borrowBt.centerX = bgView.width/2;
    borrowBt.tag = 0;
    [borrowBt addTarget:self action:@selector(borrowBtClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:borrowBt];
    //
    UILabel *tipLB = [USUIViewTool createUILabelWithTitle:@"我要借款" fontSize:kCommonFontSize_18 color:[UIColor blackColor] heigth:kCommonFontSize_20];
    tipLB.font = [UIFont boldSystemFontOfSize:kCommonFontSize_18];
    tipLB.frame = CGRectMake(0, borrowBt.y+borrowBt.height+10, kAppWidth, kCommonFontSize_18);
    tipLB.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:tipLB];
    CGRect frame = tipLB.frame;
    //
    tipLB = [USUIViewTool createUILabelWithTitle:@"现金灵活分期,当天快速到账" fontSize:kCommonFontSize_12 color:HYCTColor(168, 168, 168) heigth:kCommonFontSize_12];
    tipLB.frame = frame;
    tipLB.font = [UIFont boldSystemFontOfSize:kCommonFontSize_12];
    tipLB.frame = CGRectMake(0, tipLB.y+tipLB.height+5, kAppWidth, kCommonFontSize_12);
    tipLB.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:tipLB];
    //
    UIView *twoBttonView = [self createTwoButtonViews:tipLB.y+tipLB.height+10 height:bgView.height - tipLB.y-tipLB.height -10];
    [bgView addSubview:twoBttonView];
    return  bgView;
}
-(UIView *)createTwoButtonViews:(CGFloat)y height:(CGFloat) height{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0,y, kAppWidth,height)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.borderColor = [HYCTColor(220, 220, 220) CGColor];
    bgView.layer.borderWidth = 0.5;
    //
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0,0, kAppWidth*0.35,height)];
    leftView.backgroundColor = [UIColor clearColor];
    //
    UIButton *rebackBt = [USUIViewTool createButtonWith:@"" imageName:@"home_new_reback_bt_img"];
    rebackBt.tag = 1;
    rebackBt.frame = CGRectMake(0, 10, 50, 50);
    rebackBt.centerX = leftView.width/2;
    [rebackBt addTarget:self action:@selector(rebackBtClick:) forControlEvents:UIControlEventTouchUpInside];
    [leftView addSubview:rebackBt];
    UILabel *tipLB = [USUIViewTool createUILabelWithTitle:@"我要还款" fontSize:kCommonFontSize_15 color:[UIColor blackColor] heigth:kCommonFontSize_20];
    tipLB.font = [UIFont boldSystemFontOfSize:kCommonFontSize_15];
    tipLB.frame = CGRectMake(0, rebackBt.height+rebackBt.y+15, leftView.width, kCommonFontSize_15);
    tipLB.textAlignment = NSTextAlignmentCenter;
    [leftView addSubview:tipLB];
    CGRect frame = tipLB.frame;
    tipLB = [USUIViewTool createUILabelWithTitle:@"" fontSize:kCommonFontSize_12 color:HYCTColor(168, 168, 168) heigth:kCommonFontSize_12*2];
    tipLB.frame = frame;
    tipLB.numberOfLines = 0;
    tipLB.font = [UIFont boldSystemFontOfSize:kCommonFontSize_12];
    tipLB.frame = CGRectMake(0, tipLB.y+tipLB.height, leftView.width, kCommonFontSize_12*4);
    tipLB.text = @"自由还款,提前还,\n分期还,免手续费还";
    tipLB.textAlignment = NSTextAlignmentCenter;
    [leftView addSubview:tipLB];
    //
    [bgView addSubview:leftView];
    //
    UIView *line = [USUIViewTool createLineView];
    line.frame =CGRectMake(leftView.width+1, 0, 0.5, leftView.height);
    line.backgroundColor = HYCTColor(230, 230, 230);
    [bgView addSubview:line];
    //
    _currentBlance =  [USUIViewTool createUILabelWithTitle:@"00.00" fontSize:kCommonFontSize_36 color:HYCTColor(250, 90, 100) heigth:kCommonFontSize_30];
    _currentBlance.frame = CGRectMake(line.x+10, 10, bgView.width-line.x, kCommonFontSize_36);
    [bgView addSubview:_currentBlance];
    tipLB = [USUIViewTool createUILabelWithTitle:@"当前额度" fontSize:kCommonFontSize_12 color:HYCTColor(168, 168, 168) heigth:kCommonFontSize_12];
    tipLB.frame = _currentBlance.frame;
    tipLB.numberOfLines = 0;
    tipLB.font = [UIFont systemFontOfSize:kCommonFontSize_12];
    tipLB.frame = CGRectMake(_currentBlance.x, _currentBlance.y+_currentBlance.height+10, _currentBlance.width, kCommonFontSize_12);
    [bgView addSubview:tipLB];
    //
    line = [USUIViewTool createLineView];
    line.frame =CGRectMake(leftView.width+1, tipLB.height+tipLB.y+15, bgView.width-leftView.width, 1);
    line.backgroundColor = HYCTColor(230, 230, 230);
    [bgView addSubview:line];
    //
    UIButton *increameBt = [USUIViewTool createButtonWith:@"我要提额"];
    increameBt.titleLabel.font =[UIFont systemFontOfSize:kCommonFontSize_16];
    [increameBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    increameBt.frame= CGRectMake(_currentBlance.x, line.y+25, 65, kCommonFontSize_16);
    increameBt.tag = 2;
    [increameBt addTarget:self action:@selector(increameBtClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:increameBt];
    //
    tipLB = [USUIViewTool createUILabelWithTitle:@"额度不够,没关系速度提额>" fontSize:kCommonFontSize_12 color:HYCTColor(168, 168, 168) heigth:kCommonFontSize_10];
    tipLB.font = [UIFont systemFontOfSize:8];
    //tipLB.backgroundColor = [UIColor redColor];
    tipLB.frame = CGRectMake(increameBt.x+increameBt.width, increameBt.y+increameBt.height*0.2, kAppWidth*0.40, kCommonFontSize_10);
    tipLB.textAlignment = NSTextAlignmentRight;
    [bgView addSubview:tipLB];
    return bgView;
}
-(void)borrowBtClick:(UIButton *)button{
    if (_account == nil) {
        USLoginViewController *loginVC =[[USLoginViewController alloc]init];
        loginVC.hidesBottomBarWhenPushed = YES;
        loginVC.nextDoblock = ^(){
            UIViewController *nextShowVC = nil;
            if (!_account.isbindbankcard) {
                nextShowVC = [[USBindBankCardViewController alloc]init];
                nextShowVC.hidesBottomBarWhenPushed = YES;
            }else{
                nextShowVC = [self bussness:button];
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
            nextShowVC = [self bussness:button];
        }
        [self.navigationController pushViewController:nextShowVC animated:YES];
    }
}
-(void)rebackBtClick:(UIButton *)button{
    if (_account == nil) {
        USLoginViewController *loginVC =[[USLoginViewController alloc]init];
        loginVC.hidesBottomBarWhenPushed = YES;
        loginVC.nextDoblock = ^(){
            UIViewController *nextShowVC = [self bussness:button];
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
        UIViewController *nextShowVC = [self bussness:button];
        
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

-(void)didTopButtonClick:(UIButton *)anomarlyView{
    
    UIViewController *viewController = [self getCommonNextVC:anomarlyView];
    if (viewController!=nil) {
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
}
- (void)didLogin:(UIButton *)blockPickView {
    //blockPickView.logined = NO;
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

-(UIViewController *)bussness:(UIButton *)button{
    _account = [USUserService accountStatic];
    UIViewController *toShowVC = nil;
    if (_account.realnametype == -1) {
        toShowVC = [[USCertificationViewController alloc]init];
    }else if (_account.realnametype == 3){
        toShowVC = [self getCommonNextVC:button];
    }else{
        [MBProgressHUD showError:@"你的实名认证还未审核完毕!"];
    }
    toShowVC.hidesBottomBarWhenPushed = YES;
    return toShowVC;
}
- (UIViewController *)getCommonNextVC:(UIButton *)button {
    
    NSArray *btsArray = _buttonTitleActionDic[[NSString stringWithFormat:@"%li",(long)button.tag]];
    if ([btsArray count]>=2) {
        UIViewController  *viewController= [[NSClassFromString([btsArray lastObject]) alloc] init];
        viewController.hidesBottomBarWhenPushed = YES;
        return viewController;
    }
    return nil;
}

//加载数据
-(void)updateData{
    [self loadFirstImages];
    dispatch_async(dispatch_get_main_queue(), ^{
        _account = [USUserService account];
        if (_account!=nil) {
            _currentBlance.text = [NSString stringWithFormat:@"%.02f",_account.surplusmoney];
        }
    });
    
    
}
@end

