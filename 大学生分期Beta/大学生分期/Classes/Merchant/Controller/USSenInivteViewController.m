//
//  USSenInivteViewController.m
//  大学生分期
//
//  Created by HeXianShan on 16/1/9.
//  Copyright © 2016年 hongyunct. All rights reserved.
//

#import "USSenInivteViewController.h"
#import "PlaceholderTextView.h"
#import "USPickerDataViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import "USMyInviteViewController.h"
#import "ELCImagePickerHeader.h"
#import "USMyInviteViewController.h"
@interface USSenInivteViewController ()<ELCImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate>
@property(nonatomic,strong)UITextField *themeTF;
@property(nonatomic,strong)UITextField *dateTimeTF;
@property(nonatomic,strong)UITextField *manCountTF;
@property(nonatomic,strong)UITextField *addressTF;
@property(nonatomic,strong)UITextField *objTF;
@property(nonatomic,strong)UITextField *payTF;
@property(nonatomic,strong)NSMutableDictionary *paramDic;
@property(nonatomic,strong)NSMutableDictionary *imgFilesDic;
@property(nonatomic,strong) NSMutableArray *buttuns;
@property(nonatomic,strong)PlaceholderTextView *descTextView;
@property(nonatomic,strong) UIScrollView *scollerPics;
@property(nonatomic,assign) CGFloat dyheight;
@property(nonatomic,strong)NSMutableArray *chosenImages;
@property (nonatomic, strong) ALAssetsLibrary *specialLibrary;
@end

@implementation USSenInivteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent= NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = HYCTColor(240,240,240);
    self.title = @"发布邀约";
    [self initRightItemBar];
    [self initViews];
    [self initPicTtrueView];
    _paramDic = [NSMutableDictionary dictionary];
    _imgFilesDic = [NSMutableDictionary dictionary];
     _paramDic[@"invit_paybill"] = @(0);
    _paramDic[@"customer_id"] = [USUserService account].id;
}


