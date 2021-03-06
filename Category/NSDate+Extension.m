//
//  NSDate+Extension.m


#import "NSDate+Extension.h"

@implementation NSDate (Extension)
+ (NSTimeInterval) timeIntervalBetweenEarlyDateStr:(NSString *)earlyDateStr lateDateStr:(NSString *)lateDateStr withFormat:(NSString *)format{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDate *earlyDate = [dateFormatter dateFromString:earlyDateStr];
    NSDate *lateDate = [dateFormatter dateFromString:lateDateStr];
    NSTimeInterval timeDiff = [lateDate timeIntervalSinceDate:earlyDate];
    return timeDiff;
}

/**
 *  根据日期获得星期几
 */
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = @[[NSNull null], @"星期天", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六"];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}


/**
 *  是否为今天
 */
- (BOOL)isToday
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear;
    
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    return
    (selfCmps.year == nowCmps.year) &&
    (selfCmps.month == nowCmps.month) &&
    (selfCmps.day == nowCmps.day);
}
/**
 *  日期相差的天数
 */
- (NSInteger)dayDiffToNow{
    NSDate *nowDate = [[NSDate date] dateWithYMD];
    NSDate *selfDate = [self dateWithYMD];
    
    // 获得nowDate和selfDate的差距
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    return cmps.day;
}
/**
 *  是否为本周（周一为起始）
 */
- (BOOL)isCurrentWeek{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //以周一为起点
    calendar.firstWeekday = 2;
    
    int unit = NSCalendarUnitYear | NSCalendarUnitWeekOfYear | NSCalendarUnitWeekday;
    
    // 1.获得当前时间的年 和 本年的第几周
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 2.获得self的年 和 本年的第几周
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    return (selfCmps.year == nowCmps.year) && (selfCmps.weekOfYear == nowCmps.weekOfYear);
}
/**
 *  将date转化为年月日的date
 */
- (NSDate *)dateWithYMD
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *selfStr = [fmt stringFromDate:self];
    return [fmt dateFromString:selfStr];
}

/**
 *  是否为今年
 */
- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear;
    
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    
    return nowCmps.year == selfCmps.year;
}
/**
 *  计算和当前时间相差的时 分 秒
 */
- (NSDateComponents *)deltaWithNow
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
}

+ (NSDateFormatter *)getSharedDateFormatter{
    NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
    NSDateFormatter *dateFormatter = threadDictionary[@"mydateformatter"];
    if (!dateFormatter) {
        @synchronized(self) {
            if (!dateFormatter) {
                dateFormatter = [NSDateFormatter new];
                dateFormatter.locale = [NSLocale currentLocale];
                threadDictionary[@"mydateformatter"] = dateFormatter;
            }
        }
    }
    return dateFormatter;
}

+ (NSString *)getDateStrWithDate:(NSDate *)date dateFormatter:(NSString *)formatter{
    NSDateFormatter * dateFormatter = [self getSharedDateFormatter];
    dateFormatter.dateFormat = formatter;
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}

+ (NSString *)getDateStrWithTime:(NSString *)time{
//    if (![time isNotEmpty]) {
//        return nil;
//    }else{
//        NSDate *date = [NSDate dateWithTimeIntervalSince1970:time.longLongValue / 1000];
//        NSString *dateFormatter = [date isThisYear] ? @"MM-dd HH:mm" : @"yyyy/MM/dd HH:mm";
//        return [self getDateStrWithDate:date dateFormatter:dateFormatter];
//    }
    return [self getShortDateStrWithTime:time];
}

+ (NSString *)getShortDateStrWithTime:(NSString *)time{
    if (![time isNotEmpty]) {
        return nil;
    }else{
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:time.longLongValue / 1000];
        
        NSString *dateFormatter = [[NSString alloc] init];
        if (![date isThisYear]) {
            
            dateFormatter = @"yyyy-MM-dd";
            
        } else if ([date isToday]) {
            
            dateFormatter = @"HH:mm";
            
        } else {
            
            dateFormatter = @"MM-dd";
        }
    
//        NSString *dateFormatter = [date isThisYear] ? @"MM-dd" : @"yyyy-MM-dd";
        return [self getDateStrWithDate:date dateFormatter:dateFormatter];
    }
}

@end
