//
//  USRebackTableViewCell.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/9.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USRebackTableViewCell.h"
#import "USUpDownLabelView.h"
#define kMargin 10
#define kCellheight 100
#define kLeftViewWidth 46.5
#define kCenterWidth (kAppWidth - kMargin*2-kLeftViewWidth)*0.65
#define kRightWidth (kAppWidth - kMargin*2-kLeftViewWidth)*0.35
@interface USRebackTableViewCell()
@property(nonatomic,copy)NSString *normarImageName;
@property(nonatomic,copy)NSString *highImageName;
@property(nonatomic,strong)UIButton *checkBox;
@property(nonatomic,assign)Boolean checked;
@property(nonatomic,assign)Boolean checkClick;
@property(nonatomic,strong) UILabel *blanceLB;
@property(nonatomic,strong) UILabel *dateTipLB;
@property(nonatomic,strong) UILabel *rebackDateTipLB;
@property(nonatomic,strong) UILabel *poundageTipLB;
@property(nonatomic,strong) UILabel *loanTotalLB;
@property(nonatomic,strong) UILabel *loanTotalTipLB;
@property(nonatomic,strong) UILabel *loanDateTipLB;
@property(nonatomic,strong) UILabel *freeTipLB;
@property(nonatomic,strong) UILabel *blanceTipLB;
@property(nonatomic,assign) RebackType type;
//还款状态
@property(nonatomic,strong) UILabel *loanDateBorrowTipLB;
//借款类型
@property(nonatomic,strong) UILabel *loanDateBorrowTypeTipLB;
@end
@implementation USRebackTableViewCell

