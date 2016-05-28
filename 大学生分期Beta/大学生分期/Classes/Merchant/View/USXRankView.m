//
//  USXRankView.m
//  大学生分期
//
//  Created by HeXianShan on 16/1/8.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import "USXRankView.h"
#import "USNearProfZoneViewController.h"
#define  kMargin 2
@implementation USXRankView


-(instancetype)initWithArray:(NSArray *)array superVC:(UIViewController *)superVC{
    self = [super init];
    _dataArray = array;
    _superVC = superVC;
    if ([_dataArray count]>0) {
        _subXrankViws = [NSMutableArray array];
    }
    [_dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj!=[NSNull null]) {
            USSubXrankView *subVC = [[USSubXrankView alloc]initWithDic:obj];
            subVC.tag = idx;
            if (idx==0) {
                subVC.x = kMargin;
            }else{
                subVC.x=(idx+1)*kMargin+idx*subVC.width;
            }
            subVC.clickBlock = ^(){
               
                if (_dataArray[idx][@"customer_id"]== [NSNull null]) {
                    return ;
                }
                USNearProfZoneViewController *profZoneVC = [[USNearProfZoneViewController alloc]init];
                profZoneVC.customer_id = _dataArray[idx][@"customer_id"];
                [_superVC.navigationController pushViewController:profZoneVC animated:YES];
            };
            [self addSubview:subVC];
            [_subXrankViws addObject:subVC];
        }
       
    }];
   
    self.width = kAppWidth;
    self.height = ((USSubXrankView *)[_subXrankViws firstObject]).height+1;
    self.y = kMargin;
    self.backgroundColor = [UIColor clearColor];
    self.userInteractionEnabled = YES;
    return self;
}

@end
