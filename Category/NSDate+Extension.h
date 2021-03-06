//
//  NSDate+Extension.h


#import <Foundation/Foundation.h>

@interface NSDate (Extension)
+ (NSTimeInterval) timeIntervalBetweenEarlyDateStr:(NSString *)earlyDateStr lateDateStr:(NSString *)lateDateStr withFormat:(NSString *)format;
/**
 *  根据日期获得星期几
 */
+ (NSString*)weekdayStringFromDate:(NSDate *)inputDate;
/**
 *  日期相差的天数
 */
- (NSInteger)dayDiffToNow;
/**
 *  是否为本周（周一为起始）
 */
- (BOOL)isCurrentWeek;
/**
 *  是否为今天
 */
- (BOOL)isToday;

/**
 *  是否为今年
 */
- (BOOL)isThisYear;

/**
 *  返回一个只有年月日的时间
 */
- (NSDate *)dateWithYMD;

/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)deltaWithNow;

+ (NSDateFormatter *)getSharedDateFormatter;

+ (NSString *)getDateStrWithDate:(NSDate *)date dateFormatter:(NSString *)formatter;

+ (NSString *)getDateStrWithTime:(NSString *)time;

+ (NSString *)getShortDateStrWithTime:(NSString *)time;
@end
