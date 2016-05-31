//
//  USUIViewTool.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/2.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USUIViewTool.h"
#import "USLoginViewController.h"
#import "USMainUITabBarController.h"
@implementation USUIViewTool
+(void)createMainNavController:(UIViewController *)showVC{
    USMainUITabBarController *mainCV = [[USMainUITabBarController alloc]init];
    if (showVC==nil) {
        mainCV.selectedViewController = mainCV.accountnNavViewController;
        [USUIViewTool chageWindowRootController:mainCV];
    }else{
        [USUIViewTool chageWindowRootController:mainCV];
        
        for (UINavigationController *vc in [mainCV childViewControllers]) {
            if (vc.tabBarItem == mainCV.tabBar.selectedItem) {
                [vc pushViewController:showVC animated:YES];
                return;
            }
        }
    }
    
}
+(void)chageWindowRootController:(UIViewController *)rootViewController{
    if (rootViewController!=nil) {
        [[UIApplication sharedApplication].delegate window].rootViewController = rootViewController;
    }
}
+(void)toLoginViewController{
    
    UINavigationController *navLogin = [[UINavigationController alloc]initWithRootViewController:[[USLoginViewController alloc]init]];
    [self chageWindowRootController:navLogin];
}
+(void)toLoginViewController:(UIViewController *)showVC{
    USLoginViewController *loginVC = [[USLoginViewController alloc]init];
    loginVC.nextViewController = showVC;
    UINavigationController *navLogin = [[UINavigationController alloc]initWithRootViewController:loginVC];
    [self chageWindowRootController:navLogin];
}
+(UIView *)createLineView{
    UIView *underLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kAppWidth, 1)];
    [underLine setBackgroundColor:HYCTColor(224, 224, 224)];
    return underLine;
}
+(UIView *)createLineView:(CGFloat)x y:(CGFloat)y width:(CGFloat)width{
    UIView *underLine = [[UIView alloc]initWithFrame:CGRectMake(x, y, width, 1)];
    [underLine setBackgroundColor:HYCTColor(224, 224, 224)];
    return underLine;
}
+(UIButton *)createButtonWith:(NSString*)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, kAppWidth, 15);
    [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [button.titleLabel setFont:[UIFont systemFontOfSize:kCommonButtonTitleSize]];
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateHighlighted];
    return button;
}

/**
 下拉按钮
 **/
+(UIButton *)createButtonWithRightImg:(NSString*)title imageName:(NSString*)imageNmae width:(CGFloat ) width{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [button.titleLabel setFont:[UIFont systemFontOfSize:kCommonButtonTitleSize]];
    [button setImage:[UIImage imageNamed:imageNmae] forState:UIControlStateNormal] ;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateHighlighted];
    [button setWidth:width] ;
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, width-11, 0, 0)];
    return button;
}

