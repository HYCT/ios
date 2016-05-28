//
//  USPerDateRateIncomeViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/11.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USPerDateRateIncomeViewController.h"
#import "USCellTipView.h"
@interface USPerDateRateIncomeViewController()
@property(nonatomic,strong)NSMutableArray *tipViews;
@end
@implementation USPerDateRateIncomeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"日息收入明细";
    self.navigationController.navigationBar.translucent= NO;
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    //self.tableView.y =_accountView.y+_accountView.height + 15;
    self.tableView.dataSource = self;
   // self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.tableView];
    
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
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    cell.detailTextLabel.textColor = HYCTColor(168, 168, 168);
    cell.detailTextLabel.textColor = HYCTColor(168, 168, 168);
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    UIImage *icoImage =  [UIImage imageNamed:@"account_perrate_in_bg"];
    cell.imageView.image = icoImage;
    cell.imageView.size = icoImage.size;
    if (indexPath.row == 0) {
        cell.imageView.image = [UIImage imageNamed:@"account_total_perrate_in_bg"];
        cell.detailTextLabel.textColor = [UIColor orangeColor];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.text = @"+66.77";
        cell.textLabel.text = @"累计收益(元)";
       
    }else{
       cell.textLabel.text = @"2015-01-31";
       cell.detailTextLabel.text = @"日息宝收入 +1.11";
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:cell.detailTextLabel.text];
        [str addAttribute:NSForegroundColorAttributeName value:HYCTColor(187, 187, 187) range:NSMakeRange(0,5)];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(6,cell.detailTextLabel.text.length -6)];
        cell.detailTextLabel.attributedText = str;
        UIButton *accessoryButton = [USUIViewTool createButtonWith:@"  " imageName:@"account_cell_assory_down" highImageName:@"account_cell_assory_up" selectedImageName:@"account_cell_assory_up"];
        [accessoryButton addTarget:self action:@selector(accessoryButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        accessoryButton.frame = CGRectMake(0, 0, 11, 10);
        cell.accessoryView = accessoryButton;
        accessoryButton.tag = indexPath.row;
    }
    
    return cell;
}
-(void)accessoryButtonClick:(UIButton *)accessoryButton{
    accessoryButton.selected = !accessoryButton.selected;
    //
    NSIndexPath *indexPah = [NSIndexPath indexPathForRow:accessoryButton.tag inSection:0];
   
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
        USCellTipView *tipView = [[USCellTipView alloc]initWithFrame:frame ];
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
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
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
