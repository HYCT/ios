//
//  HYMyinfoViewController.m
//  红云创投
//
//  Created by HeXianShan on 15/8/9.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USVaughanCardViewController.h"
#import "USAccountApproveView.h"
#import "USMoreTableViewController.h"
#import "USAccountViewController.h"
#import "USAccountView.h"
#import "USAccountTableViewController.h"
#import "USAccountApproveView.h"
#import "USAccountHistoryView.h"
#import "USMainUITabBarController.h"
#import "USFinanceLoanViewController.h"
#import "USAccountManagerViewController.h"
#import "USRebackListViewController.h"
#import "USCertificationViewController.h"
#import "USLoginViewController.h"
#import "USAccount.h"
#import "USUserService.h"
#import "USUpLoadImageServiceTool.h"
#import "USVUpImagDownTitleView.h"
#import "USCircleViewController.h"
#import "USFourGridView.h"
#import "USMyInviteViewController.h"
#import "USMySnatchViewController.h"
#import "USSayHelloViewController.h"
#import "USXRankViewController.h"
#import "USMoreMessageViewController.h"
#import "USAccountManagerViewController.h"
#define kHeaderHeight 300
#define kLindeView [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, 1)]
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
@interface USVaughanCardViewController ()<USAccountApproveViewDelegate,UITabBarDelegate,USAccountViewDelegate,USAccountHistoryViewDelegate,UIAlertViewDelegate>

@property(nonatomic,strong) USAccountApproveView *accountApproveView ;
@property(nonatomic,strong)USAccountTableViewController *accountTableCV;
@property(nonatomic,strong)USAccount *account;
@property(nonatomic,strong)USUpLoadImageServiceTool *upLoadImageService;
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)UIView *footerView;
@property(nonatomic,strong)UILabel *certiTip;
@property(nonatomic,strong)UILabel *noteLB;
@property(nonatomic,strong)NSString *noteDay;
@property(nonatomic,strong)UILabel *wangBiLB;
@property(nonatomic,strong)NSString *wangBi;
@property(nonatomic,strong)UIView *noteView;
@property(nonatomic,strong)UIImageView *siginImageViw;
@property(nonatomic,strong)USVUpImagDownTitleView *myfocus;
@property(nonatomic,strong)USVUpImagDownTitleView *myfus;
@property(nonatomic,strong)USVUpImagDownTitleView *myfriend;
@property(nonatomic,strong)USFourGridView *gridFourView;

//账户名称
@property(nonatomic,strong)UILabel *nameLabel ;
//记录今天是否签到
@property(nonatomic,strong)NSString *isSignTaday ;
@end

@implementation USVaughanCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人中心";
    _noteDay = @"已经签到%@天";
    _wangBi = @"汪币: %lli";
    self.navigationController.navigationBar.translucent= NO;
    [self.view setBackgroundColor:HYCTColor(240, 241, 240)];
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kAppWidth, 100)];
    _headerView.userInteractionEnabled = YES;
    _headerView.backgroundColor = [UIColor clearColor];
    
    _footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kAppWidth, kHeaderHeight)];
    _footerView.userInteractionEnabled = YES;
    _footerView.backgroundColor = [UIColor clearColor];
    
    //头部
    [self createAccountApproveView];
    
    //退出
    [self createFooterView];
    
    //导航部分
    [self createAccountTableVC];
    
    
    
}

//登录检查
-(void)checkLogin{
    self.account = [USUserService accountStatic];
    if (self.account == nil) {
        [MBProgressHUD showError:@"还没有登录，请登录..."];
        USLoginViewController *loginVC = [[USLoginViewController alloc]init];
        loginVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginVC animated:YES];
    }
}
//重设签到数据
-(void) updateSignOptionsStatic{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.account = [USUserService accountStatic];
        if (_account==nil) {
            return;
        }
        //设置汪币和数据
        [self setSignDaysAndWangBi] ;
    });
}

