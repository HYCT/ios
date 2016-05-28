//
//  USButton.h
//  大学生分期
//
//  Created by HeXianShan on 15/10/6.
//  Copyright © 2015年 hongyunct. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "USTextField.h"
typedef void(^MakeParamDic) (NSMutableDictionary *);
@interface USButton : UIButton
@property(nonatomic,strong)UITextField *toModifyTextField;
@property(nonatomic,copy)NSString *dataUrl;
@property(nonatomic,copy)NSString *msg;
@property(nonatomic,strong)NSMutableDictionary *paramsDic;
@property(nonatomic,copy)MakeParamDic makeParamDic;
@property(nonatomic,copy) NSString *tableTitle;
@property(nonatomic,copy)FetchDataBlock fetchDataBlock;
@property(nonatomic,copy)MakeViewBlock makeViewBlock;
@end
