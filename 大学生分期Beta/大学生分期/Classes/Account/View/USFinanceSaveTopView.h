//
//  USFinanceRebackTopView.h
//  大学生分期
//
//  Created by HeXianShan on 15/9/4.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol USFinanceSaveTopViewDelegate<NSObject>
@optional
-(void)didUpdateInfo:(UITextView *)textView;
-(void)didUpdateRecord:(UITableView *)tableView;
@end
@interface USFinanceSaveTopView : UIView
@property(nonatomic,strong)UILabel *yearRateTipLabel;
@property(nonatomic,strong)UILabel *yearRateLabel;
@property(nonatomic,strong)UILabel *persentLabel;
@property(nonatomic,strong)UILabel *blancedLabel;
@property(nonatomic,strong)UILabel *blancedRateLabel;
@property(nonatomic,strong)UILabel *itemStartLabel;
@property(nonatomic,strong)UILabel *itemEndLabel;
@property(nonatomic,strong)UITextView *textInfoView;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIProgressView *blancedRateProgressView;
@property(nonatomic,assign)id<USFinanceSaveTopViewDelegate> delagate;
-(void)buttonClick;
@end
