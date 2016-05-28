//
//  HYAboutMeTableViewController.m
//  红云创投
//
//  Created by HeXianShan on 15/8/27.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USMoreTableViewController.h"

@interface USMoreTableViewController ()
@property(nonatomic,strong)NSDictionary *moreTitleIcoDic;
@end

@implementation USMoreTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    NSString *titleIcoPath = [[NSBundle mainBundle]pathForResource:@"moreCellData" ofType:@"plist"];
    self.moreTitleIcoDic = [NSDictionary dictionaryWithContentsOfFile:titleIcoPath];
    [self.view addSubview:self.tableView];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  [self.moreTitleIcoDic count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *index = [NSString stringWithFormat:@"%li",section];
    NSArray *titlesArray = self.moreTitleIcoDic[index];

    return [titlesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"reuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    }
    NSString *index = [NSString stringWithFormat:@"%ld",indexPath.section];
    NSArray *titlesArray = self.moreTitleIcoDic[index];
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
        return 10;
    }
    return 9;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  30;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *index = [NSString stringWithFormat:@"%li",(long)indexPath.section];
    NSArray *titlesArray = self.moreTitleIcoDic[index];
    NSArray *titles = titlesArray[indexPath.row];
    if ([titles count]==3) {
        UIViewController * viewController= [[NSClassFromString([titles lastObject]) alloc] init];
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
    }
}
@end
