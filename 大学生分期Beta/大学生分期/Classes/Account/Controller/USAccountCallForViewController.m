//
//  USCallForViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/2.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USAccountCallForViewController.h"
#import "USUIViewTool.h"
#import "USTextFieldTool.h"
#import "USAccountMyAskViewController.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#define kMargin 10
#define kMarginTop 20
#define kPadding 15
@interface USAccountCallForViewController()<ABPeoplePickerNavigationControllerDelegate, UINavigationControllerDelegate>
@property(nonatomic,strong)  UILabel *askTipLabel;
@property(nonatomic,strong)  UILabel *askCodeLabel;
@property(nonatomic,strong)UIImageView *askCodeImageView;
@property(nonatomic,strong)UIView *askCodeWrapView;
@property(nonatomic,strong)UIButton *shareButton;
@property(nonatomic,strong)UITextField *qrcodeField;
@property(nonatomic,copy)NSString *askUrl;
@property(nonatomic,strong)USAccount *account;
@end
@implementation USAccountCallForViewController
-(void)viewDidLoad{
    
    [super viewDidLoad];
    _account = [USUserService accountStatic];
    self.navigationItem.title = @"邀请好友";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent= NO;
    [self.view setBackgroundColor:HYCTColor(240,240,240)];
    _askUrl = [NSString stringWithFormat:@"register/index.action?inviter_id=%@",_account.id];
    _askUrl = HYWebDataPath(_askUrl);
    UIButton *askContactButton = [USUIViewTool createButtonWith:@"邀请通讯录的朋友"];
    askContactButton.titleLabel.font =[UIFont systemFontOfSize:kCommonFontSize_15];
    askContactButton.frame = CGRectMake(kMargin, kMarginTop, kAppWidth-kMargin*2, 30);
    askContactButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    askContactButton.backgroundColor = HYCTColor(26, 151, 222);
    askContactButton.layer.cornerRadius = askContactButton.height*0.5;
    askContactButton.layer.masksToBounds = YES;
    [askContactButton addTarget:self action:@selector(askButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:askContactButton];
    [self createQRcodeView:askContactButton.y+askContactButton.height+kMarginTop];
    [self createQRcodeFieldView:_askCodeWrapView.y+_askCodeWrapView.height+kMarginTop];
    _askCodeImageView.image = _account.invitcodeImg;
}
-(void)askButtonClick{
    ABPeoplePickerNavigationController *pNC = [[ABPeoplePickerNavigationController alloc] init];
    pNC.peoplePickerDelegate = self;
    if([[UIDevice currentDevice].systemVersion floatValue] >= 8.0){
        pNC.predicateForSelectionOfPerson = [NSPredicate predicateWithValue:false];
    }
    [self presentViewController:pNC animated:YES completion:nil];
    
}
-(void)createQRcodeView:(CGFloat)y{
    UIView *qrcodeBgView =[[UIView alloc]initWithFrame:CGRectMake(kMargin, y, kAppWidth-2*kMargin, (kAppHeight-y)*0.55)];
    _askCodeWrapView = qrcodeBgView;
    qrcodeBgView.backgroundColor = HYCTColor(254, 139, 0);
    _askCodeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kPadding, kPadding, qrcodeBgView.width-2*kPadding, qrcodeBgView.height-2*kPadding)];
    [qrcodeBgView addSubview:_askCodeImageView];
    [self.view addSubview:qrcodeBgView];
}
-(void)createQRcodeFieldView:(CGFloat)y{
    UITextField *qrcodeField = [USTextFieldTool createTextFieldWithPlaceholder:_askUrl target:self leftImage:nil imageFrame:CGRectZero];
    qrcodeField.text = _askUrl;
    qrcodeField.textColor = HYCTColor(190, 190, 190);
    qrcodeField.frame = CGRectMake(kMargin, y, kAppWidth-kMargin*2, 40);
    _qrcodeField = qrcodeField;
    [self.view addSubview:qrcodeField];
    UIView *tempView = [[UIView alloc]initWithFrame:CGRectMake(kAppWidth-30-2*kMargin, y, 40, 40)];
    tempView.layer.cornerRadius = tempView.height*0.5;
    tempView.backgroundColor = HYCTColor(26, 150, 221);
    tempView.layer.masksToBounds = YES;
    [self.view addSubview:tempView];
    UIButton *copyQRcodeButton = [USUIViewTool createButtonWith:@"  复制邀请码"];
    copyQRcodeButton.titleLabel.font = [UIFont systemFontOfSize:kCommonFontSize_15];
    copyQRcodeButton.frame = CGRectMake(kAppWidth-100-2*kMargin, y, 90, 40);
    copyQRcodeButton.titleLabel.textAlignment = NSTextAlignmentRight;
    copyQRcodeButton.backgroundColor = HYCTColor(26, 150, 221);
    [copyQRcodeButton addTarget:self action:@selector(copyQRcode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:copyQRcodeButton];
     UIButton *toMyAskButton = [USUIViewTool createButtonWith:@"我的邀请记录>"];
    toMyAskButton.frame = CGRectMake(kAppWidth-120, y+kMarginTop+copyQRcodeButton.height, 120, kCommonFontSize_15);
    toMyAskButton.titleLabel.font = [UIFont systemFontOfSize:kCommonFontSize_15];
    [toMyAskButton setTitleColor:HYCTColor(26, 150, 221) forState:UIControlStateNormal];
    [toMyAskButton setTitleColor:HYCTColor(26, 150, 221) forState:UIControlStateHighlighted];
    [toMyAskButton addTarget:self action:@selector(toMyAsk) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:toMyAskButton];
}
-(void)copyQRcode{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    if (_qrcodeField.text !=nil&&_qrcodeField.text.length!=0) {
        [pasteboard setString:_qrcodeField.text];
        [MBProgressHUD showError:@"邀请码已经复制到剪贴板上"];
    }else{
        [MBProgressHUD showError:@"邀请码不可以为空..."];
    }
    

}
-(void)toMyAsk{
    USAccountMyAskViewController *myAskVC = [[USAccountMyAskViewController alloc]init];
    [self.navigationController pushViewController:myAskVC animated:YES];
    
}
-(void)sendAskInfo:(NSString *)benAskPhoneNO{
    [USWebTool POST:@"invitercilent/sendMyInviterUrl.action" showMsg:@"正在发送邀请..."
           paramDic:@{
             @"beeninvitnum":benAskPhoneNO,
             @"invitnum":_account.telephone,
             @"inviturl":_askUrl
             }success:^(id data) {
                 [MBProgressHUD showSuccess:@"邀请好友成功!"];
           } failure:^(id data) {
        [MBProgressHUD showError:@"邀请好友失败!"];
           } toView:self.view];
}
-(void)dissView{
    [self updateRespons];
}
-(void)updateRespons{
    [_qrcodeField resignFirstResponder];
}


#pragma mark - ABPeoplePickerNavigationControllerDelegate
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    
    ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
    
    long index = ABMultiValueGetIndexForIdentifier(phone,identifier);
    
    NSString *phoneNO = (__bridge NSString *)ABMultiValueCopyValueAtIndex(phone, index);
    phoneNO = [phoneNO stringByReplacingOccurrencesOfString:@"-" withString:@""];
    if (phone && phoneNO.length == 11) {
        // [self sendAskInfo:phoneNO];

        [peoplePicker dismissViewControllerAnimated:YES completion:^(){
            [self sendAskInfo:phoneNO];
        }];
        //[peoplePicker dismissViewControllerAnimated:YES completion:nil];
        return;
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"错误提示" message:@"请选择正确手机号" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }
}


- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person NS_AVAILABLE_IOS(8_0)
{
    ABPersonViewController *personViewController = [[ABPersonViewController alloc] init];
    personViewController.displayedPerson = person;
    
    [peoplePicker pushViewController:personViewController animated:YES];
    
    
}

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
}



- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person NS_DEPRECATED_IOS(2_0, 8_0)
{
    return YES;
}



- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier NS_DEPRECATED_IOS(2_0, 8_0)
{
    ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
    
    long index = ABMultiValueGetIndexForIdentifier(phone,identifier);
    
    NSString *phoneNO = (__bridge NSString *)ABMultiValueCopyValueAtIndex(phone, index);
    phoneNO = [phoneNO stringByReplacingOccurrencesOfString:@"-" withString:@""];
    if (phone && phoneNO.length == 11) {
        [peoplePicker dismissViewControllerAnimated:YES completion:nil];
        return NO;
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"错误提示" message:@"请选择正确手机号" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }
    return YES;
}

@end
