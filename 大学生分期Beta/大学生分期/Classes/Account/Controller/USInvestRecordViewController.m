//
//  USFinanceInvestRecordViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/4.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USInvestRecordViewController.h"

@interface USInvestRecordViewController ()

@end

@implementation USInvestRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(5, 0, kAppWidth-10, kAppHeight)];
    [self.view addSubview:_tableView];
    [_tableView setBackgroundColor:[UIColor clearColor]];
    [self.view  setBackgroundColor:[UIColor clearColor]];
    _tableView.delegate =self;
    _tableView.dataSource = self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"reuseIdentifier";
    USRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell==nil) {
        cell = [[USRecordTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    }
    [cell setName:@"lala" amount:@"1238.00" date:@"2015-07-22 12:33:23"];
    [cell setBackgroundColor:[UIColor clearColor]];
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
    return  40;
}


@end
