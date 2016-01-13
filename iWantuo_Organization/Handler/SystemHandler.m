//
//  SystemHandler.m
//  iStudentHosting
//
//  Created by 月 吴 on 16/1/6.
//  Copyright © 2016年 月 吴. All rights reserved.
//

#import "SystemHandler.h"
//#import "HomeViewController.h"
//#import "DiscoverViewController.h"
//#import "TopViewController.h"
//#import "MyViewController.h"

@implementation SystemHandler

+ (UIViewController *)rootViewController {
    
    UITabBarController *rootTabBarController = [[UITabBarController alloc] init];
    
//    UINavigationController *homeNav     = [[UINavigationController alloc] initWithRootViewController:[[HomeViewController alloc]     init]];
//    UINavigationController *discoverNav = [[UINavigationController alloc] initWithRootViewController:[[DiscoverViewController alloc] init]];
//    UINavigationController *topNav      = [[UINavigationController alloc] initWithRootViewController:[[TopViewController alloc]      init]];
//    UINavigationController *myNav       = [[UINavigationController alloc] initWithRootViewController:[[MyViewController alloc]       init]];
//    
//    homeNav.tabBarItem     = [[UITabBarItem alloc] initWithTitle:@"首页" image:[[UIImage imageNamed:@"unSelect"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"Select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    discoverNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"发现" image:[[UIImage imageNamed:@"unSelect"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"Select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    topNav.tabBarItem      = [[UITabBarItem alloc] initWithTitle:@"排行榜" image:[[UIImage imageNamed:@"unSelect"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"Select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    myNav.tabBarItem       = [[UITabBarItem alloc] initWithTitle:@"我的" image:[[UIImage imageNamed:@"unSelect"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"Select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    
//    [rootTabBarController setViewControllers:@[homeNav, discoverNav, topNav, myNav]];
    
    
    //调整tabbar的颜色
//    rootTabBarController.tabBar.barTintColor = [UIColor whiteColor];
    //选中的颜色
    rootTabBarController.tabBar.tintColor = [UIColor purpleColor];
    //调整bar模糊效果
    rootTabBarController.tabBar.translucent = YES;
    return rootTabBarController;
}

@end
