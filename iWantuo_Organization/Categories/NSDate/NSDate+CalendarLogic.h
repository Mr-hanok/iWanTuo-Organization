//
//  NSDate+CalendarLogic.h
//  UCan_APP
//
//  Created by ミ﹏糖寅╰☆ on 14-12-12.
//  Copyright (c) 2014年 ミ﹏糖寅╰☆. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (CalendarLogic)

/**
 *  @brief  这个月有多少天
 *
 *  @return 天数
 *
 *  @since 1.0.0
 */
- (NSUInteger)numberOfDaysInCurrentMonth;

/**
 *  @brief  这个月有多少星期
 *
 *  @return 星期数
 *
 *  @since 1.0.0
 */
- (NSUInteger)numberOfWeeksInCurrentMonth;

/**
 *  @brief  这个月第一天是星期几
 *
 *  @return 星期几
 *
 *  @since 1.0.0
 */
- (NSUInteger)weeklyOrdinality;

/**
 *  @brief  这个月第一天的日期
 *
 *  @return 日期
 *
 *  @since 1.0.0
 */
- (NSDate *)firstDayOfCurrentMonth;

/**
 *  @brief  这个月最后一天的日期
 *
 *  @return 日期
 *
 *  @since 1.0.0
 */
- (NSDate *)lastDayOfCurrentMonth;

/**
 *  @brief  上一个月
 *
 *  @return 日期
 *
 *  @since 1.0.0
 */
- (NSDate *)dayInThePreviousMonth;

/**
 *  @brief  下一个月
 *
 *  @return 日期
 *
 *  @since 1.0.0
 */
- (NSDate *)dayInTheFollowingMonth;

/**
 *  @brief  获取当前日期之后的几个月
 *
 *  @param month 月数
 *
 *  @return 日期
 *
 *  @since 1.0.0
 */
- (NSDate *)dayInTheFollowingMonth:(NSInteger)month;

/**
 *  @brief  获取当前日期之后的几天
 *
 *  @param day 天数
 *
 *  @return 日期
 *
 *  @since 1.0.0
 */
- (NSDate *)dayInTheFollowingDay:(NSInteger)day;

/**
 *  @brief  获取年月日对象
 *
 *  @return 年月日Object
 *
 *  @since 1.0.0
 */
- (NSDateComponents *)YearMonthDayComponents;

/**
 *  @brief  字符串转NS日期
 *
 *  @param dateString 时间字符串
 *
 *  @return 日期
 *
 *  @since 1.0.0
 */
- (NSDate *)dateFromString:(NSString *)dateString;

/**
 *  @brief  日期转字符串
 *
 *  @param dateFormat 日期格式
 *
 *  @return 字符串
 */
- (NSString *)stringFromDateFormat:(NSString *)dateFormat;

/**
 *  @brief  二个日期直接相差多少天
 *
 *  @param today    日期一
 *  @param beforday 日期二
 *
 *  @return 天数
 *
 *  @since 1.0.0
 */
+ (NSInteger)getDayNumbertoDay:(NSDate *)today beforDay:(NSDate *)beforday;

/**
 *  @brief  周日几号
 *
 *  @return 几号
 *
 *  @since 1.0.0
 */
- (NSInteger)getWeekIntValueWithDate;

/**
 *  @brief  判断日期是今天、明天、后天、周几
 *
 *  @return 今天、明天、后天、周几
 *
 *  @since 1.0.0
 */
- (NSString *)compareIfTodayWithDate;

/**
 *  @brief  通过数字返回星期几
 *
 *  @param week 数字
 *
 *  @return 星期几
 *
 *  @since 1.0.0
 */
+ (NSString *)getWeekStringFromInteger:(NSInteger)week;

@end
