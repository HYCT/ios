//
//  USAddBankCardViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/9.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USCommonBankCardListViewController.h"
#import "USBindBankHuifuAccountViewController.h"
#import "USBindBankCardViewController.h"
#import "USBankCardCell.h"

@interface USCommonBankCardListViewController()
@property(nonatomic,strong)NSArray *bankCardList;
@property(nonatomic,strong)USAccount *account;
@end
@implementation USCommonBankCardListViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    
    
    
    self.title = @"我的银行卡";
    _account = [USUserService accountStatic];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent= NO;
    [self.view setBackgroundColor:HYCTColor(240, 241, 240)];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    self.tableView.y = 15;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.x = 10;
    
    
    [self.view addSubview:self.tableView];
}

-(void)loadBankCardlist{
    
    [USWebTool POST:@"bindbankcardcilent/bindBankCardlist.action" showMsg:@"正在玩命获取你绑定的银行卡..." paramDic:@{@"customer_id":_account.id} success:^(NSDictionary *dic) {
        _bankCardList = dic[@"data"];
        [_tableView reloadData];
    } failure:^(id data) {
        _bankCardList = nil;
        [_tableView reloadData];
    }];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  [_bankCardList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"reuseIdentifier";
    USBankCardCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell==nil) {
        cell = [[USBankCardCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    [cell setDateWithDic:_bankCardList[indexPath.section]];
    
    //实例化长按手势监听
    UILongPressGestureRecognizer *longPress =
    [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                  action:@selector(handleTableviewCellLongPressed:)];
    //代理
    longPress.delegate = self;
    longPress.minimumPressDuration = 1.0;
    //将长按手势添加到需要实现长按操作的视图里
    [cell addGestureRecognizer:longPress];
    //[longPress release];
    //[cell release];
    return cell;
}

//长按事件的实现方法
- (void) handleTableviewCellLongPressed:(UILongPressGestureRecognizer *)gestureRecognizer {
    //开始长按事件
    if (gestureRecognizer.state ==
        UIGestureRecognizerStateBegan) {
        NSLog(@"UIGestureRecognizerStateBegan");
        
    }
    if (gestureRecognizer.state ==
        UIGestureRecognizerStateChanged) {
        NSLog(@"UIGestureRecognizerStateChanged");
    }
    
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        NSLog(@"UIGestureRecognizerStateEnded");
        
    }
    
}

//点击某一行时候触发的事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:_tableView]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定要删除该银行卡吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertView.delegate = self;
        [alertView show];
    }
}

//alertview代理
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        long index = indexPath.section ;
        //NSLog(@"index %ld",index) ;
        NSDictionary *row = _bankCardList[index];
        //NSLog(@"index %@",row[@"id"]) ;
        //NSString *rowid = @"ssssss";
        NSString *rowid = row[@"id"] ;
        [USWebTool POSTWIthTip:@"bindbankcardcilent/deleteCustomerBindBank.action" showMsg:@"正在删除银行卡..." paramDic:@{@"id":rowid} success:^(NSDictionary *dic) {
            //重新设置用户
            [USUserService saveAccount:[USAccount accountWithDic:dic[@"data"]]];
            //重新加载银行卡
            [self loadBankCardlist] ;
            //_bankCardList = dic[@"data"];
            //[_tableView reloadData];
        } failure:^(id data) {
            
        }];
        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  120;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [NSThread detachNewThreadSelector:@selector(loadBankCardlist) toTarget:self withObject:nil];
}
@end
