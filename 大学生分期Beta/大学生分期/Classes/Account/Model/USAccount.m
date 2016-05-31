//
//  USAccount.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/9.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USAccount.h"

@implementation USAccount
+(id)accountWithDic:(NSDictionary *)dic{
    if (dic ==nil) {
        return nil ;
    }
    NSLog(@"usaccount:%@",dic) ;
    if ([dic count]>0) {
        USAccount *result =  [[USAccount alloc]init];
        result.id = dic[@"id"];
        result.email = dic[@"email"];
        result.inviter = dic[@"inviter"];
        result.name = dic[@"name"];
        result.note = dic[@"note"];
        result.pwd = dic[@"pwd"];
        result.sign = dic[@"sign"];
        result.personnerpic = dic[@"personnerpic"];
        result.inviter_id = dic[@"inviter_id"];
        result.invitcodepic = dic[@"invitcodepic"];
        if (result.invitcodepic!= nil&&result.invitcodepic.length>1) {
            NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:HYWebDataPath(result.invitcodepic)]];
            result.invitcodeImg= [UIImage imageWithData:imgData];
        }
        if (result.personnerpic!= nil&&result.personnerpic.length>1) {
            NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:HYWebDataPath(result.personnerpic)]];
            result.personnerpicImg= [UIImage imageWithData:imgData];
        }
        result.rs_time = dic[@"rs_time"];
        result.wang_bi = [dic[@"wang_bi"] integerValue];
        result.telephone = dic[@"telephone"];
        result.headpic = dic[@"headpic"];
        result.realnametype = [dic[@"realnametype"] integerValue];
        result.surplusmoney  = [dic[@"surplusmoney"] doubleValue];
        result.isbindbankcard = [dic[@"isbindbankcard"] integerValue];
        result.limitmoney = [dic[@"limitmoney"] doubleValue];
        //汇付账号
        result.ishashuifu_account =[dic[@"ishashuifu_account"] integerValue] ;
        if (result.headpic!= nil&&result.headpic.length>1) {
            NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:HYWebDataPath(result.headpic)]];
            result.headerImg = [UIImage imageWithData:imgData];
        }
        return result;
    }
    
    return  nil;
}
- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    _email = [aDecoder decodeObjectForKey:@"email"];
    _id = [aDecoder decodeObjectForKey:@"id"];
    _sign = [aDecoder decodeObjectForKey:@"sign"];
    _inviter = [aDecoder decodeObjectForKey:@"inviter"];
    _inviter_id = [aDecoder decodeObjectForKey:@"inviter_id"];
    _personnerpic = [aDecoder decodeObjectForKey:@"personnerpic"];
    _personnerpicImg = [aDecoder decodeObjectForKey:@"personnerpicImg"];
    _name = [aDecoder decodeObjectForKey:@"name"];
    _note = [aDecoder decodeObjectForKey:@"note"];
    _pwd = [aDecoder decodeObjectForKey:@"pwd"];
    _wang_bi = [aDecoder decodeIntegerForKey:@"wang_bi"];
    _rs_time = [aDecoder decodeObjectForKey:@"rs_time"];
    _telephone = [aDecoder decodeObjectForKey:@"telephone"];
    _headerImg  = [aDecoder decodeObjectForKey:@"headerImg"];
    _headpic = [aDecoder decodeObjectForKey:@"headpic"];
    _realnametype = [aDecoder decodeIntegerForKey:@"realnametype"];
    _ishashuifu_account =[aDecoder decodeIntegerForKey:@"ishashuifu_account"] ;
    _surplusmoney = [aDecoder decodeDoubleForKey:@"surplusmoney"];
    _isbindbankcard = [aDecoder decodeIntegerForKey:@"isbindbankcard"];
    _limitmoney = [aDecoder decodeDoubleForKey:@"limitmoney"];
    _invitcodepic = [aDecoder decodeObjectForKey:@"invitcodepic"];
    _invitcodeImg = [aDecoder decodeObjectForKey:@"invitcodeImg"];
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_email forKey:@"email"];
    [aCoder encodeObject:_id forKey:@"id"];
    [aCoder encodeObject:_inviter forKey:@"inviter"];
    [aCoder encodeObject:_inviter_id forKey:@"inviter_id"];
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_note forKey:@"note"];
    [aCoder encodeObject:_pwd forKey:@"pwd"];
    [aCoder encodeObject:_rs_time forKey:@"rs_time"];
    [aCoder encodeObject:_telephone forKey:@"telephone"];
    [aCoder encodeObject:_headpic forKey:@"headpic"];
    [aCoder encodeObject:_personnerpicImg forKey:@"personnerpicImg"];
    [aCoder encodeObject:_personnerpic forKey:@"personnerpic"];
    [aCoder encodeObject:_headerImg forKey:@"headerImg"];
    [aCoder encodeInteger:_realnametype  forKey:@"realnametype"];
    [aCoder encodeInteger:_ishashuifu_account  forKey:@"ishashuifu_account"];
    [aCoder encodeDouble:_surplusmoney forKey:@"surplusmoney"];
    [aCoder encodeDouble:_limitmoney forKey:@"limitmoney"];
    [aCoder encodeInteger:_isbindbankcard forKey:@"isbindbankcard"];
    [aCoder encodeObject:_invitcodepic forKey:@"invitcodepic"];
    [aCoder encodeObject:_invitcodeImg forKey:@"invitcodeImg"];
    [aCoder encodeObject:_sign forKey:@"sign"];
    [aCoder encodeInteger:_wang_bi forKey:@"wang_bi"];
}
-(NSString *)strSurplusmoney{
    return [NSString stringWithFormat:@"%.02f",_surplusmoney*1.00];
}
-(NSString *)strLimitmoney{
    return [NSString stringWithFormat:@"%.02f",_limitmoney*1.00];
}
@end
