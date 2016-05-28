//
//  USFinanceTableViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/3.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USFinanceTableViewController.h"
@interface USFinanceTableViewController()
@property(nonatomic,strong)NSDictionary *moreTitleIcoDic;
@end
@implementation USFinanceTableViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    NSString *titleIcoPath = [[NSBundle mainBundle]pathForResource:@"financeCellData" ofType:@"plist"];
    self.moreTitleIcoDic = [NSDictionary dictionaryWithContentsOfFile:titleIcoPath];
    //[self.view addSubview:self.tableView];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  [self.moreTitleIcoDic count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *index = [NSString stringWithFormat:@"%li",(long)section];
    NSArray *titlesArray = self.moreTitleIcoDic[index];
    
    return [titlesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"reuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    }
    NSString *index = [NSString stringWithFormat:@"%li",(long)indexPath.section];
    NSArray *titlesArray = self.moreTitleIcoDic[index];
    NSArray *titles = titlesArray[indexPath.row];
    [cell.textLabel setText:titles[0]];
    [cell.textLabel setFont:kCommonFont];
    [cell.detailTextLabel setText:titles[1]];
    [cell.detailTextLabel setTextColor:HYCTColor(174, 174, 174)];
    [cell.detailTextLabel setFont:[UIFont systemFontOfSize:10]];
    cell.imageView.image = [UIImage imageNamed:titles[2]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
        return 20;
    }
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  50;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *index = [NSString stringWithFormat:@"%li",(long)indexPath.section];
    NSArray *titlesArray = self.moreTitleIcoDic[index];
    NSArray *titles = titlesArray[indexPath.row];
    if ([titles count]>3) {
        id viewController= [[NSClassFromString(titles[3]) alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    }
   
   
}
@end
