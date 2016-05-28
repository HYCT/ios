//
//  USLoanViewController.h
//  大学生分期
//
//  Created by HeXianShan on 15/9/3.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USBaseAuthorViewController.h"
#import "USCanBorrowInfoView.h"
@protocol USFinanceLoanDelegate<NSObject>
@optional
-(void)didActLoad;
@end
@interface USFinanceLoanViewController : USBaseAuthorViewController<USCanBorrowInfoViewDelegate,USFinanceLoanDelegate>

@end
