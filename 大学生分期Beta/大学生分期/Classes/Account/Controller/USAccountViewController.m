//
//  HYDiscoverViewController.m
//  红云创投
//
//  Created by HeXianShan on 15/8/9.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

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
#import "USSayWordViewController.h"
#import "USMyticketViewController.h"
#import "USCertificationViewController.h"
#define kLindeView [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, 1)]
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
@interface USAccountViewController ()<USAccountApproveViewDelegate,UITabBarDelegate,USAccountViewDelegate,USAccountHistoryViewDelegate,UIAlertViewDelegate>
@property(nonatomic,strong) USAccountApproveView *accountApproveView ;
@property(nonatomic,strong) USAccountView *accountView ;
@property(nonatomic,strong) USAccountHistoryView *histroyView;
@property(nonatomic,weak)USAccountTableViewController *accountTableCV;
@property(nonatomic,strong)USAccount *account;
@property(nonatomic,strong)USUpLoadImageServiceTool *upLoadImageService;
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)UIView *footerView;
@property(nonatomic,strong)UILabel *certiTip;
@end

@implementation USAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人账户";
    self.navigationController.navigationBar.translucent= YES;
    [self.view setBackgroundColor:HYCTColor(240, 241, 240)];
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kAppWidth, 210)];
    _headerView.userInteractionEnabled = YES;
    _headerView.backgroundColor = [UIColor clearColor];
    _footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kAppWidth, 150)];
    _footerView.userInteractionEnabled = YES;
    _footerView.backgroundColor = [UIColor clearColor];
    [self createAccountApproveView];
    [self createAccountView];
    [self createAccountHistoryView];
    _histroyView.leftView.upTitle = @"0.00";
    _histroyView.leftView.downTitle = @"近7日待还";
    _histroyView.rightView.upTitle = @"0.00";
    _histroyView.rightView.downTitle = @"全部待还";
    //[self createFooterView];
    [self createAccountTableVC];
    //[_accountTableCV setMyIncome:@"128.00"];
    
}
-(void)checkLogin{
     self.account = [USUserService accountStatic];
    if (self.account == nil) {
        [MBProgressHUD showError:@"还没有登录，请先登录..."];
        USLoginViewController *loginVC = [[USLoginViewController alloc]init];
        loginVC.muslogin = YES;
        loginVC.hidesBottomBarWhenPushed = YES;
        loginVC.nextViewController = self;
        [self.navigationController pushViewController:loginVC animated:YES];
    }
}
-(void)updateData{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self checkLogin];
        if (_account==nil) {
            return;
        }
        if (self.account.headerImg!=nil) {
            _accountApproveView.personImageView.image = self.account.headerImg;
        }
         _certiTip.text = [USUserService realNameInfo:self.account.realnametype];
        if ((self.account.name !=nil)&&self.account.name.length>0) {
            _accountApproveView.accountNameLabel.text = _account.name;
        }
        
        _accountView.blanceLabel.text = [USStringTool getCurrencyStr:_account.surplusmoney];
        [_accountView setTotalBlance:[USStringTool getCurrencyStr:_account.limitmoney]];
        [self loadHistoryData];
    });
   
}

