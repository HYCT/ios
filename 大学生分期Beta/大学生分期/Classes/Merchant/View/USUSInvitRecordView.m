//
//  USUSInvitRecordView.m
//  大学生分期
//
//  Created by HeXianShan on 16/1/10.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import "USUSInvitRecordView.h"
@interface USUSInvitRecordView()
@property(nonatomic,strong)  UIButton *arrayBt;
@property(nonatomic,strong)  UIButton *jujueBt;
@end
@implementation USUSInvitRecordView

-(instancetype)initWithDic:(NSDictionary    *)dic{
    self = [super init];
    if (self) {
        _dataDic = dic;
        self.frame =CGRectMake(0, 0,kAppWidth, 80);
        self.backgroundColor = [UIColor whiteColor];
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 150, 100)];
        _headerImgView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 10, 50, 50)];
        _headerImgView.layer.cornerRadius = _headerImgView.height*0.5;
        _headerImgView.layer.masksToBounds = YES;
        //[_headerImgView sd_setImageWithURL:[NSURL URLWithString:HYWebDataPath(_dataDic[@"customer_headpic"])]];
        [_headerImgView sd_setImageWithURL:[NSURL URLWithString:HYWebDataPath(_dataDic[@"headpic"])]];
        [headerView addSubview:_headerImgView];
        //账户名称
        _nameLB = [USUIViewTool createUILabelWithTitle:_dataDic[@"customer_name"] fontSize:kCommonFontSize_12 color:[UIColor blackColor] heigth:kCommonFontSize_15];
        _nameLB.textAlignment = NSTextAlignmentCenter;
        _nameLB.frame = CGRectMake(_headerImgView.x+_headerImgView.width+5,10 , headerView.width-_headerImgView.x-_headerImgView.width, kCommonFontSize_15);
        _nameLB.textAlignment = UITextAlignmentLeft ;
        [headerView addSubview:_nameLB];
        //电话
        _telLB = [USUIViewTool createUILabelWithTitle:[NSString stringWithFormat:@"%@",_dataDic[@"telephone"]] fontSize:kCommonFontSize_12 color:[UIColor blackColor] heigth:kCommonFontSize_15];
        _telLB.textAlignment = NSTextAlignmentCenter;
        _telLB.frame = CGRectMake(_nameLB.x,_nameLB.y+_nameLB.height+5 , headerView.width-_headerImgView.x-_headerImgView.width, kCommonFontSize_15);
         _telLB.textAlignment = UITextAlignmentLeft ;
        [headerView addSubview:_telLB];
        //时间
        _timeLB = [USUIViewTool createUILabelWithTitle:_dataDic[@"enter_time"] fontSize:kCommonFontSize_12 color:[UIColor blackColor] heigth:kCommonFontSize_15];
        _timeLB.textAlignment = NSTextAlignmentCenter;
        _timeLB.frame = CGRectMake(_nameLB.x, _telLB.y+_telLB.height+5, headerView.width-_headerImgView.x-_headerImgView.width, kCommonFontSize_15);
        _timeLB.textAlignment = UITextAlignmentLeft ;
        [headerView addSubview:_timeLB];
        //同意按钮
        UIButton *arrayBt = [UIButton buttonWithType:UIButtonTypeCustom];
        _arrayBt =arrayBt;
        arrayBt.frame = CGRectMake(headerView.x+headerView.width+20, 15, 50, 30);
        arrayBt.backgroundColor = HYCTColor(168, 168, 168);
        if ([_dataDic[@"type"]integerValue]==1) {
             arrayBt.backgroundColor = [UIColor greenColor];
        }
        arrayBt.layer.cornerRadius = 5;
        arrayBt.layer.masksToBounds = YES;
        [arrayBt setTitle:@"同意" forState:UIControlStateNormal];
        [arrayBt addTarget:self action:@selector(agress) forControlEvents:UIControlEventTouchUpInside];
        arrayBt.font =[UIFont systemFontOfSize:14];
        [self addSubview:arrayBt];
        //拒绝按钮
        UIButton *jujueBt = [UIButton buttonWithType:UIButtonTypeCustom];
         _jujueBt =jujueBt;
        jujueBt.frame = CGRectMake(arrayBt.x+arrayBt.width+20, 15, 50, 30);
        jujueBt.backgroundColor = HYCTColor(168, 168, 168);
        if ([_dataDic[@"type"]integerValue]==2) {
            jujueBt.backgroundColor = [UIColor redColor];
        }
        jujueBt.layer.cornerRadius = 5;
        jujueBt.layer.masksToBounds = YES;
        [jujueBt setTitle:@"拒绝" forState:UIControlStateNormal];
        [jujueBt addTarget:self action:@selector(jujue) forControlEvents:UIControlEventTouchUpInside];
        arrayBt.font =[UIFont systemFontOfSize:14];
        
        [self addSubview:jujueBt];
        [self addSubview:headerView];
        //线条
        UIView *line =[USUIViewTool createLineView] ;
        line.backgroundColor = HYCTColor(168, 168, 168);
        line.frame = CGRectMake(10, _timeLB.y +30, self.width-20, 0.5) ;
        [self addSubview:line] ;
    }
    return self;
}
-(void)agress{
    [USWebTool POST:@"wangkaInviterClientcontroller/saveEnterInviter.action" paramDic:@{@"enter_id":_dataDic[@"id"],@"type":@(1)} success:^(NSDictionary *dic) {
         _arrayBt.backgroundColor = [UIColor greenColor];
        _jujueBt.backgroundColor = HYCTColor(168, 168, 168);
        _arrayBt.enabled = NO;
        _jujueBt.enabled = YES;
    } failure:^(id data) {
        
    }];
}
-(void)jujue{
    
    [USWebTool POST:@"wangkaInviterClientcontroller/saveEnterInviter.action" paramDic:@{@"enter_id":_dataDic[@"id"],@"type":@(2)} success:^(NSDictionary *dic) {
        _jujueBt.backgroundColor = [UIColor redColor];
        _jujueBt.enabled = NO;
        _arrayBt.enabled = YES;
        _arrayBt.backgroundColor = HYCTColor(168, 168, 168);
    } failure:^(id data) {
        
    }];
}
@end
