//
//  USPickerDataViewController.h
//  大学生分期
//
//  Created by HeXianShan on 15/10/7.
//  Copyright © 2015年 hongyunct. All rights reserved.
//

#import "USBaseViewController.h"
#import "USTempData.h"
typedef void(^DidSelectDataBlock) (USTempData *);

@interface USPickerDataViewController : USBaseViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,copy)DidSelectDataBlock didSelectDataBlock;
@property(nonatomic,strong)NSDictionary *paramDic;
@property(nonatomic,copy)NSString *url;
@property(nonatomic,copy)FetchDataBlock fetchDataBlock;
@property(nonatomic,copy)MakeViewBlock makeViewBlock;
@property(nonatomic,strong)NSMutableArray *dataList;
@property(nonatomic,strong)UIView *dataView;
@property(nonatomic,strong)UIDatePicker *datePicker;
-(void)datePickButtonClick;
-(void)dateTimePickButtonClick;
-(void)datePick:(UIDatePicker *)picker;
-(void)dateTimePick:(UIDatePicker *)picker;
@end
