//
//  USFinanceRebackTableViewControll.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/3.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USFinanceRebackTableViewController.h"
@interface USFinanceRebackTableViewController ()
@property(nonatomic,strong)NSDictionary *financeRebackTitleIcoDic;
@end
@implementation USFinanceRebackTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent= NO;
    [self.view setBackgroundColor:HYCTColor(240, 240, 240)];
    self.title = @"我要还款";
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    [self.tableView setBackgroundColor:[UIColor clearColor]];
    NSString *titleIcoPath = [[NSBundle mainBundle]pathForResource:@"financeRebackCellData" ofType:@"plist"];
    self.financeRebackTitleIcoDic = [NSDictionary dictionaryWithContentsOfFile:titleIcoPath];
   [self.view addSubview:self.tableView];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  [self.financeRebackTitleIcoDic count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *index = [NSString stringWithFormat:@"%li",(long)section];
    NSArray *titlesArray = self.financeRebackTitleIcoDic[index];
    
    return [titlesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"reuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    }
    NSString *index = [NSString stringWithFormat:@"%li",(long)indexPath.section];
    NSArray *titlesArray = self.financeRebackTitleIcoDic[index];
    NSArray *titles = titlesArray[indexPath.row];
    [cell.textLabel setText:titles[0]];
    [cell.textLabel setTextColor:kCellFontColor];
    [cell.textLabel setFont:kCommonFont];
    cell.imageView.image = [UIImage imageNamed:titles[1]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
        return 15;
    }
    return 9;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  30;
}
-(void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *index = [NSString stringWithFormat:@"%li",(long)indexPath.section];
    NSArray *titlesArray = self.financeRebackTitleIcoDic[index];
    NSArray *titles = titlesArray[indexPath.row];
    if ([titles count]==3) {
        UIViewController *viewController= [[NSClassFromString(titles[2]) alloc] init];
        viewController.title = titles[0];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}
@end
