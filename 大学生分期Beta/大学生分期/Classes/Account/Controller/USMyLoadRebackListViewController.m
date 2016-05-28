//
//  USMyLoadRebackListViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/25.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USMyLoadRebackListViewController.h"
#import "USSegmentView.h"
#import "USFinanceLoanViewController.h"
#import "USLoanRebackTableViewController.h"
#import "USLoadRebackRecordCellView.h"
@interface USMyLoadRebackListViewController ()
@property(nonatomic,strong)USLoanRebackTableViewController *rebackListVC;
@property(nonatomic,strong)USLoanRebackTableViewController *loanListVC;
@property(nonatomic,strong)USSegmentView *segview;
@end

@implementation USMyLoadRebackListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的借还记录";
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    //
    CGFloat margin = 10;
    CGFloat y = 15;
    CGFloat height = 25;
    CGRect frame = CGRectMake(margin, y, kAppWidth-2*margin, height);
    
    USSegmentView *segview = [[USSegmentView alloc]initWithTitles:@[@"还款记录",@"借款记录"] frame:frame];
    y = segview.y+segview.height+margin;
    _segview = segview;
   __block UIViewController *tempVC = self;
    segview.clickBlock = ^(NSInteger tag){
        if (tag == 0) {
            [_loanListVC.view removeFromSuperview];
            if(!_rebackListVC){
                _rebackListVC = [[USLoanRebackTableViewController alloc]init];
                
                 _rebackListVC.cellType = RebackType;
                _rebackListVC.url =_rebackUrl;
                _rebackListVC.param =_rebackParam;
                _rebackListVC.msg = _rebackMsg;
                _rebackListVC.y = y;
                [tempVC addChildViewController:_rebackListVC];
            }
            [tempVC.view addSubview:_rebackListVC.view];
        }else{
            [_rebackListVC.view removeFromSuperview];
            if(!_loanListVC){
                _loanListVC = [[USLoanRebackTableViewController alloc]init];
                _loanListVC.cellType = LoanType;
                _loanListVC.url =_loanUrl;
                _loanListVC.param =_loanParam;
                _loanListVC.msg = _loanMsg;
                _loanListVC.y = y;
                [tempVC addChildViewController:_loanListVC];
            }
            [tempVC.view addSubview:_loanListVC.view];
        }
    };
    segview.selectedIndex = _selectedIndex;
    [self.view addSubview:segview];
   
}

-(void)pop{
    NSArray *childs = [self.navigationController childViewControllers];
    NSInteger index = -1;
    for (NSInteger i =0;i<childs.count ; i++) {
        if ([childs[i] isKindOfClass:[USFinanceLoanViewController class]]) {
            index = i;
        }
    }
    if ((index-1)>=0) {
        UIViewController *vc = childs[index-1];
        vc.view =nil;
        [self.navigationController popToViewController:vc animated:YES];
        [childs[index] removeFromParentViewController];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
