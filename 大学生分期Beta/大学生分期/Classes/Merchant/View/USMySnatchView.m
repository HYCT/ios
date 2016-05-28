//
//  USMySnatchView.m
//  大学生分期
//
//  Created by HeXianShan on 16/1/6.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import "USMySnatchView.h"
#define kMargin 10
@interface USMySnatchView()
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UILabel *stateLB;
@property(nonatomic,strong)UIImageView *snatchImageView;
@property(nonatomic,strong)UILabel *orderIdLB;
@property(nonatomic,strong)UILabel *orderStateLB;
@property(nonatomic,strong)UILabel *endTimeLB;
@property(nonatomic,strong)UILabel *yuanLB;
@property(nonatomic,strong)UILabel *timeLB;
@property(nonatomic,strong)UIImage *upArrow;
@property(nonatomic,strong)UIImage *downArrow;
//
@property(nonatomic,strong)UIView *detailButtonView;
@property(nonatomic,strong)UILabel *recvManLB;
@property(nonatomic,strong)UILabel *recvAddrLB;
@property(nonatomic,strong)UILabel *rebackTimeLB;
@property(nonatomic,strong)UILabel *detailDescLB;
//
@property(nonatomic,strong)NSMutableDictionary *buttonsDic;
@property(nonatomic,strong)UIView *detailView;
@end
@implementation USMySnatchView

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(kMargin, 0, kAppWidth-kMargin*2, 240);
        
        self.backgroundColor = [UIColor orangeColor];
        _bgView = [[UIView alloc]initWithFrame:self.bounds];
        _bgView.y = 30;
        _bgView.height = (self.height - _bgView.y );
        _bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_bgView];
        //状态标签
        [self initStateLB:dic[@"status_label"]];
        
        //标题
        _snactNameLB = [USUIViewTool createUILabelWithTitle:dic[@"title"] fontSize:kCommonFontSize_12 color:[UIColor blackColor] heigth:22];
        _snactNameLB.frame = CGRectMake(_stateLB.x+_stateLB.width+5, _stateLB.y, self.width-_stateLB.x-_stateLB.width, 22);
        [self addSubview:_snactNameLB];
        //图片
        _snatchImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kMargin*0.5, kMargin*0.5, 80, 60)];
        [_snatchImageView sd_setImageWithURL:[NSURL URLWithString:HYWebDataPath(dic[@"title_img_path"])] placeholderImage:[UIImage imageNamed:@"circle_default"] options:5];
        [_bgView addSubview:_snatchImageView];
//        //
        _orderIdLB = [self createLB];
        _orderIdLB.x = _snatchImageView.x+_snatchImageView.width+kMargin*0.5;
//        _orderIdLB.y = _snatchImageView.y;
//        _orderIdLB.text = @"订单号:";
//        [_bgView addSubview:_orderIdLB];
        //
        _orderStateLB = [self createLB];
        //_orderStateLB.x = _orderIdLB.x;
         _orderStateLB.x =  _snatchImageView.x+_snatchImageView.width+kMargin*0.5;
       // _orderStateLB.y = _orderIdLB.y+_orderIdLB.height+kMargin*0.5;
        _orderStateLB.y = _snatchImageView.y;
        _orderStateLB.text = @"订单状态:支付成功";
        [_bgView addSubview:_orderStateLB];
        
        //
        _endTimeLB = [self createLB];
        _endTimeLB.x = _orderIdLB.x;
        _endTimeLB.y = _orderStateLB.y+_orderStateLB.height+kMargin*0.5;
        _endTimeLB.text = [NSString stringWithFormat:@"结束时间:%@",dic[@"endtime"]];
        [_bgView addSubview:_endTimeLB];
        
        //
        _yuanLB = [self createLB];
        _yuanLB.x = _orderIdLB.x;
        _yuanLB.y = _orderStateLB.y+_orderStateLB.height+kMargin*2;
        _yuanLB.text = [NSString stringWithFormat:@"￥%@",dic[@"pay_amount"]];;
        [self upateYuan];
        [_bgView addSubview:_yuanLB];
        
        //
        _timeLB = [self createLB];
        _timeLB.x = _yuanLB.x+_yuanLB.width;
        _timeLB.width = _bgView.width-_timeLB.x;
        _timeLB.y = _yuanLB.y+_yuanLB.height*0.5-kMargin*0.5;
        _timeLB.text = dic[@"joins_time"];
        [_bgView addSubview:_timeLB];
        //
        UIView *line = [USUIViewTool createLineView];
        line.frame = CGRectMake(kMargin, _timeLB.height+_timeLB.y+kMargin*1.5, _bgView.width-2*kMargin, 0.5);
        line.backgroundColor = HYCTColor(200, 200, 200);
        _bgView.height = line.y+line.height;
        //[_bgView addSubview:line];
        self.height = _bgView.y+_bgView.height;
    }
   
    _dyHeight = self.height;
    [self updateFrame];
    return self;
}

