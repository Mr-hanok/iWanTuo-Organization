//
//  SystemHandler.m
//  iStudentHosting
//
//  Created by 月 吴 on 16/1/6.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "SystemHandler.h"
#import "HomeViewController.h"
#import "DiscoverViewController.h"
#import "TopViewController.h"
#import "MyViewController.h"
#import "NewVersionViewController.h"
#import "LoginViewController.h"

#define kVersionKey @"version"
@implementation SystemHandler

+ (UIViewController *)rootViewController {
    
    // ---- 第一次启动当前版本 ----
    // 获取Info.plist
    NSDictionary *infoDict = [NSBundle mainBundle].infoDictionary;
    // 获取当前用户的软件版本
    NSString *currentVersion = infoDict[@"CFBundleVersion"];
    // 获取上一次最新的版本
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:kVersionKey];
    
    // 如果是新版本
    if (![currentVersion isEqualToString:lastVersion]) {
        
        // 存储新版本
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:kVersionKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [AccountManager sharedInstance].locationId = @"3";//默认是上海的id
        [AccountManager sharedInstance].locationName = @"上海";
        [[AccountManager sharedInstance] saveAccountInfoToDisk];
        
        NewVersionViewController *newVc = [[NewVersionViewController alloc] init];
        return newVc;
        
    } else {
        if ([AccountManager sharedInstance].isLogin) {
            return [SystemHandler mainViewController];
        } else {
            return [SystemHandler loginViewController];
        }
        
    }
}

+ (UIViewController *)mainViewController {
    UITabBarController *rootTabBarController = [[UITabBarController alloc] init];
    
    UINavigationController *homeNav     = [[UINavigationController alloc] initWithRootViewController:[[HomeViewController alloc]     init]];
    UINavigationController *discoverNav = [[UINavigationController alloc] initWithRootViewController:[[DiscoverViewController alloc] init]];
    UINavigationController *topNav      = [[UINavigationController alloc] initWithRootViewController:[[TopViewController alloc]      init]];
    UINavigationController *myNav       = [[UINavigationController alloc] initWithRootViewController:[[MyViewController alloc]       init]];
    
    homeNav.tabBarItem     = [[UITabBarItem alloc] initWithTitle:@"首页" image:[[UIImage imageNamed:@"home_unSelect"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"home_Select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    discoverNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"发现" image:[[UIImage imageNamed:@"discover_unSelect"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"discover_Select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    topNav.tabBarItem      = [[UITabBarItem alloc] initWithTitle:@"广场" image:[[UIImage imageNamed:@"top_unSelect"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"top_Select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    myNav.tabBarItem       = [[UITabBarItem alloc] initWithTitle:@"我的" image:[[UIImage imageNamed:@"my_unSelect"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"my_Select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    [rootTabBarController setViewControllers:@[homeNav, discoverNav, topNav, myNav]];
    
    
    //调整tabbar的颜色
    //    rootTabBarController.tabBar.barTintColor = [UIColor whiteColor];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationBg"] forBarMetrics:UIBarMetricsDefault];
    //选中的颜色
    rootTabBarController.tabBar.tintColor = kNavigationColor;
    //调整bar模糊效果
    rootTabBarController.tabBar.translucent = YES;
    return rootTabBarController;
}

+ (UIViewController *)loginViewController {
    LoginViewController *vc = [[LoginViewController alloc]init];
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:vc];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationBg"] forBarMetrics:UIBarMetricsDefault];
    return navi;
}


@end
