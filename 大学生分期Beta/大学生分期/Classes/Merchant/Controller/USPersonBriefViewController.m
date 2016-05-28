//
//  USPersonBriefViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/29.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USPersonBriefViewController.h"
#import "USNearTableViewCell.h"
#import "USNearProfZoneViewController.h"
#import "USSayWordViewController.h"
#define kMargin 10
@interface USPersonBriefViewController ()
@property(nonatomic,strong)UILabel *schoolLB;
@property(nonatomic,strong)UILabel *signLB;
@property(nonatomic,strong)UIButton *focusBt;
@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)USNearTableViewCell *nearTitleView;
@property(nonatomic,strong)UIView *contentBgView;
@property(nonatomic,strong)USAccount *account;
@property(nonatomic,strong) NSDictionary *dataDic;
@end

@implementation USPersonBriefViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HYCTColor(240, 240, 240);
    self.navigationController.navigationBar.translucent= NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initNearTitleView];
    [self initBriefContentLB];
    [self initTwoButtons];
    _account = [USUserService account];
    [self loadData];
}
-(void)loadData{
    [USWebTool POST:@"wangkaNearByClientcontroller/getNearByPersonDetail.action" showMsg:@"" paramDic:@{@"id":_nearId,@"customer_id":_account.id} success:^(NSDictionary *dataDic) {
        [_nearTitleView.leftImgeView sd_setImageWithURL:[NSURL URLWithString:HYWebDataPath(dataDic[@"data"][@"headpic"])]];
        _nearTitleView.nearTitleView.personTitle = dataDic[@"data"][@"name"];
        _nearTitleView.nearTitleView.addressLabel.text = _distance;
        _schoolLB.text = [NSString stringWithFormat:@"学校:%@", dataDic[@"data"][@"schoolname"]];
        _signLB.text = [NSString stringWithFormat:@"个性签名:%@", _sign];
        _dataDic = dataDic[@"data"];
        [self updateFocusBtTitle:dataDic[@"data"][@"attention_label"]];
        [self setTitle:dataDic[@"data"][@"name"]];
    } failure:^(id data)  {
        
    }];
}
-(void)initNearTitleView{
    _nearTitleView = [[USNearTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ddd" nearType:0];
    _nearTitleView.frame = CGRectMake(0,5, kAppWidth, 70);
    _nearTitleView.backgroundColor = [UIColor whiteColor];
    _nearTitleView.leftImgeView.image = [UIImage imageNamed:@"near_table_cell_person_img"];
    //_nearTitleView.nearTitleView.personTitle = @"老财";
    _nearTitleView.line.hidden = YES;
    [_nearTitleView.nearTitleView.voteLabel setHidden:YES];
    [self.view addSubview:_nearTitleView];
}


-(void)initBriefContentLB{
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, _nearTitleView.y+_nearTitleView.height+kMargin, kAppWidth, 130)];
    bgView.layer.borderColor = [HYCTColor(240, 240, 240) CGColor];
    bgView.layer.borderWidth = 1;
    bgView.backgroundColor = [UIColor whiteColor];
    //
    _schoolLB = [USUIViewTool createUILabelWithTitle:@" 学 校:" fontSize:kCommonFontSize_15 color:[UIColor blackColor] heigth:kCommonFontSize_20];
    _schoolLB.frame = CGRectMake(5, 12, kAppWidth-kMargin, kCommonFontSize_22);
    [bgView addSubview:_schoolLB];
    //
    UIView *line = [USUIViewTool createLineView];
    line.frame = CGRectMake(0, _schoolLB.y+_schoolLB.height+kMargin, kAppWidth, 0.5);
    [bgView addSubview:line];
    //
    _signLB = [USUIViewTool createUILabelWithTitle:@"个性签名:" fontSize:kCommonFontSize_15 color:[UIColor blackColor] heigth:kCommonFontSize_20];
    _signLB.frame = CGRectMake(5, line.y+line.height+kMargin, kAppWidth-kMargin, kCommonFontSize_22);
    [bgView addSubview:_signLB];
    //
    line = [USUIViewTool createLineView];
    line.frame = CGRectMake(0, _signLB.y+_signLB.height+kMargin, kAppWidth, 0.5);
    [bgView addSubview:line];
    //
    UILabel *lable = [USUIViewTool createUILabelWithTitle:@"他的圈子:" fontSize:kCommonFontSize_15 color:[UIColor blackColor] heigth:kCommonFontSize_20];
    lable.frame = CGRectMake(5, line.y+line.height+kMargin, kAppWidth, kCommonFontSize_22);
    [bgView addSubview:lable];
    UILabel *arrowLable = [USUIViewTool createUILabelWithTitle:@">" fontSize:kCommonFontSize_15 color:[UIColor blackColor] heigth:kCommonFontSize_20];
    arrowLable.frame = CGRectMake(kAppWidth-kMargin*2, lable.y, kMargin, kCommonFontSize_22);
    [bgView addSubview:arrowLable];
    UIButton *toCirclBt = [UIButton buttonWithType:UIButtonTypeCustom];
    toCirclBt.frame = CGRectMake(5, line.y+line.height+kMargin, kAppWidth, kCommonFontSize_22);
    toCirclBt.titleLabel.textAlignment = NSTextAlignmentLeft;
    [toCirclBt.titleLabel setFont:[UIFont systemFontOfSize:kCommonFontSize_15]];
    [bgView addSubview:toCirclBt];
    [toCirclBt addTarget:self action:@selector(toCirlClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bgView];
    _contentBgView = bgView;
}
-(void)initTwoButtons{
    CGFloat width = (kAppWidth - kMargin*3)*0.5;
    UIButton *sendMessageBt = [USUIViewTool createButtonWith:@"打招呼"];
    sendMessageBt.backgroundColor = [UIColor orangeColor];
    sendMessageBt.layer.cornerRadius = 5;
    sendMessageBt.titleLabel.font = [UIFont systemFontOfSize:kCommonFontSize_14];
    sendMessageBt.layer.masksToBounds = YES;
    sendMessageBt.frame = CGRectMake(kMargin, _contentBgView.y+_contentBgView.height+2*kMargin, width, kCommonFontSize_30);
    [sendMessageBt addTarget:self action:@selector(sendMessageClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendMessageBt];
    //
    _focusBt = [USUIViewTool createButtonWith:@"关注"];
    _focusBt.backgroundColor = [UIColor whiteColor];
    _focusBt.layer.cornerRadius = 5;
    [_focusBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_focusBt setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    _focusBt.titleLabel.font = [UIFont systemFontOfSize:kCommonFontSize_14];
    _focusBt.layer.masksToBounds = YES;
    _focusBt.frame = CGRectMake(kMargin+sendMessageBt.width+sendMessageBt.x, _contentBgView.y+_contentBgView.height+2*kMargin, width, kCommonFontSize_30);
    [_focusBt addTarget:self action:@selector(focusClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_focusBt];
}
-(void)updateFocusBtTitle:(NSString *)title{
    [_focusBt setTitle:title forState:UIControlStateNormal];
    [_focusBt setTitle:title forState:UIControlStateHighlighted];
}
-(void)toCirlClick{
    USNearProfZoneViewController *profZoneVC = [[USNearProfZoneViewController alloc]init];
    profZoneVC.customer_id = _dataDic[@"id"];
    [self.navigationController pushViewController:profZoneVC animated:YES];
}

-(void)sendMessageClick{
    USSayWordViewController *sendVC =[[USSayWordViewController alloc]init];
    sendVC.customer_id = _account.id;
    sendVC.been_customer_id = _dataDic[@"id"];
    [self.navigationController pushViewController:sendVC animated:YES];
}

-(void)focusClick{
    [USWebTool POST:@"wangkaNearByClientcontroller/addOrCancelAtentionFun.action" showMsg:@"" paramDic:@{@"customer_id":_account.id,@"been_customer_id":_dataDic[@"id"]} success:^(NSDictionary *dataDic) {
        [self updateFocusBtTitle:dataDic[@"data"][@"attention_label"]];
        [MBProgressHUD showSuccess:dataDic[@"msg"]];
    } failure:^(id data) {
        [MBProgressHUD showError:[NSString stringWithFormat:@"%@操作失败...",[_focusBt titleForState:UIControlStateNormal]]];
    }];
}
@end
