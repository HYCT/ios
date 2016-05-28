//
//  USAccountSecondeViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/8.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USAccountManagerViewController.h"
#import "USBorrowAccountInfoView.h"
#import "USCertificationViewController.h"
#import "USBindMobilePhoneViewController.h"
#import "USModifyPayPwdViewController.h"
#import "USBankCardListViewController.h"
#import "USUpImageDownLabelView.h"
#import "USUserService.h"
#import "USAccount.h"
#import "USUpLoadImageServiceTool.h"
@interface USAccountManagerViewController ()
@property(nonatomic,strong) USUpImageDownLabelView *upImgDownLBView;
@property(nonatomic,strong)USUpLoadImageServiceTool *upLoadImageService;
@property(nonatomic,strong)USAccount  *account;
@end

@implementation USAccountManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账户设置";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent= NO;
    USAccount  *account = [USUserService accountStatic];
    _account = account;
    USUpImageDownLabelView *upImgDownLBView = [[USUpImageDownLabelView alloc]initWithFrame:CGRectMake(0, 15, kAppWidth, 100)];
    _upImgDownLBView = upImgDownLBView;
    [upImgDownLBView setBackgroundColor:[UIColor clearColor]];
    upImgDownLBView.personImageView.size = CGSizeMake(57, 57);
    if (account!=nil) {
        upImgDownLBView.personImageView.image = account.headerImg;
        [upImgDownLBView.accountNameLabel setText:account.name];
    }else{
        upImgDownLBView.personImageView.image = [UIImage imageNamed:@"account_seconde_image"];
        [upImgDownLBView.accountNameLabel setText:@"未知"];
    }
    UIButton *carmera = [USUIViewTool createButtonWith:@"" imageName:@"account_camera"];
    carmera.frame = CGRectMake(_upImgDownLBView.personImageView.width*0.80+_upImgDownLBView.personImageView.x, _upImgDownLBView.personImageView.height*0.9-kPhotoImageSize, kPhotoImageSize, kPhotoImageSize);
    [_upImgDownLBView addSubview:carmera];
    [carmera addTarget:self action:@selector(carmera) forControlEvents:UIControlEventTouchUpInside];

    upImgDownLBView.accountNameLabel.height = 25;
    [upImgDownLBView.accountNameLabel setTextColor:[UIColor blackColor]];
    [upImgDownLBView updateFrame];
    [self.view addSubview:upImgDownLBView];
    upImgDownLBView.updateImageBlock = ^(UIImageView *imageView){
        if (_upLoadImageService==nil) {
            _upLoadImageService = [[USUpLoadImageServiceTool alloc]init];
            _upLoadImageService.saveImageBlock = ^(UIImage *image){
                imageView.image = image;
            };
        }
        [_upLoadImageService pickImage];
    };
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.scrollEnabled = NO;
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    self.tableView.y =upImgDownLBView.y+upImgDownLBView.height+10;
    [self.view addSubview:self.tableView];

}
-(void)carmera{
    [_upImgDownLBView updateImage];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"reuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    }
    NSString *title = nil;
     NSString *detailTilte = nil;
    UIColor *detailColor = HYCTColor(183, 183, 183);
    switch (indexPath.row) {
        case 0:
        {
           title = @"实名认证";
           detailTilte = [self getRealNameTip:_account.realnametype];
           detailColor = HYCTColor(65, 219, 178);
            [cell.textLabel setText:title];
            [cell.textLabel setFont:[UIFont systemFontOfSize:kCommonFontSize_15]];
            [cell.detailTextLabel setText:detailTilte];
            [cell.detailTextLabel setTextColor:detailColor];
            [cell.detailTextLabel setFont:[UIFont systemFontOfSize:kCommonFontSize_12]];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//            if (!(_account.realnametype==-1)) {
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                cell.userInteractionEnabled = NO;
//                [MBProgressHUD showSuccess:@"已经过实名认证..."];
//            }
            return cell;
        }
            break;
        case 1:
        {
            title = @"银行卡绑定";
            if (_account.isbindbankcard) {
                detailTilte = @"已绑定";
                [cell.textLabel setText:title];
                [cell.textLabel setFont:[UIFont systemFontOfSize:kCommonFontSize_15]];
                [cell.detailTextLabel setText:detailTilte];
                [cell.detailTextLabel setTextColor:detailColor];
                [cell.detailTextLabel setFont:[UIFont systemFontOfSize:kCommonFontSize_12]];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//                if (!(_account.realnametype==-1)) {
//                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                    cell.userInteractionEnabled = NO;
//                }
                return cell;
            }else{
              detailTilte = @"未绑定";
            }
        }
            break;
        case 2:
        {
             title = @"绑定手机";
            if (_account.telephone!=nil&&_account.telephone.length>0) {
                detailTilte = [USStringTool getFomaterTelNoStr:_account.telephone];
            }else{
                detailTilte = @"未绑定";
            }
           
           
        }
            break;
        case 3:
        {
            title = @"修改密码";
            detailTilte = @"";
        }
            break;

    }
    [cell.textLabel setText:title];
    [cell.textLabel setFont:[UIFont systemFontOfSize:kCommonFontSize_15]];
    [cell.detailTextLabel setText:detailTilte];
    [cell.detailTextLabel setTextColor:detailColor];
    [cell.detailTextLabel setFont:[UIFont systemFontOfSize:kCommonFontSize_12]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
   
    return cell;
}
-(NSString*)getRealNameTip:(NSInteger)realType{
    switch (realType) {
        case -1:
            return @"立即认证";
        case 3:
            return @"已认证";
        default:
           return @"审核中";
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
        return 1;
    }
    return 9;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  30;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *toCV = nil;
    switch (indexPath.row) {
        case 0:
        {
            toCV = [[USCertificationViewController alloc]init];
        }
            break;
        case 1:
        {
           
           toCV = [[USBankCardListViewController alloc]init];
        }
            break;
        case 2:
        {
            toCV = [[USBindMobilePhoneViewController alloc]init];
            
        }
            break;
        case 3:
        {
          toCV = [[USModifyPayPwdViewController alloc]init];
        }
            break;
            
    }
    toCV.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:toCV animated:YES];
}

@end
