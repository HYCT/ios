//
//  USCircleListContentView.m
//  大学生分期
//
//  Created by HeXianShan on 16/1/4.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import "USCircleListContentView.h"
#import "USCommentListViewController.h"
#import "USNearProfZoneViewController.h"
#import "UIImageView+WebCache.h"
#define kMargin 5
#define kCircleSize 140
@interface USCircleListContentView()
@property(nonatomic,assign)BOOL flag;
@property(nonatomic,assign)BOOL relaodflag;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,strong)NSMutableArray *names;
@property(nonatomic,strong)UINavigationController *navController;
@end
@implementation USCircleListContentView

-(instancetype)initWithDic:(NSDictionary *)dic  customerId:(NSString *)coustomerId tableview:(UITableView *)tablview navController:(UINavigationController *)navController{
    @try {
        _tableView = tablview ;
        _navController = navController ;
        self = [super init];
        _dataDic = dic;
        
        _names = [NSMutableArray array];
        
        self.userInteractionEnabled = YES;
        self.frame = CGRectMake(0, kMargin, kAppWidth, 120);
        //头像
        _headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kMargin*2, kMargin*3, 50, 50)];
        [_headerImageView sd_setImageWithURL:[NSURL URLWithString:HYWebDataPath(_dataDic[@"headpic"])]];
        [self addSubview:_headerImageView];
        //创建透明按钮用来覆盖头像，单击时跳转到对应的用户空间
        //UIButton *btn_head = [[USUIViewTool createButtonWith:@"sss"]initWithFrame:CGRectMake(_headerImageView.x, _headerImageView.y, _headerImageView.width, _headerImageView.height)] ;
        UIButton *btn_head = [[UIButton alloc]initWithFrame:CGRectMake(_headerImageView.x, _headerImageView.y, _headerImageView.width, _headerImageView.height)] ;
        
        [btn_head addTarget:self action:@selector(headpicClick:) forControlEvents:UIControlEventTouchUpInside] ;
        [self addSubview:btn_head] ;
        
        
        //账户名称
        _nameLB = [USUIViewTool createUILabelWithTitle:_dataDic[@"name"] fontSize:kCommonFontSize_15 color:HYCTColor(68, 160, 160) heigth:kCommonFontSize_15];
        _nameLB.frame = CGRectMake(_headerImageView.x+_headerImageView.width+kMargin*2, _headerImageView.y, kAppWidth-2*kMargin-_headerImageView.x-_headerImageView.width-2*kMargin, kCommonFontSize_15);
        [self addSubview:_nameLB];
        //内容
        _contentLB = [USUIViewTool createUILabelWithTitle:@"" fontSize:kCommonFontSize_15 color:[UIColor blackColor] heigth:0];
        _contentLB.numberOfLines = 0;
        _contentLB.frame = _nameLB.frame;
        _contentLB.y = _nameLB.y+_nameLB.height+kMargin;
        _contentLB.size = [USStringTool boundingRectWithSize:CGSizeMake(kAppWidth-_contentLB.x, 0) content: _dataDic[@"newscontent"] fontsize:kCommonFontSize_15];
        _contentLB.text = _dataDic[@"newscontent"];
        [self addSubview:_contentLB];
        
        //图片
        
        // UIImageView *newsImage = [[UIImageView alloc]initWithFrame:CGRectMake(_contentLB.x,  _headerImageView.y+_headerImageView.height + kMargin, kCircleSize, kCircleSize)];
        //[newsImage sd_setImageWithURL:[NSURL URLWithString:HYWebDataPath(_dataDic[@"pic_path"])]];
        
        _imagesView =[[USCircleImageView alloc]initWithFrame:CGRectMake(_contentLB.x, _headerImageView.y+_headerImageView.height + kMargin, kCircleSize, kCircleSize)  imageUrls:@[HYWebDataPath(_dataDic[@"pic_path"])] placehlderImageName:@"circle_default" options:5];
        //_imagesView = [[USCircleImageView alloc]initWithFrame:CGRectMake(_contentLB.x, _headerImageView.y+_headerImageView.height + kMargin, kCircleSize, kCircleSize) imageUrls:@[HYWebDataPath(_dataDic[@"pic_path"])]  ];
        [self addSubview:_imagesView];
        
        //时间
        _timeLB = [USUIViewTool createUILabelWithTitle:_dataDic[@"news_time"] fontSize:kCommonFontSize_12 color:HYCTColor(168, 168, 168) heigth:kCommonFontSize_12];
        _timeLB.frame = CGRectMake(_imagesView.x, _imagesView.y+_imagesView.height+kMargin*2, kAppWidth-_imagesView.x, kCommonFontSize_15);
        [self addSubview:_timeLB];
        
        NSArray *zangData = _dataDic[@"zang_data"];
        _title = @"点赞";
        //记载自己是否赞过
        _flag = NO;
        _relaodflag = NO;
        //是否有赞
        BOOL havZang = NO;
        if (zangData!=nil&&zangData.count>0) {
            havZang = YES;
            [zangData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSDictionary *temp = obj;
                NSString *idstr = temp[@"id"];
                [_names addObject:temp[@"name"]];
                if ([coustomerId isEqualToString:idstr]) {
                    _flag = YES;
                }
            }];
        }
        __block CGFloat zangwidth = 80;
        __block CGFloat zangX = kAppWidth-2*zangwidth -2*kMargin;
        if (_flag) {
            _title = @"取消赞";
        }
        //
        //点赞
        _surpportBt = [[USImageButton alloc]initWithFrame:CGRectMake(zangX, _timeLB.height+_timeLB.y+kMargin, zangwidth, 25) title:_title imageName:@"wangka_zang"];
        __block NSDictionary *data = _dataDic;
        
        _surpportBt.clickBlock = ^(){
            if (_flag==YES) {
                _title = @"点赞";
                _flag = NO;
                _relaodflag = YES;
                [_names removeObject:_account.name];
            }else{
                _title = @"取消赞";
                _flag = YES;
                _relaodflag = YES;
                if (_names.count==0) {
                    [_names addObject:_account.name];
                }else{
                    [_names insertObject:_account.name atIndex:0];
                }
            }
            [self addZangLabel:_names] ;
            _surpportBt.titleLB.text = _title;
            //保存数据库
            [USWebTool POST:@"wangkaClientController/saveNewsZang.action" paramDic:@{@"news_id":data[@"id"],@"customer_id":coustomerId} success:^(id data) {
                
            } failure:^(id data) {
                
            }];
        };
        [self addSubview:_surpportBt];
        
        //评论
        _commentBt = [[USImageButton alloc]initWithFrame:CGRectMake(_surpportBt.x+_surpportBt.width+kMargin, _surpportBt.y, zangwidth, 25) title:@"评论" imageName:@"wangka_pinglun"];
        _commentBt.clickBlock=^(){
            USCommentListViewController *briefVC = [[USCommentListViewController alloc]init];
            briefVC.msgId = _dataDic[@"id"] ;
            [_navController pushViewController:briefVC animated:YES];
        };
        
        [self addSubview:_commentBt];
        //
        self.height = _surpportBt.y+_surpportBt.height+kMargin;
        //赞列表
        if (havZang) {
            //[self createZangsView:self.height zangs:zangs];
            [self createZangsViewLabel:self.height names:_names];
        }
        else{
            self.height+=kMargin*3;
        }
        [self addLine];
        
    }
    @catch (NSException *exception) {
        HYLog(@"圈子创建单元格异常：%@",exception) ;
    }
    
    return self;
}
-(NSString *)arrayTostring:(NSArray *)array{
    __block NSMutableString *zangs = [NSMutableString string];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *zang = obj;
        [zangs appendString:zang];
    }];
    return (NSString *)zangs;
}
-(void)addLine{
    _line = [USUIViewTool createLineView];
    _line.frame = CGRectMake(0,  self.height+kMargin,kAppWidth, 1);
    _line.backgroundColor = HYCTColor(227, 227, 227);
    _dyHeight = self.height ;
    [self addSubview:_line];
}

