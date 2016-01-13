//
//  TimerHelper.m
//  StudyChina
//
//  Created by 陈腾飞 on 15/10/9.
//  Copyright © 2015年 BeiJingYuntai. All rights reserved.
//

#import "TimerHelper.h"
#import "NSDate+CalendarLogic.h"
#import "NSDate+FSExtension.h"

@implementation TimerHelper

+ (NSString *)timeStrWithTimeInterval:(NSString *)timeInterval {
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeInterval integerValue]];
    NSDate *toDate = [NSDate date];
    NSInteger dayInter = [NSDate getDayNumbertoDay:toDate beforDay:date];
    
    if (dayInter == 0) {
        return @"今天";
    } else if (dayInter == 1) {
        return @"昨天";
    } else if (dayInter == 2) {
        return @"前天";
    } else {
        return [date stringFromDateFormat:@"MM-dd"];
    }
    
}

+ (NSString *)timeStrWithTimeStr:(NSString *)timeStr
                  OrignalFormate:(NSString *)orignalFormate
                    OtherFormate:(NSString *)formate {
    NSDate *date = [NSDate fs_dateFromString:timeStr format:orignalFormate];
    return [date fs_stringWithFormat:@"MM-dd HH:mm"];
}

+ (NSString *)timeStrWithTimeInterval:(NSString *)timeInterval
                  TimeFormate:(NSString *)timeFormate{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeInterval integerValue]];
    return [date fs_stringWithFormat:timeFormate];//@"MM-dd HH:mm"
}
@end
