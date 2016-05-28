//
//  USCircleListContentView.h
//  大学生分期
//
//  Created by HeXianShan on 16/1/4.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "USCircleImageView.h"
#import "USImageButton.h"
#import <Foundation/Foundation.h>
@interface USCircleListTableCellView :UITableViewCell
@property(nonatomic,strong)NSDictionary *dataDic;
@property(nonatomic,assign)CGFloat dyHeight;
@property(nonatomic,strong)UIImageView *headerImageView;
@property(nonatomic,strong)UILabel *nameLB;
@property(nonatomic,strong)UILabel *contentLB;
@property(nonatomic,strong)UILabel *timeLB;
@property(nonatomic,strong)USCircleImageView *imagesView;
@property(nonatomic,strong)USImageButton *surpportBt;
@property(nonatomic,strong)USImageButton *commentBt;
@property(nonatomic,strong)USAccount *account;
//赞的行
@property(nonatomic,strong)UIView *zangListView;
//赞的背景
@property(nonatomic,strong)UIView *zangLabelBg ;
//赞文本
@property(nonatomic,strong)UILabel *zangLabel ;
//分割线
@property(nonatomic,strong)UIView *line ;
@property(nonatomic,strong)UITableView *tableView;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier dataDic:(NSDictionary *)dataDic customerId:(NSString *)coustomerId tableview:(UITableView *)tablview navController:(UINavigationController *)navController;
@end
