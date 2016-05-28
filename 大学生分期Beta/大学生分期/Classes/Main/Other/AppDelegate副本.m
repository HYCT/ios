//
//  AppDelegate.m
//  红云创投
//
//  Created by HeXianShan on 15/8/6.
//  Copyright (c) 2015年 hongyunct. All rights reserved.
//

#import "AppDelegate.h"
#import "USMainUITabBarController.h"
#import "USAuthViewController.h"
#import "USHomeViewController.h"
#import "USUserService.h"
#import "USAccount.h"
#import "USCertificationViewController.h"
#import "USScanCodeResultViewController.h"
#import "USBankCardListViewController.h"
#import "USRebackViewController.h"
#import "USRebackListViewController.h"
#import "USAccountManagerViewController.h"
#import "USBindMobilePhoneViewController.h"
#import "USMoreAboutUsViewController.h"
#import "USRegisterFirstViewController.h"
#import "USFinanceLoanViewController.h"
#import "USBlackNameListViewController.h"
#import "USIncreateQuotaViewController.h"
#import "USVaughanCardViewController.h"
#import "USNearViewController.h"
#import "USRegisterFinshViewController.h"
#import "USSnatchViewController.h"
//----------二期内容-------------
#import "USCircleViewController.h"
#import "USSnatchDetailViewController.h"
#import "USMySnatchViewController.h"
#import "USPersonBriefViewController.h"
#import "USSayWordViewController.h"
#import "USXRankViewController.h"
#import "USInviteViewController.h"
#import "USPictureScanViewController.h"
#import "USSenInivteViewController.h"
#import "USMyInviteViewController.h"
#import "USMyInvitListViewController.h"
#import "USMyJoinIvitListViewController.h"
#import "USInvitRecordViewController.h"
#import "USFinanceLoanViewController.h"
#import "USCommentListViewController.h"
#import "USNearProfZoneViewController.h"
#import "USSayHelloViewController.h"
#import "USMyTicketViewController.h"
//百度推送
#import "BPush.h"
@interface AppDelegate ()<UIAlertViewDelegate>{
    UITabBarController *_tabBarCtr;
}
//消息类型
@property(nonatomic,strong)NSString *msg ;
@end

@implementation AppDelegate
+(void)initialize{
    UINavigationBar *navgationbar = [UINavigationBar appearance];
    [navgationbar setBackgroundImage:[UIImage imageNamed:@"nav_top_bg"] forBarMetrics:UIBarMetricsDefault];
    navgationbar.translucent = YES;
    NSMutableDictionary *navtitleTextAttri = [NSMutableDictionary dictionary];
    
    navtitleTextAttri[NSForegroundColorAttributeName] = HYCTColor(248,254,254);
    navtitleTextAttri[NSFontAttributeName]= [UIFont systemFontOfSize:kCommonNavFontSize];
    navgationbar.titleTextAttributes = navtitleTextAttri;
    [navgationbar setShadowImage:[[UIImage alloc] init]];
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    @try {
        self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        [self.window setBackgroundColor:[UIColor whiteColor]];
        
        // USScanCodeResultViewController *bindVC = [[USScanCodeResultViewController alloc]init];
        // UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:bindVC];
        //self.window.rootViewController = navVC;
        
        
        USMainUITabBarController *mainVC = [[USMainUITabBarController alloc]init];
        self.window.rootViewController = mainVC;
        
        //添加百度推送以后加的
        _tabBarCtr = mainVC;
        [self initBPushNotification:application TabBarController:mainVC launchOptions:launchOptions] ;
        
        [self.window  makeKeyAndVisible];
        
        return YES;
    }
    @catch (NSException *exception) {
        HYLog(@"didFinishLaunchingWithOptions error: %@ ",exception) ;
    }
    
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}





//百度推送--------百度推送--------百度推送--------百度推送--------百度推送--------百度推送--------百度推送--------


