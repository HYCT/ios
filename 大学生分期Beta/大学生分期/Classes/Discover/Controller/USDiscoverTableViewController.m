//
//  HYNewsTableViewController.m
//  红云创投
//
//  Created by HeXianShan on 15/8/25.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USDiscoverTableViewController.h"
#import "USBlackNameCell.h"
#import "HYNews.h"
@interface USDiscoverTableViewController ()
@property(nonatomic,strong)NSDictionary *discoverTitleIcoDic;
@end

@implementation USDiscoverTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setBackgroundColor:HYCTColor(240, 240, 240)];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    NSString *titleIcoPath = [[NSBundle mainBundle]pathForResource:@"discoverCellData" ofType:@"plist"];
    self.discoverTitleIcoDic = [NSDictionary dictionaryWithContentsOfFile:titleIcoPath];
    [self.view addSubview:self.tableView];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return [self.discoverTitleIcoDic count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *index = [NSString stringWithFormat:@"%li",section];
    NSArray *titlesArray = self.discoverTitleIcoDic[index];
    return [titlesArray count];

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"reuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    }
    NSString *index = [NSString stringWithFormat:@"%li",indexPath.section];
    NSArray *titlesArray = self.discoverTitleIcoDic[index];
    NSArray *titles = titlesArray[indexPath.row];
    [cell.textLabel setText:titles[0]];
    [cell.textLabel setTextColor:kCellFontColor];
    [cell.textLabel setFont:[UIFont systemFontOfSize:kCommonFontSize_18]];
    cell.imageView.image = [UIImage imageNamed:titles[1]];
    cell.imageView.size = CGSizeMake(50, 50);
    cell.imageView.autoresizesSubviews = NO;
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
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
    
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *index = [NSString stringWithFormat:@"%li",(long)indexPath.section];
    NSArray *titlesArray = self.discoverTitleIcoDic[index];
    NSArray *titles = titlesArray[indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([titles count]==3) {
        UIViewController * viewController= [[NSClassFromString([titles lastObject]) alloc] init];
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
}

@end
