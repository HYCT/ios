//
//  USMyInvitView.m
//  大学生分期
//
//  Created by HeXianShan on 16/1/10.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import "USMyInvitView.h"
#import "USPictureScanViewController.h"
#define kMargin 20
#define kMargin_10 10
@interface USMyInvitView ()
@property(nonatomic,strong) UILabel    *releaseTimeLB;
@property(nonatomic,strong) UILabel    *themeLB;
@property(nonatomic,strong) UILabel    *addressLB;
@property(nonatomic,strong) UILabel    *dateLB;
@property(nonatomic,strong) UILabel    *zhifuLB;
@property(nonatomic,strong) UILabel    *descLB;
@property(nonatomic,strong) UIScrollView *scollerPics;
@property(nonatomic,strong)NSMutableArray *imgUrls;
@property(nonatomic,strong) NSDictionary *dataDic;
@end
@implementation USMyInvitView

-(instancetype)initWithDic:(NSDictionary *)dic superVC:(UIViewController *)superVC;{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
        _superVC = superVC;
        _dataDic = dic;
        self.backgroundColor = [UIColor whiteColor];
        //
        CGFloat margin = kMargin*0.5;
        
        //发布时间静态文本
        UILabel *publishLabel = [USUIViewTool createUILabelWithTitle:@"• 发布时间：" fontSize:kCommonFontSize_15 color:HYCTColor(168, 168, 168) heigth:15 ] ;
        publishLabel.frame= CGRectMake(kMargin_10, 10, 90, kCommonFontSize_15);
        [self addSubview:publishLabel];
        
        //绑定发布时间
        _releaseTimeLB = [USUIViewTool createUILabelWithTitle:@"" fontSize:kCommonFontSize_15 color:HYCTColor(168, 168, 168) heigth:kCommonFontSize_15];
        _releaseTimeLB.frame = CGRectMake(publishLabel.x+publishLabel.width, publishLabel.y, kAppWidth-publishLabel.x-publishLabel.width, kCommonFontSize_15);
        [self addSubview:_releaseTimeLB];
        _releaseTimeLB.text=_dataDic[@"publish_time"] ;
       //类型
        _themeLB = [USUIViewTool createUILabelWithTitle:@"• 类型" fontSize:kCommonFontSize_15 color:HYCTColor(168, 168, 168) heigth:kCommonFontSize_15];
        _themeLB.frame = CGRectMake(publishLabel.x, _releaseTimeLB.y+_releaseTimeLB.height+margin, kAppWidth-10, kCommonFontSize_15);
        [self addSubview:_themeLB];
        [self updateLB:_themeLB title:_dataDic[@"theme_name"]];
        
        //
        _addressLB = [USUIViewTool createUILabelWithTitle:@"• 地点" fontSize:kCommonFontSize_15 color:HYCTColor(168, 168, 168) heigth:kCommonFontSize_15];
        _addressLB.frame = CGRectMake(_themeLB.x, _themeLB.height+_themeLB.y+margin,_themeLB.width, kCommonFontSize_15);
        [self addSubview:_addressLB];
        [self updateLB:_addressLB title:_dataDic[@"invit_address"]];
        //
        _dateLB = [USUIViewTool createUILabelWithTitle:@"• 时间" fontSize:kCommonFontSize_15 color:HYCTColor(168, 168, 168) heigth:kCommonFontSize_15];
        _dateLB.frame = CGRectMake(_addressLB.x, _addressLB.height+_addressLB.y+margin, _themeLB.width, kCommonFontSize_15);
        [self addSubview:_dateLB];
        [self updateLB:_dateLB title:_dataDic[@"invit_time"]];
        //
        _zhifuLB = [USUIViewTool createUILabelWithTitle:@"• AA" fontSize:kCommonFontSize_15 color:HYCTColor(168, 168, 168) heigth:kCommonFontSize_15];
        _zhifuLB.frame = CGRectMake(_addressLB.x, _dateLB.height+_dateLB.y+margin, _themeLB.width, kCommonFontSize_15);
        [self addSubview:_zhifuLB];
        [self updateLB:_zhifuLB title:_dataDic[@"invit_paybill_lable"]];
        //
        _descLB = [USUIViewTool createUILabelWithTitle:@"• 说明一些事情...." fontSize:kCommonFontSize_15 color:HYCTColor(168, 168, 168) heigth:kCommonFontSize_15];
        _descLB.frame = CGRectMake(_addressLB.x, _zhifuLB.height+_zhifuLB.y+margin, _themeLB.width, kCommonFontSize_15);
        [self addSubview:_descLB];
        NSString *desc = _dataDic[@"invit_detail"];
        [self updateLB:_descLB title:desc];
        //
        _dyHeight=(_descLB.y+_descLB.height);
        NSMutableArray *pics = [NSMutableArray array];
        NSArray *picsPath = _dataDic[@"pics_path"];
        for (int i = 0; i<picsPath.count;i++) {
            NSDictionary *paths = picsPath[i];
            [pics addObject:HYWebDataPath(paths[@"savepath"])];
        }
        [self initScollvers:pics];
    }
    //[self initBottom];
    UIView *bottomView =  [[UIView alloc]initWithFrame:CGRectMake(0, _dyHeight+5, kAppWidth, 5)];
    bottomView.backgroundColor = HYCTColor(200, 200, 200);
    [self addSubview:bottomView];
    _dyHeight +=5;
    //     self.height = _dyHeight;
    if (_dyHeight<self.height) {
        _dyHeight = self.height;
    }
    self.frame = CGRectMake(0, 0, kAppWidth, _dyHeight);
    return self;
}
-(void)updateLB:(UILabel *)upLabel title:(NSString *)title{
    
    if (title.length<3) {
        return;
    }
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"• %@",title]];
    [str addAttribute:NSForegroundColorAttributeName value:HYCTColor(168, 168, 168) range:NSMakeRange(0, 1)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kCommonFontSize_18] range:NSMakeRange(0, 1)];
    [str addAttribute:NSForegroundColorAttributeName value:HYCTColor(120, 120, 120) range:NSMakeRange(1, str.length-1)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kCommonFontSize_15] range:NSMakeRange(1, str.length-1)];
    if (title.length>20) {
        upLabel.numberOfLines = 0;
        CGSize size = [USStringTool boundingRectWithSize:CGSizeMake(upLabel.width, 0) content:title fontsize:kCommonFontSize_16];
        upLabel.size = size;
    }
    upLabel.attributedText = str;
}
-(void)initScollvers:(NSArray *)picUrls{
    //
    NSInteger count = [picUrls count];
    if (count <=0) {
        return ;
    }
    CGFloat height = 100;
    _scollerPics = [[UIScrollView alloc]initWithFrame:CGRectMake(5, _dyHeight+kMargin*0.5, kAppWidth-10, height)];
    _scollerPics.backgroundColor = [UIColor redColor];
    _scollerPics.userInteractionEnabled = YES;
    _scollerPics.showsVerticalScrollIndicator = NO;
    _scollerPics.showsHorizontalScrollIndicator = NO;
    _scollerPics.backgroundColor = HYCTColor(245, 245, 245);
    _scollerPics.bounces = NO;
    _scollerPics.pagingEnabled = YES;
    [self addSubview:_scollerPics];
    
    CGFloat width = 0;
    if (picUrls.count>0) {
        _imgUrls = [NSMutableArray array];
    }
    for(NSInteger i = 0;i<count;i++){
        NSString *imagePath = picUrls[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.x = width;
        button.y = 0;
        button.tag = i;
        button.width = height;
        button.height = height;
        [button addTarget:self action:@selector(toscanPictureVC) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *temp = [[UIImageView alloc]initWithFrame:CGRectMake(width, 0, height, height)];
        NSURL *imgUrl = [NSURL URLWithString:imagePath];
        [temp sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"circle_default"] options:5];
        [_imgUrls addObject:imgUrl];
        temp.userInteractionEnabled = YES;
        [_scollerPics addSubview:temp];
        [_scollerPics addSubview: button];
        width += temp.width+5;
    }
    _scollerPics.contentSize = CGSizeMake(width, _scollerPics.height);
    _dyHeight= _scollerPics.height+_scollerPics.y;
}

-(void)toscanPictureVC{
    HYLog(@"toscanPictureVC");
    USPictureScanViewController *pictureScanView = [[USPictureScanViewController alloc]init];
    pictureScanView.imgsUrl= _imgUrls;
    pictureScanView.desc = pictureScanView.desc = _dataDic[@"invit_detail"];
    [_superVC.navigationController pushViewController:pictureScanView animated:YES];
}
-(void)initBottom{
    UIView *line = [USUIViewTool createLineView];
    line.frame = CGRectMake(0, _dyHeight+5, kAppWidth, 1);
    [self addSubview:line];
    //
    UILabel *quereyCountLB = [USUIViewTool createUILabelWithTitle:@"1 已经确认/" fontSize:kCommonFontSize_15 color:HYCTColor(120, 120, 120) heigth:kCommonFontSize_18];
    quereyCountLB.frame = CGRectMake(15, line.y+line.height, 100, kCommonFontSize_15);
    
    quereyCountLB.textAlignment = NSTextAlignmentRight;
    [self addSubview:quereyCountLB];
    
    [self updateLBs:quereyCountLB title:[NSString stringWithFormat:@"%@ 已经确认/",_dataDic[@"sure_count"]] change:@" 已经确认/"];
    //
    UILabel *yaoqueCountLB = [USUIViewTool createUILabelWithTitle:@"" fontSize:kCommonFontSize_15 color:HYCTColor(120, 120, 120) heigth:kCommonFontSize_18];
    yaoqueCountLB.frame = CGRectMake(quereyCountLB.x+quereyCountLB.width+1, line.y+line.height, 100, kCommonFontSize_15);
    
    yaoqueCountLB.textAlignment = NSTextAlignmentLeft;
    [self addSubview:yaoqueCountLB];
    [self updateLBs:yaoqueCountLB title:[NSString stringWithFormat:@" %@ 邀约数",_dataDic[@"invit_num"]] change:@" 邀约数"];
    
    UIButton *baomiBt = [USUIViewTool createButtonWith:@"报名"];
    baomiBt.frame = CGRectMake(kAppWidth - 80, yaoqueCountLB.y, 70, 20);
    baomiBt.titleLabel.font = [UIFont systemFontOfSize:kCommonFontSize_12];
    [baomiBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [baomiBt setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    baomiBt.backgroundColor = [UIColor whiteColor];
    baomiBt.layer.cornerRadius = 10;
    baomiBt.layer.borderColor = [HYCTColor(120, 120, 120) CGColor];
    baomiBt.layer.borderWidth = 0.8;
    baomiBt.layer.masksToBounds = YES;
    [baomiBt addTarget:self action:@selector(baomiClick) forControlEvents:UIControlEventTouchUpInside];
    _dyHeight = baomiBt.y+baomiBt.height;
    [self addSubview:baomiBt];
}
-(void)baomiClick{
    USAccount *account  = [USUserService account];
    [USWebTool POSTShowMsg:@"wangkaInviterClientcontroller/saveCustomerEnterInviter.action" showMsg:@"" paramDic:@{@"customer_id":account.id,@"inviter_id":_dataDic[@"id"]} success:^(NSDictionary *data) {
        
    } failure:^(id data) {
        
    }];
}
-(void)updateLBs:(UILabel *)upLabel title:(NSString *)title change:(NSString *)changeTile{
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:title];
    
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(0,title.length - changeTile.length )];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kCommonFontSize_18] range:NSMakeRange(0, title.length - changeTile.length)];
    [str addAttribute:NSForegroundColorAttributeName value:HYCTColor(120, 120, 120) range:NSMakeRange(title.length -(title.length - changeTile.length), str.length-(title.length -(title.length - changeTile.length)))];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kCommonFontSize_15] range:NSMakeRange(1, str.length-1)];
    CGSize size = [USStringTool boundingRectWithSize:CGSizeMake(0, kCommonFontSize_15) content:title fontsize:kCommonFontSize_16];
    upLabel.size = size;
    upLabel.attributedText = str;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //CGFloat pageNum = scrollView.contentOffset.x/kAppWidth +0.5;
}

@end
