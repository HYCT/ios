//
//  USSendMessageViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/30.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USSendMessageViewController.h"
#import "PlaceholderTextView.h"
#import "USNearProfZoneViewController.h"
@interface USSendMessageViewController ()
{
    NSString * _normarImageName ;
    NSString * _checkedImageName ;
}
@property(nonatomic,strong)UITextField *sendView;
@property(nonatomic,strong)PlaceholderTextView *textView;
@property(nonatomic,strong)USAccount *account;
@property(nonatomic,strong)UIButton *checkBox;
@end

@implementation USSendMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent= NO;
    self.view.backgroundColor = HYCTColor(240,240,240);
    _account = [USUserService account];
    self.title = _account.name;
    [self initRightItemBar];
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kAppWidth, 210)];
    bgView.userInteractionEnabled = YES;
    bgView.backgroundColor = [UIColor whiteColor];
    _textView=[[PlaceholderTextView alloc] initWithFrame:CGRectMake(0, 0, kAppWidth, 100)];
    _textView.placeholder=@"这一刻的想法...";
    //_textView.backgroundColor = [UIColor grayColor];
    _textView.font=[UIFont boldSystemFontOfSize:14];
    _textView.placeholderFont=[UIFont boldSystemFontOfSize:13];
    _textView.placeholderColor = [UIColor lightGrayColor];
    __block UIViewController *temp = self;
    _textView.didEndBlock = ^(BOOL flag){
        
    temp.navigationItem.rightBarButtonItem.enabled = flag;
    };
    [bgView addSubview:_textView];
    //
    
    UIButton *imageBt = [self createImageButton:nil];
    [bgView addSubview:imageBt];
    UIView *line = [USUIViewTool createLineView];
    line.frame = CGRectMake(0, imageBt.y+imageBt.height+5, kAppWidth, 1);
    [bgView addSubview:line];
    //
    UIButton *checkBox = [self createCheckBox];
    _checkBox = checkBox;
    checkBox.frame = CGRectMake(10, line.y+10, 30, 30);
    [bgView addSubview:checkBox];
    UILabel *checkTip = [USUIViewTool createUILabelWithTitle:@"是否参加人气榜" fontSize:12 color:HYCTColor(36, 36, 36) heigth:30];
    checkTip.frame = CGRectMake(checkBox.width+checkBox.x+10, checkBox.y, kAppWidth, 30);
    [bgView addSubview:checkTip];
    //
    line = [USUIViewTool createLineView];
    line.frame = CGRectMake(0, checkTip.y+checkTip.height+5, kAppWidth, 1);
    [bgView addSubview:line];
    [self.view addSubview:bgView];
   
}
-(UIButton *)createImageButton:(UIImage *)image{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(5, _textView.height, (kAppWidth-10)*0.25, 60);
    [button setImage:_selectedImage forState:UIControlStateNormal];
    return button;
}

-(void)initLeftItemBar {
    
    UIButton *leftButton = [self createBarButton:@"取消" target:self action:@selector(pop) color:[UIColor whiteColor] disableColor:[UIColor grayColor]];
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc]initWithCustomView:leftButton];
   
}
-(void)initRightItemBar {
    
    UIButton *rightButton = [self createBarButton:@"发送" target:self action:@selector(send) color:HYCTColor(252, 232, 2) disableColor:[UIColor grayColor]];
    self.navigationItem.rightBarButtonItem= [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
}
-(UIButton *)createCheckBox{
    _normarImageName = @"account_cell_unchecked_ico";
    _checkedImageName = @"account_cell_checked_ico";
    UIButton *checkBox = [USUIViewTool createButtonWith:@"    " imageName: _normarImageName highImageName:_checkedImageName selectedImageName:_checkedImageName];
    [checkBox addTarget:self action:@selector(checkClick:) forControlEvents:UIControlEventTouchUpInside];
    return checkBox;
}

-(void)checkClick:(UIButton *)checkBox{
    checkBox.selected = !checkBox.selected;
}
-(UIButton *)createBarButton:(NSString *)title target:(id)target action:(SEL)action color:(UIColor *)color disableColor:(UIColor *)disableColor {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor clearColor];
    [button.titleLabel setFont:[UIFont systemFontOfSize:kCommonNavFontSize]];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateHighlighted];
    [button setTitleColor:color forState:UIControlStateNormal];
    if (disableColor) {
         [button setTitleColor:disableColor forState:UIControlStateDisabled];
    }
    button.size = CGSizeMake(60, 24);
    [button.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

-(void)send{
    
    [USWebTool POST:@"wangkaClientController/saveCustomerNewsMessage.action" showMsg:@"正在发送新消息..." paramDiC:@{@"customer_id":_account.id,@"newscontent":_textView.text,@"type":@(_checkBox.selected)} fileParamDic:@{@"uploadimgFilephoto":UIImagePNGRepresentation(_selectedImage)} success:^(NSDictionary *data) {
        USNearProfZoneViewController *profZoneVC = [[USNearProfZoneViewController alloc]init];
        [self.navigationController pushViewController:profZoneVC animated:YES];
    } failure:^(id data) {
        [MBProgressHUD showError:@"发送新消息失败!"];
    }];
    
}
@end