-(UIButton *)createAccessory{
    self.accessoryType = UITableViewCellAccessoryNone;
    UIButton *accessory = [USUIViewTool createButtonWith:@"" imageName: @"account_cell_next_ico" highImageName:@"account_cell_next_ico"];
    accessory.size = CGSizeMake(15, 15);
    accessory.layer.cornerRadius = accessory.width/2;
    accessory.layer.masksToBounds = YES;
    self.accessoryView = accessory;
    return accessory ;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =  [self initWithStyle:style reuseIdentifier:reuseIdentifier type:NoReback];
    return  self;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(RebackType) rebackType{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self) {
         _type = rebackType;
        switch (rebackType) {
               
            case CurrentReback:
            {
                [self initCurrentRebackCell];
            }
            break;
            case PrePayReback:
            {
                [self initPreRebackCell];
            }
                break;
            case FreeReback:
            {
                [self initFreeRebackCell];
            }
                break;
            case NoReback_1:
            {
                [self initNoRebackCell_1];
            }
                break;
            default:{
                [self initNoRebackCell];
            }
            break;
        }
       
    }
    return  self;
}
-(UIView *)createline:(CGFloat)y width:(CGFloat)width{
    UIView *line = [USUIViewTool createLineView];
    line.frame = CGRectMake(0, y, width, 0.6);
    line.backgroundColor = HYCTColor(200, 200, 200);
    return  line;
}
-(void)initNoRebackCell{
    CGFloat height = 63;
    //[self.contentView setBackgroundColor:[UIColor redColor]];
    self.accessoryType = UITableViewCellAccessoryNone;
    UIButton *accessory = [USUIViewTool createButtonWith:@"" imageName: @"account_cell_next_ico" highImageName:@"account_cell_next_ico"];
    _accessoryBt = accessory;
    accessory.size = CGSizeMake(15, 15);
    accessory.layer.cornerRadius = accessory.width/2;
    accessory.layer.masksToBounds = YES;
    self.accessoryView = accessory;
    CGFloat width = kAppWidth-kMargin*2;
    self.contentView.userInteractionEnabled = YES;
    _leftView = [[UIView alloc]initWithFrame:CGRectMake(kMargin, self.contentView.height/4-accessory.height/2, width*0.15,height)];
    _leftView.userInteractionEnabled = YES;
    [self.contentView addSubview:_leftView];
    _normarImageName = @"account_cell_unchecked_ico";
    _highImageName = @"account_cell_checked_ico";
    UIButton *checkBox = [USUIViewTool createButtonWith:@"    " imageName: _normarImageName highImageName:_highImageName];
    _checkBox = checkBox;
    [_checkBox addTarget:self action:@selector(checkClick:) forControlEvents:UIControlEventTouchUpInside];
    checkBox.frame = CGRectMake(kMargin, height/4, height/2-5, height/2-5);
    checkBox.layer.cornerRadius = checkBox.width/2;
    checkBox.layer.masksToBounds = YES;
    [_leftView addSubview:checkBox];
    _centerView= [[UIView alloc]initWithFrame:CGRectMake(_leftView.x+_leftView.width+5, self.contentView.height/4-accessory.height/2, width*0.75,height)];
    CGRect upDownFrame = CGRectMake(0, _centerView.height/8+5, _centerView.width, _centerView.height);
    _upDownLabelView = [[USUpDownLabelView alloc]initWithFrame:upDownFrame];
    [_upDownLabelView setTextAlignment:NSTextAlignmentLeft];
    [_upDownLabelView.upLabel setFont:[UIFont systemFontOfSize:kCommonFontSize_16]];
    _upDownLabelView.upLabel.y-=8;
    [_upDownLabelView setUpTitle:@"白眉大侠"];
    [_upDownLabelView.downLabel setFont:[UIFont systemFontOfSize:kCommonFontSize_12]];
    _upDownLabelView.downLabel.y = _upDownLabelView.downLabel.y -15;
    [_upDownLabelView setDownTitle:@"白眉大侠"];
    [_centerView addSubview:_upDownLabelView];
    _centerView.userInteractionEnabled = YES;
    [self.contentView addSubview:_centerView];
}
-(void)initNoRebackCell_1{
    self.accessoryType = UITableViewCellAccessoryNone;
    UIButton *accessory = [USUIViewTool createButtonWith:@"还款"];
    _accessoryBt = accessory;
    [_accessoryBt.titleLabel setFont:[UIFont systemFontOfSize:kCommonFontSize_15]];
    [_accessoryBt addTarget:self action:@selector(didClick:) forControlEvents:UIControlEventTouchUpInside];
    accessory.backgroundColor = [UIColor orangeColor];
    accessory.size = CGSizeMake(80, 30);
    accessory.layer.cornerRadius = accessory.height*0.1;
    accessory.layer.masksToBounds = YES;
    self.accessoryView = accessory;
    CGFloat width = kAppWidth-kMargin*2;
    self.contentView.userInteractionEnabled = YES;
    UILabel *blanceLB = [USUIViewTool createUILabelWithTitle:@"" fontSize:kCommonFontSize_32 color:[UIColor blackColor] heigth:kCommonFontSize_32];
    _blanceLB = blanceLB;
    [blanceLB setFont:[UIFont boldSystemFontOfSize:kCommonFontSize_32]];
    blanceLB.frame = CGRectMake(kMargin, kMargin*0.5, width, blanceLB.height);
    [self.contentView addSubview:blanceLB];
    //借款状态
    UILabel *tipborrowLB = [USUIViewTool createUILabelWithTitle:@"借款状态:" fontSize:kCommonFontSize_12 color:HYCTColor(168, 168, 168) heigth:kCommonFontSize_12];
    tipborrowLB.frame = CGRectMake(kMargin, blanceLB.y+blanceLB.height+kMargin*0.5, 55, kCommonFontSize_12);
    [self.contentView addSubview:tipborrowLB];
    
    //绑定状态
    _loanDateBorrowTipLB = [USUIViewTool createUILabelWithTitle:@"待预约" fontSize:kCommonFontSize_12 color:HYCTColor(168, 168, 168) heigth:kCommonFontSize_12];
    _loanDateBorrowTipLB.frame = tipborrowLB.frame;
    _loanDateBorrowTipLB.width = width - tipborrowLB.width;
    _loanDateBorrowTipLB.x = tipborrowLB.width+tipborrowLB.x;
    [self.contentView addSubview:_loanDateBorrowTipLB];
    
    //借款类型
    UILabel *tipborrowTypeLB = [USUIViewTool createUILabelWithTitle:@"借款类型:" fontSize:kCommonFontSize_12 color:HYCTColor(168, 168, 168) heigth:kCommonFontSize_12];
    tipborrowTypeLB.frame = CGRectMake(kMargin, _loanDateBorrowTipLB.y+_loanDateBorrowTipLB.height+kMargin*0.5, 55, kCommonFontSize_12);
    [self.contentView addSubview:tipborrowTypeLB];
    
    //绑定类型
    _loanDateBorrowTypeTipLB = [USUIViewTool createUILabelWithTitle:@"现金借款" fontSize:kCommonFontSize_12 color:HYCTColor(168, 168, 168) heigth:kCommonFontSize_12];
    _loanDateBorrowTypeTipLB.frame = tipborrowTypeLB.frame;
    _loanDateBorrowTypeTipLB.width = width - tipborrowTypeLB.width;
    _loanDateBorrowTypeTipLB.x = tipborrowTypeLB.width+tipborrowTypeLB.x;
    [self.contentView addSubview:_loanDateBorrowTypeTipLB];
    
    
    //日期
    UILabel *tipLB = [USUIViewTool createUILabelWithTitle:@"借款日期:" fontSize:kCommonFontSize_12 color:HYCTColor(168, 168, 168) heigth:kCommonFontSize_12];
    tipLB.frame = CGRectMake(kMargin, tipborrowTypeLB.y+tipborrowTypeLB.height+kMargin*0.5, 55, kCommonFontSize_12);
    [self.contentView addSubview:tipLB];
    //绑定日期
    _loanDateTipLB = [USUIViewTool createUILabelWithTitle:@"" fontSize:kCommonFontSize_12 color:HYCTColor(168, 168, 168) heigth:kCommonFontSize_12];
    _loanDateTipLB.frame = tipLB.frame;
    _loanDateTipLB.width = width - tipLB.width;
    _loanDateTipLB.x = tipLB.width+tipLB.x;
    [self.contentView addSubview:_loanDateTipLB];
    
    
    //
    /*
    tipLB = [USUIViewTool createUILabelWithTitle:@"最后还款日期:" fontSize:kCommonFontSize_12 color:HYCTColor(168, 168, 168) heigth:kCommonFontSize_12];
    tipLB.frame = CGRectMake(kMargin, _loanDateTipLB.y+_loanDateTipLB.height+kMargin*0.5, 78, kCommonFontSize_12);
    [self.contentView addSubview:tipLB];
    _rebackDateTipLB = [USUIViewTool createUILabelWithTitle:@"2015-10-05" fontSize:kCommonFontSize_12 color:HYCTColor(168, 168, 168) heigth:kCommonFontSize_12];
    _rebackDateTipLB.frame = tipLB.frame;
    _rebackDateTipLB.width = width - tipLB.width;
    _rebackDateTipLB.x = tipLB.width+tipLB.x;
    [self.contentView addSubview:_rebackDateTipLB];
     */
}