-(void)upateYuan{
    _yuanLB.textColor = [UIColor blackColor];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:_yuanLB.text];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kCommonFontSize_10] range:NSMakeRange(0, 1)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kCommonFontSize_20] range:NSMakeRange(1, str.length-1)];
    _yuanLB.attributedText = str;
    _yuanLB.size = [USStringTool boundingRectWithSize:CGSizeMake(0, kCommonFontSize_20) content:_yuanLB.text fontsize:kCommonFontSize_20];
}

-(void)updateFrame{
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
}

-(UILabel *)createLB{
    UILabel *label = [USUIViewTool createUILabelWithTitle:@"" fontSize:kCommonFontSize_12 color:HYCTColor(180 , 180, 180) heigth:kCommonFontSize_12];
    label.frame = CGRectMake(0, 0, _bgView.width-_snatchImageView.width-_snatchImageView.x-kMargin*0.5, kCommonFontSize_12);
    return label;
}

//状态标签
-(void)initStateLB:(NSString *)title{
    _stateLB = [USUIViewTool createUILabelWithTitle:title fontSize:kCommonFontSize_12 color:[UIColor whiteColor]  heigth:20];
    
    _stateLB.frame = CGRectMake(kMargin, (30-20)/2, 60, 20);
    //_stateLB.size = [USStringTool boundingRectWithSize:_stateLB.size content:title fontsize:kCommonFontSize_12];
    _stateLB.textAlignment = UITextAlignmentCenter ;
    _stateLB.layer.cornerRadius = _stateLB.height*0.2;
    _stateLB.layer.masksToBounds = YES;
    _stateLB.textColor = [UIColor orangeColor];
    _stateLB.backgroundColor = [UIColor whiteColor];
    [self addSubview:_stateLB];
}

-(void)detail:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    [self updateArrowImag:sender];
    
    if (sender.selected) {
        _detailView.hidden = NO;
        _detailView.y = _detailButtonView.y+_detailButtonView.height;
        _bgView.height+=_detailView.height+kMargin;
        self.height +=_detailView.height+kMargin;
        [_bgView addSubview:_detailView];
        
    }else{
        _bgView.height-=_detailView.height+kMargin;
        self.height -=_detailView.height+kMargin;
        _detailView.hidden = YES;
    }
    _dyHeight = self.height;
    if (_snatchdDelegate != nil) {
        if ([_snatchdDelegate respondsToSelector:@selector(didDetailClick:)]) {
            [_snatchdDelegate didDetailClick:self];
        }
    }
}
-(void)updateArrowImag:(UIButton *)sender{
    UIImageView *arrowImgView = _buttonsDic[[sender description]];
    if (sender.selected) {
        arrowImgView.image = _upArrow;
    }else{
        arrowImgView.image = _downArrow;
    }
}
-(UIView *)createButtonViews:(NSString *)title action:(SEL)action{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,_bgView.width, 20)];
    bgView.userInteractionEnabled = YES;
    bgView.backgroundColor = [UIColor whiteColor];
    UILabel *label = [USUIViewTool createUILabelWithTitle:title fontSize:kCommonFontSize_12 color:HYCTColor(168, 168, 168) heigth:30];
    label.textAlignment = NSTextAlignmentRight;
    label.width = 60;
    label.x = _bgView.width*0.5-label.width;
    label.y = -5;
    [bgView addSubview:label];
    UIImageView *arrowView = [[UIImageView alloc]initWithImage:_downArrow];
    
    arrowView.frame = CGRectMake(label.width+label.x, kMargin*0.5, 10, 10);
    [bgView addSubview:arrowView];
    UIButton *topBt = [UIButton buttonWithType:UIButtonTypeCustom];
    topBt.frame = bgView.bounds;
    [bgView addSubview:topBt];
    [topBt addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [_buttonsDic setObject:arrowView forKey:[topBt description]];
    return bgView;
}

