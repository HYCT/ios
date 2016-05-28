//
//  USLoginViewController.h
//  大学生分期
//
//  Created by HeXianShan on 15/9/6.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USBaseAuthorViewController.h"
typedef void(^NextDoBlock) ();
@interface USLoginViewController : USBaseAuthorViewController
@property(nonatomic,copy)NSString *phoneCode;
@property(nonatomic,copy)NextDoBlock nextDoblock;
@property(nonatomic,strong)UIViewController *nextViewController;
@property(nonatomic,assign)BOOL muslogin;
@property(nonatomic, strong) NSString *accountTelephone ;
@property(nonatomic, strong) NSString *accountPwd ;
@end
