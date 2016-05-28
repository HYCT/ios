//
//  HYNews.h
//  红云创投
//
//  Created by HeXianShan on 15/8/25.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYNews : NSObject
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *content;
@property(nonatomic,copy) NSString *realeaseTime;
@property(nonatomic,assign)CGFloat cellHeight;
@end
