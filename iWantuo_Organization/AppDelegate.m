//
//  AppDelegate.m
//  iWantuo_Organization
//
//  Created by 月 吴 on 16/1/12.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "AppDelegate.h"
#import "SystemHandler.h"
#import "LoginViewController.h"
#import "APNsManager.h"
#import "PushInfoManager.h"

//第三方平台的SDK头文件，根据需要的平台导入。
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import "WXApi.h"


/// 个推开发者网站中申请App时注册的AppId、AppKey、AppSecret
#define kGtAppId           @"mdQNCtTzlb70jzCqQI4u43"
#define kGtAppKey          @"JYd49ugwx762hImEBIdwp1"
#define kGtAppSecret       @"C88yQCw8SF8bgTVekaVVu1"

@interface AppDelegate ()<GeTuiSdkDelegate>
@property (nonatomic, strong) BMKMapManager *mapManager;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //设置根视图
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    [self.window  makeKeyAndVisible];
    self.window.rootViewController = [SystemHandler rootViewController];

    
    [self initializePlat];
    
    //推送
    //     通过个推平台分配的appId、 appKey 、appSecret 启动SDK，注：该方法需要在主线程中调用
    [GeTuiSdk startSdkWithAppId:kGtAppId appKey:kGtAppKey appSecret:kGtAppSecret delegate:self];
    
    // 注册APNS
    [self registerUserNotification];
    
    // 处理远程通知启动APP
    [self receiveNotificationByLaunchingOptions:launchOptions];

    
    return YES;
}

//远程推送通知
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *deviceTokenStr = [[[[deviceToken description]
                                  stringByReplacingOccurrencesOfString:@"<" withString:@""]
                                 stringByReplacingOccurrencesOfString:@">" withString:@""]
                                stringByReplacingOccurrencesOfString:@" " withString: @""];
    [AccountManager sharedInstance].deviceToken = deviceTokenStr;
    //向APNS注册成功，收到返回的deviceToken
    [[APNsManager sharedInstance] registerDeviceToken:deviceTokenStr];
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    
    NSLog(@"error:%@",error);
    
    //向APNS注册失败，返回错误信息error
    [[APNsManager sharedInstance] registerDeviceToken:@""];
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"userInfo:%@",userInfo);
    //收到远程推送通知消息
    
    @try {
        if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive) {
            [[PushInfoManager sharedInstance] onLineReceivePushInfoWithDict:userInfo];
        } else {
            [[PushInfoManager sharedInstance] offLineReceivePushInfoWithDict:userInfo];
        }
    }
    @catch (NSException *exception) {
        [AlertViewManager showAlertViewWithMessage:@"推送信息解析错误"];
    }
    @finally {
        
    }
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[APNsManager sharedInstance] stopSdk];
    [[AccountManager sharedInstance] saveAccountInfoToDisk];

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [[APNsManager sharedInstance] startSdk];
    [[AccountManager sharedInstance] loadAccountInfoFromDisk];

}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[AccountManager sharedInstance] saveAccountInfoToDisk];
}


#pragma mark - private 初始化第三方平台
- (void)initializePlat {
    
    [self initMap];
    [self initShareSDK];
    [self initUmeng];
}

- (void)initMap {
    //设置百度地图
    self.mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    //key已更换为iWantuo的了
    BOOL ret = [self.mapManager start:@"4YO0YwrrN3l75ftF5u5pO6Bb"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
}

- (void)initShareSDK {
    
    [ShareSDK registerApp:@"d33bc55e6ff8"
     
          activePlatforms:@[
                            @(SSDKPlatformTypeWechat)]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
                 
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wx69aecc1a2a29b130"
                                       appSecret:@"cb80fd46a5d9458750062721fe5a314e"];
                 break;
             default:
                 break;
         }
     }];
}

- (void)initUmeng {
    //key已更换为iWantuo的了
    [MobClick startWithAppkey:@"569864e7e0f55af78b001fbb" reportPolicy:BATCH   channelId:nil];
}

#pragma mark - 用户通知(推送) _自定义方法

/** 注册用户通知 */
- (void)registerUserNotification {
    
    /*
     注册通知(推送)
     申请App需要接受来自服务商提供推送消息
     */
    
    // 判读系统版本是否是“iOS 8.0”以上
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ||
        [UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]) {
        
        // 定义用户通知类型(Remote.远程 - Badge.标记 Alert.提示 Sound.声音)
        UIUserNotificationType types = UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        
        // 定义用户通知设置
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        
        // 注册用户通知 - 根据用户通知设置
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    } else { // iOS8.0 以前远程推送设置方式
        // 定义远程通知类型(Remote.远程 - Badge.标记 Alert.提示 Sound.声音)
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        
        // 注册远程通知 -根据远程通知类型
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    }
}

/** 自定义：APP被“推送”启动时处理推送消息处理（APP 未启动--》启动）*/
- (void)receiveNotificationByLaunchingOptions:(NSDictionary *)launchOptions {
    if (!launchOptions)
        return;
    
    /*
     通过“远程推送”启动APP
     UIApplicationLaunchOptionsRemoteNotificationKey 远程推送Key
     */
    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (userInfo) {
        NSLog(@"\n>>>[Launching RemoteNotification]:%@", userInfo);
    }
}



@end
