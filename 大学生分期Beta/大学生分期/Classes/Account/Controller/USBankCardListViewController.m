//
//  USAddBankCardViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/9.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USBankCardListViewController.h"
#import "USBindBankHuifuAccountViewController.h"
#import "USBindBankCardViewController.h"
#import "USBankCardCell.h"

@interface USBankCardListViewController()
@property (nonatomic,strong)UIView *footer;
@property(nonatomic,strong)NSArray *bankCardList;
@property(nonatomic,strong)USAccount *account;
@end
@implementation USBankCardListViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    
    
    
    self.title = @"添加银行卡";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent= NO;
    [self.view setBackgroundColor:HYCTColor(240, 241, 240)];
    _account = [USUserService accountStatic];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    self.tableView.y = 15;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.x = 10;
    
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 240)];
    [footer setBackgroundColor:HYCTColor(240, 241, 240)];
    //
    UIView *subfooter = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kAppWidth-self.tableView.x*2, 120)];
    subfooter.layer.cornerRadius = 5;
    subfooter.layer.masksToBounds = YES;
    [subfooter setBackgroundColor:[UIColor whiteColor]];
    [footer addSubview:subfooter];
    //
    UIButton *addBt = [USUIViewTool createButtonWith:@"  " imageName:@"account_add_card_bt_img"];
    addBt.size =CGSizeMake(50, 50);
    addBt.x = subfooter.width/2-addBt.width/2;
    addBt.y = subfooter.height/4;
    [subfooter addSubview:addBt];
    UILabel *label = [USUIViewTool createUILabelWithTitle:@"添加银行卡" fontSize:14 color:HYCTColor(207, 207, 207) heigth:25];
    label.textAlignment = NSTextAlignmentCenter;
    label.x = 0;
    label.width = subfooter.width;
    label.y = addBt.y+addBt.height+10;
    [subfooter addSubview:label];
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = subfooter.bounds;
    [subfooter addSubview:addButton];
    [addButton addTarget:self action:@selector(addCard) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableFooterView = footer;
    self.tableView.scrollsToTop = YES;
    [self.view addSubview:self.tableView];
}

-(void)addCard{
    NSInteger realnameType = _account.realnametype ;
    if (realnameType < 3 ) {
        [MBProgressHUD showError:@"抱歉，你的实名认证还没有通过审核！"];
        return ;
    }else{
        NSInteger huifu_account = _account.ishashuifu_account ;
        //跳转到开户页面
        if (huifu_account == 0 ) {
            USBindBankHuifuAccountViewController *toCV = [[USBindBankHuifuAccountViewController alloc]init];
            toCV.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:toCV animated:YES];
        }else{
            USBindBankCardViewController *toCV = [[USBindBankCardViewController alloc]init];
            toCV.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:toCV animated:YES];
        }
    }
    
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