-(void)createDetailView:(NSDictionary *)dic{
    _detailView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _bgView.width, 100)];
    CGFloat height = _detailView.height;
    UIView *dbgview = [[UIView alloc]initWithFrame:CGRectMake(kMargin*0.5, kMargin*0.5, _detailView.width-2*kMargin*0.5, 60)];
    dbgview.layer.cornerRadius = 5;
    dbgview.layer.masksToBounds = YES;
    dbgview.backgroundColor = HYCTColor(239, 239, 239);
      //
    UIImageView *addrImgV = [[UIImageView alloc]initWithFrame:CGRectMake(kMargin*0.5, kMargin, 35, 40)];
    addrImgV.image = [UIImage imageNamed:@"snatch_address"];
    [dbgview addSubview:addrImgV];
      //
     _recvManLB = [self createLB];
     _recvManLB.x = addrImgV.x+addrImgV.width+kMargin*0.8;
     _recvManLB.y = addrImgV.y;
     _recvManLB.width = dbgview.width - _recvManLB.x;
     _recvManLB.text = @"收货人:";
    [dbgview addSubview:_recvManLB];
    //
    _recvAddrLB = [self createLB];
    _recvAddrLB.x = addrImgV.x+addrImgV.width+kMargin*0.5;
    _recvAddrLB.y = _recvManLB.y+_recvManLB.height+kMargin;
    _recvAddrLB.width = dbgview.width - _recvManLB.x;
    _recvAddrLB.text = @"收货地址:";
    [dbgview addSubview:_recvAddrLB];
    [_detailView addSubview:dbgview];
    //
    _rebackTimeLB = [self createLB];
    _rebackTimeLB.x = dbgview.x;
    _rebackTimeLB.y = dbgview.y+dbgview.height+kMargin;
    _rebackTimeLB.text = @"回报时间:";
     [_detailView addSubview:_rebackTimeLB];
    //
    UILabel *tipLB = [self createLB];
    tipLB.x = _rebackTimeLB.x;
    tipLB.y = _rebackTimeLB.y+_rebackTimeLB.height+kMargin;
    tipLB.text = @"夺宝说明:";
    [_detailView addSubview:tipLB];
    UIView *descBgView = [[UIView alloc]initWithFrame: CGRectMake(tipLB.x, tipLB.y, _detailView.width-tipLB.x*2, 50)];
    descBgView.layer.cornerRadius = 5;
    descBgView.backgroundColor = HYCTColor(239, 239, 239);
    //
    _detailDescLB = [self createLB];
    _detailDescLB.numberOfLines = 0;
    _detailDescLB.x =  kMargin*0.5;
    _detailDescLB.y = 0;
    _detailDescLB.textColor = HYCTColor(160, 160, 160);
    _detailDescLB.text = @"习近平指出，重庆集大城市、大农村、大山区、大库区于一体，协调发展任务繁重。要促进城乡区域协调发展，促进新型工业化、信息化、城镇化、农业现代化同步发展，在加强薄弱领域中增强发展后劲，着力形成平衡发展结构，不断增强发展整体性。保护好三峡库区和长江母亲河，事关重庆长远发展，事关国家发展全局。要深入实施“蓝天、碧水、宁静、绿地、田园”环保行动，建设长江上游重要生态屏障，推动城乡自然资本加快增值，使重庆成为山清水秀美丽之地。";
    _detailDescLB.size = [USStringTool boundingRectWithSize:CGSizeMake(_detailView.width-2*_detailDescLB.x, 0) content:_detailDescLB.text fontsize:kCommonFontSize_14];
    descBgView.height = _detailDescLB.height+kMargin;
    [descBgView addSubview:_detailDescLB];
    [_detailView addSubview:descBgView];
    if (height<(descBgView.y+descBgView.height)) {
        height = descBgView.y+descBgView.height;
    }
    _detailView.height = height;
}

@end