//设置汪币和签到
-(void)setSignDaysAndWangBi{
    _wangBiLB.text = [NSString stringWithFormat:_wangBi,self.account.wang_bi ];
    //获取签到数据
    [USWebTool POST:@"signclient/getsignDays.action" paramDic:@{@"customer_id":_account.id} success:^(NSDictionary *dataDic) {
        _isSignTaday = [NSString stringWithFormat:@"%@",dataDic[@"data"][@"is_sign_taday"]];
        _noteLB.text = [NSString stringWithFormat:_noteDay, dataDic[@"data"][@"sign_days"]];
        if ([_isSignTaday isEqualToString:@"1"]) {
            //_noteLB.text = [NSString stringWithFormat:_noteDay, dataDic[@"data"][@"sign_days"]];
            _siginImageViw.hidden = NO;
        }else{
            _siginImageViw.hidden = YES;
            //_noteLB.text = @"今天还未签到";
        }
        
    } failure:^(id data) {
        
    }];
    
}

-(void)updateData{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self checkLogin];
        self.account = [USUserService account];
        if (_account==nil) {
            return;
        }
        if (self.account.headerImg!=nil) {
            _accountApproveView.personImageView.image = self.account.headerImg;
        }
        if (self.account.realnametype == 3) {
            _certiTip.text = @"已认证";
        }
        if ((self.account.name !=nil)&&self.account.name.length>0) {
            _nameLabel.text = _account.name ;
            _accountApproveView.accountNameLabel.text = _account.name;
        }
        //设置汪币和数据
        [self setSignDaysAndWangBi] ;
        
        /**
        //获取统计数据
        [USWebTool POST:@"wangkaClientController/getCustomerSomeCount.action" paramDic:@{@"customer_id":_account.id} success:^(NSDictionary *dataDic) {
            dataDic = dataDic[@"data"];
            _gridFourView.sendYyueCLB.text=[NSString stringWithFormat:@"发起 %@",@(2)];
            _gridFourView.joinYyueCLB.text = [NSString stringWithFormat:@"参与 %@",@(3)];
            //
            _gridFourView.joinSnaCLB.text=[NSString stringWithFormat:@"参与 %@",@(4)];
            _gridFourView.succeSnaCLB.text = [NSString stringWithFormat:@"成功 %@",@(5)];
            
            //
            _gridFourView.scanCLB.text=[NSString stringWithFormat:@"浏览 %@",@(6)];
            _gridFourView.voteCLB.text = [NSString stringWithFormat:@"点赞 %@",@(100)];
            //
            _gridFourView.sortLB.text = [NSString stringWithFormat:@" %@",@(1)];
            //
            //            _gridFourView.sendYyueCLB.text=[NSString stringWithFormat:@"发起 %@",@([dataDic[@"inviter_count"] longValue])];
            _gridFourView.sendYyueCLB.text=[NSString stringWithFormat:@"发起 %@",@([dataDic[@"inviter_count"] longValue])];
            [self dealData:_gridFourView.sendYyueCLB data:dataDic[@"inviter_count"] format:@"发起 %@"];
            //            _gridFourView.joinYyueCLB.text = [NSString stringWithFormat:@"参与 %@",@([dataDic[@"inviter_enter_count"] longValue])];
            [self dealData: _gridFourView.joinYyueCLB data:dataDic[@"inviter_enter_count"] format:@"参与 %@"];
            //            //
            //            _gridFourView.joinSnaCLB.text=[NSString stringWithFormat:@"参与 %@",@([dataDic[@"indiana_count"] longValue])];
            //            _gridFourView.succeSnaCLB.text = [NSString stringWithFormat:@"成功 %@",@([dataDic[@"success_indiana_count"] longValue])];
            [self dealData: _gridFourView.joinSnaCLB data:dataDic[@"indiana_count"] format:@"参与 %@"];
            [self dealData: _gridFourView.succeSnaCLB data:dataDic[@"success_indiana_count"] format:@"成功 %@"];
            //            //
            //            _gridFourView.scanCLB.text=[NSString stringWithFormat:@"浏览 %@",@([dataDic[@"visit_count"] longValue])];
            //            _gridFourView.voteCLB.text = [NSString stringWithFormat:@"点赞 %@",@([dataDic[@"zang_count"] longValue])];
            //            //
            [self dealData: _gridFourView.scanCLB data:dataDic[@"visit_count"] format:@"浏览 %@"];
            [self dealData: _gridFourView.voteCLB data:dataDic[@"zang_count"] format:@"点赞 %@"];
            //            _gridFourView.sortLB.text = [NSString stringWithFormat:@" %@",@([dataDic[@"p_count"] longValue])];
            [self dealData: _gridFourView.sortLB data:dataDic[@"p_count"] format:@" %@"];
        } failure:^(id data) {
            
        }];
        **/
    });
    
    
}
-(void)dealData:(UILabel *)lable data:(id)obj format:(NSString *)fomat{
    long count = 0;
    if ([NSNull null]!=obj) {
        count = [obj longValue];
    }
    lable.text = [NSString stringWithFormat:fomat,@(count)];
}


