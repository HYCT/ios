//
//  USLoadAgreementViewController.h
//  大学生分期
//
//  Created by HeXianShan on 16/1/12.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import "USHtmlLoadViewController.h"
#import "USFinanceLoanViewController.h"
@interface USLoadAgreementViewController : USHtmlLoadViewController
@property(nonatomic,strong)id<USFinanceLoanDelegate> loadDelegate;
@property(nonatomic,assign)CGFloat borrowmoney ;
@property(nonatomic,copy)NSString *usage ;
@end
