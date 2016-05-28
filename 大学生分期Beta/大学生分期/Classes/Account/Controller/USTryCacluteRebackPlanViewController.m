//
//  USTryCacluteRebackPlanViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/10/26.
//  Copyright © 2015年 hongyunct. All rights reserved.
//

#import "USTryCacluteRebackPlanViewController.h"
#import "USUSTryCacluteRebackPlanViewCell.h"
#define kMargin 10
#define kPadding 2
#define kMarginTop 20
@interface USTryCacluteRebackPlanViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArrayList;
@end

@implementation USTryCacluteRebackPlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"试算还款计划";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent= NO;
    UILabel  *tipLable = [USUIViewTool createUILabelWithTitle:@"" fontSize:kCommonFontSize_15 color:[UIColor orangeColor] heigth:kCommonFontSize_15];
    tipLable.x = 10;
    tipLable.y = 10;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"提示:整除不尽的余额算在第一期的手续费中"];
    [str addAttribute:NSForegroundColorAttributeName value:HYCTColor(170, 170, 170) range:NSMakeRange(0,3)];
    tipLable.attributedText = str;
    [self.view addSubview:tipLable];
    //
    UIView *hrozenView = [self createHrozonUILables:tipLable.y+tipLable.height+kMargin];
    [self.view addSubview:hrozenView];

    //
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.height = (self.view.height-hrozenView.height-hrozenView.y)*0.88;
    self.tableView.y = hrozenView.height+hrozenView.y;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    [self loadData];

}
-(void)loadData{
    [USWebTool POST:@"repayplan/getRepayMoneyPlan.action" showMsg:@"正在获取还款计划..."
           paramDic:@{@"borrow_money":@(_brrowMoney),
                    @"month":@(_monthCount)
                    }
            success:^(NSDictionary  *dataDic) {
                _dataArrayList = [NSMutableArray array];
                [_dataArrayList addObjectsFromArray:dataDic[@"data"]];
                [_tableView reloadData];
    }];
}
-(UIView *)createHrozonUILables:(CGFloat)y{
    UIView *bigViw = [[UIView alloc]initWithFrame:CGRectMake(0, y, kAppWidth, 40)];
    bigViw.backgroundColor = HYCTColor(230, 230, 230);
    UILabel *perCountLB = [self createUILable:@"期数" width:40];
    perCountLB.frame = CGRectMake(5, 0,40, 40);
    perCountLB.textAlignment = NSTextAlignmentCenter;
    [bigViw addSubview:perCountLB];
    //
    UILabel *montoRebackLB = [self createUILable:@"月还本金" width:70];
    montoRebackLB.frame = CGRectMake(perCountLB.x+perCountLB.width+kPadding, 0,70, 40);
    montoRebackLB.textAlignment = NSTextAlignmentCenter;
    [bigViw addSubview:montoRebackLB];
    //
    UILabel *freeLB = [self createUILable:@"手续费" width:50];
    freeLB.frame = CGRectMake(montoRebackLB.x+montoRebackLB.width+kPadding, 0,50, 40);
    freeLB.textAlignment = NSTextAlignmentCenter;
    [bigViw addSubview:freeLB];
    //
    UILabel *monthTotalRebackLB = [self createUILable:@"月还总额" width:70];
    monthTotalRebackLB.frame = CGRectMake(freeLB.x+freeLB.width+kPadding, 0,70, 40);
    monthTotalRebackLB.textAlignment = NSTextAlignmentCenter;
    [bigViw addSubview:monthTotalRebackLB];
    //
    UILabel *limitDateLB = [self createUILable:@"月还总额" width:80];
    limitDateLB.frame = CGRectMake(monthTotalRebackLB.x+monthTotalRebackLB.width+kPadding, 0,70, 40);
    limitDateLB.textAlignment = NSTextAlignmentCenter;
    [bigViw addSubview:limitDateLB];
    return bigViw;
}
-(UILabel *)createUILable:(NSString *)title width:(CGFloat) width{
    UILabel *uiLB = [USUIViewTool createUILabelWithTitle:title fontSize:kCommonFontSize_15 color:HYCTColor(84, 84, 84) heigth:40];
    uiLB.width = width;
    //uiLB.backgroundColor = [UIColor redColor];
    return uiLB;
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return  1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return _dataArrayList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"reuseIdentifier";
    USUSTryCacluteRebackPlanViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell==nil) {
        cell = [[USUSTryCacluteRebackPlanViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    }
    [cell setDataWithDic:_dataArrayList[indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
   return 0.0001f; 
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return  44;
}


@end
