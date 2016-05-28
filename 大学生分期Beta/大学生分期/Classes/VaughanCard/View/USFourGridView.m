//
//  USFourGridView.m
//  大学生分期
//
//  Created by HeXianShan on 16/1/8.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import "USFourGridView.h"

@implementation USFourGridView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.width = kAppWidth;
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor whiteColor];
        CGFloat width = kAppWidth*0.5;
        self.height = 130;
        USVUpImagDownTitleView *yaoyueView = [[USVUpImagDownTitleView alloc]initWithFrame:CGRectMake(15, 10, 60, 50) imageName:@"mine_inviter" downTitle:@"我的邀约"];
        _yaoyueView =yaoyueView;
        _sendYyueCLB = [USUIViewTool createUILabelWithTitle:@"发起" fontSize:kCommonFontSize_15 color:HYCTColor(120, 120, 120) heigth:kCommonFontSize_12];
        yaoyueView.downTitle.textColor = HYCTColor(120, 120, 120);
        _sendYyueCLB.frame = CGRectMake(yaoyueView.width+yaoyueView.x+10, yaoyueView.y+5, width, kCommonFontSize_15);
        _sendYyueCLB.width = width - _sendYyueCLB.x;
        [self addSubview:yaoyueView];
        [self addSubview:_sendYyueCLB];
        _joinYyueCLB = [USUIViewTool createUILabelWithTitle:@"发起" fontSize:kCommonFontSize_15 color:HYCTColor(120, 120, 120) heigth:kCommonFontSize_12];
        _sendYyueCLB.y = _sendYyueCLB.y+_sendYyueCLB.height+5;
        _joinYyueCLB.frame = CGRectMake(yaoyueView.width+yaoyueView.x+10, yaoyueView.y+5, width, kCommonFontSize_15);
        _joinYyueCLB.width = width - _joinYyueCLB.x;
        [self addSubview:_joinYyueCLB];
        //邀约大的按钮透明
        _yaoyueBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, width, self.height/2)];
        [self addSubview:_yaoyueBtn] ;
        
        //
        UIView *rowline = [USUIViewTool createLineView];
        rowline.width = self.width;
        rowline.height = 1;
        rowline.y = yaoyueView.y+yaoyueView.height+5;
        rowline.x = 0;
        rowline.backgroundColor = HYCTColor(240, 240, 240);
        [self addSubview:rowline];
        //
        UIView *colline = [USUIViewTool createLineView];
        colline.width = 1;
        colline.height = self.height;
        colline.y = 0;
        colline.x = width-10;
        colline.backgroundColor = HYCTColor(240, 240, 240);
        [self addSubview:colline];
        //
        USVUpImagDownTitleView *duobaoView = [[USVUpImagDownTitleView alloc]initWithFrame:CGRectMake(width, 10, 60, 50) imageName:@"mine_wddb" downTitle:@"我的夺宝"];
        _duobaoView = duobaoView;
        duobaoView.downTitle.textColor =  yaoyueView.downTitle.textColor;
        [self addSubview:duobaoView];
        //
        _joinSnaCLB = [USUIViewTool createUILabelWithTitle:@"参与" fontSize:kCommonFontSize_15 color:HYCTColor(120, 120, 120) heigth:kCommonFontSize_12];
        _joinSnaCLB.y = duobaoView.y+5;
        _joinSnaCLB.frame = CGRectMake(0, duobaoView.y+5, width, kCommonFontSize_15);
        _joinSnaCLB.x = duobaoView.x+duobaoView.width+5;
        [self addSubview:_joinSnaCLB];
        _succeSnaCLB = [USUIViewTool createUILabelWithTitle:@"成功" fontSize:kCommonFontSize_15 color:HYCTColor(120, 120, 120) heigth:kCommonFontSize_12];
        _succeSnaCLB.frame = CGRectMake(0, _joinSnaCLB.y+_joinSnaCLB.height+5, width, kCommonFontSize_15);
        _succeSnaCLB.x = _joinSnaCLB.x+3;
        [self addSubview:_succeSnaCLB];
        //夺宝大的按钮透明
        _duobaoBtn = [[UIButton alloc] initWithFrame:CGRectMake(width, 0, width, self.height/2)];
        [self addSubview:_duobaoBtn] ;
        //////////////////////
        USVUpImagDownTitleView *paihban = [[USVUpImagDownTitleView alloc]initWithFrame:CGRectMake(15, rowline.y+rowline.height+5, 60, 50) imageName:@"mine_paihang" downTitle:@"我的排行"];
        _mysortView=paihban ;
        _sortLB = [USUIViewTool createUILabelWithTitle:@"1" fontSize:kCommonFontSize_20 color:[UIColor orangeColor] heigth:kCommonFontSize_20];
        paihban.downTitle.textColor = HYCTColor(120, 120, 120);
        _sortLB.frame = CGRectMake(paihban.width+paihban.x+20, paihban.y+15, width, kCommonFontSize_15);
        _sortLB.width = width - _sortLB.x;
        [self addSubview:paihban];
        [self addSubview:_sortLB];
        //排行大的按钮透明
        _mysortBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.height/2, width, self.height/2)];
        [self addSubview:_mysortBtn] ;
        ////
        USVUpImagDownTitleView *scanView = [[USVUpImagDownTitleView alloc]initWithFrame:CGRectMake(width, paihban.y, 60, 50) imageName:@"mine_fangke" downTitle:@"我的访客"];
        _myfangkeView = scanView ;
        scanView.downTitle.textColor =  yaoyueView.downTitle.textColor;
        [self addSubview:scanView];
        //
        _scanCLB = [USUIViewTool createUILabelWithTitle:@"浏览" fontSize:kCommonFontSize_15 color:HYCTColor(120, 120, 120) heigth:kCommonFontSize_12];
        _scanCLB.y = scanView.y+5;
        _scanCLB.frame = CGRectMake(0, scanView.y+5, width, kCommonFontSize_15);
        _scanCLB.x = scanView.x+scanView.width+5;
        [self addSubview:_scanCLB];
        _voteCLB = [USUIViewTool createUILabelWithTitle:@"点赞" fontSize:kCommonFontSize_15 color:HYCTColor(120, 120, 120) heigth:kCommonFontSize_12];
        _voteCLB.frame = CGRectMake(0, _scanCLB.y+_scanCLB.height+5, width, kCommonFontSize_15);
        _voteCLB.x = _scanCLB.x+3;
        [self addSubview:_voteCLB];
        //访客大的按钮透明
        _myfangkeBtn = [[UIButton alloc] initWithFrame:CGRectMake(width, self.height/2, width, self.height/2)];
        [self addSubview:_myfangkeBtn] ;
    }
    return self;
}
@end
