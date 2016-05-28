//
//  NewCellView.h
//  红云创投
//
//  Created by HeXianShan on 15/8/25.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "HYNews.h"
#import "USUpDownLabelView.h"
@interface USBlackNameCell : UITableViewCell
@property(strong,nonatomic) HYNews *news;
@property(strong,nonatomic) USUpDownLabelView *loanAmount;
@property(strong,nonatomic) USUpDownLabelView *loanDateLimit;
@property(strong,nonatomic) USUpDownLabelView *overDate;
@property(strong,nonatomic)UILabel *nameLB;
@property(strong,nonatomic)UILabel *warinLB;
@property(strong,nonatomic) UITextView *textView;
@property(strong,nonatomic)UIImageView *header;
//
//+(instancetype)newsCellViewWithNews:(HYNews *)news;
@end
