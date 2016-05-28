//
//  USMoreAboutUsViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/12.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USMoreAboutUsViewController.h"
#define kMarginTop 15
@interface USMoreAboutUsViewController()
@property(nonatomic,assign)CGFloat height;
@end
@implementation USMoreAboutUsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"关于我们";
    self.navigationController.navigationBar.translucent= NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view setBackgroundColor:[UIColor whiteColor]];
//    UIImageView *topView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 175)];
//    //HYLog(@"%@",[UIImage imageNamed:@"aboutus_top_img.jpg"]);
//    topView.image = [UIImage imageNamed:@"aboutus_top_img.jpg"];
    _height = 0;
    //[self.view addSubview:topView];
    NSString *content = @"汪卡平台是由本公司专业技术团队研发,为大学生量身定制的金融服务平台。我们的团队具有丰富的开发经验、运作经验及风险控制经验。我们本着诚信透明、安全高效、互惠互利的原则为您服务。";
    UIView *usView = [self createAboutView:@"公司简介" content:content];
    usView.y = kMarginTop;
    _height+=kMarginTop;
    [self.view addSubview:usView];
    //
    content = @"为大学生朋友提供金融及相关衍生服务";
    UIView *usView1 = [self createAboutView:@"主要业务" content:content];
    usView1.y = usView.height+kMarginTop+usView.y;
    _height+=kMarginTop;
    [self.view addSubview:usView1];
    //
   // content = @"邓建勇\n董事长\n对互联网金融尤其是P2P网贷进行了大量全面深入的研究学习，对民间资本、民间借贷、运营推广、风控控制、金融产品、互联网金融等方面积累了深刻的领悟及实践经验。\n\n薛净城\n首席顾问\n男，1960年2月出生，云南农业大学水利水电工程、中央党校国际贸易与涉外经济管理专业毕业， 金融经济师，云南斯泰城投资管理有限公司董事长， 昆明市“创业工程专家志愿团”专家。\n\n曹开俊\n首席顾问\n1995年毕业于昆明理工大学管理工程学院，管理工程硕士研究生。从事IT研发和电子商务投资行业多年，历任广州中国新太集团系统集成项目技术总监，广州中南计算机系统有限公司，现担任红云创投技术和平台运营顾问，指导平台的技术和业务运营流程以及公司重大发展战略的参谋和评估。\n\n华辉\n首席顾问\n1997年法律专业毕业后，便一直在云南望城律师事务所工作，于2000年取得中国政法大学认可的本科法律专业学历。毕业至今一直从事法律实务工作，在工作过程中积累了丰富的办案经验。\n\n邓成志\n总经理\n对民间借贷业务和风险控制有着独到的认识和见解，对互联网金融有着深入的思考和研究。长期从事民间借贷业务，积累了丰富的实践经验。\n\n刘鲲\n技术研发总监\n本科毕业于西南交通大学通信与信息工程学院，云南财经大学工商管理硕士。从事IT行业多年，历任成都江都影视技术总监、云师大商学院软件研发中心主任、云电同方技术总监、用友软件项目管理，云南哈奴曼科技有限公司COO。在IT企业负责过大型项目设计实施，对中国用户IT应用有比较深入的体会和心得。";
   // UIView *usView2 = [self createAboutView:@"I 我们的团队" content:content];
   // usView2.y = usView1.height+kMarginTop+usView1.y;
   // _height+=kMarginTop;
   // [self.view addSubview:usView2];
    //
    UIScrollView *scrollVIew = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    scrollVIew.y = 0;
    scrollVIew.contentSize = CGSizeMake(kAppWidth, _height+100);
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
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kAppWidth,0)];
    UILabel *titleLabel = [USUIViewTool createUILabel];
    CGFloat margin = 0;
    if (title == nil) {
        titleLabel.height = 0;
    }else{
        titleLabel.text = title;
        titleLabel.font = [UIFont systemFontOfSize:kCommonFontSize_18];
        titleLabel.textColor = [UIColor orangeColor];
        [bgView addSubview:titleLabel];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:title];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kCommonFontSize_18] range:NSMakeRange(0,str.length)];
        [str addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:kCommonFontSize_22] range:NSMakeRange(0,1)];
        titleLabel.attributedText = str;
        margin = 5;
    }
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(10, titleLabel.height+titleLabel.y+margin, kAppWidth, bgView.height)];
    textView.userInteractionEnabled = NO;
    textView.scrollEnabled = YES;
    textView.font = [UIFont systemFontOfSize:kCommonFontSize_15];
    textView.textColor = HYCTColor(130, 130, 130);
    textView.text = content;
    CGSize size = [self boundingRectWithSize:CGSizeMake(kAppWidth, 0) content:content];
    textView.height = size.height+10;
    bgView.height = textView.height+titleLabel.height+textView.y;
    [bgView addSubview:textView];
    _height+=bgView.height;
    return bgView;
}
-(CGSize)boundingRectWithSize:(CGSize)size content:(NSString *)content
{
    return [USStringTool boundingRectWithSize:size content:content fontsize:kCommonFontSize_15];
}
@end
