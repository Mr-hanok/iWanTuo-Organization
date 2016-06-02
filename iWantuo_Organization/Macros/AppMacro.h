//
//  AppMacro.h
//  StudyChina
//
//  Created by 陈腾飞 on 15/9/8.
//  Copyright (c) 2015年 BeiJingYuntai. All rights reserved.
//

#ifndef StudyChina_AppMacro_h
#define StudyChina_AppMacro_h

#import "SizeMacro.h"
#import "NetworkMacro.h"
#import "NotificationMacro.h"
#import "ColorMacro.h"
#import "ReusableMacros.h"
#import "FontMacro.h"

// 型号
#define IS_IPHONE4      kScreenBoundHeight == 480
#define IS_IPHONE5      kScreenBoundHeight == 568
#define IS_IPHONE6      kScreenBoundHeight == 667
#define IS_IPHONE6P     kScreenBoundHeight == 736

#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

// 系统版本
#define SystemOSVersion [[[UIDevice currentDevice] systemVersion] floatValue]

#define IS_IOS_8_OR_LATER [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0

// 根试图
#define kRootNavigation (UINavigationController *)[UIApplication sharedApplication].delegate.window.rootViewController

#define kRootViewController [UIApplication sharedApplication].delegate.window.rootViewController

#define KeyWindow [UIApplication sharedApplication].keyWindow


#define kPlaceholderImage @"DefaultImage"

#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#define debugMethod() NSLog(@"%s", __func__)
#define DDLog(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

#else
#define NSLog(...)
#define debugMethod()
#define DDLog(xx, ...)  ((void)0)

#endif

#endif
