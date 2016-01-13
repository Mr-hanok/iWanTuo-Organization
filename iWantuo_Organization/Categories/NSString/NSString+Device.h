//
//  NSString+Device.h
//  StudyChina
//
//  Created by 陈腾飞 on 15/9/8.
//  Copyright (c) 2015年 BeiJingYuntai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Device)

/**
 *  @brief  设备名称
 *
 *  @return "ios"
 */
+ (NSString *)systemName;

/**
 *  @brief  当前系统版本号
 *
 *  @return 版本号
 */
+ (NSString *)systemVersion;


/**
 *  @brief  app版本号
 *
 *  @return Version
 */
+ (NSString *)appVersion;


/**
 *  @brief  获取当前设备名称
 *
 *  @return 设备名称
 */
+ (NSString *)deviceName;

@end