-(void) initBPushNotification:(UIApplication *)application TabBarController:(UITabBarController *)TabBarController launchOptions:(NSDictionary *)launchOptions{
    @try {
        //UIColor * cc = [UIColor whiteColor];
        //NSDictionary * dict = [NSDictionary dictionaryWithObject:cc forKey:UITextAttributeTextColor];
        //nav.navigationBar.titleTextAttributes = dict;
        //[nav.navigationBar setTranslucent:NO];//设置navigationbar的半透明
        //    [_tabBarCtr.tabBar setTranslucent:NO];
        //UIColor *blueColor=[UIColor blueColor] ;
        if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0)
        {
            
            //[nav.navigationBar setBarTintColor:UIColorFromRGB(0x39526d)];
            
            // [nav.navigationBar setBarTintColor:blueColor];
            //[TabBarController.tabBar setBarTintColor:UIColorFromRGB(0x39526d)];
            //[TabBarController.tabBar setBarTintColor:blueColor];
        }
        else
        {
            //[nav.navigationBar setTintColor:blueColor];
            //[TabBarController.tabBar setTintColor:blueColor];
        }
        // iOS8 下需要使用新的 API
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
            UIUserNotificationType myTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
            
            UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:myTypes categories:nil];
            [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        }else {
            UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
            [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
        }
        
#warning 测试 开发环境 时需要修改BPushMode为BPushModeDevelopment,生产环境为BPushModeProduction 需要修改Apikey为自己的Apikey
        
        BPushMode model = BPushModeDeFine;
        
        // 在 App 启动时注册百度云推送服务，需要提供 Apikey
        [BPush registerChannel:launchOptions apiKey:BPushApiKey pushMode:model withFirstAction:nil withSecondAction:nil withCategory:nil isDebug:BPushIsDubug];
        // App 是用户点击推送消息启动
        NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if (userInfo) {
            NSLog(@"从消息启动:%@",userInfo);
            [BPush handleNotification:userInfo];
        }
        
#if TARGET_IPHONE_SIMULATOR
        Byte dt[32] = {0xc6, 0x1e, 0x5a, 0x13, 0x2d, 0x04, 0x83, 0x82, 0x12, 0x4c, 0x26, 0xcd, 0x0c, 0x16, 0xf6, 0x7c, 0x74, 0x78, 0xb3, 0x5f, 0x6b, 0x37, 0x0a, 0x42, 0x4f, 0xe7, 0x97, 0xdc, 0x9f, 0x3a, 0x54, 0x10};
        [self application:application didRegisterForRemoteNotificationsWithDeviceToken:[NSData dataWithBytes:dt length:32]];
        
#endif
        //角标清0
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
        
        /*
         // 测试本地通知
         [self performSelector:@selector(testLocalNotifi) withObject:nil afterDelay:1.0];
         */
    }
    @catch (NSException *exception) {
        HYLog(@"initBPushNotification error :%@",exception) ;
    }
    
    
}





- (void)testLocalNotifi
{
    @try {
        NSLog(@"测试本地通知啦！！！");
        NSDate *fireDate = [[NSDate new] dateByAddingTimeInterval:5];
        [BPush localNotification:fireDate alertBody:@"这是本地通知" badge:3 withFirstAction:@"打开" withSecondAction:@"关闭" userInfo:nil soundName:nil region:nil regionTriggersOnce:YES category:nil];
    }
    @catch (NSException *exception) {
        HYLog(@"testLocalNotifi error :%@",exception) ;
    }
    
    
}

// 此方法是 用户点击了通知，应用在前台 或者开启后台并且应用在后台 时调起
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    @try {
        completionHandler(UIBackgroundFetchResultNewData);
        HYLog(@"收到消息：%@",userInfo) ;
        //赋值
        _msg = userInfo[@"type"] ;
        // 打印到日志 textView 中
        NSLog(@"********** iOS7.0之后 background **********");
        // 应用在前台 或者后台开启状态下，不跳转页面，让用户选择。
        if (application.applicationState == UIApplicationStateActive || application.applicationState == UIApplicationStateBackground) {
            NSLog(@"acitve or background");
            UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"收到一条消息" message:userInfo[@"aps"][@"alert"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alertView show];
        }
        else//杀死状态下，直接跳转到跳转页面。
        {
            [self MsgToController] ;
            // USSayHelloViewController *skipCtr = [[USSayHelloViewController alloc]init];
            // 根视图是nav 用push 方式跳转
            //[_tabBarCtr.selectedViewController pushViewController:skipCtr animated:YES];
            /*
             // 根视图是普通的viewctr 用present跳转
             [_tabBarCtr.selectedViewController presentViewController:skipCtr animated:YES completion:nil]; */
        }
        //[self.viewController addLogString:[NSString stringWithFormat:@"backgroud : %@",userInfo]];
    }
    @catch (NSException *exception) {
        HYLog(@"didReceiveRemoteNotification error : %@",exception) ;
    }
    
    
    
}