-(void)loadHistoryData{
    if (_account==nil) {
        return;
    }
    [USWebTool POST:@"repaymoneycilent/getRepayZhanghuHeadInfo.action" paramDic:@{@"customer_id":_account.id} success:^(NSDictionary *dataDic) {
        _histroyView.leftView.upTitle = [dataDic[@"data"][@"repaymoney_7"] length] ==0?@"0.00":dataDic[@"data"][@"repaymoney_7"];
        _histroyView.rightView.upTitle = dataDic[@"data"][@"repaymoney_all"];
    } failure:^(id data) {
        
    }];
   
}
-(void)createAccountApproveView{
    UIView *bgView = [[UIView alloc]init];
    bgView.userInteractionEnabled = YES;
    USAccountApproveView *accountApproveView = [USAccountApproveView accountApproveView];
    accountApproveView.height = 70;
    accountApproveView.backgroundView.height = 70;
    accountApproveView.bgImgeView.height = 70;
    bgView.frame = accountApproveView.frame;
    [bgView addSubview:accountApproveView];
    accountApproveView.y = 0;
    accountApproveView.deleage = self;
    //[self.view addSubview:accountApproveView];
     _accountApproveView = accountApproveView;
    _accountApproveView.accountNameLabel.text = self.account.name;
    _accountApproveView.accountNameLabel.font = [UIFont systemFontOfSize:kCommonFontSize_18];
    _accountApproveView.accountNameLabel.textColor = [UIColor blackColor];
    _accountApproveView.personImageView.size = CGSizeMake(65, 65);
    _accountApproveView.personImageView.layer.cornerRadius = _accountApproveView.personImageView.width*0.5;
    _accountApproveView.personImageView.layer.masksToBounds = YES;
    _accountApproveView.accountNameLabel.x+=10;
    _accountApproveView.accountNameLabel.y+=5;
    _certiTip = [USUIViewTool createUILabelWithTitle:@"未认证" fontSize:kCommonFontSize_15 color:[UIColor whiteColor] heigth:kCommonFontSize_15];
    _certiTip.frame = CGRectMake(_accountApproveView.accountNameLabel.x, _accountApproveView.accountNameLabel.y+_accountApproveView.accountNameLabel.height+5, 80, kCommonFontSize_15);
    [_accountApproveView.nameView addSubview:_certiTip];
   UIButton *carmera = [USUIViewTool createButtonWith:@"" imageName:@"account_camera"];
    carmera.frame = CGRectMake(_accountApproveView.personImageView.width+kPhotoImageSize*0.2, _accountApproveView.personImageView.height*0.9-kPhotoImageSize, kPhotoImageSize, kPhotoImageSize);
    [_accountApproveView addSubview:carmera];
    [carmera addTarget:self action:@selector(carmera) forControlEvents:UIControlEventTouchUpInside];
    UIButton *accountMgrBt = [USUIViewTool createButtonWith:@"账户管理 >"];
    accountMgrBt.frame = CGRectMake(kAppWidth-80, accountApproveView.height - 20, 80, 15);
    accountMgrBt.titleLabel.font = [UIFont systemFontOfSize:kCommonFontSize_14];
    [accountMgrBt addTarget:self action:@selector(managerAccount) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:accountMgrBt];
    UIView *line = [USUIViewTool createLineView];
    line.frame = CGRectMake(5, accountApproveView.y+accountApproveView.height-1, kAppWidth-5*2, 0.5);
    line.backgroundColor = HYCTColor(253, 154, 32);
    //[self.view addSubview:line];
    [accountApproveView.settingButton setHidden:YES];
    [bgView addSubview:accountMgrBt];
    [bgView addSubview:line];
    [_headerView addSubview:bgView];
}
-(void)createAccountView{
   // USAccountView *accountView = [[USAccountView alloc]initWithFrame:CGRectMake(_accountApproveView.x, _accountApproveView.y+_accountApproveView.height, kAppWidth, 115)];
     USAccountView *accountView = [[USAccountView alloc]initWithFrame:CGRectMake(_accountApproveView.x, _accountApproveView.y+_accountApproveView.height, kAppWidth, 90)];
    accountView.delegate = self;
     [self.view addSubview:accountView];
    accountView.backgroundColor = [UIColor redColor];
    self.accountView = accountView;
     [_headerView addSubview:self.accountView];
    accountView.blanceTipLabel.x = -10;
    accountView.blanceLabel.x = 5;
    accountView.blanceLabel.y+=5;
    accountView.blanceLabel.textAlignment = NSTextAlignmentLeft;
    accountView.totalBlanceLabel.textAlignment = NSTextAlignmentRight;
    accountView.totalBlanceLabel.x = 5;
    accountView.totalBlanceLabel.width = kAppWidth - accountView.totalBlanceLabel.x*2;
    accountView.borrowingButton.hidden = YES;
}
-(void)createAccountHistoryView{
    USAccountHistoryView *histroyView = [[USAccountHistoryView alloc]initWithFrame:CGRectMake(0, _accountView.y+_accountView.height, kAppWidth, 44)];
    _histroyView = histroyView;
    _histroyView.delegate =self;
    [histroyView.leftView removeFromSuperview];
    //histroyView.rightView.width = kAppWidth;
    histroyView.rightView.x = kAppWidth/2-histroyView.rightView.width/2;
    //[self.view addSubview:histroyView];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, histroyView.y+histroyView.height+1 , kAppWidth, 1)];
    [line setBackgroundColor:HYCTColor(224, 224, 224)];
    [_headerView addSubview:histroyView];
    [_headerView addSubview:line];
}

-(void)createAccountTableVC{
    USAccountTableViewController *accountTableCV = [[USAccountTableViewController alloc]init];
    accountTableCV.dataFileUrl = @"accountCellData";
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
    UIButton *logout = [USUIViewTool createButtonWith:@"安全退出"];
    logout.layer.cornerRadius = 10;
    logout.layer.masksToBounds = YES;
    logout.frame = CGRectMake(10, 20, kAppWidth-20, 40);
    [logout setBackgroundColor:HYCTColor(150, 150, 150)];
    [logout addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    [_footerView addSubview:logout];
}
- (void)logout{
    
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
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
     HYLog(@"------%li------",item.tag);
}
-(void)didApprove{
    HYLog(@"------didApprove------");
    UIViewController *toCV = [[USCertificationViewController alloc]init];
    toCV.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:toCV animated:YES];
}

-(void)didBorrowing{
    USFinanceLoanViewController *loadVC = [[USFinanceLoanViewController alloc]init];
    loadVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:loadVC animated:YES];
}
-(void)managerAccount{
    USAccountManagerViewController *secondeVC = [[USAccountManagerViewController alloc]init];
    [self.navigationController pushViewController:secondeVC animated:YES];
}
-(void)carmera{
    [self didUpdateImage:_accountApproveView.personImageView];
}
-(void)didUpdateImage:(UIImageView *)imageView{
    //[self upload:nil];
    if (_upLoadImageService==nil) {
        __block USAccountViewController *tempVC = self;
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
-(void)didLeftClick:(UIButton *)button{
    /*USRebackListViewController *sevenRebackList = [[USRebackListViewController alloc]init];
    sevenRebackList.title = @"七日待还";
    sevenRebackList.selectedIndex = 2;
    sevenRebackList.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:sevenRebackList animated:YES];
     */
    USRebackListViewController *allRebackList = [[USRebackListViewController alloc]init];
    allRebackList.hidesBottomBarWhenPushed = YES;
    allRebackList.title = @"全部待还";
    allRebackList.selectedIndex = 0;
    [self.navigationController pushViewController:allRebackList animated:YES];
}
-(void)didRightClick:(UIButton *)button{
    USRebackListViewController *allRebackList = [[USRebackListViewController alloc]init];
    allRebackList.hidesBottomBarWhenPushed = YES;
    allRebackList.title = @"全部待还";
    allRebackList.selectedIndex = 0;
    [self.navigationController pushViewController:allRebackList animated:YES];
}
-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    /*dispatch_async(kBgQueue, ^(){
        [self checkLogin];
        [self updateData];
        [self loadHistoryData];
    });*/
    
     [self performSelectorInBackground:@selector(updateData) withObject:nil];
}
@end
