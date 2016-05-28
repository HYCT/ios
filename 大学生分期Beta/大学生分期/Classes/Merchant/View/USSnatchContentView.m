//
//  USSnatchContentView.m
//  大学生分期
//
//  Created by HeXianShan on 16/1/6.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import "USSnatchContentView.h"
#import "USSnatchDetailViewController.h"
@interface USSnatchContentView()
@property(nonatomic,strong)USSnatchDetailViewController *detailVC;
@end
@implementation USSnatchContentView

-(instancetype)initWithArray:(NSArray *)array superVC:(UIViewController *)superVC{
    self = [super init];
    if (self) {
        __block NSDictionary *leftDic = (array.count>=1)?array[0]:nil;
        __block NSDictionary *rightDic = (array.count==2)?array[1]:nil;
        self.userInteractionEnabled = YES;
        _superVC = superVC;
        self.backgroundColor = [UIColor whiteColor];
        _leftView = [[USSubSnatchView alloc]initWithDic:leftDic];
        _leftView.x = 10;
        self.frame = _leftView.bounds;
      
        self.frame = CGRectMake(0, 0, kAppWidth, _leftView.dyHeight);
        
        [self addSubview:_leftView];
        if (rightDic!=nil&&rightDic.count>0) {
            _rightView = [[USSubSnatchView alloc]initWithDic:rightDic];
            UIView *colLine = [USUIViewTool createLineView];
            colLine.frame = CGRectMake(_leftView.x+_leftView.width+1, 0, 1, _leftView.height);
            //colLine.backgroundColor= [ UIColor redColor];
            _rightView.x = colLine.width+colLine.x;
            [self addSubview:colLine];
            [self addSubview:_rightView];
            UIView *rowLine = [USUIViewTool createLineView];
            rowLine.frame = CGRectMake(0, self.height+1, kAppWidth, 1);
            [self addSubview:rowLine];
            self.height+=1;
            _dyHeight = self.height;
        }else{
            _dyHeight = self.height;
        }
        
        __block UIViewController *tempVC  = _superVC;
        __block UIViewController *tempdVC  = _detailVC;
        _leftView.clickBlock = ^(){
            _detailVC = [[USSnatchDetailViewController alloc]init];
            _detailVC.snatchId = leftDic[@"id"];
            tempdVC  = _detailVC;
            [tempVC.navigationController pushViewController:tempdVC animated:YES];
        };
        _rightView.clickBlock = ^(){
            _detailVC = [[USSnatchDetailViewController alloc]init];
            _detailVC.snatchId = rightDic[@"id"];
            tempdVC  = _detailVC;
            [tempVC.navigationController pushViewController:tempdVC animated:YES];
        };
    }
    return self;
}

-(void)setBlock:(USSubSnatchView *)subView snaId:(NSString *)snaId{
    
}
@end