// 在 iOS8 系统中，还需要添加这个方法。通过新的 API 注册推送服务
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    @try {
        [application registerForRemoteNotifications];
    }
    @catch (NSException *exception) {
        
    }
    
    
    
    
}




- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    @try {
        NSLog(@"test:%@",deviceToken);
        [BPush registerDeviceToken:deviceToken];
        [BPush bindChannelWithCompleteHandler:^(id result, NSError *error) {
            //[self.viewController addLogString:[NSString stringWithFormat:@"Method: %@\n%@",BPushRequestMethodBind,result]];
            // 需要在绑定成功后进行 settag listtag deletetag unbind 操作否则会失败
            if (result) {
                //绑定数据
                [USUserService saveBPushChannelID] ;
                HYLog(@"bangdingresult:%@",result) ;
                /*
                 [BPush setTag:@"Mytag" withCompleteHandler:^(id result, NSError *error) {
                 if (result) {
                 NSLog(@"设置tag成功");
                 HYLog(@"result:%@",result) ;
                 }
                 }];
                 **/
            }
        }];
        
        // 打印到日志 textView 中
        //[self.viewController addLogString:[NSString stringWithFormat:@"Register use deviceToken : %@",deviceToken]];
    }
    @catch (NSException *exception) {
        
    }
    
    
    
}

// 当 DeviceToken 获取失败时，系统会回调此方法
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    @try {
        NSLog(@"DeviceToken 获取失败，原因：%@",error);
    }
    @catch (NSException *exception) {
        
        
    }
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    @try {
        // App 收到推送的通知
        [BPush handleNotification:userInfo];
        HYLog(@"收到消息%@",userInfo) ;
        _msg = userInfo[@"type"] ;
        NSLog(@"********** ios7.0之前 **********");
        // 应用在前台 或者后台开启状态下，不跳转页面，让用户选择。
        if (application.applicationState == UIApplicationStateActive || application.applicationState == UIApplicationStateBackground) {
            NSLog(@"acitve or background");
            UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"收到一条消息" message:userInfo[@"aps"][@"alert"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alertView show];
        }
        else//杀死状态下，直接跳转到跳转页面。
        {
            [self MsgToController] ;
            //USSayHelloViewController *skipCtr = [[USSayHelloViewController alloc]init];
            //[_tabBarCtr.selectedViewController pushViewController:skipCtr animated:YES];
        }
        
        //[self.viewController addLogString:[NSString stringWithFormat:@"Received Remote Notification :\n%@",userInfo]];
        
        NSLog(@"%@",userInfo);
    }
    @catch (NSException *exception) {
        
    }
    
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    @try {
        NSLog(@"接收本地通知啦！！！");
        [BPush showLocalNotificationAtFront:notification identifierKey:nil];
        
    }
    @catch (NSException *exception) {
        
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    @try {
        if (buttonIndex == 1) {
            
            [self MsgToController] ;
            //USSayHelloViewController *skipCtr = [[USSayHelloViewController alloc]init];
            // 根视图是nav 用push 方式跳转
            //[_tabBarCtr.selectedViewController pushViewController:skipCtr animated:YES];
            /*
             // 根视图是普通的viewctr 用present跳转
             [_tabBarCtr.selectedViewController presentViewController:skipCtr animated:YES completion:nil]; */
        }
    }
    @catch (NSException *exception) {
        
    }
    
}
//根据收到的消息跳转到不同的视图
-(void)MsgToController{
    //打招呼信息
    if([ @"0" isEqualToString:_msg] ){
        USSayHelloViewController *skipCtr = [[USSayHelloViewController alloc]init];
        // 根视图是nav 用push 方式跳转
        [_tabBarCtr.selectedViewController pushViewController:skipCtr animated:YES];
    }else if([ @"1" isEqualToString:_msg]){
        USMyTicketViewController *skipCtr = [[USMyTicketViewController alloc]init];
        // 根视图是nav 用push 方式跳转
        [_tabBarCtr.selectedViewController pushViewController:skipCtr animated:YES];
    }
}



@end
