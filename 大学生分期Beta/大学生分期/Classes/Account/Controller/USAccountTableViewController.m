//
//  HYAccountTableViewTableViewController.m
//  红云创投
//
//  Created by HeXianShan on 15/8/26.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USAccountTableViewController.h"

@interface USAccountTableViewController ()
@property(nonatomic,strong)NSDictionary *accountTitleIcoDic;
@end

@implementation USAccountTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    
    //NSString *titleIcoPath = [[NSBundle mainBundle]pathForResource:@"accountCellData" ofType:@"plist"];
    NSString *titleIcoPath = [[NSBundle mainBundle]pathForResource:_dataFileUrl ofType:@"plist"];
    self.accountTitleIcoDic = [NSDictionary dictionaryWithContentsOfFile:titleIcoPath];
    [self.view addSubview:self.tableView];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  [self.accountTitleIcoDic count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *index = [NSString stringWithFormat:@"%li",(long)section];
    NSArray *titles = self.accountTitleIcoDic[index];
    return [titles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"reuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    }
    NSString *index = [NSString stringWithFormat:@"%li",(long)indexPath.section];
    NSArray *titlesArray = self.accountTitleIcoDic[index];
    NSArray *titles = titlesArray[indexPath.row];
    [cell.textLabel setText:titles[0]];
    [cell.textLabel setTextColor:kCellFontColor];
    [cell.textLabel setFont:[UIFont systemFontOfSize:kCommonFontSize_18]];
    // [cell.contentView addSubview:cell.imageView];
    cell.imageView.image = [UIImage imageNamed:titles[1]];
    cell.imageView.size = CGSizeMake(50, 50);
    cell.imageView.autoresizesSubviews = NO;
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    // cell.imageView.image = [UIImage imageNamed:@"ask_image"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //    if ([titles[1]isEqualToString:@"account_cell_myincome_ico"]) {
    //        [cell.detailTextLabel setText:self.myIncome?self.myIncome:@"未知"];
    //        [cell.detailTextLabel setTextColor:kCellFontColor];
    //        [cell.detailTextLabel setFont:kCommonFont];
    //    }
    return cell;
}
-(void)setMyIncome:(NSString *)myIncome{
    _myIncome = myIncome;
    // NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    //    [[self.tableView cellForRowAtIndexPath:indexPath].detailTextLabel setText:self.myIncome?self.myIncome:@"未知"];
    //    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0.0001;
    }
    return 9;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        return 0.0001;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  44;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *index = [NSString stringWithFormat:@"%li",(long)indexPath.section];
    NSArray *titlesArray = self.accountTitleIcoDic[index];
    NSArray *titles = titlesArray[indexPath.row];
    if ([titles count]==3) {
        UIViewController * viewController= [[NSClassFromString([titles lastObject]) alloc] init];
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

@end
