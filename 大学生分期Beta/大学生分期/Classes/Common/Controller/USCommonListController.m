//
//  USSayHelloViewController.m
//  大学生分期
//
//  Created by mac on 16/2/22.
//  Copyright © 2016年 hongyunct. All rights reserved.
//
//打招呼信息
#import "USCommonListController.h"
#import "USCommonListTableCell.h"
@implementation USCommonListController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = _mytitle ;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent= NO;
    [self.view setBackgroundColor:HYCTColor(240, 240, 240)];
    
    
    
    //列表
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView setBackgroundColor:[UIColor whiteColor]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.y=-30;
    [self.view addSubview:self.tableView];
    
    self.tableView.height = self.view.height-30;
    
    //初始化参数
    [self initPara] ;
    
    
}
//初始化参数
-(void) initPara{
    [self.tableView reloadData];
}

///
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataList.count;
}

/**
 去掉id列和包好code的列
 **/
-(void)changeListData:(NSDictionary *)data newData:(NSMutableDictionary *)newData {
    
    NSArray *keys;
    NSInteger i, count;
    id key, value;
    
    keys = [data allKeys];
    count = [keys count];
    for (i = 0; i < count; i++)
    {
        
        key = [keys objectAtIndex: i];
        value = [data objectForKey: key];
         NSString *key_str = key ;
        if ([key_str isEqualToString:@"id"]) {
            continue ;
        }
        if ([key_str containsString:@"code"]) {
            continue ;
        }
        [newData setObject:value forKey:key] ;
       
    }
    

}

//行内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *data = _dataList[indexPath.row];
    NSMutableDictionary *new_dic =[[NSMutableDictionary alloc]init] ;
    
    [self changeListData:data newData:new_dic] ;
    static NSString *reuseIdentifier = @"commonlistIdentifier";
    USCommonListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell==nil) {
        cell  = [[USCommonListTableCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier data:new_dic];
        
    }
//    for (UIView *view in cell.subviews) {
//        [view removeFromSuperview];
//        view.hidden = YES;
//        
//    }
    [cell setData:new_dic] ;

    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
//高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50 ;
}
//当击行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *data = _dataList[indexPath.row];
    HYLog(@"%@",data) ;
    if (_ListCommonDelegate !=nil) {
        [_ListCommonDelegate listClickReturn:data type:_type] ;
        [self.navigationController popViewControllerAnimated:YES] ;
    }
    
}


@end
