//
//  USSayHelloViewController.m
//  大学生分期
//
//  Created by mac on 16/2/22.
//  Copyright © 2016年 hongyunct. All rights reserved.
//
//打招呼信息
#import "USCommentListViewController.h"
#import "USCommentTableCell.h"
@interface USCommentListViewController()
@property(nonatomic,strong) USAccount *account;
@property(nonatomic,strong)NSMutableArray *dataList;
@property(nonatomic,strong)NSMutableDictionary *paramDic;
@property(nonatomic,assign)int currentPage;
@property(nonatomic,assign)int totalPage;
@property(nonatomic,strong)UIView *dataTipView;
@property(nonatomic,strong)UIImage *headerPic;
@property(nonatomic,strong)NSString *url ;
@property(nonatomic,strong)NSString *reuseIdentifier;
@property(nonatomic,strong)UITextField *textComment ;
@property(nonatomic,strong)UIButton *sendBtn ;
@property(nonatomic,strong)UIView *commentBg ;
@end
@implementation USCommentListViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"消息评论";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent= NO;
    [self.view setBackgroundColor:[UIColor whiteColor]];

    //列表
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView setBackgroundColor:[UIColor whiteColor]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.y=-30;
    [self.view addSubview:self.tableView];
    
    self.tableView.height = self.view.height -80 ;
    
    //初始化参数
    [self initPara] ;
    
    //底部
    [self createFooterCommentSend] ;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardwasShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardwasHidden:) name:UIKeyboardDidHideNotification object:nil];
    
    
}

//键盘显示时候
-(void)keyboardwasShown:(NSNotification *) notify{
    CGRect frame = [self.view frame];
    if ([[notify name]isEqualToString:UIKeyboardDidShowNotification]) {
        [UIView animateWithDuration:0.3 animations:^{
            self.view.frame = frame;
        }completion:^(BOOL finished) {
            //
        }];
    }
    
    NSDictionary *info = [notify userInfo];
    NSValue *aValue = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    
    CGSize keyBoardSize = [aValue CGRectValue].size;
    
    CGRect rect = _commentBg.frame;
    rect.origin.y = self.view.frame.size.height - keyBoardSize.height -2*_commentBg.height;
    _commentBg.frame = rect;
    
}
//键盘消失
-(void) keyboardwasHidden:(NSNotification *) notify{
    NSDictionary *info = [notify userInfo];
    NSValue *aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyBoardSize = [aValue CGRectValue].size;
    CGRect rect = _commentBg.frame;
    rect.origin.y = self.view.frame.size.height - rect.size.height;
    _commentBg.frame = rect;
}

//初始化参数
-(void) initPara{
    _reuseIdentifier =@"commentlisttableview" ;
    _dataList = [NSMutableArray array];
    //用户
    _account = [USUserService accountStatic];
    _paramDic = [NSMutableDictionary dictionary];
    
    _paramDic[@"message_id"] = _msgId;
    _paramDic[@"pageSize"] = @(kPageSize);
    _currentPage=1 ;
    _paramDic[@"currentPage"] = @(_currentPage);
    _url=@"wangkaClientController/getMsgCommentList.action";
    
    //
     _dataTipView = [USUIViewTool createDataTipViewWithTarget:self action:@selector(loadData)];
    
    //默认头像
    _headerPic = [UIImage imageNamed:@"near_table_cell_person_img"];
    
    //底部的刷新控件
    [self setupRefresh];
    
    
    //加载数据
    [self loadData] ;
    
    return ;
}
//创建底部发表评论视图
-(void)createFooterCommentSend{
    @try {
        
        CGFloat ly =kAppHeight -80 ;
        CGFloat t_width = kAppWidth-110 ;
        CGFloat t_hight = 30 ;
        //背景
        _commentBg = [[UIView alloc]initWithFrame:CGRectMake(0, ly, kAppWidth, 40)];
        [_commentBg setBackgroundColor:HYCTColor(240, 240, 240)];
        [self.view addSubview:_commentBg] ;
      
        _textComment = [[UITextField alloc]initWithFrame:CGRectMake(10,5 , t_width, t_hight)];
        [_textComment setBorderStyle:UITextBorderStyleNone] ;
        [_textComment setTextColor:[UIColor darkGrayColor]] ;
        [_textComment setFont:[UIFont systemFontOfSize:14]] ;
        [_textComment setClearButtonMode:UITextFieldViewModeAlways] ;
        //边框
        [_textComment.layer setBackgroundColor:[[UIColor whiteColor] CGColor]] ;
        [_textComment.layer setBorderColor:[[UIColor grayColor] CGColor]] ;
        [_textComment.layer setCornerRadius:5] ;
        [_textComment.layer setBorderWidth:0.5] ;
        //提示字符
        _textComment.placeholder=@"请输入评论";
        [_textComment setFrame:CGRectMake(10,5 , t_width, t_hight)] ;
        [_commentBg addSubview:_textComment] ;
        
        //评论按钮
        _sendBtn = [USUIViewTool createButtonWith:@"评论"] ;
        [_sendBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal] ;
        [_sendBtn setFont:[UIFont systemFontOfSize:14]] ;
        _sendBtn.frame = CGRectMake(_textComment.x+_textComment.width+10, _textComment.y, 80, t_hight) ;
        [_sendBtn.layer setBorderColor:[[UIColor grayColor] CGColor]] ;
        [_sendBtn.layer setBorderWidth:0.5] ;
        [_sendBtn.layer setCornerRadius:5] ;
        [_sendBtn addTarget:self action:@selector(sendCommentClick) forControlEvents:UIControlEventTouchUpInside];
        [_commentBg addSubview:_sendBtn] ;
        
    }
    @catch (NSException *exception) {
        HYLog(@"createFooterCommentSend:%@",exception) ;
    }
    
    
}

