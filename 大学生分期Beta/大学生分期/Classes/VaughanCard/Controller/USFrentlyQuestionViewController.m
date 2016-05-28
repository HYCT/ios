//
//  USFrentlyQuestionViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/13.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USFrentlyQuestionViewController.h"
#import "USCellTipView.h"
@interface USFrentlyQuestionViewController()
@property(nonatomic,strong)NSMutableArray *tipViews;
@property(nonatomic,strong)NSMutableDictionary *heigthsDic;
@property(nonatomic,strong)NSMutableDictionary *sectionViewsDic;
//
@property(nonatomic,copy)NSString *pageUrl;
@property(nonatomic,copy)NSString *msg;
@property(nonatomic,strong)NSMutableArray *dataArrayList;
@property(nonatomic,assign)int currentPage;
@property(nonatomic,assign)int totalPage;
@property(nonatomic,strong)USAccount *account;
@property(nonatomic,strong)NSDictionary *pageParam;
//
@property(nonatomic,strong)UIView *dataTipView;
@end
@implementation USFrentlyQuestionViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent= NO;
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.height = kAppHeight*0.9;
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.tableView];
    _heigthsDic = [NSMutableDictionary dictionary];
    _sectionViewsDic = [NSMutableDictionary dictionary];
    _currentPage = 1;
    _totalPage = 1;
    _pageUrl = @"helpcenterclient/getHelpCenterClientByCode.action";
    _dataTipView = [USUIViewTool createDataTipViewWithTarget:self action:@selector(loadData)];
    [self setupRefresh];
    [self loadData];
}
-(void)loadData{
    [_dataTipView removeFromSuperview];
    _pageParam = @{ @"pageSize":@(kPageSize),
                   @"currentPage":@(_currentPage),
                    @"menucode":_code};
    [USWebTool POSTWithNoTip:_pageUrl showMsg:@"正在加载帮助信息..."
                    paramDic: _pageParam
                     success:^(NSDictionary *dataDic) {
                         if (_dataArrayList == nil) {
                             _dataArrayList = [NSMutableArray array];
                         }
                         if ([dataDic[@"data"] count]==0) {
                             [self.view addSubview:_dataTipView];
                             return ;
                         }
                         [_dataArrayList addObjectsFromArray:dataDic[@"data"]];
                         _currentPage =[dataDic[@"currentPage"] intValue];
                         _totalPage = [dataDic[@"totalPage"] intValue];
                         [_tableView reloadData];
                     }];
}
-(NSString *)getStr:(NSInteger)row{
    return [NSString stringWithFormat:@"%li",(long)row];
}

