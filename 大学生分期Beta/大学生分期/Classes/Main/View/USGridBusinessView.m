//
//  USGridView.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/1.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USGridBusinessView.h"
#import "USGridCellView.h"
#import "USHtmlLoadViewInsideController.h"
#import "USMainUITabBarController.h"
@interface USGridBusinessView()
@property(nonatomic,strong)UINavigationController *nav;
@property(nonatomic,strong)NSArray *titles ;
@end
@implementation USGridBusinessView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame itemTitles:(NSArray *)itemTitles
                  itemImages:(NSArray *)itemImageNames ids:(NSArray *)ids  rowCount:(NSInteger) rowCount cellCount:(NSInteger) cellCount nav:(UINavigationController *)nav {
    _nav = nav ;
    _titles = itemTitles ;
    self = [self initWithFrame:frame];
    if (self) {
        CGFloat rowheight = frame.size.height/rowCount -10;
        CGFloat cellwidth = frame.size.width/cellCount ;
        CGFloat btnWidth = 40;
        CGFloat btnHeight = 40 ;
        for (int i=0; i<rowCount; i++) {
            UIView *bigview = [[UIView alloc]initWithFrame:CGRectMake(0, i*rowheight, kAppWidth, rowheight) ];
            
            [self addSubview:bigview] ;
            for (int j=0 ; j<cellCount; j++) {
                long item = (i*cellCount) + j ;
                // HYLog(@"i:%d,item:%lu",i,item) ;
                UIButton *btn = [USUIViewTool createButtonWith:@"" imageName:itemImageNames[item]] ;
                [btn setWidth:btnWidth];
                [btn setTitleColor:[UIColor blackColor] forState:0] ;
                [btn setHeight:btnHeight] ;
                [btn setX:cellwidth*j+btnWidth/2] ;
                [btn setY:btnHeight/2];
                //设置tag
                [btn setTag:[ids[item] integerValue]] ;
                [btn addTarget:self action:@selector(btnOnclick:) forControlEvents:UIControlEventTouchUpInside] ;
                [  bigview addSubview:btn ];
                
                
                UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(cellwidth*j, btn.y+btnHeight+5, cellwidth, 14)];
                [title setText:itemTitles[item]] ;
                [title setTextAlignment:NSTextAlignmentCenter] ;
                [title setTextColor:[UIColor blackColor]] ;
                [title setFont:[UIFont systemFontOfSize:14]] ;
                [bigview addSubview:title] ;
            }
        }
    }
    return self;
}

-(void)btnOnclick:(UIButton *)sender{
    NSString *url = [NSString stringWithFormat:@"%@%lu",shopUrl,sender.tag] ;
    HYLog(@"url:%@",url) ;
    USHtmlLoadViewInsideController *controller = [[USHtmlLoadViewInsideController alloc]init ] ;
    controller.hidesBottomBarWhenPushed = YES ;
    controller.htmlUrl = url ;
    controller.htmlTitle = @"商家列表" ;
    controller.loadMsg =@"正在加载......";
    controller.showMsg=true ;
    //[USUIViewTool chageWindowRootController:controller];
    //[USUIViewTool createMainNavController:controller];
    [_nav pushViewController:controller animated:YES] ;
}

@end
