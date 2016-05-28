//
//  USPictureScanViewController.h
//  大学生分期
//
//  Created by HeXianShan on 16/1/9.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import "USBaseViewController.h"

@interface USPictureScanViewController : USBaseViewController
@property(nonatomic,strong) UIScrollView *scollerPics;
@property(nonatomic,strong) NSArray *imgsUrl;
@property(nonatomic,copy) NSString *desc;
@end
