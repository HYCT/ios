//
//  NewCellView.m
//  红云创投
//
//  Created by HeXianShan on 15/8/25.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USBlackNameCell.h"
#define kCellMargin 10
#define kTitleHeight 15
#define kTitleFontSize 15
#define kLineViewMargin 5
#define kLineHeight 1
#define kCellHeight 220
#define kCellWidth [[UIScreen mainScreen]applicationFrame].size.width -kCellMargin*2
@interface  USBlackNameCell()

@property(nonatomic,strong)UILabel *newsTitleLabel;

@property(nonatomic,strong)UILabel *newsContentLabel;

@property(nonatomic,strong)UILabel *createTimeLabel;
@property(nonatomic,strong)UIView *lineView;
@end
@implementation USBlackNameCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat cellWidth = kCellWidth;
        [self.contentView setFrame:CGRectMake(kCellMargin, 0, cellWidth,kCellHeight)];
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(kCellMargin, 0, kAppWidth-2*kCellMargin, kCellHeight)];
        [bgView setBackgroundColor:[UIColor whiteColor]];
        //
        UIView *headerView = [self createHeadertView];
        [bgView addSubview:headerView];
       
        //
        UIView *lineView = [self createLineWithWidth:cellWidth-kCellMargin];
        lineView.y = headerView.y+headerView.height;
        [bgView addSubview:lineView];
        //
       // UIView *blanceView = [self createBlanceView:0 y:lineView.y];
        //[bgView addSubview:blanceView];
        //
        //lineView = [self createLineWithWidth:cellWidth-kCellMargin];
       // lineView.y = blanceView.y+blanceView.height;
        //[bgView addSubview:lineView];
        //
        UIView *overView = [self createOverView:0 y:lineView.y+5];
        [bgView addSubview:overView];
        overView.hidden = YES;
        UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(0, overView.y+overView.height, kCellWidth, 100)];
        _textView = textView;
       // textView.hidden = YES;
        textView.font = [UIFont systemFontOfSize:kCommonFontSize_12];
        textView.userInteractionEnabled = NO;
        //textView.y-=20;
        textView.textColor = HYCTColor(110, 110, 110);
        textView.text = @"借款人拒不还款，逾期超过30日，其行为已构成严重逾期，根据校园通违约公示相关规定，向校园通所有用户公布借款人个人信息，并将协助担保人和尽调人启动法律程序建造追讨。催收进度：借款人及其家人失陪，联系通通讯录中联系人，无有效线索。通过失信被执行查询，近日";
        [bgView addSubview:textView];
        //
        //lineView = [self createLineWithWidth:kAppWidth];
        //lineView.height = 10;
        //lineView.x = 0;
        //lineView.y = textView.y+textView.height;
        //[self.contentView addSubview:lineView];
        [self.contentView addSubview:bgView];
        
    }
    return self;
}
-(UIView *)createOverView:(CGFloat)x y:(CGFloat)y{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(x, y, kAppWidth-2*kCellMargin, 15)];
    UILabel *overAmount = [self createDatesLable:@"逾期金额:3,125.00元" tag:5];
    overAmount.x = kCellMargin;
    [bgView addSubview:overAmount];
    UILabel *overDate = [self createDatesLable:@"逾期时长:108天" tag:5];
    overDate.x = overAmount.x+overAmount.width*0.8;
    [bgView addSubview:overDate];
    return bgView;
}
-( UILabel *)createDatesLable:(NSString *)title tag:(NSInteger )tag{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kAppWidth*0.6, 15)];
    [label setFont:[UIFont systemFontOfSize:kCommonFontSize_10]];
    label.textAlignment = NSTextAlignmentLeft;
    [label setTextColor:[UIColor grayColor]];
    label.text = title;
    label.tag = tag;
    if (title.length>0) {
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:title];
        [str addAttribute:NSForegroundColorAttributeName value:HYCTColor(120, 120, 120) range:NSMakeRange(0,label.tag)];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(label.tag,label.text.length -(label.tag+1))];
        [str addAttribute:NSForegroundColorAttributeName value:HYCTColor(120, 120, 120) range:NSMakeRange(label.text.length-1,1)];
        label.attributedText = str;
    }
    return label;
}
-(UIView *)createBlanceView:(CGFloat)x y:(CGFloat)y{
   UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(x, y, kAppWidth-2*kCellMargin, 44)];
    //
    USUpDownLabelView *loanAmount = [self createUpDownLableView:@"3,000.00" downTitle:@"借款金额"];
    _loanAmount = loanAmount;
    loanAmount.x = loanAmount.width*0.3;
    loanAmount.y = 5;
     [bgView addSubview:loanAmount];
    USUpDownLabelView *loanDateLimit = [self createUpDownLableView:@"3月" downTitle:@"借款期限"];
    _loanDateLimit = loanDateLimit;
    loanDateLimit.width = loanDateLimit.width*0.7;
    loanDateLimit.x = loanAmount.x+loanAmount.width;
    loanDateLimit.y = 5;
    [bgView addSubview:loanDateLimit];
    USUpDownLabelView *overDate = [self createUpDownLableView:@"108天" downTitle:@"逾期天数"];
    _overDate = overDate;
    overDate.x = loanDateLimit.x+loanDateLimit.width+10;
    overDate.width = loanDateLimit.width*0.7;
    overDate.y = 5;
    [bgView addSubview:overDate];
    return bgView;
}

-(USUpDownLabelView *)createUpDownLableView:(NSString *)upTitle downTitle: (NSString *)downTitle{
    CGFloat width = (kCellWidth-kCellMargin-2*kCellMargin)/3;
    USUpDownLabelView *updow = [[USUpDownLabelView alloc]initWithFrame:CGRectMake(0,0, width, 44)];
    updow.upLabel.text = upTitle;
    updow.downLabel.text = downTitle;
    updow.upLabel.font = updow.downLabel.font;
    updow.upLabel.textColor = updow.downLabel.textColor;
    return updow;
}
-(UIView *)createHeadertView{
   UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, kAppWidth-2*kCellMargin, 60)];
    UIImageView *header = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
    _header = header;
    header.layer.cornerRadius = header.width/2;
    header.layer.masksToBounds = YES;
    header.backgroundColor = HYCTColor(71, 198, 198);
    [bgView addSubview:header];
    UILabel *nameLB = [USUIViewTool createUILabelWithTitle:@"lisa" fontSize:kCommonFontSize_10 color:[UIColor blackColor] heigth:10];
    _nameLB = nameLB;
    nameLB.frame = CGRectMake(header.width+15, 10, bgView.width, kCommonFontSize_10);
    [bgView addSubview:nameLB];
    UILabel *warinLB  = [USUIViewTool createUILabel];
    _warinLB = warinLB;
    warinLB.frame = nameLB.frame;
    warinLB.width = 70;
    warinLB.y+=5;
    warinLB.height = 20;
    warinLB.x = bgView.width - warinLB.width;
    warinLB.textAlignment = NSTextAlignmentCenter;
    warinLB.font = [UIFont systemFontOfSize:kCommonFontSize_15];
    [warinLB setTextColor:[UIColor whiteColor]];
    warinLB.text = @"严重逾期";
    warinLB.backgroundColor = HYCTColor(248, 69, 131);
    [bgView addSubview:warinLB];
    
    return bgView;
}
- (UIView *)createLineWithWidth:(CGFloat)cellWidth {
    //
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(kCellMargin, 0,cellWidth, kLineHeight)];
    [lineView setBackgroundColor:HYCTColor(224, 224, 224)];
    return lineView;
}
@end
