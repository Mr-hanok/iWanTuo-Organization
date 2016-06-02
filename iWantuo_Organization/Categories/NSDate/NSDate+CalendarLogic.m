//
//  NSDate+CalendarLogic.m
//  UCan_APP
//
//  Created by ミ﹏糖寅╰☆ on 14-12-12.
//  Copyright (c) 2014年 ミ﹏糖寅╰☆. All rights reserved.
//

#import "NSDate+CalendarLogic.h"

@implementation NSDate (CalendarLogic)

/*计算这个月有多少天*/
- (NSUInteger)numberOfDaysInCurrentMonth {
    
    return [[NSCalendar currentCalendar] rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:self].length;
    
}

- (NSUInteger)numberOfWeeksInCurrentMonth {
    
    NSUInteger weekday = [[self firstDayOfCurrentMonth] weeklyOrdinality];
    
    NSUInteger days = [self numberOfDaysInCurrentMonth];
    
    NSUInteger weeks = 0;
    
    if (weekday > 1) {
        
        weeks += 1, days -= (7 - weekday + 1);
    
    }
    
    weeks += days / 7;
    
    weeks += (days % 7 > 0) ? 1 : 0;
    
    return weeks;

}

- (NSUInteger)weeklyOrdinality {
    
    return [[NSCalendar currentCalendar] ordinalityOfUnit:NSDayCalendarUnit inUnit:NSWeekCalendarUnit forDate:self];

}

- (NSDate *)firstDayOfCurrentMonth {
    
    NSDate *startDate = nil;
    
    BOOL ok = [[NSCalendar currentCalendar] rangeOfUnit:NSMonthCalendarUnit startDate:&startDate interval:NULL forDate:self];
    
    NSAssert1(ok, @"Failed to calculate the first day of the month based on %@", self);
    
    return startDate;

}


- (NSDate *)lastDayOfCurrentMonth {
    
    NSCalendarUnit calendarUnit = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:calendarUnit fromDate:self];
    
    dateComponents.day = [self numberOfDaysInCurrentMonth];
    
    return [[NSCalendar currentCalendar] dateFromComponents:dateComponents];

}

- (NSDate *)dayInThePreviousMonth {
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    
    dateComponents.month = -1;
    
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];

}

- (NSDate *)dayInTheFollowingMonth {
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    
    dateComponents.month = 1;
    
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];

}

- (NSDate *)dayInTheFollowingMonth:(NSInteger)month {
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    
    dateComponents.month = month;
    
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];

}

- (NSDate *)dayInTheFollowingDay:(NSInteger)day {
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    
    dateComponents.day = day;
    
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];

}

- (NSDateComponents *)YearMonthDayComponents {
    
    return [[NSCalendar currentCalendar] components:
            NSYearCalendarUnit|
            NSMonthCalendarUnit|
            NSDayCalendarUnit|
            NSWeekdayCalendarUnit fromDate:self];
    
}

- (NSDate *)dateFromString:(NSString *)dateString {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    
    return destDate;
    
}

- (NSString *)stringFromDateFormat:(NSString *)dateFormat {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:dateFormat];
    
    NSString *destDateString = [dateFormatter stringFromDate:self];
    
    return destDateString;
    
}


+ (NSInteger)getDayNumbertoDay:(NSDate *)today beforDay:(NSDate *)beforday {
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *components = [calendar components:NSDayCalendarUnit fromDate:today toDate:beforday options:0];
    
    NSInteger day = [components day];
    
    return day;

}


//周日是“1”，周一是“2”...
-(NSInteger)getWeekIntValueWithDate {
    
    int weekIntValue;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSChineseCalendar];
    
    NSDateComponents *comps= [calendar components:(NSYearCalendarUnit |
                                                   NSMonthCalendarUnit |
                                                   NSDayCalendarUnit |
                                                   NSWeekdayCalendarUnit) fromDate:self];
    
    weekIntValue = (int)[comps weekday];
    
    return weekIntValue;

}

-(NSString *)compareIfTodayWithDate {
    
    NSDate *todate = [NSDate date];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSChineseCalendar];
    
    NSDateComponents *comps_today= [calendar components:(NSYearCalendarUnit |
                                                         NSMonthCalendarUnit |
                                                         NSDayCalendarUnit |
                                                         NSWeekdayCalendarUnit) fromDate:todate];
    
    
    NSDateComponents *comps_other= [calendar components:(NSYearCalendarUnit |
                                                         NSMonthCalendarUnit |
                                                         NSDayCalendarUnit |
                                                         NSWeekdayCalendarUnit) fromDate:self];
    
    NSInteger weekIntValue = [self getWeekIntValueWithDate];
    
    if (comps_today.year == comps_other.year &&
        comps_today.month == comps_other.month &&
        comps_today.day == comps_other.day) {
        
        return @"今天";
        
    }else if (comps_today.year == comps_other.year &&
              comps_today.month == comps_other.month &&
              (comps_today.day - comps_other.day) == -1){
        
        return @"明天";
        
    }else if (comps_today.year == comps_other.year &&
              comps_today.month == comps_other.month &&
              (comps_today.day - comps_other.day) == -2){
        
        return @"后天";
        
    }else{
    
        return [NSDate getWeekStringFromInteger:weekIntValue];
    
    }
    
}

+ (NSString *)getWeekStringFromInteger:(NSInteger)week {
    
    NSString *str_week;
    
    switch (week) {
        case 1:
            str_week = @"SUN";
            break;
        case 2:
            str_week = @"MON";
            break;
        case 3:
            str_week = @"TUE";
            break;
        case 4:
            str_week = @"WED";
            break;
        case 5:
            str_week = @"THU";
            break;
        case 6:
            str_week = @"FRI";
            break;
        case 7:
            str_week = @"STA";
            break;
    
    }
    
    return str_week;
    
}

@end
