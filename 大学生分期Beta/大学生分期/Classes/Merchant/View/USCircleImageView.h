//
//  USCircleImageView.h
//  大学生分期
//
//  Created by HeXianShan on 16/1/4.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
@interface USCircleImageView : UIView
@property(nonatomic,strong)NSArray  *imageUrls;
@property(nonatomic,assign)CGFloat dyHeiht;
@property(nonatomic,assign)CGFloat dyWidth;
-(instancetype)initWithFrame:(CGRect)frame imageUrls:(NSArray *)imageUrls;
-(instancetype)initWithFrame:(CGRect)frame imageUrls:(NSArray *)imageUrls placehlderImageName:(NSString *)placehlderImageName options:(SDWebImageOptions )options;
@end
