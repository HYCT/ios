//
//  USPickerDataViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/10/7.
//  Copyright © 2015年 hongyunct. All rights reserved.
//

#import "USPickerDataViewController.h"
#import "USTempData.h"
#import "USWebTool.h"
@interface USPickerDataViewController ()

@end

@implementation USPickerDataViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    if (_fetchDataBlock!=nil) {
        _fetchDataBlock(_paramDic,_url);
    }
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
        self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    if (_makeViewBlock!= nil) {
        _makeViewBlock(self);
    }
}
-(void)datePick:(UIDatePicker *)picker{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    if (_didSelectDataBlock!=nil) {
        
    NSString *destDateString = [dateFormatter stringFromDate:picker.date];
        USTempData *tempData = [[USTempData alloc]init];
        tempData.name = destDateString;
        _didSelectDataBlock(tempData);
    }
}
-(void)dateTimePick:(UIDatePicker *)picker{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    if (_didSelectDataBlock!=nil) {
        
        NSString *destDateString = [dateFormatter stringFromDate:picker.date];
        USTempData *tempData = [[USTempData alloc]init];
        tempData.name = destDateString;
        _didSelectDataBlock(tempData);
    }
}
-(void)dateTimePickButtonClick{
    [self dateTimePick:_datePicker];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)datePickButtonClick{
    [self datePick:_datePicker];
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_dataList!=nil) {
        return _dataList.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"reuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier ];
    }
    USTempData *data = _dataList[indexPath.row];
    cell.width = kAppWidth;
    cell.textLabel.textColor = HYCTColor(150, 150, 150);
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    [cell.textLabel setText:data.name];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    USTempData *data = _dataList[indexPath.row];
    if (_didSelectDataBlock!=nil) {
        _didSelectDataBlock(data);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
