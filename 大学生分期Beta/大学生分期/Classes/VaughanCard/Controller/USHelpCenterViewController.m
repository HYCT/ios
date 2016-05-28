//
//  USHelpCenterViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/12.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USHelpCenterViewController.h"
#import "USGridView.h"
#import "USGridCellView.h"
#import "USFrentlyQuestionViewController.h"
@interface USHelpCenterViewController()<UIScrollViewDelegate,USGridCellViewDelegate>
@property(nonatomic,weak)UIScrollView *adsScollView;
@property(nonatomic,weak)UIPageControl *pageControl;
@property(nonatomic,weak) USGridView *helpTopView;
@property(nonatomic,weak) USGridView *helpSecondeView;
@property(nonatomic,strong) NSArray *topHelpCodes;
@property(nonatomic,strong) NSArray *topHelpTitles;
@property(nonatomic,strong) NSArray *helpSecondeCodes;
@property(nonatomic,strong) NSArray *helpSecondeTitles;
@end
@implementation USHelpCenterViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"帮助中心";
    self.navigationController.navigationBar.translucent= NO;
    [self.view setBackgroundColor:HYCTColor(240, 240, 240)];
    [self createHelpTopView];
    [self createHelpSecondeView];
    _topHelpCodes = @[@"QQ_CODE",@"TEL_CODE"];
    _helpSecondeCodes = @[@"CJ_CODE",@"DK_CODE",@"FK_CODE",@"HK_CODE",@"TZ_CODE"];
}
-(void)createHelpTopView{
    NSArray *titles = @[@"QQ咨询",@"电话咨询"];
    _topHelpTitles = titles;
    NSArray *images = @[@"help_center_qq_img",@"help_center_tel_img"];
    USGridView *helpTopView = [[ USGridView alloc]initWithFrame:CGRectMake(0, 0, kAppWidth, 85) itemTitles:titles itemImages:images rowCount:2 delegate:self];
    [helpTopView setBackgroundColor:[UIColor whiteColor]];
    [self updataGridCellView:helpTopView];
    [self.view addSubview:helpTopView];
    _helpTopView = helpTopView;
    
}
-(void)createHelpSecondeView{
    NSArray *titles = @[@"常见问题",@"贷款申请",@"放款事项",@"还款事项",@"投资问题"];
    _helpSecondeTitles = titles;
    NSArray *images = @[@"help_center_qora_img",@"help_center_loan_img",@"help_center_outloan_img",@"help_center_reback_img",@"help_center_throw_img"];
    USGridView *helpSecondeView = [[ USGridView alloc]initWithFrame:CGRectMake(0, _helpTopView.y+_helpTopView.height+10, kAppWidth, 170) itemTitles:titles itemImages:images rowCount:4 delegate:self];
    [helpSecondeView setBackgroundColor:[UIColor whiteColor]];
    UIView *top = [[UIView alloc]initWithFrame:CGRectMake(kAppWidth*1.0/4+7, _helpTopView.y+_helpTopView.height+94-1.78, kAppWidth*1.0/4*3, 92)];
    top.backgroundColor = HYCTColor(240, 240, 240);
    [self.view addSubview:helpSecondeView];
    [self.view addSubview:top];
    _helpSecondeView = helpSecondeView;
    
}
-(void)updataGridCellView:(USGridView *)gridView{
    NSArray *subViews = [gridView subviews];
    for (UIView *subView in subViews) {
        if ([subView isKindOfClass:[USGridCellView class]] ) {
            USGridCellView *tempGC = (USGridCellView *)subView;
            tempGC.titelLabel.y -=5;
            [tempGC settitleColor:HYCTColor(72, 72, 72)];
        }
    }
}
-(void)didClickItem:(UIButton *)sender{
    UIView *view = sender.superview;
    while (view.superview!=nil) {
        view = view.superview;
        if (view==_helpSecondeView||view ==_helpTopView) {
            
            break;
        }
    }
    if (view ==_helpSecondeView) {
        USFrentlyQuestionViewController *toCV = [[USFrentlyQuestionViewController alloc]init];
        toCV.title = _helpSecondeTitles[sender.tag];
        toCV.code = _helpSecondeCodes[sender.tag];
        [self.navigationController pushViewController:toCV animated:YES];
    }
    if (view ==_helpTopView) {
        USFrentlyQuestionViewController *toCV = [[USFrentlyQuestionViewController alloc]init];
        toCV.title = _topHelpTitles[sender.tag];
        toCV.code = _topHelpCodes[sender.tag];
        [self.navigationController pushViewController:toCV animated:YES];

    }
    
}
@end