-(void)createAccountApproveView{
    UIView *bgView = [[UIView alloc]init];
    bgView.userInteractionEnabled = YES;
    USAccountApproveView *accountApproveView = [USAccountApproveView accountApproveView];
    accountApproveView.height = _headerView.height-10;
    accountApproveView.width = kAppWidth;
    accountApproveView.backgroundView.height = accountApproveView.height ;
    accountApproveView.backgroundColor = HYCTColor(255, 140, 1);
    //accountApproveView.bgImgeView.height = 70;
    bgView.frame = accountApproveView.frame;
    [bgView addSubview:accountApproveView];
    
    accountApproveView.y = 0;
    accountApproveView.deleage = self;
    _accountApproveView = accountApproveView;
    
    //隐藏
    _accountApproveView.nameView.hidden=YES ;
    _accountApproveView.personImageView.size = CGSizeMake(65, 65);
    _accountApproveView.personImageView.y = 5;
    _accountApproveView.personImageView.layer.cornerRadius = _accountApproveView.personImageView.width*0.5;
    _accountApproveView.personImageView.layer.masksToBounds = YES;
    _accountApproveView.personImageView.x = 20;
    
    _accountApproveView.settingButton.hidden = YES;
    _accountApproveView.userInteractionEnabled = YES;
    UIButton *carmera = [USUIViewTool createButtonWith:@"" imageName:@"account_camera"];
    carmera.frame = CGRectMake(_accountApproveView.personImageView.width*0.85+_accountApproveView.personImageView.x, _accountApproveView.personImageView.height*0.9-kPhotoImageSize, kPhotoImageSize, kPhotoImageSize);
    [carmera addTarget:self action:@selector(carmera) forControlEvents:UIControlEventTouchUpInside];
    [_accountApproveView addSubview:carmera];
    
    //账户名称
    UILabel *namelabel = [USUIViewTool createUILabelWithTitle:@"账户名称" fontSize:12 color:[UIColor whiteColor] heigth:14];
    [namelabel setX:_accountApproveView.personImageView.x + _accountApproveView.personImageView.width+20] ;
    [namelabel setY:_accountApproveView.personImageView.y+10] ;
    [namelabel setWidth:100] ;
    _nameLabel = namelabel ;
    [_accountApproveView addSubview:namelabel ];
    
    //账户管理按钮
    UIButton *accountManager = [USUIViewTool createButtonWith:@"账户管理"] ;
    [accountManager setHeight:25] ;
    [accountManager setWidth:70] ;
    [accountManager setX:namelabel.x] ;
    [accountManager setY:namelabel.y+20] ;
    [accountManager setFont:[UIFont systemFontOfSize:12 ]] ;
    [accountManager setBackgroundColor:[UIColor orangeColor]] ;
    [accountManager.layer setMasksToBounds:TRUE] ;
    [accountManager.layer setBorderWidth:1] ;
    [accountManager.layer setCornerRadius:3] ;
    [accountManager addTarget:self action:@selector(accountManagerFun) forControlEvents:UIControlEventTouchUpInside] ;
    
    [accountManager.layer setBorderColor:[[UIColor whiteColor]CGColor] ] ;
    [_accountApproveView addSubview:accountManager];
    
    //消息图片
    UIButton *btnMsg = [USUIViewTool createButtonWith:@"" imageName:@"person_message"];
    [btnMsg setX:kAppWidth-60] ;
    [btnMsg setY:_accountApproveView.personImageView.y+20] ;
    [btnMsg setWidth:30] ;
    [btnMsg setHeight:30] ;
    [btnMsg addTarget:self action:@selector(myMessage) forControlEvents:UIControlEventTouchUpInside] ;
    [_accountApproveView addSubview:btnMsg] ;
    
   
    [_headerView addSubview:bgView];
    
    
   
}



