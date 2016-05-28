//
//  USNearTableViewController.m
//  大学生分期
//
//  Created by HeXianShan on 15/9/3.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "USNearTableViewController.h"
#import "USNearTableViewCell.h"
#import "USPersonBriefViewController.h"
@interface USNearTableViewController ()
@property(nonatomic,strong)UILabel *locatoin;
@property(atomic,strong)CLLocation *currentLocation;
@property(nonatomic,strong) MBProgressHUD *mbProgressView;
@property(nonatomic,assign)BOOL flag;
@property(nonatomic,strong)UIImage *headerPic;
//////
@property(nonatomic,strong)NSMutableDictionary *paramDic;
@property(nonatomic,strong)UIView *dataTipView;
@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSString *url;
@property(nonatomic,assign)int totalPage;
@property(nonatomic,assign)int currentPage;
@property(nonatomic,strong)USAccount *account;
@property(nonatomic,strong)NSMutableArray *dataList;
@end
@implementation USNearTableViewController
-(void)viewDidLoad{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    //
    [self initLocMgr];
    
    //用户
     _account = [USUserService account];
    
    _msg = @"正在加载附件的人...";
    _url = @"wangkaNearByClientcontroller/getNearByPersonListInstance.action";
    _paramDic = [NSMutableDictionary dictionary];
    _paramDic[@"customer_id"] = _account.id;
    _paramDic[@"pageSize"] = @(kPageSize);
    _paramDic[@"currentPage"] = @(1);
    _paramDic[@"raidus"] = @(100000);
    
    if ([CLLocationManager locationServicesEnabled]) {
        if ([[[UIDevice currentDevice] systemVersion] doubleValue] > 8.0)
        {
            //设置定位权限 仅ios8有意义
            [self.locMgr requestWhenInUseAuthorization];// 前台定位
            
            [self.locMgr requestAlwaysAuthorization];// 前后台同时定位
        }
        //开始定位用户的位置
        //每隔多少米定位一次（这里的设置为任何的移动）
        self.locMgr.distanceFilter= kCLLocationAccuracyNearestTenMeters;
        //设置定位的精准度，一般精准度越高，越耗电（这里设置为精准度最高的，适用于导航应用）
        self.locMgr.desiredAccuracy=kCLLocationAccuracyBestForNavigation;
        [self.locMgr startUpdatingLocation];
        _currentLocation = [self.locMgr location];
        //获得以后，开始提取
        _flag = YES;
        _headerPic = [UIImage imageNamed:@"near_table_cell_person_img"];
        _dataTipView = [USUIViewTool createDataTipViewWithTarget:self action:@selector(loadData)];
      
        [self setupRefresh];
        [self loadData];
        //[NSThread detachNewThreadSelector:@selector(loadData) toTarget:self withObject:nil];
    }else
    {
        [[[UIAlertView alloc] initWithTitle:@"提示：" message:@"请去设置-隐私-位置 开启位置服务..." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
        
    }
}

-(void)loadData{
    _mbProgressView = [MBProgressHUD showMessage:@"正在获取你的位置..."];
//    int count = 0;
//    while (_currentLocation==nil&&_flag) {
//        _currentLocation = [self.locMgr location];
//        [NSThread sleepForTimeInterval:0.005];
//        count++;
//        if(count>20){
//            [_locMgr stopUpdatingLocation];
//            _currentLocation =nil;
//            break;
//        }
//    }
    if (_currentLocation == nil) {
        [_mbProgressView hide:YES];
        [MBProgressHUD showSuccess:@"获取位置失败..."];
        return;
    }
    if (_currentLocation!=nil) {
        [MBProgressHUD showSuccess:@"获取位置成功..."];
        [_mbProgressView hide:YES];
        [_dataTipView removeFromSuperview];
        //_paramDic[@"x"]=_currentLocation.altitude;
        //维度：loc.coordinate.latitude
        //经度：loc.coordinate.longitude
        _paramDic[@"y"]=@(_currentLocation.coordinate.latitude);
        _paramDic[@"x"]=@(_currentLocation.coordinate.longitude);
        [USWebTool POST:_url showMsg:_msg paramDic:_paramDic success:^(NSDictionary *dic) {
            _dataList = [NSMutableArray array];
            if([dic[@"totalNum"]intValue]>0){
                [_dataList addObjectsFromArray:dic[@"data"]];
                _currentPage =[dic[@"currentPage"] intValue];
                _totalPage = [dic[@"totalPage"] intValue];
                [_tableView reloadData];
            }else{
                [self.view addSubview:_dataTipView];
            }
            
        } failure:^(id data) {
            [self.view addSubview:_dataTipView];
        }];
    }else{
        [MBProgressHUD showError:@"获取位置失败..."];
        [self.navigationController popViewControllerAnimated:YES];
        [_locMgr stopUpdatingLocation];
    }

//   dispatch_async(dispatch_get_main_queue(), ^{
//
//   });
    //
}
-(void)returnbak{
    dispatch_async(dispatch_get_main_queue(), ^{
        
    });
}
//
/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    self.tableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.tableView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    self.tableView.footerRefreshingText = @"正在玩命加载中...";
}


//底部刷新按钮
- (void)footerRereshing
{
    if (_currentPage<=_totalPage&&_currentPage>0) {
        _currentPage++;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_paramDic];
        dic[@"currentPage"] = @(_currentPage);
        [USWebTool POST:_url paramDic:dic success:^(NSDictionary *dataDic) {
            
            if ([dataDic[@"data"] count]==0||[NSNull null]==dataDic[@"data"]||!([dataDic[@"totalNum"]intValue]>0)) {
                _currentPage--;
                [MBProgressHUD showSuccess:@"没有更多的数据可显示..."];
                return ;
            }
            [_dataList addObjectsFromArray:dataDic[@"data"]];
            [self.tableView reloadData];
            _currentPage =[dataDic[@"currentPage"] intValue];
            _totalPage = [dataDic[@"totalPage"] intValue];
        } failure:^(id data) {
            
        }];
    }
    [self.tableView footerEndRefreshing];
}
//
-(void)initLocMgr
 {
     if (_locMgr==nil) {
          //1.创建位置管理器（定位用户的位置）
        self.locMgr=[[CLLocationManager alloc]init];
                //2.设置代理
        self.locMgr.delegate=self;
    }
}


