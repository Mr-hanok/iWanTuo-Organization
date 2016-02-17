//
//  AppDeviceManager.h
//  DoctorYL
//
//  Created by 张玺 on 15/1/13.
//  Copyright (c) 2015年 yuntai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppDeviceManager : NSObject

//ios
+ (NSString *)systemName;
//系统版本号
+ (NSString *)systemVersion;
//app版本号
+ (NSString *)appVersion;
//设备名称
+ (NSString *)deviceName;

@end
