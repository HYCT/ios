//
//  USCricleDetailViewViewController.m
//  大学生分期
//
//  Created by HeXianShan on 16/1/5.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import "USCircleDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "USImageButton.h"
#import "USCommentListViewController.h"
@interface USCircleDetailViewController ()
@property(nonatomic,strong)USAccount *account;
@property(nonatomic,strong)UILabel *zangLabel ;
@property(nonatomic,strong)UILabel *commentLabel ;
@property(nonatomic,strong)UIImageView *bgImageView;
@property(nonatomic,strong)UILabel *contentLB;
@property(nonatomic,strong)NSDictionary *dataDic;
@property(nonatomic,assign)int zang_my ;
@end

@implementation USCircleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor blackColor]] ;
    _account = [USUserService accountStatic];
    [super initRightImgButton];
   
    [self loadData];
}
-(void)loadData{
    
    [USWebTool POST:@"wangkaClientController/getNewsMessageDetailByid.action" showMsg:@"正在玩命加载..." paramDic:@{@"customer_id":_account.id,@"id":_newsId} success:^(NSDictionary *dataDic) {
        _dataDic = dataDic;
        _zang_my =[_dataDic[@"zang_my"] intValue] ;
      [self initViews];
    } failure:^(id data) {
        
    }];
    
}



-(void)initViews{
    _bgImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    
    //自适应
    [USUIViewTool imagesSelfFit:_bgImageView] ;
    [self.view addSubview:_bgImageView];
    //[_bgImageView sd_setImageWithURL:[NSURL URLWithString:HYWebDataPath(_dataDic[@"data"][@"pic_path"])]];
    //默认图片和后台下载
    [_bgImageView sd_setImageWithURL:[NSURL URLWithString:HYWebDataPath(_dataDic[@"data"][@"pic_path"])] placeholderImage:[UIImage imageNamed:@"circle_default"] options:5];
   
    //最低下一行的高度
    CGFloat height = 40;
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kAppWidth, 0)];
    UIColor *gray_alpha =[UIColor colorWithWhite:0.5 alpha:0.6] ;
    bgView.backgroundColor = gray_alpha;
    
    _contentLB = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, kAppWidth-20, 0)];
    NSString *text = @"这是一个测试！！！adsfsaf时发生发勿忘我勿忘我勿忘我勿忘我勿忘我阿阿阿阿阿阿阿阿阿阿阿阿阿啊00000000阿什顿eeeeee";
    text=_dataDic[@"data"][@"newscontent"] ;
    
    _contentLB.text = text;
    [_contentLB setNumberOfLines:0];
    [_contentLB setTextColor:[UIColor whiteColor]];
    [_contentLB setFont:[UIFont systemFontOfSize:14]] ;
    [_contentLB setLineBreakMode:NSLineBreakByTruncatingTail] ;
    CGSize maximumLabelSize = CGSizeMake(kAppWidth-20, 9999);//labelsize的最大值
    //关键语句
    CGSize expectSize = [_contentLB sizeThatFits:maximumLabelSize];
    _contentLB.frame = CGRectMake(_contentLB.x,5, kAppWidth-20, expectSize.height);
    [bgView addSubview:_contentLB];
    bgView.height = _contentLB.y+_contentLB.height +5  ;
    bgView.y = kAppHeight -bgView.height -2*height ;
    [bgView addSubview:_contentLB];
    [self.view addSubview:bgView];
    
    
    //底行
    UIView *bgview1 = [[UIView alloc]initWithFrame:CGRectMake(0, kAppHeight-2*height, kAppWidth, height)];
    UIColor *black_alpha =[UIColor colorWithWhite:0.5 alpha:0.8] ;
    bgview1.backgroundColor = black_alpha;
    //点赞
    UIView *zangView = [self createCommentBottun:[NSString stringWithFormat:@"%@",_dataDic[@"data"][@"zang_count"]] imageName:@"wangka_zang_white" type:0];
    zangView.y = 10;
    zangView.x = kAppWidth -2*zangView.width -10 ;
    //uiview 单击
    UITapGestureRecognizer *tapGesture_zang = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(zangsAction:)];
    [zangView addGestureRecognizer:tapGesture_zang];
    [bgview1 addSubview:zangView];
    //评论
    UIView *commentView = [self createCommentBottun:[NSString stringWithFormat:@"%@",_dataDic[@"data"][@"comment_count"]] imageName:@"wangka_pinglun_white" type:1];
    commentView.y = zangView.y;
    commentView.x = zangView.x + zangView.width +10;
    //uiview 单击
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(CommentListAction:)];
    [commentView addGestureRecognizer:tapGesture];
    [bgview1 addSubview:commentView];
    //
    [self.view addSubview:bgview1];
}


//评论和赞
-(UIView *)createCommentBottun:(NSString *)title imageName:(NSString *)imageNmae type:(int )type{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0,0, 60, 40)];
    UIImage *img = [UIImage imageNamed:imageNmae];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:img];
    imageView.size = CGSizeMake(20, 20);
    //type=0为赞，1为评论
    if ( 0 == type ) {
        _zangLabel = [USUIViewTool createUILabelWithTitle:title fontSize:kCommonFontSize_15 color:[UIColor whiteColor] heigth:20];
        _zangLabel.frame = CGRectMake(imageView.width+5, imageView.y+2, bgView.width-imageView.width, 20);
        [bgView addSubview:_zangLabel];
    }else{
        _contentLB = [USUIViewTool createUILabelWithTitle:title fontSize:kCommonFontSize_15 color:[UIColor whiteColor] heigth:20];
        _contentLB.frame = CGRectMake(imageView.width+5, imageView.y+2, bgView.width-imageView.width, 20);
        [bgView addSubview:_contentLB];
 
    }
   
    [bgView addSubview:imageView];
    return bgView;
}
//评论列表
-(void)CommentListAction:(id)sender{
    USCommentListViewController *detailVC = [[USCommentListViewController alloc]init];
    detailVC.msgId=_newsId;
    [self.navigationController pushViewController:detailVC animated:YES];
}
//点赞
-(void)zangsAction:(id)sender{
    @try {
        int zang_count = [_zangLabel.text intValue] ;
        NSString *zang_str = [NSString stringWithFormat:@"%d",zang_count] ;
        if (_zang_my ==0) {
            _zang_my = 1 ;
            zang_count +=1 ;
        }else{
            _zang_my = 0 ;
            if (zang_count>0) {
                zang_count -=1 ;
            }
        }
        zang_str =[NSString stringWithFormat:@"%d",zang_count] ;
        [_zangLabel setText:zang_str] ;
        //保存数据库
        [USWebTool POST:@"wangkaClientController/saveNewsZang.action" paramDic:@{@"news_id":_newsId,@"customer_id":_account.id} success:^(id data) {
            
        } failure:^(id data) {
            
        }];
    }
    @catch (NSException *exception) {
        HYLog(@"%@",exception) ;
    }
    
    
}

@end
