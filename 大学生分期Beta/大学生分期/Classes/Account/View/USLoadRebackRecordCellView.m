//
//  USMyLoadRebackRecordCellView.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/25.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USLoadRebackRecordCellView.h"
#define kMargin 10
#define kcommonSize 12
@interface USLoadRebackRecordCellView()
@property(nonatomic,strong)UILabel *nameTipLB;
@property(nonatomic,strong)UILabel *rebackDateLB;
@property(nonatomic,strong)UILabel *rebackMsgLB;
@property(nonatomic,strong)UILabel *rebackCountLB;
///
@property(nonatomic,strong)UILabel *loanDateLB;
@property(nonatomic,strong)UILabel *loanDateCountLB;
@property(nonatomic,strong)UILabel *loanCountLB;

//状态
@property(nonatomic,strong)UILabel *typeLB;
@property(nonatomic,strong)UILabel *typebindLB;
//类型
@property(nonatomic,strong)UILabel *borrowtypeLB;
@property(nonatomic,strong)UILabel *borrowtypebindLB;

@end
@implementation USLoadRebackRecordCellView

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    return  self;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(enum LoanRebackrRecordCellType)type{
    self = [self initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _cellType = type;
        if (type == LoanType) {
            [self initLoadCellView];
        }else{
            [self initRebackCellView];
        }
    }
    return self;
}
-(void)initLoadCellView{
    UIColor *commonColor = HYCTColor(168, 168, 168);
    _nameTipLB = [self createUILabelWithTitle:@"借款金额" fontSize:kCommonFontSize_15 color:commonColor heigth:kCommonFontSize_15];
    _loanCountLB = [self createUILabelWithTitle:@"-3,000.00" fontSize:kCommonFontSize_30 color:[UIColor blackColor] heigth:kCommonFontSize_30];
    _loanCountLB.y-=5;
    _loanCountLB.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_nameTipLB];
    [self.contentView addSubview:_loanCountLB];
    //
    /*_nameTipLB = [self createUILabelWithTitle:@"分期情况" fontSize:kCommonFontSize_15 color:commonColor heigth:kCommonFontSize_15];
    _nameTipLB.y = _loanCountLB.y+_loanCountLB.height+10;
    _loanDateCountLB = [self createUILabelWithTitle:@"3期" fontSize:kCommonFontSize_15 color:commonColor heigth:kCommonFontSize_15];
    _loanDateCountLB.y = _loanCountLB.y+_loanCountLB.height+10;
    _loanDateCountLB.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_nameTipLB];
    [self.contentView addSubview:_loanDateCountLB];
     */
    //
    //状态
    _typeLB= [self createUILabelWithTitle:@"借款状态" fontSize:kCommonFontSize_15 color:commonColor heigth:kCommonFontSize_15];
    //_nameTipLB.y = _loanDateCountLB.y+_loanDateCountLB.height+10;
    _typeLB.y = _loanCountLB.y+_loanCountLB.height+10;
    //状态绑定
    _typebindLB = [self createUILabelWithTitle:@"待预约" fontSize:kCommonFontSize_15 color:commonColor heigth:kCommonFontSize_15];
    _typebindLB.y = _loanCountLB.y+_loanCountLB.height+10;
    _typebindLB.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_typeLB];
    [self.contentView addSubview:_typebindLB];
    
    //借款类型
    _borrowtypeLB= [self createUILabelWithTitle:@"借款类型" fontSize:kCommonFontSize_15 color:commonColor heigth:kCommonFontSize_15];
    //_nameTipLB.y = _loanDateCountLB.y+_loanDateCountLB.height+10;
    _borrowtypeLB.y = _typeLB.y+_typeLB.height+10;
    //借款类型绑定
    _borrowtypebindLB = [self createUILabelWithTitle:@"现金借款" fontSize:kCommonFontSize_15 color:commonColor heigth:kCommonFontSize_15];
    _borrowtypebindLB.y = _typeLB.y+_typeLB.height+10;
    _borrowtypebindLB.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_borrowtypeLB];
    [self.contentView addSubview:_borrowtypebindLB];
    
    
    //
    _nameTipLB = [self createUILabelWithTitle:@"借款日期" fontSize:kCommonFontSize_15 color:commonColor heigth:kCommonFontSize_15];
    //_nameTipLB.y = _loanDateCountLB.y+_loanDateCountLB.height+10;
    _nameTipLB.y = _borrowtypeLB.y+_borrowtypeLB.height+10;
    _loanDateLB = [self createUILabelWithTitle:@"2015-07-13 15:30" fontSize:kCommonFontSize_15 color:commonColor heigth:kCommonFontSize_15];
    //_loanDateLB.y = _loanDateCountLB.y+_loanDateCountLB.height+10;
    _loanDateLB.y = _borrowtypeLB.y+_borrowtypeLB.height+10;
    _loanDateLB.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_nameTipLB];
    [self.contentView addSubview:_loanDateLB];
    
}
-(void)initRebackCellView{
    self.contentView.width = kAppWidth;
    _nameTipLB = [self createUILabelWithTitle:@"汪卡还款" fontSize:kCommonFontSize_15 color:[UIColor blackColor] heigth:kCommonFontSize_15];
    _rebackDateLB.y = 15;
    _rebackCountLB = [self createUILabelWithTitle:@"" fontSize:kCommonFontSize_18 color:[UIColor blackColor] heigth:kCommonFontSize_15];
    _rebackCountLB.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_nameTipLB];
    [self.contentView addSubview:_rebackCountLB];
    _rebackDateLB = [self createUILabelWithTitle:@"" fontSize:kCommonFontSize_15 color:HYCTColor(168, 168, 168) heigth:kCommonFontSize_15];
    _rebackDateLB.y = _nameTipLB.y+_nameTipLB.height+10;
    _rebackMsgLB= [self createUILabelWithTitle:@"还款成功" fontSize:kCommonFontSize_15 color:HYCTColor(168, 168, 168) heigth:kCommonFontSize_15];
     _rebackMsgLB.textAlignment = NSTextAlignmentRight;
    _rebackMsgLB.y = _rebackDateLB.y;
    [self.contentView addSubview:_rebackDateLB];
    [self.contentView addSubview:_rebackMsgLB];
    //UIView *line = [self createline:_rebackMsgLB.y+_rebackMsgLB.height+kMargin];
    //[self.contentView addSubview:line];
}
-(UIView *)createline:(CGFloat)y{
    UIView *line = [USUIViewTool createLineView];
    line.frame = CGRectMake(kMargin, y, kAppWidth-kMargin*2, 1);
    line.backgroundColor = HYCTColor(200, 200, 200);
    return  line;
}
-(UILabel*)createUILabelWithTitle:(NSString *)title fontSize:(CGFloat)size color:(UIColor *)color heigth:(CGFloat)heigth{
    UILabel *label = [USUIViewTool createUILabelWithTitle:title fontSize:size color:color heigth:heigth];
    label.frame = CGRectMake(kMargin, kMargin, kAppWidth-kMargin*2, heigth);
    return  label;
}

-(void)setDataWithDic:(NSDictionary *)dataDic{
    if (_cellType == LoanType ) {
      _loanCountLB.text = [USStringTool getCurrencyStr:[dataDic[@"agreemoney_"] floatValue]];
      _loanDateCountLB.text = dataDic[@"month_"];
      _loanDateLB.text = dataDic[@"fangkuan_time_"];
      _typebindLB.text=dataDic[@"type_lable"];
     _borrowtypebindLB.text=dataDic[@"borrow_type_label"] ;
    }else{
        _rebackDateLB.text = dataDic[@"repaytime_"];
        _rebackCountLB.text =  dataDic[@"repaymoney_"];
    }
}
@end