//创建头部------暂时不用
-(void)createAccountApproveViewOld{
    UIView *bgView = [[UIView alloc]init];
    bgView.userInteractionEnabled = YES;
    USAccountApproveView *accountApproveView = [USAccountApproveView accountApproveView];
    accountApproveView.height = kHeaderHeight-10;
    accountApproveView.width = kAppWidth;
    accountApproveView.backgroundView.height = kHeaderHeight-10;
    accountApproveView.backgroundColor = HYCTColor(255, 140, 1);
    accountApproveView.bgImgeView.height = 70;
    bgView.frame = accountApproveView.frame;
    [bgView addSubview:accountApproveView];
    accountApproveView.y = 0;
    accountApproveView.deleage = self;
    _accountApproveView = accountApproveView;
    _accountApproveView.accountNameLabel.text = self.account.name;
    _accountApproveView.accountNameLabel.font = [UIFont systemFontOfSize:kCommonFontSize_15];
    _accountApproveView.accountNameLabel.x=5;
    _accountApproveView.accountNameLabel.textColor = [UIColor blackColor];
    _accountApproveView.personImageView.size = CGSizeMake(65, 65);
    _accountApproveView.personImageView.y = 5;
    _accountApproveView.personImageView.layer.cornerRadius = _accountApproveView.personImageView.width*0.5;
    _accountApproveView.personImageView.layer.masksToBounds = YES;
    _accountApproveView.personImageView.centerX = kAppWidth/2;
    _accountApproveView.nameView.centerX = _accountApproveView.personImageView.centerX+5;
    _accountApproveView.nameView.y =_accountApproveView.personImageView.y+_accountApproveView.personImageView.height+5;
    _accountApproveView.settingButton.hidden = YES;
    _accountApproveView.userInteractionEnabled = YES;
    UIButton *carmera = [USUIViewTool createButtonWith:@"" imageName:@"account_camera"];
    carmera.frame = CGRectMake(_accountApproveView.personImageView.width*0.85+_accountApproveView.personImageView.x, _accountApproveView.personImageView.height*0.9-kPhotoImageSize, kPhotoImageSize, kPhotoImageSize);
    [carmera addTarget:self action:@selector(carmera) forControlEvents:UIControlEventTouchUpInside];
    [_accountApproveView addSubview:carmera];
    //签到
    UIView *noteView = [self createNoteView:_accountApproveView.nameView.y+5];
    noteView.y = 10;
    noteView.centerX = kAppWidth*0.8;
    _noteView = noteView;
    [_accountApproveView addSubview:noteView];
    //
    _wangBiLB = [USUIViewTool createUILabelWithTitle:@"汪币:0" fontSize:kCommonFontSize_12 color:[UIColor whiteColor] heigth:kCommonFontSize_12];
    _wangBiLB.frame = CGRectMake(10, noteView.y+noteView.height+5, noteView.width, kCommonFontSize_12);
    _wangBiLB.centerX = noteView.centerX;
    _wangBiLB.textAlignment = NSTextAlignmentCenter;
    [_accountApproveView addSubview:_wangBiLB];
    //_accountApproveView.backgroundColor = [UIColor redColor];
    [_headerView addSubview:bgView];
    
    
    CGFloat margin = 20;
    USVUpImagDownTitleView *myfocus = [[USVUpImagDownTitleView alloc]initWithFrame:CGRectMake(15, _accountApproveView.nameView.y+margin*1.5, 60, 40) imageName:@"mine_attention" downTitle:@"我的关注"];
    _myfocus = myfocus;
    _myfocus.x = margin*3.5;
    //__block UIViewController *tempVC = self;
    _myfocus.clickBlock = ^(){
        [self quanxiTypefun:@"0"] ;
        //USCircleViewController *circleVC = [[USCircleViewController alloc]init];
        //[tempVC.navigationController pushViewController:circleVC animated:YES];
    };
    
    [_accountApproveView addSubview:myfocus];
    _myfus = [[USVUpImagDownTitleView alloc]initWithFrame:CGRectMake(_myfocus.x+_myfocus.width+margin*0.5, _myfocus.y, 60, 40) imageName:@"mine_fans" downTitle:@"我的粉丝"];
    [_accountApproveView addSubview:_myfus];
    //_myfus.clickBlock = _myfocus.clickBlock;
    _myfus.clickBlock = ^(){
        [self quanxiTypefun:@"1"] ;
    };
    _myfriend = [[USVUpImagDownTitleView alloc]initWithFrame:CGRectMake(_myfus.x+_myfus.width+margin*0.5, _myfocus.y, 60, 40) imageName:@"mine_friend" downTitle:@"我的朋友"];
    //_myfriend.clickBlock = _myfocus.clickBlock;
    _myfriend.clickBlock = ^(){
        [self quanxiTypefun:@"2"] ;
    };
    [_accountApproveView addSubview:_myfriend];
    //
    UIView *marginView = [[UIView alloc]initWithFrame:CGRectMake(0, _myfriend.y+_myfriend.height+10, _headerView.width, 10)];
    marginView.backgroundColor = HYCTColor(240, 240, 240);
    [_headerView addSubview:marginView];
    //我的邀约，我的夺宝，我的排行，我的访客4个导航
    USFourGridView *gridFourView = [[USFourGridView alloc]initWithFrame:CGRectZero];
    _gridFourView = gridFourView;
    gridFourView.y = marginView.y+marginView.height;
    //我的邀约
    [gridFourView.yaoyueBtn addTarget:self action:@selector(myinviteClick) forControlEvents:UIControlEventTouchUpInside];
    //我的夺宝
    [gridFourView.duobaoBtn addTarget:self action:@selector(myduobaoClick) forControlEvents:UIControlEventTouchUpInside];
    //我的排行
    [gridFourView.mysortBtn addTarget:self action:@selector(mysortClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_headerView addSubview:gridFourView];
}

//我的邀约单击函数
-(void)myinviteClick{
    USMyInviteViewController *vc = [[USMyInviteViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

//我的夺宝单击函数
-(void)myduobaoClick{
    USMySnatchViewController *vc = [[USMySnatchViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

}

//我的排行单击函数
-(void)mysortClick{
    USXRankViewController *renqi = [[USXRankViewController  alloc]init];
    [self.navigationController pushViewController:renqi animated:YES] ;
    
}



//圈子的三个函数
-(void)quanxiTypefun:(NSString *)type{
    USCircleViewController *circleVC = [[USCircleViewController alloc]init];
    circleVC.type=type;
    [self.navigationController pushViewController:circleVC animated:YES];
}
//创建签到
-(UIView *)createNoteView:(CGFloat)y{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, y, 100, 22)];
    bgView.userInteractionEnabled = YES;
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = bgView.height*0.5;
    bgView.layer.masksToBounds = YES;
    UIButton *noteBt = [UIButton buttonWithType:UIButtonTypeCustom];
    noteBt.frame = bgView.bounds;
    [noteBt addTarget:self action:@selector(note) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:noteBt];
    UIImage *siginImg = [UIImage imageNamed:@"more_sigin_img"];
    UIImageView *siginImageViw = [[UIImageView alloc]init];
    siginImageViw.frame = CGRectMake(8, (25-kCommonFontSize_12)/2, 12, kCommonFontSize_12);
    siginImageViw.image = siginImg;
    _siginImageViw = siginImageViw;
    [bgView addSubview:siginImageViw];
    _noteLB = [USUIViewTool createUILabelWithTitle:@"今天还未签到" fontSize:kCommonFontSize_12 color:[UIColor orangeColor] heigth:kCommonFontSize_12];
    _noteLB.frame = CGRectMake(siginImageViw.x+siginImageViw.width, (25-kCommonFontSize_12)/2, bgView.width -siginImageViw.x-siginImageViw.width-5, kCommonFontSize_12);
    //_noteLB.backgroundColor = [UIColor redColor];
    _noteLB.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:_noteLB];
    return bgView;
}
//签到操作
-(void)note{
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

//导航部分
-(void)createAccountTableVC{
    USAccountTableViewController *accountTableCV = [[USAccountTableViewController alloc]init];
    accountTableCV.dataFileUrl = @"meCellData";
    accountTableCV.view.x = 0;
    [self addChildViewController:accountTableCV];
    accountTableCV.tableView.tableHeaderView = _headerView;
    accountTableCV.tableView.bounces = YES;
    accountTableCV.tableView.scrollsToTop = YES;
    [self.view addSubview:accountTableCV.view];
    _accountTableCV = accountTableCV;
    _accountTableCV.tableView.tableFooterView = _footerView;
    
}
-(void)createFooterView{
    UIButton *logout = [USUIViewTool createButtonWith:@"退出登录"];
    logout.layer.cornerRadius = 10;
    logout.layer.masksToBounds = YES;
    logout.frame = CGRectMake(10, 20, kAppWidth-20, 40);
    [logout setBackgroundColor:HYCTColor(150, 150, 150)];
    [logout addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    [_footerView addSubview:logout];
}
- (void)logout{
    if (_account == nil) {
        [MBProgressHUD showError:@"你还没有登录..."];
        return;
    }
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"确定退出?" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.delegate = self;
    [alertView show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        [USUserService logout];
        USMainUITabBarController *rootVC = [[USMainUITabBarController alloc]init];
        [USUIViewTool chageWindowRootController:rootVC];
    }
}
-(void)carmera{
    [self didUpdateImage:_accountApproveView.personImageView];
}
-(void)didUpdateImage:(UIImageView *)imageView{
    self.account = [USUserService account];
    if (self.account == nil) {
        [MBProgressHUD showError:@"还没有登录，请登录..."];
        USLoginViewController *loginVC = [[USLoginViewController alloc]init];
        loginVC.hidesBottomBarWhenPushed = YES;
        loginVC.nextViewController = self;
        [self.navigationController pushViewController:loginVC animated:YES];
        return;
    }
    if (_upLoadImageService==nil) {
        __block USVaughanCardViewController *tempVC = self;
        _upLoadImageService = [[USUpLoadImageServiceTool alloc]init];
        _upLoadImageService.saveImageBlock = ^(UIImage *image){
            // imageView.image = image;
            [tempVC upload:image imageView:imageView];
        };
    }
    [_upLoadImageService pickImage];
}
-(void)upload:(UIImage *)image imageView:(UIImageView *)imageView{
    self.account = [USUserService account];
    NSString *idstr = self.account.id;
    if (self.account.headerImg!=nil) {
        _accountApproveView.personImageView.image = self.account.headerImg;
    }
    if (idstr!=nil&&idstr.length>0) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"customer_id"]=idstr;
        [USWebTool POST:@"register/updateCustomerHeadPic.action" paramDiC:dic uploadimgFilephoto:UIImagePNGRepresentation(image) success:^(NSDictionary * dicData) {
            imageView.image = image;
        } failure:^(id data) {
            
        }];
        
    }
}
-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    /*dispatch_async(kBgQueue, ^(){
     [self checkLogin];
     [self updateData];
     });*/
    [self performSelectorInBackground:@selector(updateData) withObject:nil];
}

//消息
-(void)myMessage{
    USMoreMessageViewController *controller=[[USMoreMessageViewController alloc]init] ;
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES] ;
}
/**
 **账户管理
 **/
-(void)accountManagerFun{
    USAccountManagerViewController *managerController = [[USAccountManagerViewController alloc]init] ;
    managerController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:managerController animated:TRUE] ;
}

@end
