//
//  USSnatchDetailViewController.m
//  大学生分期
//
//  Created by HeXianShan on 16/1/6.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import "USSnatchDetailViewController.h"
#import "USSnatchDetailTopView.h"
#import "USRecordTableViewController.h"
#define kMargin 10
@interface USSnatchDetailViewController ()
@property(nonatomic,strong)USSnatchDetailTopView *topView;
@property(nonatomic,strong)UIImage *upArrow;
@property(nonatomic,strong)UIImage *downArrow;
@property(nonatomic,strong)NSMutableDictionary *buttonsDic;
@property(nonatomic,strong)NSMutableDictionary *viewsDic;
@property(nonatomic,strong)UIView *detailButtonView;
@property(nonatomic,strong)UIView *jionListButtonView;
@property(nonatomic,strong)NSMutableArray *buttons;
@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,strong)UIWebView *descTextView;
@property(nonatomic,strong)NSString *key;
@property(nonatomic,strong)USAccount *account;
@end

@implementation USSnatchDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent= NO;
    _account = [USUserService accountStatic];
    self.title = @"宝贝详情";
    _downArrow = [UIImage imageNamed:@"account_cell_assory_down"];
    _upArrow = [UIImage imageNamed:@"account_cell_assory_up"];
    _buttonsDic = [ NSMutableDictionary dictionary];
    _viewsDic = [ NSMutableDictionary dictionary];
    _buttons = [NSMutableArray array];
    [self initTopView];
    _detailButtonView = [self createButtonViews:@"宝贝详情" action:@selector(detail:)];
    _detailButtonView.y = _topView.y+_topView.height+5;
    [self.view addSubview:_detailButtonView];
    _jionListButtonView = [self createButtonViews:@"参与记录" action:@selector(joinList:)];
    _jionListButtonView.y = _detailButtonView.y+_detailButtonView.height+kMargin;
    [self.view addSubview:_jionListButtonView];
    UIWebView *descTextView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kAppWidth, 100)];
    _descTextView = descTextView;
    [self initBottomView];
    [self loadData];
}
//
-(void)loadData{
    [USWebTool POST:@"indianaJohnsClient/recorderDetail.action" showMsg:@"" paramDic:@{@"id":_snatchId} success:^(NSDictionary *dataDic) {
        [_topView setDataDic:dataDic[@"data"]];
        //_descTextView.text = dataDic[@"data"][@"content"];
        //_descTextView.text = @"11111";
        //_descTextView.backgroundColor = [UIColor redColor];
        //[NSURL URLWithString:HYWebDataPath(@"")]
        [_descTextView loadHTMLString:dataDic[@"data"][@"content"] baseURL:nil];
    } failure:^(id data) {
        
    }];
}
//
-(void)initTopView{
    _topView = [[USSnatchDetailTopView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_topView];
}

-(void)initBottomView{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, kAppHeight-95, kAppWidth, 90)];
    bgView.layer.borderColor = [HYCTColor(230, 230, 230)CGColor];
    bgView.layer.borderWidth = 0.5;
    bgView.backgroundColor = [UIColor whiteColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(15, 10, kAppWidth-30, 30);
    button.backgroundColor = [UIColor orangeColor];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button setTitle:@"立即参与" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(join) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = button.height*0.5;
    [bgView addSubview:button];
    [self.view addSubview:bgView];
    _bottomView = bgView;
}
-(void)join{
    NSMutableString *urlStr = [NSMutableString stringWithString:HYWebDataPath(@"huichaoPayController/indianaJonesPay.action")];
    [urlStr appendString:[NSString stringWithFormat:@"?indiana_id=%@&",_snatchId]];
    [urlStr appendString:[NSString stringWithFormat:@"customer_id=%@",_account.id]];
    NSString *ulr = (NSString *)urlStr;
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:ulr]];
    if (_key!=nil) {
        UIView *view = _viewsDic[_key];
        [view removeFromSuperview];
        [_viewsDic removeObjectForKey:_key];
    }
    
    
}
-(UIView *)createButtonViews:(NSString *)title action:(SEL)action{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kAppWidth, 30)];
    bgView.userInteractionEnabled = YES;
    bgView.backgroundColor = [UIColor whiteColor];
    UILabel *label = [USUIViewTool createUILabelWithTitle:title fontSize:kCommonFontSize_15 color:[UIColor blackColor] heigth:44];
    label.textAlignment = NSTextAlignmentLeft;
    label.y = -5;
    [bgView addSubview:label];
    UIImageView *arrowView = [[UIImageView alloc]initWithImage:_downArrow];
    
    arrowView.frame = CGRectMake(kAppWidth-20, 5, 15, 15);
    [bgView addSubview:arrowView];
    UIButton *topBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buttons addObject:topBt];
    topBt.frame = bgView.bounds;
    [bgView addSubview:topBt];
    [_buttonsDic setObject:arrowView forKey:[topBt description]];
    [topBt addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return bgView;
}