#pragma mark-CLLocationManagerDelegate

/**
 *  当定位到用户的位置时，就会调用（调用的频率比较频繁）
 */
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //locations数组里边存放的是CLLocation对象，一个CLLocation对象就代表着一个位置
   _currentLocation = [locations firstObject];
    
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    [MBProgressHUD showError:@"获取位置失败..."];
    [_mbProgressView hide:YES];
    _flag = NO;
}


///
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"reuseIdentifier";
    USNearTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell==nil) {
        cell = [[USNearTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier
                nearType:_nearType];
        
    }
    NSDictionary *data = _dataList[indexPath.row];
    if (data[@"headpic"]!=nil&&[NSNull null]!=data[@"headpic"]) {
        [cell.leftImgeView sd_setImageWithURL:[NSURL URLWithString:HYWebDataPath(data[@"headpic"])]];
    }else{
       cell.leftImgeView.image = _headerPic;
    }
    
//    if (_nearType == NearType_Person) {
//       
//        if (indexPath.row%2==0||indexPath.row%3==0) {
//              cell.nearTitleView.imgeNames = @[@"peron_blue_image"];
//        }else{
//            cell.nearTitleView.imgeNames = @[@"current_yuan_image"];
//        }
//       
//    }else{
//       cell.leftImgeView.image = [UIImage imageNamed:@"near_table_cell_group_img"];
//    }
    cell.nearTitleView.personTitle = data[@"name"];
    cell.nearTitleView.addressLabel.text = [NSString stringWithFormat:@"%@",data[@"distance"]];
    NSString *sign = data[@"sign"];
    if (sign!=nil&&sign.length>0) {
        cell.nearTitleView.voteLabel.text = [NSString stringWithFormat:@"  %@",sign];
    }else{
        cell.nearTitleView.voteLabel.hidden = YES;
 
    }
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  70;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    USPersonBriefViewController *briefVC = [[USPersonBriefViewController alloc]init];
    briefVC.nearId = _dataList[indexPath.row][@"id"];
    briefVC.distance = [NSString stringWithFormat:@"%@",_dataList[indexPath.row][@"distance"]];
    briefVC.sign = _dataList[indexPath.row][@"sign"];
    [self.navigationController pushViewController:briefVC animated:YES];
}
@end
