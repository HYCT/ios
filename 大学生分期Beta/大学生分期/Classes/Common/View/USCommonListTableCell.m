//
//  USSayHelloTableCell.m
//  大学生分期
//
//  Created by mac on 16/2/22.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import "USCommonListTableCell.h"
#import "USNearProfZoneViewController.h"

@interface USCommonListTableCell()
@property(nonatomic,strong) UIView *bgview;
@property(nonatomic,strong) UILabel *label_0 ;
@property(nonatomic,strong) UILabel *label_1 ;
@property(nonatomic,strong) UILabel *label_2 ;
@end

@implementation USCommonListTableCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier data:(NSDictionary *)data{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kAppWidth, 50) ];
        [self.contentView addSubview:_bgview] ;
        
        
        
        NSArray *keys;
        NSInteger  count;
        
        keys = [data allKeys];
        count = [keys count];
        CGFloat margin = 20 ;
        
        if (count <=3 ) {
            
            if (count == 1) {
                _label_0 = [USUIViewTool createUILabelWithTitle:@"1" fontSize:14 color:[UIColor grayColor] x:margin y:5 width:kAppWidth-2*margin heigth:40];
                [_bgview addSubview:_label_0] ;
            }
            if (count == 2) {
                _label_0 = [USUIViewTool createUILabelWithTitle:@"2" fontSize:14 color:[UIColor grayColor] x:margin y:5 width:(kAppWidth-3*margin)/2 heigth:40];
                [_bgview addSubview:_label_0] ;
                _label_1 = [USUIViewTool createUILabelWithTitle:@"" fontSize:14 color:[UIColor grayColor] x:_label_0.x+_label_0.width+margin y:5 width:(kAppWidth-3*margin)/2 heigth:40];
                [_bgview addSubview:_label_1] ;
            }
            if (count == 3) {
                _label_0 = [USUIViewTool createUILabelWithTitle:@"3" fontSize:14 color:[UIColor grayColor] x:margin y:5 width:(kAppWidth-4*margin)/3 heigth:40];
                [_bgview addSubview:_label_0] ;
                _label_1 = [USUIViewTool createUILabelWithTitle:@"" fontSize:14 color:[UIColor grayColor] x:_label_0.x+_label_0.width+margin y:5 width:(kAppWidth-4*margin)/3 heigth:40];
                [_bgview addSubview:_label_1] ;
                _label_2 = [USUIViewTool createUILabelWithTitle:@"" fontSize:14 color:[UIColor grayColor] x:_label_1.x+_label_1.width+margin y:5 width:(kAppWidth-4*margin)/3 heigth:40];
                [_bgview addSubview:_label_2] ;
            }
        }
        
        
        
        [self setData:data] ;
        
        
        
        UIView *line = [USUIViewTool createLineView:5 y:_bgview.height-1 width:kAppWidth-10] ;
        [_bgview addSubview:line] ;
        
    }
    return self;
}


-(void)setData:(NSMutableDictionary *)data {
    
    
    NSArray *keys;
    NSInteger i, count;
    id key, value;
    
    keys = [data allKeys];
    count = [keys count];
    
    
    
    for (i = 0; i < count; i++)
    {
        
        key = [keys objectAtIndex: i];
        value = [data objectForKey: key];
        NSString *value_str= value ;
        switch (i) {
            case 0:
                [_label_0 setText:value_str] ;
                break;
            case 1:
                _label_1.text = value_str;
                break;
            case 2:
                _label_2.text = value_str;
                break;
                
            default:
                break;
        }
        
    }
    
    
    
    
    
}





@end