-(void)initViews{
    UIView *bgview  = [[UIView alloc]initWithFrame:CGRectMake(0, 5, kAppWidth,340)];
    bgview.backgroundColor = [UIColor whiteColor];
    //主题
    UILabel *tip = [USUIViewTool createUILabelWithTitle:@"选择主题:" fontSize:kCommonFontSize_15 color:[UIColor grayColor] heigth:kCommonFontSize_20];
    tip.frame = CGRectMake(10, 5, 70, kCommonFontSize_20);
    [bgview addSubview:tip];
    
    _themeTF = [[UITextField alloc]initWithFrame:CGRectMake(tip.width+tip.x, tip.y, kAppWidth-tip.x-tip.width-9, kCommonFontSize_20)];
    _themeTF.placeholder = @"选择主题";
    _themeTF.font=[UIFont systemFontOfSize:15] ;
    _themeTF.textColor=[UIColor grayColor] ;
    _themeTF.rightView = [self createArrowLb];
    _themeTF.rightViewMode = UITextFieldViewModeAlways;
    UIButton *selectThemeBt = [UIButton buttonWithType:UIButtonTypeCustom];
    selectThemeBt.frame = _themeTF.frame;
    [bgview addSubview:_themeTF];
    [bgview addSubview:selectThemeBt];
    [selectThemeBt addTarget:self action:@selector(selectThem) forControlEvents:UIControlEventTouchUpInside];
    UIView *line = [USUIViewTool createLineView];
    line.frame = CGRectMake(0, _themeTF.y+_themeTF.height+10, kAppWidth, 1);
    line.backgroundColor = HYCTColor(180, 180, 180);
    [bgview addSubview:line];
    //时间
    tip = [USUIViewTool createUILabelWithTitle:@"邀约时间:" fontSize:kCommonFontSize_15 color:[UIColor grayColor] heigth:kCommonFontSize_20];
    tip.frame = CGRectMake(10, line.y+line.height+10, 70, kCommonFontSize_20);
    [bgview addSubview:tip];
    _dateTimeTF = [[UITextField alloc]initWithFrame:CGRectMake(tip.width+tip.x, tip.y, kAppWidth-tip.x-tip.width-9, kCommonFontSize_20)];
    _dateTimeTF.placeholder = @"选择时间";
    _dateTimeTF.rightView = [self createArrowLb];;
    _dateTimeTF.rightViewMode = UITextFieldViewModeAlways;
    _dateTimeTF.font=[UIFont systemFontOfSize:15] ;
    _dateTimeTF.textColor=[UIColor grayColor] ;
   [bgview addSubview:_dateTimeTF];
    //
    UIButton *selectDateBt = [UIButton buttonWithType:UIButtonTypeCustom];
    selectDateBt.frame = _dateTimeTF.frame;
    [bgview addSubview:selectDateBt];
    [selectDateBt addTarget:self action:@selector(selectDateTime) forControlEvents:UIControlEventTouchUpInside];
    line = [USUIViewTool createLineView];
    line.frame = CGRectMake(0, _dateTimeTF.y+_dateTimeTF.height+5, kAppWidth, 1);
    line.backgroundColor = HYCTColor(180, 180, 180);
    [bgview addSubview:line];
    //人数
    tip = [USUIViewTool createUILabelWithTitle:@"邀约人数:" fontSize:kCommonFontSize_15 color:[UIColor grayColor] heigth:kCommonFontSize_20];
    tip.frame = CGRectMake(10, line.y+line.height+10, 70, kCommonFontSize_20);
    [bgview addSubview:tip];
    _manCountTF = [[UITextField alloc]initWithFrame:CGRectMake(tip.width+tip.x, tip.y, kAppWidth-tip.x-tip.width-9, kCommonFontSize_20)];
    _manCountTF.placeholder = @"填写人数";
    _manCountTF.delegate =self;
    _manCountTF.keyboardType = UIKeyboardTypeNumberPad;
    _manCountTF.rightView = [self createArrowLb];;
    _manCountTF.rightViewMode = UITextFieldViewModeAlways;
    _manCountTF.font=[UIFont systemFontOfSize:15] ;
    _manCountTF.textColor=[UIColor grayColor] ;
     [bgview addSubview:_manCountTF];
    line = [USUIViewTool createLineView];
    line.frame = CGRectMake(0, _manCountTF.y+_manCountTF.height+5, kAppWidth, 1);
    line.backgroundColor = HYCTColor(180, 180, 180);
    [bgview addSubview:line];
    //地点
    tip = [USUIViewTool createUILabelWithTitle:@"邀约地点:" fontSize:kCommonFontSize_15 color:[UIColor grayColor] heigth:kCommonFontSize_20];
    tip.frame = CGRectMake(10, line.y+line.height+10, 70, kCommonFontSize_20);
    [bgview addSubview:tip];
    _addressTF = [[UITextField alloc]initWithFrame:CGRectMake(tip.width+tip.x, tip.y, kAppWidth-tip.x-tip.width-9, kCommonFontSize_20)];
    _addressTF.placeholder = @"填写地点";
    _addressTF.delegate =self;
    _addressTF.rightView = [self createArrowLb];;
    _addressTF.rightViewMode = UITextFieldViewModeAlways;
    _addressTF.font=[UIFont systemFontOfSize:15] ;
    _addressTF.textColor=[UIColor grayColor] ;
    [bgview addSubview:_addressTF];
    line = [USUIViewTool createLineView];
    line.frame = CGRectMake(0, _addressTF.y+_addressTF.height+5, kAppWidth, 1);
    line.backgroundColor = HYCTColor(180, 180, 180);
    [bgview addSubview:line];
    ///对象
    tip = [USUIViewTool createUILabelWithTitle:@"邀约对象:" fontSize:kCommonFontSize_15 color:[UIColor grayColor] heigth:kCommonFontSize_20];
    tip.frame = CGRectMake(10, line.y+line.height+10, 70, kCommonFontSize_20);
    [bgview addSubview:tip];
    _objTF = [[UITextField alloc]initWithFrame:CGRectMake(tip.width+tip.x, tip.y, kAppWidth-tip.x-tip.width-9, kCommonFontSize_20)];
    _objTF.placeholder = @"填写对象";
    _objTF.rightView = [self createArrowLb];
    _objTF.delegate =self;
    _objTF.rightViewMode = UITextFieldViewModeAlways;
    _objTF.font=[UIFont systemFontOfSize:15] ;
    _objTF.textColor=[UIColor grayColor] ;
    [bgview addSubview:_objTF];
    line = [USUIViewTool createLineView];
    line.frame = CGRectMake(0, _objTF.y+_objTF.height+5, kAppWidth, 1);
    line.backgroundColor = HYCTColor(180, 180, 180);
    [bgview addSubview:line];
    //买单
    tip = [USUIViewTool createUILabelWithTitle:@"邀约买单:" fontSize:kCommonFontSize_15 color:[UIColor grayColor] heigth:kCommonFontSize_20];
    tip.frame = CGRectMake(10, line.y+line.height+10, 70, kCommonFontSize_20);
    [bgview addSubview:tip];
    NSArray *buttonTitles = @[@"AA",@"你买单",@"我买单"];
    __block CGFloat x = tip.x+tip.width;
    _buttuns = [NSMutableArray array];
    [buttonTitles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat width = 60;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, tip.y, width, kCommonFontSize_20);
        button.x = x+5;
        button.tag = idx;
        [button setFont:[UIFont systemFontOfSize:15]] ;
        [button setTitleColor:HYCTColor(168, 168, 168) forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [button setTitle:obj forState:UIControlStateNormal];
        [button setTitle:obj forState:UIControlStateHighlighted];
        if (idx == 0) {
            button.selected = true;
        }
        [bgview addSubview:button];
        x+=width+5;
        [_buttuns addObject:button];
        [button addTarget:self action:@selector(selectPay:) forControlEvents:UIControlEventTouchUpInside];
    }];
    line = [USUIViewTool createLineView];
    line.frame = CGRectMake(0, tip.y+tip.height+5, kAppWidth, 1);
    line.backgroundColor = HYCTColor(180, 180, 180);
    [bgview addSubview:line];
    //
    tip = [USUIViewTool createUILabelWithTitle:@"邀约说明:" fontSize:kCommonFontSize_15 color:[UIColor grayColor] heigth:kCommonFontSize_20];
    tip.frame = CGRectMake(10, line.y, 70, kCommonFontSize_20);
    [bgview addSubview:tip];
    _descTextView=[[PlaceholderTextView alloc] initWithFrame:CGRectMake(tip.x+tip.width, line.y+line.height+10, kAppWidth-tip.x-tip.width-1, 100)];
    _descTextView.layer.borderColor = [[UIColor clearColor] CGColor];
    _descTextView.layer.borderWidth  = 0.5;
    _descTextView.placeholder=@"说得越详细，应邀的人更多，更精准...";
    _descTextView.font=[UIFont systemFontOfSize:kCommonFontSize_15];
    _descTextView.textAlignment = NSTextAlignmentCenter;
    _descTextView.placeholderFont=[UIFont systemFontOfSize:kCommonFontSize_15];
    _descTextView.placeholderColor = [UIColor grayColor];
    _descTextView.textColor =[UIColor grayColor] ;
    _descTextView.textAlignment =UITextAlignmentLeft ;
    [bgview addSubview:_descTextView];
    [self.view addSubview:bgview];
    tip.y+=_descTextView.height*0.5;
    //
    _dyheight+=bgview.height+bgview.y;
}

