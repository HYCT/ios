//
//  USMoreSafyViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/13.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USMoreSafetyViewController.h"
@interface USMoreSafetyViewController()
@property(nonatomic,assign)CGFloat height;
@end
@implementation USMoreSafetyViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"安全保障";
    self.navigationController.navigationBar.translucent= NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    NSMutableString *content = [NSMutableString string];
    _height = 0;
    [content appendString:@"      “汪卡”是一家规范运营、严格行业自律，着力打造诚信透明、安全高效、互惠互利的借贷服务平台。“汪卡”竭尽全力，采取多种措施为您提供必要的借贷服务。\n"];
    UIView *usView = [self createAboutView:nil content: [NSString stringWithString:content]];
     usView.y = -5;
    [self.view addSubview:usView];
    

    content = [NSMutableString string];
    [content appendString:@"       汪卡目前的风控管理团队主要由金融系统和计算机技术的专业人士组成。管理团队大多来自中国各银行及民间金融行业，具有金融行业从业背景、丰富的金融从业经验、较强的专业素养和业务能力。风险控制是汪卡发展的核心和关键，我们拥有一只专业的风险控制团队。"];
  UIView *usView1 = [self createAboutView:@"风控团队" content:[NSString stringWithString:content]];
    usView1.y = usView.y+usView.height;
  [self.view addSubview:usView1];
    content = [NSMutableString string];
    UIView *usView2 = [self createAboutView:nil content:@"汪卡把客户的数据及隐私保护置于首位。"];
    usView2.y = usView1.y+usView1.height;
    [self.view addSubview:usView2];
    
    UIView *usView3 = [self createAboutView:nil content:@"       汪卡拥有一支在业内技术过硬、经验丰富的研发团队。汪卡的服务器部署于国内顶尖的云平台，具备企业级的物理安全性和容灾能力，享有专业的抵抗网络攻击、黑客入侵和病毒攻击的软硬件技术支撑。客户数据采用高频多份的备份策略，并严格进行高复杂度的加密，保证数据的可恢复性和安全性。\n\n  管理团队\n\n       汪卡有完整的管理制度、严谨的管理流程及详细的管理办法。汪卡从员工素质、管理规范、法律支持完善等多方面严格自控，保障客户信息的安全。\n\n我们承若将为您提供更优质高效的服务！"];
    usView3.y = usView2.y+usView2.height;
    [self.view addSubview:usView3];
    UIScrollView *scrollVIew = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    scrollVIew.y = 0;
    scrollVIew.contentSize = CGSizeMake(kAppWidth, _height+90);
    scrollVIew.showsHorizontalScrollIndicator = NO;
    scrollVIew.bounces = NO;
    //scrollVIew.contentOffset = CGPointMake(kAppWidth, kAppHeight);
    for (UIView *uiview in self.view.subviews) {
        [uiview removeFromSuperview];
        [scrollVIew addSubview:uiview];
    }
    [self.view addSubview:scrollVIew];
}
-(UIView *)createAboutView:(NSString *)title content:(NSString *)content{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kAppWidth,kAppHeight/2-30)];
    UILabel *titleLabel = [USUIViewTool createUILabel];
    CGFloat margin = 0;
    if (title == nil) {
        titleLabel.height = 0;
    }else{
        titleLabel.text = title;
        titleLabel.font = [UIFont systemFontOfSize:kCommonFontSize_15];
        //titleLabel.textColor = [UIColor blackColor];
        titleLabel.textColor = HYCTColor(160, 160, 160);
        [bgView addSubview:titleLabel];
        margin = 5;
    }
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(0, titleLabel.height+titleLabel.y+margin, kAppWidth, bgView.height)];
    textView.userInteractionEnabled = NO;
    textView.scrollEnabled = YES;
    textView.font = [UIFont systemFontOfSize:kCommonFontSize_15];
    textView.textColor = HYCTColor(160, 160, 160);
    textView.text = content;
    CGSize size = [self boundingRectWithSize:CGSizeMake(kAppWidth, 0) content:content];
    textView.height = size.height+10;
    bgView.height = textView.height+titleLabel.height;
    [bgView addSubview:textView];
    _height+=bgView.height;
    return bgView;
}
-(CGSize)boundingRectWithSize:(CGSize)size content:(NSString *)content
{
    return [USStringTool boundingRectWithSize:size content:content fontsize:kCommonFontSize_15];
}

@end