//发送评论
-(void) sendCommentClick{
    @try {
        NSString *message_id=_msgId ;
        NSString *customer_id = _account.id;
        NSString *content = _textComment.text  ;
         NSString *comment_id = @""  ;
        if (nil == customer_id || NULL == customer_id ) {
            [MBProgressHUD showError:@"还没有登录,请登!"];
            return  ;
        }else if (nil==content || NULL == content || content.length ==0 ){
            [MBProgressHUD showError:@"请输入内容!"];
            return ;
        }
        else{
            NSMutableDictionary *paramData =[[NSMutableDictionary alloc] init];
            paramData[@"message_id"]=message_id ;
            paramData[@"customer_id"]=customer_id ;
            paramData[@"content"]=content ;
            paramData[@"comment_id"]=comment_id ;
            [USWebTool POSTWIthTip:@"wangkaClientController/saveMsgComment.action" showMsg:@"请稍后..." paramDic:paramData success:^(NSDictionary *dic) {
                //_dataList = [NSMutableArray array];
                [_dataList removeAllObjects] ;
                //重新设置page
                _currentPage =1 ;
                [_textComment setText:@""] ;
                //重新加载数据
                [self loadData] ;
            } failure:^(id data) {
                
            }];
 
        }

    }
    @catch (NSException *exception) {
        HYLog(@"sendCommentClick:%@",exception) ;
    }
    
}

//加载数据
-(void) loadData{
    [USWebTool POSTPageWIthTip:_url showMsg:@"请稍后..." paramDic:_paramDic success:^(NSDictionary *dic) {
        if([dic[@"totalNum"]intValue]>0){
            //[_dataList addObjectsFromArray:dic[@"data"]];
            [self createDataView:dic[@"data"]] ;
            _currentPage =[dic[@"currentPage"] intValue];
            _totalPage = [dic[@"totalPage"] intValue];
            [_tableView reloadData];
        }else{
            [self.view addSubview:_dataTipView];
        }
        
    } failure:^(id data) {
        [self.view addSubview:_dataTipView];
    }];

    return  ;
}

//创建view行
-(void)createDataView:(NSArray *)dicData{
    if (dicData!=nil&&dicData.count>0) {
        for (NSDictionary *dic in dicData) {
            USCommentTableCell *view = [[USCommentTableCell alloc]initWithData:dic ];
            [_dataList addObject:view];
        }
    }
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    self.tableView.footerPullToRefreshText = @"上拉加载更多数据";
    self.tableView.footerReleaseToRefreshText = @"松开加载更多数据";
    self.tableView.footerRefreshingText = @"正在玩命加载中...";
}



- (void)footerRereshing
{
    if (_currentPage<=_totalPage&&_currentPage>0) {
        _currentPage++;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_paramDic];
        dic[@"currentPage"] = @(_currentPage);
        [USWebTool POST:_url paramDic:dic success:^(NSDictionary *dataDic) {
            
            if ([dataDic[@"data"] count]==0||[NSNull null]==dataDic[@"data"]||!([dataDic[@"totalNum"]intValue]>0)) {
                _currentPage--;
                [MBProgressHUD showSuccess:@"没有更多的数据可显示..."];
                return ;
            }
            //[_dataList addObjectsFromArray:dataDic[@"data"]];
            [self createDataView:dic[@"data"]] ;
            [self.tableView reloadData];
            _currentPage =[dataDic[@"currentPage"] intValue];
            _totalPage = [dataDic[@"totalPage"] intValue];
        } failure:^(id data) {
            
        }];
    }
    [self.tableView footerEndRefreshing];
}

///
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataList.count;
}

//行内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_reuseIdentifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:_reuseIdentifier];
        
    }
    for (UIView *view in cell.subviews) {
        [view removeFromSuperview];
        view.hidden = YES;
        
    }
    USCommentTableCell *view = [_dataList objectAtIndex:indexPath.row];
    cell.contentView.userInteractionEnabled = YES;
    view.hidden = NO;
    [cell addSubview:view];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
//高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //USSayHelloTableCell *cell = [self tableView: _tableView cellForRowAtIndexPath: indexPath];
    //return cell.height +10;
    USCommentTableCell *view = [_dataList objectAtIndex:indexPath.row];
    return view.height;
    //return 110 ;
}
//当击行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
}


@end