-(void)initPicTtrueView{
//    UILabel *tip = [USUIViewTool createUILabelWithTitle:@"选择主题:" fontSize:kCommonFontSize_15 color:[UIColor blackColor] heigth:kCommonFontSize_15];
//    tip.frame = CGRectMake(10, _dyheight+20, 70, kCommonFontSize_15);
    //    UILabel *arrayLable = [USUIViewTool createUILabelWithTitle:@">" fontSize:kCommonFontSize_20 color:HYCTColor(180, 180, 180) heigth:kCommonFontSize_20];
    //    arrayLable.frame = CGRectMake(0, 0, kCommonFontSize_20,kCommonFontSize_20);
//    [self.view addSubview:tip];
    CGFloat height = 100;
    _scollerPics = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _dyheight+20, kAppWidth, height)];
    _scollerPics.userInteractionEnabled = YES;
    _scollerPics.delegate = self;
    _scollerPics.showsVerticalScrollIndicator = NO;
    _scollerPics.showsHorizontalScrollIndicator = NO;
    //_scollerPics.backgroundColor = HYCTColor(120, 120, 120);
    _scollerPics.bounces = NO;
    [self.view addSubview:_scollerPics];
    [self updatescollerView:nil];
    UIButton *baomiBt = [USUIViewTool createButtonWith:@"选择图片"];
    baomiBt.frame = CGRectMake(kAppWidth - 90, _scollerPics.y+_scollerPics.height+10, 80, 20);
    baomiBt.titleLabel.font = [UIFont systemFontOfSize:kCommonFontSize_12];
    [baomiBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [baomiBt setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    baomiBt.backgroundColor = [UIColor whiteColor];
    baomiBt.layer.cornerRadius = 10;
    baomiBt.layer.borderColor = [HYCTColor(120, 120, 120) CGColor];
    baomiBt.layer.borderWidth = 0.8;
    baomiBt.layer.masksToBounds = YES;
    [baomiBt addTarget:self action:@selector(baomiClick) forControlEvents:UIControlEventTouchUpInside];
    _dyheight = baomiBt.y+baomiBt.height;
    [self.view  addSubview:baomiBt];
}

-(void)baomiClick{
    HYLog(@"baomiClick");
//    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
//    self.specialLibrary = library;
//    NSMutableArray *groups = [NSMutableArray array];
//    [_specialLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
//        if (group) {
//            [groups addObject:group];
//        } else {
//            // this is the end
//            [self displayPickerForGroup:[groups objectAtIndex:0]];
//        }
//    } failureBlock:^(NSError *error) {
//        self.chosenImages = nil;
//        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"Album Error: %@ - %@", [error localizedDescription], [error localizedRecoverySuggestion]] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//        [alert show];
//        
//        NSLog(@"A problem occured %@", [error description]);
//        // an error here means that the asset groups were inaccessable.
//        // Maybe the user or system preferences refused access.
//    }];
    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initImagePicker];
    
    elcPicker.maximumImagesCount = 10; //Set the maximum number of images to select to 100
    elcPicker.returnsOriginalImage = YES; //Only return the fullScreenImage, not the fullResolutionImage
    elcPicker.returnsImage = YES; //Return UIimage if YES. If NO, only return asset location information
    elcPicker.onOrder = YES; //For multiple image selection, display and return order of selected images
    elcPicker.mediaTypes = @[(NSString *)kUTTypeImage]; //Supports image and movie types
    elcPicker.imagePickerDelegate = self;
    
    [self presentViewController:elcPicker animated:YES completion:nil];
}

