//
//  USSegmentView.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/24.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USSegmentView.h"
#define kCount 2
@interface USSegmentView()
@property(nonatomic,strong)  UIView *leftView;
@property(nonatomic,strong)  UIView *rightView;
@property(nonatomic,strong)  UIView *segmentBgView;
@property(nonatomic,strong)  NSArray *titles;
@property(nonatomic,strong)  NSMutableArray *titleButtons;
@property(nonatomic,assign)  NSInteger count;
@property(nonatomic,assign)  NSInteger preIndex;
@end
@implementation USSegmentView



-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.userInteractionEnabled = YES;
    CGFloat height = 25;
    UIView *segmentBgView = [[UIView alloc]initWithFrame:self.bounds];
    segmentBgView.userInteractionEnabled = YES;
    _segmentBgView = segmentBgView;
    segmentBgView.layer.cornerRadius = 12;
    segmentBgView.layer.borderWidth = 1;
    segmentBgView.layer.masksToBounds = YES;
    segmentBgView.layer.borderColor = [[UIColor orangeColor]CGColor];
    UIView *leftView = [self createTempView:height];
    _leftView = leftView;
    [segmentBgView addSubview:leftView];
    UIView *rightView = [self createTempView:height];
    _rightView = rightView;
    rightView.x = self.width - rightView.width;
    [segmentBgView addSubview:rightView];
    [self addSubview:segmentBgView];
    return self;
}

-(instancetype)initWithTitles:(NSArray *)titles frame:(CGRect)frame{
    self = [self initWithFrame:frame];
    CGFloat width = self.width/[titles count];
    _titles = titles;
    _titleButtons = [NSMutableArray array];
    self.count = titles.count;
    CGFloat x = 0;
    for (NSInteger i = 0; i<[titles count]; i++) {
        NSString *title = titles[i];
        UIButton *bt = [self createButton:title width:width];
        [_titleButtons addObject:bt];
        bt.x = x;
        bt.tag = i;
        x+=width;
        if (i==0) {
            bt.selected = YES;
            _rightView.hidden = YES;
            bt.backgroundColor = [UIColor orangeColor];
            _preIndex = 0;
        }
        [bt addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [_segmentBgView addSubview:bt];
    }
    return self;
}


-(void)click:(UIButton *)button{
    [self updatePreButton];
    button.enabled = NO;
    button.backgroundColor = [UIColor orangeColor];
    _rightView.hidden = YES;
    _leftView.hidden = YES;
    if (button.tag == 0) {
        _rightView.hidden = YES;
        _leftView.hidden = NO;
    }else if (button.tag == (self.count -1)){
        _leftView.hidden = YES;
        _rightView.hidden = NO;
    }
    _selectedIndex = button.tag;
    _preIndex = _selectedIndex;
    if (_clickBlock!=nil) {
        _clickBlock(_selectedIndex);
    }
}
- (void)updatePreButton {
    UIButton *preBt = _titleButtons[_preIndex];
    preBt.selected = NO;
    preBt.enabled = YES;
    preBt.backgroundColor = [UIColor clearColor];
    [preBt setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
   [preBt setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    [preBt setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
}
- (UIButton *)createButton:(NSString *)title width:(CGFloat)width {
    UIButton *bt = [USUIViewTool createButtonWith:title];
    bt.frame = CGRectMake(1, 0, width, self.height);
    [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [bt setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    [bt setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [bt.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [bt setBackgroundColor:[UIColor clearColor]];
    return bt;
}
-(void)setSelectedIndex:(NSInteger)selectedIndex{
    if (selectedIndex<0||selectedIndex>[self.titles count]) {
        return;
    }
    _selectedIndex = selectedIndex;
    [self click:self.titleButtons[selectedIndex]];
}
- (UIView *)createTempView:(CGFloat)height {
    UIView *leftView = [[UIView alloc]init];
    leftView.frame = CGRectMake(1, 0,30, height);
    leftView.layer.cornerRadius = 12;
    leftView.layer.masksToBounds = YES;
    [leftView setBackgroundColor:[UIColor orangeColor]];
    return leftView;
}
@end
