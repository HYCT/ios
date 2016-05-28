//
//  USExchangeDetailViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/12.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USExchangeDetailViewController.h"
#import "USCellTipView.h"
#define kButtonMargin 20
@interface USExchangeDetailViewController()
@property(nonatomic,strong)NSMutableArray *tipViews;
@end
@implementation USExchangeDetailViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"日息交易明细";
    self.navigationController.navigationBar.translucent= NO;
    [self.view addSubview:[self createViewButtons]];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.y = 30;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.tableView];
    
}
-(UIView *)createViewButtons{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kAppWidth, 30)];
    UIButton * inorOutBt = [self createButtonWithTitle:@"买入取出"];
    UIView *line1 = [USUIViewTool createLineView];
    line1.width =1;
    line1.height = inorOutBt.height*0.6;
    line1.y = inorOutBt.height*0.2;
    line1.x = inorOutBt.x+inorOutBt.width+kButtonMargin;
    [bgView addSubview:inorOutBt];
    [bgView addSubview:line1];
    //
    UIButton * allProductBt = [self createButtonWithTitle:@"全部产品"];
    allProductBt.x = line1.x;
    UIView *line2 = [USUIViewTool createLineView];
    line2.width =1;
    line2.height = allProductBt.height*0.6;
    line2.y = allProductBt.height*0.2;
    line2.x = allProductBt.x+allProductBt.width+kButtonMargin;
    [bgView addSubview:line2];
    [bgView addSubview:allProductBt];
    //
    UIButton * allMonthButton = [self createButtonWithTitle:@"所有月份"];
    allMonthButton.x = line2.x;
    [bgView addSubview:allMonthButton];
    [bgView setBackgroundColor:[UIColor whiteColor]];
    return bgView;
}
-(UIButton *)createButtonWithTitle:(NSString *)title{
    CGFloat width = (kAppWidth-20-kButtonMargin*3)/3;
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *upImage = [[UIImage imageNamed:@"account_cell_assory_up"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *downImage = [[UIImage imageNamed:@"account_cell_assory_down"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [button setImage:downImage forState:UIControlStateNormal];
    [button setImage:upImage  forState:UIControlStateHighlighted];
    [button setImage:upImage forState:UIControlStateSelected];
    [button setTitle:@"买入取出"forState:UIControlStateNormal];
    [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [button.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [button setTitleColor:HYCTColor(165, 165, 165) forState:UIControlStateNormal];
    [button setTitleColor:HYCTColor(165, 165, 165) forState:UIControlStateSelected];
    [button setTitleColor:HYCTColor(165, 165, 165) forState:UIControlStateHighlighted];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateHighlighted];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, width*0.9, 0, 0);
    button.frame = CGRectMake(0, 0, width, 30);
    return button;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"reuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    }
    cell.textLabel.textColor = HYCTColor(168, 168, 168);
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    UIButton *accessoryButton = [USUIViewTool createButtonWith:@"  " imageName:@"account_cell_assory_down" highImageName:@"account_cell_assory_up" selectedImageName:@"account_cell_assory_up"];
    [accessoryButton addTarget:self action:@selector(accessoryButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    accessoryButton.frame = CGRectMake(0, 0, 11, 10);
    cell.accessoryView = accessoryButton;
    accessoryButton.tag = indexPath.row;
    if (indexPath.row < 3) {
        cell.imageView.image = [UIImage imageNamed:@"account_cell_getout_bg"];
        cell.detailTextLabel.textColor = HYCTColor(71, 198, 187);
             cell.detailTextLabel.text = @"+66.77";
        cell.textLabel.text = @"2015-01-31";
        
    }else{
        accessoryButton.tag = -1*indexPath.row;
        cell.imageView.image = [UIImage imageNamed:@"account_cell_getIn_bg"];
        cell.detailTextLabel.textColor = HYCTColor(255, 140, 1);
        cell.textLabel.text = @"2015-01-31";
        cell.detailTextLabel.text = @"+2,000.00";
        
    }
    
    return cell;
}
-(void)accessoryButtonClick:(UIButton *)accessoryButton{
    accessoryButton.selected = !accessoryButton.selected;
    //
    NSInteger index = accessoryButton.tag>0?accessoryButton.tag:-1*accessoryButton.tag;
    NSIndexPath *indexPah = [NSIndexPath indexPathForRow:index inSection:0];
    
    if (accessoryButton.selected) {
        CGRect rectInTableView = [_tableView rectForRowAtIndexPath:indexPah];
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
        USCellTipView *tipView = nil;
        if (accessoryButton.tag>0) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:@"建设银行(尾号5434)" forKey:@"到账方式："];
            [dic setObject:@"2015-02-01 10:20:11" forKey:@"到账时间："];
             [dic setObject:@"2015-02-01 10:20:11" forKey:@"取出时间："];
            tipView = [[USCellTipView alloc]initWithFrame:frame dic:dic];
        }else{
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:@"日息宝" forKey:@"买入产品："];
            [dic setObject:@"2015-02-01 10:20:11" forKey:@"买入时间："];
            [dic setObject:@"建设银行(尾号5434)" forKey:@"买入方式："];
            tipView = [[USCellTipView alloc]initWithFrame:frame dic:dic];
        }
        
        tipView.tag = accessoryButton.tag;
        tipView.accessoryBt = accessoryButton;
        [_tipViews addObject:tipView];
        [self.view addSubview:tipView];
    }else{
        for (UIView *tempView in _tipViews) {
            if(tempView.tag == accessoryButton.tag){
                [tempView removeFromSuperview];
                [_tipViews removeObject:tempView];
                return;
            }
        }
    }
    
}
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    
}
- (void)updateTipViews {
    NSInteger count = _tipViews.count;
    if (count>0) {
        for (NSInteger i= 0; count;) {
            USCellTipView * tempView = _tipViews[i];
            tempView.accessoryBt.selected = NO;
            [tempView removeFromSuperview];
            [_tipViews removeObjectAtIndex:i];
            i = 0;
            count = _tipViews.count;
        }
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self updateTipViews];
    
    
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
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return  130;
//}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
@end