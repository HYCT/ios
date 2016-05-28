//
//  USToolBarView.m
//  大学生分期
//
//  Created by HeXianShan on 15/8/30.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USTabBarView.h"
@interface USTabBarView()
@property(nonatomic,strong)NSArray *titles;
@property(nonatomic,strong)NSArray *images;
@property(nonatomic,strong)NSArray *selectedImages;
@end
@implementation USTabBarView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.width = kAppWidth;
        self.height = frame.size.height+8;
        self.backgroundColor = [UIColor whiteColor];
        
        [self initBarButtonView];
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray*) titles images:(NSArray*)images selectedImages:(NSArray*)selectedImages deleagete:(id<UITabBarDelegate>) delegate{
    self = [super initWithFrame:frame];
    if (self) {
        self.width = kAppWidth;
        self.height = frame.size.height+2;
        self.backgroundColor = [UIColor whiteColor];
        self.delegate = delegate;
        self.titles = titles;
        self.images = images;
        self.selectedImages = selectedImages;
        [self initBarButtonView];
    }
    return  self;
}
-(void)initBarButtonView{
    UITabBar *toolBar = [[UITabBar alloc]initWithFrame:CGRectMake(0, 2, kAppWidth,  self.height-2)];
    toolBar.delegate = self.delegate;
    UIView *view = [[UIView alloc]initWithFrame:toolBar.frame];
    [view setBackgroundColor:HYCTColor(255, 255, 255)];
    //[view setBackgroundColor:[UIColor redColor]];
    view.y = toolBar.y-1;
    view.height = 1;
    toolBar.translucent = NO;
    toolBar.clearsContextBeforeDrawing = YES;
    [self addSubview:toolBar];
    [self addSubview:view];
    [toolBar setBackgroundColor:[UIColor redColor]];
    [toolBar setBackgroundImage:[[UIImage alloc]init]];
    NSMutableArray *toolBarItems = [NSMutableArray array];
    for (NSInteger i =0; i <self.titles.count; i++) {
        UITabBarItem *nearButton = [self createBarButtonWithTitle:self.titles[i] image:self.images[i] selectedmage:self.selectedImages[i] tag:i];
        [toolBarItems addObject:nearButton];
    }
    [toolBar setItems:toolBarItems animated:YES];
}
-( UITabBarItem *)createBarButtonWithTitle:(NSString *)title image:(NSString *)imageName selectedmage:(NSString *)selectedmage tag:(NSInteger)tag{
    UIImage *image = [self createOriginalImage:imageName];
     UIImage *selectedImage = [self createOriginalImage:selectedmage];
    UITabBarItem *barButton = [[UITabBarItem alloc]initWithTitle:title image:image selectedImage:selectedImage];
    NSMutableDictionary *titleTextAttri = [NSMutableDictionary dictionary];
    
    titleTextAttri[NSForegroundColorAttributeName]= HYCTColor(145, 145, 145);
    [barButton setTitleTextAttributes:titleTextAttri forState:UIControlStateSelected];
    [barButton setTitleTextAttributes:titleTextAttri forState:UIControlStateNormal];
    barButton.tag = tag;
    return barButton;
}
-(UIImage *)createOriginalImage:(NSString *)imageName{
    
    return [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

@end
