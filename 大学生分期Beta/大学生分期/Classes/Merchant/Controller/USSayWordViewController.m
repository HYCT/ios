//
//  USSayWordViewController.m
//  大学生分期
//
//  Created by HeXianShan on 16/1/8.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import "USSayWordViewController.h"
#import "PlaceholderTextView.h"
@interface USSayWordViewController ()
@property(nonatomic,strong)UITextField *sendView;
@property(nonatomic,strong)PlaceholderTextView *textView;
@property(nonatomic,strong)USAccount *account;
@end

@implementation USSayWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent= NO;
    self.view.backgroundColor = HYCTColor(240,240,240);
    _account = [USUserService account];
    self.title = @"打招呼";
    [self initRightItemBar];
    
    //静态文本
    UIView *bgviewtitle =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kAppWidth, 40)];
    
    UILabel *lable = [USUIViewTool createUILabelWithTitle:@"对他说句话，打下招呼" fontSize:kCommonFontSize_15 color:[UIColor grayColor] heigth:kCommonFontSize_30];
    lable.frame = CGRectMake(5, 5, kAppWidth, kCommonFontSize_30);
    [bgviewtitle addSubview:lable];
    [self .view addSubview:lable] ;
    
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, lable.y+lable.height+10, kAppWidth, 40)];
    bgView.userInteractionEnabled = YES;
    bgView.backgroundColor = [UIColor whiteColor];
    _textView=[[PlaceholderTextView alloc] initWithFrame:CGRectMake(0, lable.y+lable.height +10, kAppWidth, 40)];
    _textView.placeholder=@"写在这里...";
    //_textView.backgroundColor = [UIColor grayColor];
    _textView.font=[UIFont boldSystemFontOfSize:14];
    _textView.placeholderFont=[UIFont boldSystemFontOfSize:14];
    _textView.placeholderColor = [UIColor lightGrayColor];
    __block UIViewController *temp = self;
    _textView.didEndBlock = ^(BOOL flag){
        temp.navigationItem.rightBarButtonItem.enabled = flag;
    };
    [bgView addSubview:_textView];
    [self.view addSubview:_textView];
    
}

-(void)initLeftItemBar {
    
    UIButton *leftButton = [self createBarButton:@"取消" target:self action:@selector(pop) color:[UIColor whiteColor] disableColor:[UIColor grayColor]];
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
}
-(void)initRightItemBar {
    
    UIButton *rightButton = [self createBarButton:@"发送" target:self action:@selector(send) color:[UIColor whiteColor] disableColor:[UIColor grayColor]];
    self.navigationItem.rightBarButtonItem= [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
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
    HYLog(@"111111");
    [USWebTool POST:@"wangkaNearByClientcontroller/customerSayWords.action"
            showMsg:@"正在发送你说的话给他(她)..."
           paramDic:@{@"customer_id":_customer_id,@"been_customer_id":_been_customer_id,@"wordscontent":_textView.text}
           success:^(NSDictionary *dataDic) {
               [MBProgressHUD showSuccess:@"打招呼成功...."];
               [self.navigationController popViewControllerAnimated:YES];
    } failure:^(id data) {
        [MBProgressHUD showError:@"打招呼失败..."];
    }];
//    [USWebTool POST:@"wangkaClientController/saveCustomerNewsMessage.action" showMsg:@"正在发送新消息..." paramDiC:@{@"customer_id":_account.id,@"newscontent":@""}  success:^(NSDictionary *data) {
////        USNearProfZoneViewController *profZoneVC = [[USNearProfZoneViewController alloc]init];
////        [self.navigationController pushViewController:profZoneVC animated:YES];
//    } failure:^(id data) {
//        [MBProgressHUD showError:@"发送新消息失败!"];
//    }];
//    
}

@end