-(void)updateLine{
    if (nil !=_zangListView) {
        if (_zangListView.hidden==NO) {
            _line.y=_zangListView.y+_zangListView.height+2*kMargin ;
        }else{
            _line.y=_zangListView.y+2*kMargin ;
        }
        self.height =_line.y+_line.height +kMargin;
        _dyHeight = self.height ;
    }
    
}

/**
 赞列表
 **/
-(void)createZangsViewLabel:(CGFloat)y  names:(NSMutableArray *)names{
    if (nil==names||[names count]==0) {
        return ;
    }
    
    //赞的外框
    _zangListView = [[UIView alloc]initWithFrame:CGRectMake(_contentLB.x, y+kMargin, kAppWidth-_contentLB.x-10, 0)];
    _zangListView.backgroundColor = [UIColor whiteColor];
    //尖头图片
    UIImage *img = [UIImage imageNamed:@"zhanghu_trade_detail_grey"];
    UIImageView *arrow = [[UIImageView alloc]initWithFrame:CGRectMake(2*kMargin, 0, 10, 10)];
    arrow.image = img;
    //高度加
    _zangListView.height +=arrow.height ;
    [_zangListView addSubview:arrow] ;
    self.height = _zangListView.y +_zangListView.height ;
    [self addSubview:_zangListView] ;
    //赞列表
    [self initZangLabel:names] ;
    
}

