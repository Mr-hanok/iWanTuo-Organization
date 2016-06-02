//
//  TimerHelper.h
//  StudyChina
//
//  Created by 陈腾飞 on 15/10/9.
//  Copyright © 2015年 BeiJingYuntai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimerHelper : NSObject

+ (NSString *)timeStrWithTimeInterval:(NSString *)timeInterval;

+ (NSString *)timeStrWithTimeStr:(NSString *)timeStr
                  OrignalFormate:(NSString *)orignalFormate
                    OtherFormate:(NSString *)formate;

+ (NSString *)timeStrWithTimeInterval:(NSString *)timeInterval
                          TimeFormate:(NSString *)timeFormate;
@end