- (void)displayPickerForGroup:(ALAssetsGroup *)group
{
    ELCAssetTablePicker *tablePicker = [[ELCAssetTablePicker alloc] initWithStyle:UITableViewStylePlain];
    tablePicker.singleSelection = YES;
    tablePicker.immediateReturn = YES;
    
    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initWithRootViewController:tablePicker];
    elcPicker.maximumImagesCount = 10;
    elcPicker.imagePickerDelegate = self;
    elcPicker.returnsOriginalImage = YES; //Only return the fullScreenImage, not the fullResolutionImage
    elcPicker.returnsImage = YES; //Return UIimage if YES. If NO, only return asset location information
    elcPicker.onOrder = NO; //For single image selection, do not display and return order of selected images
    tablePicker.parent = elcPicker;
    
    // Move me
    tablePicker.assetGroup = group;
    [tablePicker.assetGroup setAssetsFilter:[ALAssetsFilter allAssets]];
    
    [self presentViewController:elcPicker animated:YES completion:nil];
}

-(void)updatescollerView:(NSArray *)imgs{
    //
    //NSInteger count = [picUrls count];
    CGFloat height = 100;

    CGFloat width = 0;
    NSMutableArray *imgDatas = [NSMutableArray array];
    for(NSInteger i = 0;i<imgs.count;i++){
        UIImageView *temp = [[UIImageView alloc]initWithFrame:CGRectMake(width, 0, height, height)];
        temp.image = imgs[i];
        temp.userInteractionEnabled = YES;
        [_scollerPics addSubview:temp];
        width += temp.width+5;
        [imgDatas addObject:UIImagePNGRepresentation(imgs[i])];
    }
    _scollerPics.contentSize = CGSizeMake(width, _scollerPics.height);
    _imgFilesDic = [NSMutableDictionary dictionary];
    if (imgDatas.count>0) {
        [_imgFilesDic setObject:imgDatas forKey:@"uploadimgFilephoto"];
    }
    [self dissView];
}

