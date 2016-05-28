//
//  USGridView.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/1.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USGridView.h"
#import "USGridCellView.h"
@interface USGridView()
@property(nonatomic,assign)CGFloat cellHeight;
@end
@implementation USGridView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame itemTitles:(NSArray *)itemTitles
                  itemImages:(NSArray *)itemImageNames rowCount:(NSInteger) colCount delegate:(id<USGridCellViewDelegate>) delegate{
    self = [self initWithFrame:frame];
    if (self) {
        if ([itemTitles count]) {
            CGFloat rowCount = [itemTitles count]%colCount == 0?[itemTitles count]/colCount:
            [itemTitles count]/colCount+1;
            self.cellHeight = frame.size.height/rowCount-rowCount-1;
            UIView *line = nil;
            CGFloat width = kAppWidth*1.0/colCount-colCount;
            CGFloat y = 0;
            CGFloat rowIndex = 0;
            for (NSInteger i =0; i<itemTitles.count; i++) {
                
                if (i&&i%colCount==0) {
                    y = i/colCount * self.cellHeight;
                  line = [self createLine];
                    line.y = y;
                    line.width = kAppWidth;
                    line.height = 1;
                    y+=1;
                    rowIndex = 0;
                    [self addSubview:line];
                }
                USGridCellView *cell = [[USGridCellView alloc]initWithFrame:CGRectMake(rowIndex*width+10,  y, width, self.cellHeight)];
                [cell setIndex:i];
                [cell setTitle:itemTitles[i]];
                [cell setImageName:itemImageNames[i]];
                cell.delegate = delegate;
                [self addSubview:cell];
                if (rowIndex!=colCount-1) {
                    line = [self createLine];
                    line.x =cell.x+cell.width+1;
                    line.y = y;
                    [self addSubview:line];
                }
                rowIndex++;
        }
      }
    }
    return self;
}
-(UIView *)createLine{
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1,  self.cellHeight)];
    [line setBackgroundColor:HYCTColor(243, 243, 243)];
    return line;
}
@end