//初始化赞行
-(void)initZangLabel:(NSMutableArray *)names{
    
    //灰色的一条
    _zangLabelBg  = [[UIView alloc]initWithFrame:CGRectMake(0, 10,_zangListView.width, 0)];
    _zangLabelBg.backgroundColor = HYCTColor(240, 240, 240);
    
    UIImageView *zangImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kMargin, kMargin, 15, 15)];
    zangImageView.image = [UIImage imageNamed:@"wangka_zang"];
    //高度
    _zangLabelBg.height =zangImageView.y +zangImageView.height +2*kMargin ;
    [_zangLabelBg addSubview:zangImageView];
    //高度加
    _zangListView.height +=_zangLabelBg.height ;
    [_zangListView addSubview:_zangLabelBg] ;
    //文本
    _zangLabel  = [USUIViewTool createUILabelWithTitle:@"" fontSize:kCommonFontSize_15 color:[UIColor blackColor] heigth:0];
    _zangLabel.numberOfLines = 0;
    _zangLabel.frame = _zangLabelBg.frame;
    _zangLabel.y = zangImageView.y;
    _zangLabel.x = zangImageView.x +zangImageView.width +kMargin;
    _zangLabel.size = [USStringTool boundingRectWithSize:CGSizeMake(_zangLabelBg.width-zangImageView.width-zangImageView.x-kMargin, 0) content:@"" fontsize:kCommonFontSize_15];
    //更新赞
    [self updateZangLabel:names] ;
    
    
}
/**
 **
 获取赞字符串
 **/
-(NSMutableString *)getZangString:(NSMutableArray *)names{
    long size =[names count] ;
    NSMutableString *label_str =[[NSMutableString alloc]init] ;
    if (size >0) {
        for (int i=0; i<size; i++) {
            if (i !=0) {
                [label_str appendString:@","];
            }
            NSString *temp = names[i] ;
            [label_str appendString:temp];
        }
    }
    return label_str ;
}
//更新赞
-(void)updateZangLabel:(NSMutableArray *)names{
    NSMutableString *label_str =[[NSMutableString alloc]init] ;
    label_str =[self getZangString:names] ;
    _zangLabel.text = label_str;
    _zangLabel.size = [USStringTool boundingRectWithSize:CGSizeMake(_zangLabelBg.width, 0) content:label_str fontsize:kCommonFontSize_15];
    if (_zangLabel.height>_zangLabelBg.height) {
        _zangLabelBg.height = _zangLabel.height ;
        _zangListView.height +=_zangLabelBg.height ;
    }
    [_zangLabelBg addSubview:_zangLabel];
    [_zangListView addSubview:_zangLabelBg];
    self.height = _zangListView.y + _zangListView.height ;
    
}

-(void)addZangLabel:(NSMutableArray *)names{
    if ([names count] >0) {
        if (nil==_zangListView) {
            [self createZangsViewLabel:_surpportBt.y +4*kMargin names:names] ;
            [self updateLine] ;
            [_tableView reloadData] ;
            
        }else{
            _zangListView.hidden = NO ;
            [self updateZangLabel:names] ;
            [self updateLine] ;
            [_tableView reloadData] ;
        }
        
    }else{
        if (nil!=_zangListView) {
            _zangListView.hidden=YES ;
            [self updateLine] ;
            [_tableView reloadData] ;
        }
    }
}

//头像跳转链接
-(void)headpicClick:(UIButton *)sender{
    
    USNearProfZoneViewController *profZoneVC = [[USNearProfZoneViewController alloc]init];
    profZoneVC.customer_id = _dataDic[@"customer_id"];
    [_navController pushViewController:profZoneVC animated:YES];
}

@end