-(void)detail:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    [self updateButtonArrow:sender];
    [self updateArrowImag:sender];
    [self updateViews];
    UIView *detailView = _viewsDic[[sender description]];
    if (detailView==nil) {
        detailView = [[UIView alloc]initWithFrame:CGRectMake(0, _detailButtonView.y+_detailButtonView.height, kAppWidth, 100)];
        [_viewsDic setObject:detailView forKey:[sender description]];
        detailView.backgroundColor = [UIColor redColor];
        //_descTextView = descTextView;
        //_descTextView.editable = NO;
        [detailView addSubview:_descTextView];
        [self.view addSubview:detailView];
    }
    if (sender.selected) {
        _jionListButtonView.y = _detailButtonView.y+_detailButtonView.height+5+detailView.height;
        detailView.hidden = NO;
        
    }else{
        _jionListButtonView.y = _detailButtonView.y+_detailButtonView.height+5;
        detailView.hidden = YES;
    }
    [self.view addSubview:_bottomView];
}

-(void)joinList:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    [self updateButtonArrow:sender];
    [self updateArrowImag:sender];
    UIView *recordView = _viewsDic[[sender description]];
    [self updateViews];
    if (recordView==nil) {
        USRecordTableViewController *recordVC = [[USRecordTableViewController alloc]init];
        recordVC.snatchId = _snatchId;
        [self addChildViewController:recordVC];
        recordVC.view.frame = CGRectMake(0, _jionListButtonView.y+_jionListButtonView.height, kAppWidth, kAppHeight- _jionListButtonView.y-_jionListButtonView.height);
        recordVC.view.backgroundColor = [UIColor clearColor];
        _key = [sender description];
        [_viewsDic setObject:recordVC.view forKey:_key];
        recordVC.tableView.frame = recordVC.view.bounds;
        [self.view addSubview:recordVC.view];
        [self.view addSubview:_jionListButtonView];
    }
    if (sender.selected) {
        _jionListButtonView.y = _detailButtonView.y+_detailButtonView.height+5;
        recordView.y = _jionListButtonView.y+_jionListButtonView.height;
        recordView.hidden = NO;
    }else{
        _jionListButtonView.y = _detailButtonView.y+_detailButtonView.height+5;
        recordView.y = _jionListButtonView.y+_jionListButtonView.height;
        recordView.hidden = YES;
    }
    [self.view addSubview:_bottomView];
}

-(void)updateViews{
    [_viewsDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        UIView *view = obj;
        view.hidden = YES;
    }];
}
-(void)updateButtonArrow:(UIButton *)sender{
    [_buttons enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *bt = obj;
        if (bt!=sender&&bt.selected) {
            bt.selected = NO;
            [self updateArrowImag:bt];
        }
    }];
    
}
-(void)updateArrowImag:(UIButton *)sender{
    UIImageView *arrowImgView = _buttonsDic[[sender description]];
    if (sender.selected) {
        arrowImgView.image = _upArrow;
    }else{
        arrowImgView.image = _downArrow;
    }
}
@end
