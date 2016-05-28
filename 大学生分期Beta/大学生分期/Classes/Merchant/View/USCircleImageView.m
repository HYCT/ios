//
//  USCircleImageView.m
//  大学生分期
//
//  Created by HeXianShan on 16/1/4.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import "USCircleImageView.h"
#define kMaxCol 2
#define kMaxRow 2
#define kMaxWidth 120
#define kMargin 2
@implementation USCircleImageView

-(instancetype)initWithFrame:(CGRect)frame imageUrls:(NSArray *)imageUrls{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.imageUrls = imageUrls;
        [self initSubViews];
    }
    _dyHeiht = self.height;
    _dyWidth = self.width;
    return self;
}
-(void)initSubViews{
    NSInteger count = _imageUrls.count;
    CGFloat width = self.width;;
    CGFloat height = self.height;
    if (count==2) {
        width = (self.width-kMargin)*0.5;
        height = self.height;
    }else if (count>=3){
        width = (self.width-kMargin)*0.5;
        height = (self.height-kMargin)*0.5;
        
    }
    int col = 0;
    int row = 0;
    for (NSInteger i = 0; i<count; i++) {
        UIImageView *view =[self createUIImageView:_imageUrls[i]];
        [self addSubview:view];
        //view.frame = CGRectMake(col*width+col*kMargin, row*height+row*kMargin, width, height);
        view.frame = CGRectMake(col*width+col*kMargin, row*height+row*kMargin, width, height);
        //view.frame.origin
        if (i==1) {
            row++;
            col=0;
        }else{
            col++;
        }
    }
}

-(UIImageView *)createUIImageView:(NSString *)imageUrl{
    UIImageView  *imageView = [[UIImageView alloc]init];
    //自适应
    [USUIViewTool imagesSelfFit:imageView] ;
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    return imageView;
}

//有默认图 options不知道可以传-1
//失败后重试
//SDWebImageRetryFailed = 1 << 0,

//UI交互期间开始下载，导致延迟下载比如UIScrollView减速。
//SDWebImageLowPriority = 1 << 1,

//只进行内存缓存
//SDWebImageCacheMemoryOnly = 1 << 2,

//这个标志可以渐进式下载,显示的图像是逐步在下载
//SDWebImageProgressiveDownload = 1 << 3,

//刷新缓存
//SDWebImageRefreshCached = 1 << 4,

//后台下载
//SDWebImageContinueInBackground = 1 << 5,

//NSMutableURLRequest.HTTPShouldHandleCookies = YES;

//SDWebImageHandleCookies = 1 << 6,

//允许使用无效的SSL证书
//SDWebImageAllowInvalidSSLCertificates = 1 << 7,

//优先下载
//SDWebImageHighPriority = 1 << 8,

//延迟占位符
//SDWebImageDelayPlaceholder = 1 << 9,

//改变动画形象
//SDWebImageTransformAnimatedImage = 1 << 10,
-(instancetype)initWithFrame:(CGRect)frame imageUrls:(NSArray *)imageUrls placehlderImageName:(NSString *)placehlderImageName options:(SDWebImageOptions )options{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.imageUrls = imageUrls;
        [self initSubViews:placehlderImageName options:options];
    }
    _dyHeiht = self.height;
    _dyWidth = self.width;
    return self;
}
-(void)initSubViews:(NSString *)placehlderImageName options:(SDWebImageOptions )options{
    NSInteger count = _imageUrls.count;
    CGFloat width = self.width;;
    CGFloat height = self.height;
    if (count==2) {
        width = (self.width-kMargin)*0.5;
        height = self.height;
    }else if (count>=3){
        width = (self.width-kMargin)*0.5;
        height = (self.height-kMargin)*0.5;
        
    }
    int col = 0;
    int row = 0;
    for (NSInteger i = 0; i<count; i++) {
        UIImageView *view =[self createUIImageView:_imageUrls[i] placehlderImageName:placehlderImageName options:options];
        [self addSubview:view];
        //view.frame = CGRectMake(col*width+col*kMargin, row*height+row*kMargin, width, height);
        view.frame = CGRectMake(col*width+col*kMargin, row*height+row*kMargin, width, height);
        //view.frame.origin
        if (i==1) {
            row++;
            col=0;
        }else{
            col++;
        }
    }
}
//有默认的图片
-(UIImageView *)createUIImageView:(NSString *)imageUrl placehlderImageName:(NSString *)placehlderImageName options:(SDWebImageOptions )options{
    UIImageView  *imageView = [[UIImageView alloc]init];
    //自适应
    [USUIViewTool imagesSelfFit:imageView] ;
    if (options) {
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:placehlderImageName] options:options ];
    }else{
       [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:placehlderImageName] options:SDWebImageProgressiveDownload];
    }
    
    //[imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    return imageView;
}

@end
