//
//  USAccount.h
//  大学生分期
//
//  Created by HeXianShan on 15/9/9.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface USAccount : NSObject<NSCoding>
@property(nonatomic,strong)NSDictionary *valueDic;

@property(nonatomic,copy)NSString *email;
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *inviter;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *sign;
@property(nonatomic,copy)NSString *note;
@property(nonatomic,copy)NSString *pwd;
@property(nonatomic,copy)NSString *headpic;
@property(nonatomic,copy)NSString *personnerpic;
@property(nonatomic,copy)NSString *inviter_id;
@property(nonatomic,copy)NSString *rs_time;
@property(nonatomic,copy)NSString *invitcodepic;
@property(nonatomic,copy)NSString *telephone;
@property(nonatomic,assign)NSInteger wang_bi;
@property(nonatomic,assign)NSInteger realnametype;
@property(nonatomic,assign)NSInteger isbindbankcard;
@property(nonatomic,assign)CGFloat limitmoney;
@property(nonatomic,assign)CGFloat surplusmoney;
@property(nonatomic,copy)UIImage *headerImg;
@property(nonatomic,copy)UIImage *invitcodeImg;
@property(nonatomic,copy)UIImage *personnerpicImg;

-(NSString *)strSurplusmoney;
-(NSString *)strLimitmoney;
+(id)accountWithDic:(NSDictionary *)dic;
@end