#pragma mark ELCImagePickerControllerDelegate Methods

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    for (UIView *v in [_scollerPics subviews]) {
        [v removeFromSuperview];
    }
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:[info count]];
    for (NSDictionary *dict in info) {
        if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypePhoto){
            if ([dict objectForKey:UIImagePickerControllerOriginalImage]){
                UIImage* image=[dict objectForKey:UIImagePickerControllerOriginalImage];
                [images addObject:image];
            } else {
                [MBProgressHUD showError:@"选择图片类型不对，必须是图片类型...."];
                return;
            }
        }
        
    }
    self.chosenImages = images;
    [self updatescollerView:images];
}

- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)dissView{
    [_manCountTF resignFirstResponder];
    [_addressTF resignFirstResponder];
    [_objTF resignFirstResponder];
    [_descTextView resignFirstResponder];
    //[self validateFD];
}
-(BOOL)validateFD{
    
    if (_manCountTF.text==nil||_manCountTF.text.length==0) {
        [MBProgressHUD showError:@"必须输入人数..."];
        return NO;
    }else{
        if ([_manCountTF.text integerValue]<0) {
            [MBProgressHUD showError:@"人数必须是正整数..."];
            return NO;
        }
    }
    if (_dateTimeTF.text==nil||_dateTimeTF.text.length==0) {
        [MBProgressHUD showError:@"没有输入时间..."];
        return NO;;
    }
    if (_themeTF.text==nil||_themeTF.text.length==0) {
        [MBProgressHUD showError:@"没有选择主题..."];
        return NO;;
    }
    if (_addressTF.text==nil||_addressTF.text.length==0) {
         [MBProgressHUD showError:@"必须输入地址..."];
        return NO;;
    }
    if (_objTF.text==nil||_objTF.text.length==0) {
        [MBProgressHUD showError:@"必须输入邀请对象..."];
        return NO;;
    }
    if (_descTextView.text==nil||_descTextView.text.length==0) {
        [MBProgressHUD showError:@"必须输入邀约说明..."];
        return NO;;
    }
    if (_imgFilesDic.count==0) {
         [MBProgressHUD showError:@"必须选择图片..."];
         return NO;;
    }
     //self.navigationItem.rightBarButtonItem.enabled = YES;
    return YES ;
   
}
-(void)selectPay:(UIButton *)sender{
   [_buttuns enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       UIButton *objbt = obj;
       objbt.selected = NO;
   }];
    sender.selected = !sender.selected;
    _paramDic[@"invit_paybill"] = @(sender.tag);
}
-(UILabel *)createArrowLb{
    UILabel *arrayLable = [USUIViewTool createUILabelWithTitle:@">" fontSize:kCommonFontSize_20 color:HYCTColor(180, 180, 180) heigth:kCommonFontSize_20];
    arrayLable.frame = CGRectMake(0, 0, kCommonFontSize_20,kCommonFontSize_20);
    return arrayLable;
}
-(void)selectThem{
    HYLog(@"selectThem");
    USPickerDataViewController *pickDataVC = [[USPickerDataViewController alloc]init];
    __block USPickerDataViewController *blockPickerVC = pickDataVC;
    pickDataVC.fetchDataBlock = ^(NSDictionary *paramDic,NSString *url){
        [USWebTool POST:@"wangkaInviterClientcontroller/getInviterTypeTheme.action" showMsg:@"" paramDic:@{} success:^(NSDictionary *responseObject) {
            NSArray *datas = responseObject[@"data"];
            blockPickerVC.dataList = [NSMutableArray arrayWithCapacity:[datas count]];
            for (NSDictionary *data in datas) {
                USTempData *tempData = [[USTempData alloc]init];
                tempData.name = data[@"name"];
                if (data[@"code"]!=nil||([data[@"code"] length] > 0)) {
                    tempData.id = data[@"code"];
                }else{
                    tempData.id = data[@"id"];
                }
                [blockPickerVC.dataList addObject:tempData];
            }
            
            [blockPickerVC.tableView reloadData];
        }];
    };
    pickDataVC.didSelectDataBlock = ^(USTempData *tempData){
        _themeTF.text = tempData.name;
        _paramDic[@"theme_id"] = tempData.id;
    };
    [self.navigationController pushViewController:pickDataVC animated:YES];
}
-(void)selectDateTime{
    HYLog(@"selectDateTime");
     USPickerDataViewController *pickDataVC = [[USPickerDataViewController alloc]init];
    pickDataVC.makeViewBlock = ^(UIViewController *vc) {
        // USPickerDataViewController *pickVC = vc;
        UIDatePicker *datePicker = [self createUIDatePicker];
        USPickerDataViewController *pickVC = (USPickerDataViewController *)vc;
        pickVC.datePicker = datePicker;
        [pickVC.tableView removeFromSuperview];
        [pickVC.view addSubview:datePicker];
        [datePicker addTarget:pickVC action:@selector(dateTimePick:) forControlEvents:UIControlEventValueChanged ];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(15, datePicker.y+datePicker.height+15, kAppWidth-30, 30);
        button.backgroundColor = [UIColor orangeColor];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:kCommonFontSize_15];
        [button setTitle:@"确定" forState:UIControlStateNormal];
        [button setTitle:@"确定" forState:UIControlStateHighlighted];
        [button addTarget:pickVC action:@selector(dateTimePickButtonClick) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.textColor = [UIColor whiteColor];
        button.layer.cornerRadius = button.height*0.5;
        button.layer.masksToBounds = YES;
        [pickVC.view addSubview:button];
    };
    pickDataVC.didSelectDataBlock = ^(USTempData *tempData){
        _dateTimeTF.text = tempData.name;
        _paramDic[@"invit_time"]=tempData.name;
    };
    [self.navigationController pushViewController:pickDataVC animated:YES];
}

