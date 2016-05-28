//
//  USBindCardViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/5.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USBindCardViewController.h"
#import "USFillAccountViewController.h"
@interface USBindCardViewController ()
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation USBindCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"校园一卡通充值";
    self.navigationController.navigationBar.translucent= NO;
    [self.view setBackgroundColor:HYCTColor(240, 241, 240)];
    [self createUILable];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.y = 60;
    self.tableView.height = 90;
    self.tableView.scrollEnabled = NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.tableView];
    UIButton *bindCard = [USUIViewTool createButtonWith:@"立即绑定" imageName:@"finance_bindcard_button_bg"];
    [bindCard.titleLabel setFont:[UIFont systemFontOfSize:12]];
    bindCard.frame = CGRectMake(5, self.tableView.y+self.tableView.height+20, kAppWidth-10, 30);
    [self.view addSubview:bindCard];
    [bindCard addTarget:self action:@selector(toFillAccount) forControlEvents:UIControlEventTouchUpInside];
}
-(void)toFillAccount{
   
    USFillAccountViewController *fillAccountVC = [[USFillAccountViewController alloc]init];
    [self.navigationController pushViewController:fillAccountVC animated:YES];
    [self removeFromParentViewController];
   
}
-(void)createUILable{
    UILabel *titleUILable = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, kAppWidth, 30)];
    [titleUILable setFont:kCommonFont];
    [titleUILable setTextAlignment:NSTextAlignmentCenter];
    [titleUILable setTextColor:HYCTColor(166, 166, 166)];
    titleUILable.text = @"是否绑定此校园卡为你的卡号?";
    [self.view addSubview:titleUILable];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"reuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    }
    [cell.textLabel  setFont:kCommonFont];
    [cell.textLabel setTextColor:HYCTColor(165, 165, 165)];
    if (indexPath.row==0) {
        [cell.textLabel setText:@"姓名:"];
    }
    if (indexPath.row==1) {
        [cell.textLabel setText:@"学校:"];
    }
    if (indexPath.row==2) {
        [cell.textLabel setText:@"卡号:  1473 8864 7721 6634 882"];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    return 9;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  30;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