+(UIButton *)createButtonWith:(NSString*)title imageName:(NSString*)imageNmae{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [button.titleLabel setFont:[UIFont systemFontOfSize:kCommonButtonTitleSize]];
    [button setBackgroundImage:[UIImage imageNamed:imageNmae] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:imageNmae] forState:UIControlStateHighlighted];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateHighlighted];
    return button;
}
+(UIButton *)createButtonWith:(NSString*)title imageName:(NSString*)imageNmae highImageName:(NSString*)highImageName{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [button.titleLabel setFont:[UIFont systemFontOfSize:kCommonButtonTitleSize]];
    [button setBackgroundImage:[UIImage imageNamed:imageNmae] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateHighlighted];
    return button;
}
+(UIButton *)createButtonWith:(NSString*)title imageName:(NSString*)imageNmae highImageName:(NSString*)highImageName disableImageName:(NSString*)disableImageName{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [button.titleLabel setFont:[UIFont systemFontOfSize:10]];
    [button setBackgroundImage:[UIImage imageNamed:imageNmae] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateHighlighted];
    return button;
}
+(UIButton *)createButtonWith:(NSString*)title imageName:(NSString*)imageNmae highImageName:(NSString*)highImageName selectedImageName:(NSString*)selectedImageName{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [button.titleLabel setFont:[UIFont systemFontOfSize:kCommonButtonTitleSize]];
    [button setBackgroundImage:[UIImage imageNamed:imageNmae] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    [button setBackgroundImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateHighlighted];
    return button;
}
+(UIButton *)createButtonWith:(NSString*)title imageName:(NSString*)imageNmae highImageName:(NSString*)highImageName selectedImageName:(NSString*)selectedImageName flag:(Boolean) flag{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [button.titleLabel setFont:[UIFont systemFontOfSize:kCommonButtonTitleSize]];
    [button setBackgroundImage:[[UIImage imageNamed:imageNmae]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [button setBackgroundImage:[[UIImage imageNamed:highImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ] forState:UIControlStateHighlighted];
    [button setBackgroundImage:[[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ] forState:UIControlStateSelected];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateHighlighted];
    return button;
}
+(UILabel *)createUILabel{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, kAppWidth, 15)];
    [label setFont:kCommonFont];
    [label setTextAlignment:NSTextAlignmentLeft];
    return label;
}
+(NSAttributedString *)createAttrbutedStringWithHtml:(NSString *)htmlString{
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    return attributedString;
}
+(UILabel*)createUILabelWithTitle:(NSString *)title fontSize:(CGFloat)size color:(UIColor *)color heigth:(CGFloat)heigth{
    UILabel *label = [self createUILabel];
    label.frame = CGRectMake(10, 10, kAppWidth-20, heigth);
    [label setFont:[UIFont systemFontOfSize:size]];
    [label setTextColor:color];
    label.text = title;
    return label;
}

//uilabel
+(UILabel*)createUILabelWithTitle:(NSString *)title fontSize:(CGFloat)size color:(UIColor *)color x:(CGFloat)x y:(CGFloat)y width:(CGFloat)width heigth:(CGFloat)heigth{
    UILabel *label = [self createUILabel];
    label.frame = CGRectMake(x, y, width, heigth);
    [label setFont:[UIFont systemFontOfSize:size]];
    [label setTextColor:color];
    label.text = title;
    return label;
}
+(UIView *)createComplexViewWithTile:(NSString *)title imageName:(NSString *)imageName fontSize:(CGFloat)fontSize fontColor:(UIColor *)fontColor bgsize:(CGSize) bgsize bgColor:(UIColor *)bgColor{
    UIView *bgView = [[UIView alloc]init];
    bgView.frame = CGRectMake(0, 0, bgsize.width, bgsize.height);
    bgView.backgroundColor = bgColor;
    UIButton *imgBt = [USUIViewTool createButtonWith:@"  " imageName:imageName];
    imgBt.size =CGSizeMake(bgsize.width/5, bgsize.width/5);
    imgBt.y = bgView.height/4-imgBt.height/4;
    imgBt.x = bgView.width/2 - imgBt.width/2;
    [bgView addSubview:imgBt];
    UILabel *label = [USUIViewTool createUILabelWithTitle:title fontSize:fontSize color:fontColor heigth:30];
    label.textAlignment = NSTextAlignmentCenter;
    label.x = 0;
    label.y = imgBt.y+imgBt.height+10;
    label.width = kAppWidth;
    [bgView addSubview:label];
    return bgView;
}
+(UIView *)createDataTipViewWithTarget:(nullable id)target action:(SEL)action{
    UIView *tipBigViw = [[UIView alloc]initWithFrame:CGRectMake(0, 10, kAppWidth, 60)];
    tipBigViw.backgroundColor = [UIColor clearColor];
    UILabel *label = [USUIViewTool createUILabelWithTitle:@"暂时没有更多的数据......" fontSize:kCommonFontSize_14 color:[UIColor blackColor] heigth:30];
    label.frame = CGRectMake(0, (tipBigViw.height-label.height)*0.5, kAppWidth, 30);
    label.textAlignment = NSTextAlignmentCenter;
    [tipBigViw addSubview:label];
    /**
     UIButton *loadDataBt = [USUIViewTool createButtonWith:@"刷新"];
     loadDataBt.frame = CGRectMake(kAppWidth*0.5-kAppWidth*0.35*0.5, label.y+label.height+5, kAppWidth*0.35, 30);
     loadDataBt.titleLabel.font = [UIFont systemFontOfSize:kCommonFontSize_15];
     loadDataBt.layer.cornerRadius = loadDataBt.height*0.5;
     loadDataBt.layer.masksToBounds = YES;
     [loadDataBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     [loadDataBt setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
     loadDataBt.backgroundColor = [UIColor blueColor];
     [loadDataBt addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
     [tipBigViw addSubview:loadDataBt];
     **/
    return tipBigViw;
}

//图片自适应
+(void)imagesSelfFit:(UIImageView *)imageview{
    //自适应
    imageview.contentMode = UIViewContentModeScaleAspectFit;
    //imageview.autoresizesSubviews = YES;
    //imageview.autoresizingMask =
    //UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    //imageview.autoresizingMask =
    //UIViewAutoresizingFlexibleWidth ;
}
//text自适应高度

+(CGFloat )setTextHeight:(UILabel *)label width:(CGFloat)width content:(NSString *)content font:(UIFont *)font {
    // content = @"网上都好低分季度加肥加大烦烦的单击封ID及非积分抵扣积分积分积分地方地的地方ID疯狂的口水就非法建设两架飞机的发动机及覅额覅你房低价房地非法金额非福建地方地方IDEif都快放假的覅对方及诶放假了十分噢噢你发送的覅而非那是浪费你的负担法搜喂奶粉";
    label.text = content;
    [label setNumberOfLines:0];
    [label setFont:font] ;
    [label setLineBreakMode:NSLineBreakByTruncatingTail] ;
    CGSize maximumLabelSize = CGSizeMake(width, 9999);//labelsize的最大值
    //关键语句
    CGSize expectSize = [label sizeThatFits:maximumLabelSize];
    [label setHeight:expectSize.height] ;
    return expectSize.height ;
}

@end