-(void)initCurrentRebackCell{
    self.contentView.userInteractionEnabled = YES;
    _leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kLeftViewWidth, kCellheight)];
    _leftView.userInteractionEnabled = YES;
    [self.contentView addSubview:_leftView];
    _normarImageName = @"account_cell_unchecked_ico";
    _highImageName = @"account_cell_checked_ico";
    UIButton *checkBox = [USUIViewTool createButtonWith:@"    " imageName: _normarImageName highImageName:_highImageName];
    _checkBox = checkBox;
    [_checkBox addTarget:self action:@selector(checkClick:) forControlEvents:UIControlEventTouchUpInside];
    checkBox.frame = CGRectMake(kMargin*0.5, kCellheight/2.0-(kCellheight/2-kMargin*1.5)*0.75, kCellheight/2-kMargin*1.5, kCellheight/2-kMargin*1.5);
    checkBox.layer.cornerRadius = checkBox.width/2;
    checkBox.layer.masksToBounds = YES;
    [_leftView addSubview:checkBox];
    //
    UIView *centerBigView = [[UIView alloc]initWithFrame:CGRectMake(_leftView.width, 0, kCenterWidth, kCellheight)];
    //centerBigView.backgroundColor = [UIColor redColor];
    UILabel *blanceLB = [USUIViewTool createUILabelWithTitle:@"856.00" fontSize:kCommonFontSize_18 color:[UIColor blackColor] heigth:kCommonFontSize_18];
    _blanceLB = blanceLB;
    blanceLB.frame = CGRectMake(0, kMargin*0.5, centerBigView.width, blanceLB.height);
    [centerBigView addSubview:blanceLB];
    //
    UILabel *dateTipLB = [USUIViewTool createUILabelWithTitle:@"第3期--全六期" fontSize:kCommonFontSize_10 color:HYCTColor(168, 168, 168) heigth:kCommonFontSize_10];
    _dateTipLB = dateTipLB;
    dateTipLB.frame = CGRectMake(0, blanceLB.y+blanceLB.height+kMargin/2.0, centerBigView.width, dateTipLB.height);
    [centerBigView addSubview:dateTipLB];
    //
    UILabel *rebackDateTipLB = [USUIViewTool createUILabelWithTitle:@"本期还款日期:2015-10-05" fontSize:kCommonFontSize_10 color:HYCTColor(168, 168, 168) heigth:kCommonFontSize_10];
    _rebackDateTipLB = rebackDateTipLB;
    rebackDateTipLB.frame = CGRectMake(0, dateTipLB.y+dateTipLB.height+kMargin/2.0, centerBigView.width, rebackDateTipLB.height);
    [centerBigView addSubview:rebackDateTipLB];
    //
    UIView *line = [self createline:(rebackDateTipLB.y+rebackDateTipLB.height+kMargin/2.0) width:rebackDateTipLB.width];
    [centerBigView addSubview:line];
    //
    UILabel *poundageTipLB = [USUIViewTool createUILabelWithTitle:@"本金 800.00 +手续费 56.00" fontSize:kCommonFontSize_10 color:HYCTColor(168, 168, 168) heigth:kCommonFontSize_10];
    _poundageTipLB = poundageTipLB;
    poundageTipLB.frame = CGRectMake(0, line.y+line.height+kMargin/2.0, centerBigView.width, poundageTipLB.height);
    [centerBigView addSubview:poundageTipLB];
    [self.contentView addSubview:centerBigView];
    //
    line = [self createline:kMargin*0.5 width:0.6];
    line.height = kCellheight - kMargin*3;
    line.x = poundageTipLB.width+kMargin+_leftView.x+_leftView.width;
    [self.contentView addSubview:line];
    //
    UIView *rightBigView = [[UIView alloc]initWithFrame:CGRectMake(line.x+kMargin/3.0, 0, kRightWidth, kCellheight)];
    //
    UILabel *loanTotalLB = [USUIViewTool createUILabelWithTitle:@"3000.00" fontSize:kCommonFontSize_18 color:HYCTColor(168, 168, 168) heigth:kCommonFontSize_18];
    _loanTotalLB = loanTotalLB;
    loanTotalLB.frame = CGRectMake(kMargin, kMargin, rightBigView.width, loanTotalLB.height);
    [rightBigView addSubview:loanTotalLB];
    //
    UILabel *loanTotalTipLB = [USUIViewTool createUILabelWithTitle:@"借款总额" fontSize:kCommonFontSize_10 color:HYCTColor(168, 168, 168) heigth:kCommonFontSize_10];
    _loanTotalTipLB = loanTotalTipLB;
    loanTotalTipLB.textAlignment = NSTextAlignmentCenter;
    loanTotalTipLB.frame = CGRectMake(0, loanTotalLB.y+loanTotalLB.height+kMargin, rightBigView.width, loanTotalTipLB.height);
    [rightBigView addSubview:loanTotalTipLB];
    //
    UILabel *loanDateTipLB = [USUIViewTool createUILabelWithTitle:@"2015-09-01 12:06" fontSize:kCommonFontSize_10 color:HYCTColor(168, 168, 168) heigth:kCommonFontSize_10];
    _loanDateTipLB = loanDateTipLB;
    loanDateTipLB.textAlignment = NSTextAlignmentCenter;
    loanDateTipLB.frame = CGRectMake(0, loanTotalTipLB.y+loanTotalTipLB.height+kMargin, rightBigView.width, loanDateTipLB.height);
    //loanTotalTipLB.backgroundColor = [UIColor redColor];
    [rightBigView addSubview:loanDateTipLB];
    [self.contentView addSubview:rightBigView];
}
-(void)initPreRebackCell{
    self.contentView.userInteractionEnabled = YES;
    _leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kLeftViewWidth, kCellheight)];
    _leftView.userInteractionEnabled = YES;
    [self.contentView addSubview:_leftView];
    _normarImageName = @"account_cell_unchecked_ico";
    _highImageName = @"account_cell_checked_ico";
    UIButton *checkBox = [USUIViewTool createButtonWith:@"    " imageName: _normarImageName highImageName:_highImageName];
    _checkBox = checkBox;
    [_checkBox addTarget:self action:@selector(checkClick:) forControlEvents:UIControlEventTouchUpInside];
    checkBox.frame = CGRectMake(kMargin*0.5, kCellheight/2.0-(kCellheight/2-kMargin*1.5)*0.75, kCellheight/2-kMargin*1.5, kCellheight/2-kMargin*1.5);
    checkBox.layer.cornerRadius = checkBox.width/2;
    checkBox.layer.masksToBounds = YES;
    [_leftView addSubview:checkBox];
    //
    UIView *centerBigView = [[UIView alloc]initWithFrame:CGRectMake(_leftView.width, 0, kCenterWidth, kCellheight)];
    //centerBigView.backgroundColor = [UIColor redColor];
    UILabel *blanceLB = [USUIViewTool createUILabelWithTitle:@"2144.00" fontSize:kCommonFontSize_18 color:[UIColor blackColor] heigth:kCommonFontSize_18];
    _blanceLB = blanceLB;
    blanceLB.frame = CGRectMake(0, kMargin, centerBigView.width, blanceLB.height);
    [centerBigView addSubview:blanceLB];
    //
    UILabel *blanceTipLB = [USUIViewTool createUILabelWithTitle:@"剩余未还金额" fontSize:kCommonFontSize_10 color:HYCTColor(168, 168, 168) heigth:kCommonFontSize_10];
    _blanceTipLB = blanceTipLB;
    blanceTipLB.frame = CGRectMake(0, blanceLB.y+blanceLB.height+kMargin/2.0, centerBigView.width, blanceTipLB.height);
    [centerBigView addSubview:blanceTipLB];
    //
    
    UIView *line = [self createline:(blanceTipLB.y+blanceTipLB.height+kMargin) width:blanceTipLB.width];
    [centerBigView addSubview:line];
    //
    UILabel *poundageTipLB = [USUIViewTool createUILabelWithTitle:@"本金 2100.00 +本期手续费 44.00" fontSize:kCommonFontSize_10 color:HYCTColor(168, 168, 168) heigth:kCommonFontSize_10];
    _poundageTipLB = poundageTipLB;
    poundageTipLB.frame = CGRectMake(0, line.y+line.height+kMargin/2.0, centerBigView.width, poundageTipLB.height);
    [centerBigView addSubview:poundageTipLB];
    [self.contentView addSubview:centerBigView];
    //
    line = [self createline:kMargin*0.5 width:0.6];
    line.height = kCellheight - kMargin*3;
    line.x = poundageTipLB.width+kMargin+_leftView.x+_leftView.width;
    [self.contentView addSubview:line];
    //
    UIView *rightBigView = [[UIView alloc]initWithFrame:CGRectMake(line.x+kMargin/3.0, 0, kRightWidth, kCellheight)];
    //rightBigView.backgroundColor = [UIColor redColor];
    //
    UILabel *loanTotalLB = [USUIViewTool createUILabelWithTitle:@"3000.00" fontSize:kCommonFontSize_18 color:HYCTColor(168, 168, 168) heigth:kCommonFontSize_18];
    _loanTotalLB = loanTotalLB;
    loanTotalLB.frame = CGRectMake(kMargin, kMargin, rightBigView.width, loanTotalLB.height);
    [rightBigView addSubview:loanTotalLB];
    //
    UILabel *loanTotalTipLB = [USUIViewTool createUILabelWithTitle:@"借款总额" fontSize:kCommonFontSize_10 color:HYCTColor(168, 168, 168) heigth:kCommonFontSize_10];
    _loanTotalTipLB = loanTotalTipLB;
    loanTotalTipLB.textAlignment = NSTextAlignmentCenter;
    loanTotalTipLB.frame = CGRectMake(0, loanTotalLB.y+loanTotalLB.height+kMargin, rightBigView.width, loanTotalTipLB.height);
    //loanTotalTipLB.backgroundColor = [UIColor redColor];
    [rightBigView addSubview:loanTotalTipLB];
    //
    UILabel *loanDateTipLB = [USUIViewTool createUILabelWithTitle:@"2015-09-01 12:06" fontSize:kCommonFontSize_10 color:HYCTColor(168, 168, 168) heigth:kCommonFontSize_10];
    _loanDateTipLB = loanDateTipLB;
    loanDateTipLB.textAlignment = NSTextAlignmentCenter;
    loanDateTipLB.frame = CGRectMake(0, loanTotalTipLB.y+loanTotalTipLB.height+kMargin, rightBigView.width, loanDateTipLB.height);
    [rightBigView addSubview:loanDateTipLB];
    [self.contentView addSubview:rightBigView];
}
-(void)initFreeRebackCell{
    self.contentView.userInteractionEnabled = YES;
    _leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kLeftViewWidth, kCellheight)];
    _leftView.userInteractionEnabled = YES;
    [self.contentView addSubview:_leftView];
    _normarImageName = @"account_cell_unchecked_ico";
    _highImageName = @"account_cell_checked_ico";
    UIButton *checkBox = [USUIViewTool createButtonWith:@"    " imageName: _normarImageName highImageName:_highImageName];
    _checkBox = checkBox;
    [_checkBox addTarget:self action:@selector(checkClick:) forControlEvents:UIControlEventTouchUpInside];
    checkBox.frame = CGRectMake(kMargin*0.5, kCellheight/2.0-(kCellheight/2-kMargin*1.5)*0.75, kCellheight/2-kMargin*1.5, kCellheight/2-kMargin*1.5);
    checkBox.layer.cornerRadius = checkBox.width/2;
    checkBox.layer.masksToBounds = YES;
    [_leftView addSubview:checkBox];
    //
    UIView *centerBigView = [[UIView alloc]initWithFrame:CGRectMake(_leftView.width, 0, kCenterWidth, kCellheight)];
    //centerBigView.backgroundColor = [UIColor redColor];
    UILabel *blanceLB = [USUIViewTool createUILabelWithTitle:@"3000.00" fontSize:kCommonFontSize_18 color:[UIColor blackColor] heigth:kCommonFontSize_18];
    _blanceLB = blanceLB;
    blanceLB.frame = CGRectMake(0, kMargin, centerBigView.width, blanceLB.height);
    [centerBigView addSubview:blanceLB];
    //
    UILabel *blanceTipLB = [USUIViewTool createUILabelWithTitle:@"全部借款" fontSize:kCommonFontSize_10 color:HYCTColor(168, 168, 168) heigth:kCommonFontSize_10];
    _blanceTipLB = blanceTipLB;
    blanceTipLB.frame = CGRectMake(0, blanceLB.y+blanceLB.height+kMargin/2.0, centerBigView.width, blanceTipLB.height);
    [centerBigView addSubview:blanceTipLB];
    //
    
    UIView *line = [self createline:(blanceTipLB.y+blanceTipLB.height+kMargin) width:blanceTipLB.width];
    [centerBigView addSubview:line];
    //
    UILabel *poundageTipLB = [USUIViewTool createUILabelWithTitle:@"本金 3000.00 +本期手续费 0.00" fontSize:kCommonFontSize_10 color:HYCTColor(168, 168, 168) heigth:kCommonFontSize_10];
    _poundageTipLB = poundageTipLB;
    poundageTipLB.frame = CGRectMake(0, line.y+line.height+kMargin/2.0, centerBigView.width, poundageTipLB.height);
    [centerBigView addSubview:poundageTipLB];
    [self.contentView addSubview:centerBigView];
    //
    line = [self createline:kMargin*0.5 width:0.6];
    line.height = kCellheight - kMargin*3;
    line.x = poundageTipLB.width+kMargin+_leftView.x+_leftView.width;
    [self.contentView addSubview:line];
    //
    UIView *rightBigView = [[UIView alloc]initWithFrame:CGRectMake(line.x+kMargin/3.0, 0, kRightWidth, kCellheight)];
    //rightBigView.backgroundColor = [UIColor redColor];
    //
    UILabel *loanTotalLB = [USUIViewTool createUILabelWithTitle:@"3000.00" fontSize:kCommonFontSize_18 color:HYCTColor(168, 168, 168) heigth:kCommonFontSize_18];
    _loanTotalLB = loanTotalLB;
    loanTotalLB.frame = CGRectMake(kMargin, kMargin, rightBigView.width, loanTotalLB.height);
    [rightBigView addSubview:loanTotalLB];
    //
    UILabel *loanTotalTipLB = [USUIViewTool createUILabelWithTitle:@"借款总额" fontSize:kCommonFontSize_10 color:HYCTColor(168, 168, 168) heigth:kCommonFontSize_10];
    _loanTotalTipLB = loanTotalTipLB;
    loanTotalTipLB.textAlignment = NSTextAlignmentCenter;
    loanTotalTipLB.frame = CGRectMake(0, loanTotalLB.y+loanTotalLB.height+kMargin, rightBigView.width, loanTotalTipLB.height);
    //loanTotalTipLB.backgroundColor = [UIColor redColor];
    [rightBigView addSubview:loanTotalTipLB];
    //
    UILabel *loanDateTipLB = [USUIViewTool createUILabelWithTitle:@"2015-09-01 12:06" fontSize:kCommonFontSize_10 color:HYCTColor(168, 168, 168) heigth:kCommonFontSize_10];
    _loanDateTipLB = loanDateTipLB;
    //loanDateTipLB.textAlignment = NSTextAlignmentCenter;
    loanDateTipLB.frame = CGRectMake(kMargin*0.5, loanTotalTipLB.y+loanTotalTipLB.height+kMargin*0.5, rightBigView.width, loanDateTipLB.height);
    [rightBigView addSubview:loanDateTipLB];
    //
    UILabel *freeTipLB = [USUIViewTool createUILabelWithTitle:@"七日内免息" fontSize:kCommonFontSize_10 color:HYCTColor(168, 168, 168) heigth:kCommonFontSize_10];
    _freeTipLB = freeTipLB;
    freeTipLB.frame = CGRectMake(kMargin*0.5, loanDateTipLB.y+loanDateTipLB.height+kMargin*0.5, rightBigView.width, loanDateTipLB.height);
    [rightBigView addSubview:freeTipLB];
    [self.contentView addSubview:rightBigView];
}
-(void)checkedBox{
   [_checkBox setBackgroundImage:[UIImage imageNamed:_highImageName] forState:UIControlStateNormal];
}
-(void)unCheckedBox{
     [_checkBox setBackgroundImage:[UIImage imageNamed:_normarImageName] forState:UIControlStateNormal];
}
-(void)setDataWithDic:(NSDictionary *)data{

    switch (_type) {
            
        case CurrentReback:
        {
            _blanceLB.text= [USStringTool getCurrencyStr:[data[@"repay_total"] floatValue]];
            _rebackDateTipLB.text = [NSString stringWithFormat:@"本期还款日期:%@",data[@"repaytime_"]];
//            _poundageTipLB.text = [NSString stringWithFormat:@"本金 %@ +手续费%@",
//                                   [USStringTool getCurrencyStr:[data[@"repaymoney"] floatValue]],
//                                   [USStringTool getCurrencyStr:[data[@"repaymoney_rate"] floatValue]]];
             _poundageTipLB.text = data[@"repay_info"];
            _loanTotalLB.text = data[@"total_money"];
            _loanDateTipLB.text = data[@"fangkuan_time"];
            _dateTipLB.text = data[@"stages_info"];
        }
            break;
        case PrePayReback:
        {
            _blanceLB.text= [USStringTool getCurrencyStr:[data[@"repay_total"] floatValue]];
            _poundageTipLB.text = data[@"repay_info"];
//            _poundageTipLB.text = [NSString stringWithFormat:@"本金 %@ +手续费%@",
//                              [USStringTool getCurrencyStr:[data[@"repaymoney"] floatValue]],
//                              [USStringTool getCurrencyStr:[data[@"repaymoney_rate"] floatValue]]];
            _loanTotalLB.text = data[@"total_money"];
            _loanDateTipLB.text = data[@"fangkuan_time"];
        }
            break;
        case FreeReback:
        {
            _blanceLB.text= [USStringTool getCurrencyStr:[data[@"total_money"] floatValue]];
//            _poundageTipLB.text = [NSString stringWithFormat:@"本金 %@ +手续费%@",
//                                   [USStringTool getCurrencyStr:[data[@"repaymoney"] floatValue]],
//                                   [USStringTool getCurrencyStr:[data[@"repaymoney_rate"] floatValue]]];
            _poundageTipLB.text = data[@"repay_info"];
            _loanTotalLB.text = [USStringTool getCurrencyStr:[data[@"total_money"] floatValue]];
            _loanDateTipLB.text = data[@"fangkuan_time"];
        }
            break;
        case NoReback_1:
        {
            _blanceLB.text= [USStringTool getCurrencyStr:[data[@"sum_total"] floatValue]];
           _loanDateTipLB.text = data[@"fangkuan_time"];
           _rebackDateTipLB.text = data[@"limit_time"];
            //状态
            _loanDateBorrowTipLB.text = data[@"type_lable"];
            //借款类型
            _loanDateBorrowTypeTipLB.text = data[@"borrow_type_label"];
            
            if (![[data[@"type"] stringValue] isEqualToString:@"3"]) {
                _accessoryBt.enabled = NO;
                _accessoryBt.backgroundColor = HYCTColor(148, 148, 148);
            }
            
        }
            break;
        default:{
           
        }
            break;
    }
}
/*
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //[self.contentView setBackgroundColor:[UIColor redColor]];
        self.accessoryType = UITableViewCellAccessoryNone;
        UIButton *accessory = [USUIViewTool createButtonWith:@"" imageName: @"account_cell_next_ico" highImageName:@"account_cell_next_ico"];
        accessory.size = CGSizeMake(15, 15);
        accessory.layer.cornerRadius = accessory.width/2;
        accessory.layer.masksToBounds = YES;
        self.accessoryView = accessory;
        CGFloat width = kAppWidth-kCellMargin*2;
        self.contentView.userInteractionEnabled = YES;
        _leftView = [[UIView alloc]initWithFrame:CGRectMake(kCellMargin, self.contentView.height/4-accessory.height/2, width*0.15,kCellheight)];
        _leftView.userInteractionEnabled = YES;
        [self.contentView addSubview:_leftView];
        _normarImageName = @"account_cell_unchecked_ico";
        _highImageName = @"account_cell_checked_ico";
        UIButton *checkBox = [USUIViewTool createButtonWith:@"    " imageName: _normarImageName highImageName:_highImageName];
        _checkBox = checkBox;
        [_checkBox addTarget:self action:@selector(checkClick:) forControlEvents:UIControlEventTouchUpInside];
        checkBox.frame = CGRectMake(kCellMargin, kCellheight/4, kCellheight/2-5, kCellheight/2-5);
        checkBox.layer.cornerRadius = checkBox.width/2;
        checkBox.layer.masksToBounds = YES;
        [_leftView addSubview:checkBox];
        _centerView= [[UIView alloc]initWithFrame:CGRectMake(_leftView.x+_leftView.width+5, self.contentView.height/4-accessory.height/2, width*0.75,kCellheight)];
        CGRect upDownFrame = CGRectMake(0, _centerView.height/8+5, _centerView.width, _centerView.height);
        _upDownLabelView = [[USUpDownLabelView alloc]initWithFrame:upDownFrame];
        [_upDownLabelView setTextAlignment:NSTextAlignmentLeft];
        [_upDownLabelView.upLabel setFont:[UIFont systemFontOfSize:14]];
        _upDownLabelView.upLabel.y-=5;
        [_upDownLabelView setUpTitle:@"白眉大侠"];
        [_upDownLabelView.downLabel setFont:[UIFont systemFontOfSize:10]];
        _upDownLabelView.downLabel.y = _upDownLabelView.downLabel.y -15;
        [_upDownLabelView setDownTitle:@"白眉大侠"];
        [_centerView addSubview:_upDownLabelView];
        _centerView.userInteractionEnabled = YES;
        [self.contentView addSubview:_centerView];
        self.selected = NO;
    }
    return  self;
}*/
- (void)updateCheckBox:(UIButton *)checkBox {
    if (_checked) {
        [checkBox setBackgroundImage:[UIImage imageNamed:_highImageName] forState:UIControlStateNormal];
    }else{
        [checkBox setBackgroundImage:[UIImage imageNamed:_normarImageName] forState:UIControlStateNormal];
    }
    if ([self.delegate respondsToSelector:@selector(didSelectButton:flag:)]) {
        [self.delegate didSelectButton:checkBox.tag flag:_checked];
    }
}

-(void)checkClick:(UIButton *)checkBox{
    _checked = !_checked;
    _checkClick = YES;
    [self setSelected:_checked animated:YES];
    [self updateCheckBox:_checkBox];

}
-(void)setCheckButtonTag:(NSInteger)checkButtonTag{
    _checkBox.tag = checkButtonTag;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    /*_checkClick = selected;
    if (_checkClick) {
        _checked = selected;
       [self updateCheckBox:_checkBox];
         _checkClick = !selected;
    }
     _checkClick = NO;
     */
    //[self didClick:_accessoryBt];
}
-(void)updateFrame:(CGRect)frame{
    CGFloat width = kAppWidth-kMargin*2;
    _leftView.frame = frame;
    _centerView.frame = CGRectMake(_leftView.x+_leftView.width+5, self.contentView.height/4-self.accessoryView.height/2, width*0.75,kCellheight);
}
-(void)didClick:(UIButton *)sender{
    if (_delegate!=nil) {
        [_delegate didSelectButton:sender.tag flag:YES];
    }
}
@end
