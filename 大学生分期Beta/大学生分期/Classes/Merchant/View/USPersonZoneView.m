//
//  USPersonZoneView.m
//  大学生分期
//
//  Created by HeXianShan on 16/1/5.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import "USPersonZoneView.h"
#define kMargin 15
#define kContentMargin 10
#define kCircleSize 140
@interface USPersonZoneView()
@property(nonatomic,strong)UILabel *dateLB;
@property(nonatomic,strong)UILabel *massegeLB;
@end
@implementation USPersonZoneView
-(instancetype)initWithDic:(NSDictionary *)dic{
    @try {
        self = [super init];
        if (self) {
            CGFloat margin = 10;
            _dataDic = dic;
            self.userInteractionEnabled = YES;
            self.frame = CGRectMake(0, kMargin, kAppWidth, 100);
            _dateLB = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 60, 30)];
            _dateLB.textAlignment = NSTextAlignmentLeft;
            _dateLB.textColor = HYCTColor(30, 30, 30);
            _dateLB.text = [NSString stringWithFormat:@"%@ %@",_dataDic[@"news_time_format_day"],_dataDic[@"news_time_format_month"]];
            //_dateLB.text = @"31 十二月";
            _monthStr = _dateLB.text;
            [self addSubview:_dateLB];
            for (int i=0; i<1; i++) {
                //这里会有多个
                UIView *bgView = [[UIView alloc]init];
                bgView.backgroundColor = HYCTColor(240, 240, 240);
                bgView.frame = CGRectMake(_dateLB.width+_dateLB.x, _dyHeight==0?0:(_dyHeight+kContentMargin), kAppWidth-_dateLB.width-kMargin, 100);
                ////
               // _leftImageView = [[USCircleImageView alloc]initWithFrame:CGRectMake(margin, margin, bgView.height-margin*2, bgView.height-margin*2) imageUrls:@[HYWebDataPath(_dataDic[@"pic_path"])]];
                _leftImageView=[[USCircleImageView alloc]initWithFrame:CGRectMake(margin, margin, bgView.height-margin*2, bgView.height-margin*2) imageUrls:@[HYWebDataPath(_dataDic[@"pic_path"])] placehlderImageName:@"circle_default" options:5];
                
                [bgView addSubview:_leftImageView];
                ////
                _massegeLB = [[UILabel alloc]initWithFrame:_leftImageView.frame];
                _massegeLB.x = _leftImageView.width+margin*2;
                _massegeLB.textColor = HYCTColor(10, 10, 10);
                _massegeLB.numberOfLines = 0;
                CGSize size = CGSizeMake(bgView.width-_leftImageView.width-_leftImageView.x-margin*2,0);
                _massegeLB.font = [UIFont systemFontOfSize:kCommonFontSize_12];
                _massegeLB.text = _dataDic[@"newscontent"];
                CGSize labelsize =  [USStringTool boundingRectWithSize:size content:_massegeLB.text fontsize:kCommonFontSize_12];
                
                _massegeLB.size = labelsize;
                [bgView addSubview:_massegeLB];
                if (_massegeLB.height>bgView.height) {
                    bgView.height = _massegeLB.height+_massegeLB.y+kContentMargin;
                }
                _dyHeight+=bgView.height+(_dyHeight==0?0:kContentMargin);
                [self  addSubview:bgView];
            }
            _dyHeight += _dateLB.height+_dateLB.y-kMargin;
            
            if (self.height<_dyHeight) {
                self.height=_dyHeight;
            }
        }
        return self;
    }
    @catch (NSException *exception) {
        HYLog(@"%@",exception) ;
    }
    
    
}

-(void)setDate:(NSString *)dateStr flag:(BOOL)flag{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:dateStr];
    if (flag) {
        if (dateStr.length==2) {
            _dateLB.text = dateStr;
            _dateLB.font = [UIFont systemFontOfSize:kCommonFontSize_15];
            [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kCommonFontSize_15] range:NSMakeRange(0, 2)];
            [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kCommonFontSize_15] range:NSMakeRange(2, str.length-2)];
        }else{
            if (dateStr.length>2) {
                [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kCommonFontSize_20] range:NSMakeRange(0, 2)];
                [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kCommonFontSize_10_5] range:NSMakeRange(2, str.length-2)];
            }else{
                [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kCommonFontSize_20] range:NSMakeRange(0, 1)];
                [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kCommonFontSize_10_5] range:NSMakeRange(1, str.length-1)];
            }
        }
       
    }else{
        if (dateStr.length>2) {
            [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kCommonFontSize_20] range:NSMakeRange(0, 2)];
            [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kCommonFontSize_10_5] range:NSMakeRange(2, str.length-2)];
        }else{
            [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kCommonFontSize_20] range:NSMakeRange(0, 1)];
            [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kCommonFontSize_10_5] range:NSMakeRange(1, str.length-1)];
        }
        
    }
     _dateLB.attributedText = str;
}

@end
