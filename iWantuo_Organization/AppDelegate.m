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

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //设置根视图
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    [self.window  makeKeyAndVisible];
    self.window.rootViewController = [SystemHandler rootViewController];
//    LoginViewController *vc = [[LoginViewController alloc]init];
//    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:vc];
//    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationBg"] forBarMetrics:UIBarMetricsDefault];
//    self.window.rootViewController = navi;
    
    [self initializePlat];
    
    return YES;
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

#pragma mark 初始化第三方
- (void)initializePlat {

    [self initUmeng];
}

- (void)initUmeng {
    //key已更换为iWantuo的了
    [MobClick startWithAppkey:@"569864e7e0f55af78b001fbb" reportPolicy:BATCH   channelId:nil];
}


@end