-(UIDatePicker *)createUIDatePicker{
    UIDatePicker *datePicker = [ [ UIDatePicker alloc] init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中
    datePicker.locale = locale;
    datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    NSDate* minDate = [[NSDate alloc]initWithTimeIntervalSince1970:0];
    NSDate* maxDate = [[NSDate alloc]init];
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSCalendarUnitYear|NSCalendarUnitDay;
    
    NSDateComponents *d = [cal components:unitFlags fromDate:maxDate];//把要从date中获取的unitFlags标示的日期元素存放在NSDateComponents类型的d里面；
    //然后就可以从d中获取具体的年月日了；
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSInteger year = [d year];
    NSString *dateStr = [NSString stringWithFormat:@"%li-12-31",(long)year];
    maxDate = [dateFormat dateFromString:dateStr];
    datePicker.minimumDate = minDate;
    datePicker.maximumDate = maxDate;
    return datePicker;
}
-(void)initLeftItemBar {
    
    UIButton *leftButton = [self createBarButton:@"取消" target:self action:@selector(pop) color:[UIColor whiteColor] disableColor:[UIColor grayColor]];
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
}
-(void)initRightItemBar {
    
    UIButton *rightButton = [self createBarButton:@"发送" target:self action:@selector(send) color:HYCTColor(252, 232, 2) disableColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem= [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem.enabled = YES;
    
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
    BOOL bool_ = [self validateFD] ;
    if (bool_==NO) {
        return ;
    }
    _paramDic[@"invit_address"]=_addressTF.text;
    _paramDic[@"invit_num"]=_manCountTF.text;
    _paramDic[@"invit_detail"]=_descTextView.text;
    _paramDic[@"invit_time"]= _dateTimeTF.text;
    _paramDic[@"invit_target"]= _objTF.text;
    [USWebTool POST:@"wangkaInviterClientcontroller/saveCustomerInvite.action" showMsg:@"正在发布邀约...." paramDiC:_paramDic fileName:@"uploadimgFilephoto" dataArray:_imgFilesDic[@"uploadimgFilephoto"] success:^(id data) {
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(id data) {
        [MBProgressHUD showError:@"邀约失败..."];
    }];
}
-(UIView *)createCumstomView{
    return  nil;
}
@end
