//
//  USFinanceRebackTopView.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/4.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USFinanceSaveTopView.h"
#define kLabelMargin 5
#define kBlanceMargin 20
#define kTipFont [UIFont boldSystemFontOfSize:10]
#define kTipLabelHeight 15
@interface USFinanceSaveTopView()
@property(nonatomic,strong) UIView *backgroundView ;
@property(nonatomic,strong) UIView *currentView ;
@property(nonatomic,strong) UILabel*progeressLabel;
@property(nonatomic,strong) NSArray *itemButtons;
@end
@implementation USFinanceSaveTopView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = true;
        _backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        UIImage *tipBgImage = [UIImage imageNamed:@"account_top_view_bg"];
        UIImageView *bgImgeView = [[UIImageView alloc]initWithImage:tipBgImage];
        [bgImgeView setBackgroundColor:[UIColor redColor]];
        bgImgeView.frame =  _backgroundView.bounds;
        _backgroundView.userInteractionEnabled = true;
        [_backgroundView addSubview:bgImgeView];
        //
        self.yearRateLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, 70, 40)];
        //[self.yearRateLabel setBackgroundColor:[UIColor redColor]];
        [self.yearRateLabel setText:@"8"];
        [self.yearRateLabel setTextColor:HYCTColor(255, 255, 255)];
        [self.yearRateLabel setFont:[UIFont systemFontOfSize:40]];
        [self.yearRateLabel setTextAlignment:NSTextAlignmentRight];
        [ _backgroundView addSubview:self.yearRateLabel];
        //
        self.persentLabel = [[UILabel alloc]initWithFrame:CGRectMake( self.yearRateLabel.x+self.yearRateLabel.width,  self.yearRateLabel.y+ self.yearRateLabel.height/2,10, 10)];
        [self.persentLabel setText:@"%"];
        [self.persentLabel setTextAlignment:NSTextAlignmentLeft];
        [self.persentLabel setTextColor:[UIColor whiteColor]];
        [self.persentLabel setFont:kTipFont];
        [ _backgroundView addSubview:self.persentLabel];
        //
        self.yearRateTipLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.yearRateLabel.x+self.yearRateLabel.width/2-10,  self.yearRateLabel.y+self.yearRateLabel.height, 70, kTipLabelHeight)];
        [self.yearRateTipLabel setTextAlignment:NSTextAlignmentCenter];
        [self.yearRateTipLabel setText:@"年化利率"];
        [self.yearRateTipLabel setTextColor:HYCTColor(234, 192, 160)];
        [self.yearRateTipLabel setFont:[UIFont systemFontOfSize:15]];
        [ _backgroundView addSubview:self.yearRateTipLabel];
        //
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(self.yearRateTipLabel.x+self.yearRateTipLabel.width+20, self.yearRateLabel.y+2, 1, self.yearRateLabel.height+self.persentLabel.height)];
        [line setBackgroundColor:HYCTColor(220, 127, 15)];
        [ _backgroundView addSubview:line];
        //
        UIView *blanceProgressView = [self createBlanceProgressView];
        [ _backgroundView addSubview:blanceProgressView];
        //
       line = [[UIView alloc]initWithFrame:CGRectMake(0, blanceProgressView.y+blanceProgressView.height, kAppWidth, 1)];
       [line setBackgroundColor:HYCTColor(175, 96, 1)];
        line.alpha = 0.7;
       [ _backgroundView addSubview:line];
        //
        UIView *itemLabels = [self createItemLabelsView];
        itemLabels.y = line.y+1;
        [ _backgroundView addSubview:itemLabels];
        //
        UIView *itemButtonsView = [self createItemButtonsView];
        itemButtonsView.frame = CGRectMake(0, itemLabels.y+itemLabels.height, kAppWidth, 30);
         [ _backgroundView addSubview:itemButtonsView];
       [self addSubview: _backgroundView];
        //self.height =frame.size.height+20;
    }

    return self;
}
-(UIView *)createBlanceProgressView{
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(self.yearRateTipLabel.x+self.yearRateTipLabel.width+20*2, 20, kAppWidth-self.yearRateTipLabel.x-self.yearRateTipLabel.width-20-20, 70)];
    [backgroundView setBackgroundColor:[UIColor clearColor]];
    //
    _blancedLabel =  [[UILabel alloc]initWithFrame:CGRectMake(0,  5, kAppWidth, kTipLabelHeight)];
    [ _blancedLabel setText:@"剩余可投:776,521.00元"];
    [ _blancedLabel setTextAlignment:NSTextAlignmentLeft];
    [ _blancedLabel setTextColor:[UIColor whiteColor]];
    [ _blancedLabel setFont:kTipFont];
    [backgroundView addSubview:_blancedLabel];
    //
    _blancedRateProgressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
    _blancedRateProgressView.frame = CGRectMake(0, _blancedLabel.y+_blancedLabel.height+10,backgroundView.width-15, 30);
    CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 3.0f);
    _blancedRateProgressView.transform = transform;
    _blancedRateProgressView.progress =0.23;
    _blancedRateProgressView.layer.masksToBounds = YES;
    _blancedRateProgressView.layer.cornerRadius = _blancedRateProgressView.frame.size.width/40;
    [_blancedRateProgressView setProgress:0.24 animated:YES];
    
    [_blancedRateProgressView setProgressTintColor:HYCTColor(213, 125, 18)];
    [_blancedRateProgressView setTrackTintColor:HYCTColor(175, 96, 1)];
    [backgroundView addSubview:_blancedRateProgressView];
    //
    _progeressLabel = [[UILabel alloc]initWithFrame:_blancedRateProgressView.frame];
    [_progeressLabel setTextAlignment:NSTextAlignmentCenter];
    _progeressLabel.text = @"23%";
    _progeressLabel.alpha = 0.5;
    [ _progeressLabel setTextColor:[UIColor whiteColor]];
    [ _progeressLabel setFont:[UIFont systemFontOfSize:6]];
    [backgroundView addSubview:_progeressLabel];
    //
    _blancedRateLabel =  [[UILabel alloc]initWithFrame:CGRectMake(0,  _blancedRateProgressView.height+_blancedRateProgressView.y+5, kAppWidth, kTipLabelHeight)];

    [ _blancedRateLabel setText:@"222,489.00元/1,000,000.00元"];
    [ _blancedRateLabel setTextAlignment:NSTextAlignmentLeft];
    [ _blancedRateLabel setTextColor:[UIColor whiteColor]];
    [ _blancedRateLabel setFont:kTipFont];
    [backgroundView addSubview:_blancedRateLabel];

    return backgroundView;
}
-(UIView *)createItemButtonsView{
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kAppWidth, 30)];
    [backgroundView setBackgroundColor:[UIColor whiteColor]];
    //
    UIButton *itemDetail = [self createButton:@"项目详情"];
    itemDetail.frame = CGRectMake(0, 0, kAppWidth/2, 30);
    [backgroundView addSubview:itemDetail];
    itemDetail.tag = 0;
    //
    UIButton *itemRecord = [self createButton:@"投资记录"];
    itemRecord.frame = CGRectMake(kAppWidth/2, 0, kAppWidth/2, 30);
    itemRecord.tag = 1;
    [backgroundView addSubview:itemRecord];
    self.itemButtons = [NSMutableArray arrayWithObjects:itemDetail,itemRecord,nil];
    backgroundView.userInteractionEnabled = YES;
    return backgroundView;
}
-(UIView *)createItemLabelsView{
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kAppWidth, 30)];
    [backgroundView setBackgroundColor:[UIColor clearColor]];
    self.itemStartLabel = [self createItemLabel:@"项目结束时间:581天"];
    [backgroundView addSubview:self.itemStartLabel];
     //
    self.itemEndLabel = [self createItemLabel:@"项目结束时间:581天"];
    self.itemEndLabel.x = kAppWidth/2;
    self.itemEndLabel.width = kAppWidth/2-5;
    [self.itemEndLabel setTextAlignment:NSTextAlignmentRight];
    [backgroundView addSubview: self.itemEndLabel];
    backgroundView.userInteractionEnabled = YES;
    return backgroundView;
}
-(UIButton *)createButton:(NSString *)title{
    UIButton *buttoun = [UIButton buttonWithType:UIButtonTypeCustom];
    buttoun.frame = CGRectMake(0, 0, kAppWidth/2, 30);
    [buttoun.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [buttoun.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [buttoun setTitle:title forState:UIControlStateNormal];
    [buttoun setTitle:title forState:UIControlStateHighlighted];
    [buttoun setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [buttoun setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    [buttoun setTitleColor:[UIColor orangeColor] forState:UIControlStateDisabled];
    [buttoun addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    return buttoun;
}
-(UILabel *)createItemLabel:(NSString *)title{
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(5, 0, kAppWidth/2, 30);
    [label setFont:[UIFont systemFontOfSize:10]];
    [label setTextAlignment:NSTextAlignmentLeft];
    [label setText:title];
    label.alpha = 0.8;
    [label setTextColor:[UIColor whiteColor]];
    return label;
}
-(void)buttonClick{
    [self buttonClick:[self.itemButtons firstObject]];
}
-(void)buttonClick:(UIButton *)buttoun{
    buttoun.enabled = NO;
    for (UIButton *bt in self.itemButtons) {
        if (buttoun!=bt) {
            bt.enabled = YES;
        }
    }
    if (0==buttoun.tag) {
        [self.delagate didUpdateInfo:self.textInfoView];
    }else{
       [self.delagate didUpdateRecord:self.tableView];
    }
}
@end