-(void)accessoryButtonClick:(UIButton *)accessoryButton{
    accessoryButton.selected = !accessoryButton.selected;
    //
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:accessoryButton.tag];
    if (accessoryButton.selected) {
        CGRect rectInTableView = [_tableView rectForRowAtIndexPath:indexPath];
        CGRect rectInSuperview = [_tableView convertRect:rectInTableView toView:[_tableView superview]];
        CGRect frame = CGRectMake(0, rectInSuperview.origin.y+rectInSuperview.size.height*2/3, kAppWidth, 60);
        if (_tipViews==nil) {
            _tipViews = [NSMutableArray array];
        }
        for (UIView *tempView in _tipViews) {
            if(tempView.tag == accessoryButton.tag){
                tempView.frame = frame;
                tempView.hidden = NO;
                return;
            }
        }
        USCellTipView *tipView = [[USCellTipView alloc]initWithFrame:frame ];
        for (UIView *subView in tipView.contentViewBg.subviews) {
            [subView removeFromSuperview];
        }
        UITextView *textView = [[UITextView alloc]initWithFrame:tipView.contentViewBg.bounds];
        textView.backgroundColor = HYCTColor(240, 240, 240);
        
        textView.font = [UIFont systemFontOfSize:kCommonFontSize_14];
        textView.textColor = HYCTColor(160, 160, 160);
        
        NSString *content = _dataArrayList[indexPath.section][@"content"];
        CGFloat height = [self boundingRectWithSize:content].height+10;
        tipView.height = height;
        textView.height = height;
        textView.text = content;
        textView.y-=15;
        [tipView.contentViewBg addSubview:textView];
        textView.userInteractionEnabled = NO;
        tipView.tag = accessoryButton.tag;
        tipView.accessoryBt = accessoryButton;
        [_tipViews addObject:tipView];
        [_heigthsDic setObject:@(height) forKey:[self getStr:indexPath.section]];
        [_sectionViewsDic setObject:tipView forKey:[self getStr:indexPath.section]];
        [_tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
        
    }else{
        accessoryButton.selected = NO;
        [_heigthsDic removeObjectForKey:[self getStr:indexPath.section]];
        [_tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
        UIView *tempView = nil;
        for (tempView in _tipViews) {
            if(tempView.tag == accessoryButton.tag){
                tempView.hidden = YES;
                break;
            }
        }
        [tempView removeFromSuperview];
        [_tipViews removeObject:tempView];
        
    }
    
}
- (void)setupRefresh
{
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    self.tableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.tableView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    self.tableView.footerRefreshingText = @"正在玩命加载中...";
}



- (void)footerRereshing
{
    
    if (_currentPage<=_totalPage&&_currentPage>0) {
        _currentPage++;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_pageParam];
        dic[@"currentPage"] = @(_currentPage);
        [USWebTool POST:_pageUrl paramDic:dic success:^(NSDictionary *dataDic) {
            if ([dataDic[@"data"]count]==0) {
                _currentPage--;
                [MBProgressHUD showError:@"已经加载完所有帮助信息了..."];
                return ;
            }
            [_dataArrayList addObjectsFromArray:dataDic[@"data"]];
            [self.tableView reloadData];
            _currentPage =[dataDic[@"currentPage"] intValue];
            _totalPage = [dataDic[@"totalPage"] intValue];
        } failure:^(id data) {
            
        }];
    }
    [self.tableView footerEndRefreshing];
    [self updateTableFooterView];
}
-(void)updateTableFooterView{
  //  self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kAppWidth, 50)];
   // self.tableView.tableFooterView.hidden = NO;
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  [_dataArrayList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"reuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.font = [UIFont systemFontOfSize:kCommonFontSize_15];
        UIButton *accessoryButton = [USUIViewTool createButtonWith:@"  " imageName:@"account_cell_assory_down" highImageName:@"account_cell_assory_up" selectedImageName:@"account_cell_assory_up"];
        [accessoryButton addTarget:self action:@selector(accessoryButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        accessoryButton.frame = CGRectMake(0, 0, 11, 10);
        cell.accessoryView = accessoryButton;
    }
    CGFloat height = [_heigthsDic[[self getStr:indexPath.section]]floatValue];
    ((UIButton *)cell.accessoryView).selected = height>0;
    cell.accessoryView.tag = indexPath.section;
    cell.textLabel.text = _dataArrayList[indexPath.section][@"title"];
    return cell;
}

-(CGSize)boundingRectWithSize:(NSString *)content
{
    return [USStringTool boundingRectWithSize:CGSizeMake(kAppWidth-20, 0) content:content fontsize:kCommonFontSize_14];
}
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    NSInteger count = _tipViews.count;
//    if (count>0) {
//        for (NSInteger i= 0; count;) {
//            USCellTipView * tempView = _tipViews[i];
//            tempView.accessoryBt.selected = NO;
//            [tempView removeFromSuperview];
//            [_tipViews removeObjectAtIndex:i];
//            i = 0;
//            count = _tipViews.count;
//        }
//    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 0.00001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    CGFloat height = [_heigthsDic[[self getStr:section]]floatValue];
    if (height>0) {
        return  height;
    }
   return 0.00001;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = _sectionViewsDic[[self getStr:section]];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return  44;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell =  [ _tableView cellForRowAtIndexPath:indexPath];
    [self accessoryButtonClick:(UIButton *)cell.accessoryView];
}
@end
