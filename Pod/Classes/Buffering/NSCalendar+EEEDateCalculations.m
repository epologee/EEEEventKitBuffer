#import "NSCalendar+EEEDateCalculations.h"

@implementation NSCalendar (EEEDateCalculations)

- (BOOL)eee_date:(NSDate *)date isEqualToOtherDate:(NSDate *)otherDate forUnits:(NSCalendarUnit)units
{
    NSDateComponents *simpleDate = [self components:units fromDate:date];
    NSDateComponents *simpleOtherDate = [self components:units fromDate:otherDate];

    BOOL equality = [simpleDate isEqual:simpleOtherDate];
    return equality;
}

- (NSInteger)eee_numericDayForDate:(NSDate *)date
{
    NSDateComponents *dayComponents = [self components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    return dayComponents.year * 10000 + dayComponents.month * 100 + dayComponents.day;
}

- (BOOL)eee_date:(NSDate *)date isOnSameDayAs:(NSDate *)otherDate
{
    if (!otherDate) return NO;

    return [self eee_date:date isEqualToOtherDate:otherDate forUnits:NSYearCalendarUnit | NSMonthCalendarUnit | NSCalendarUnitDay];
}

- (NSDate *)eee_firstSecondOfDate:(NSDate *)date
{
    NSDate *beginning = nil;
    if (![self rangeOfUnit:NSCalendarUnitDay startDate:&beginning interval:NULL forDate:date])
    {
        [NSException raise:@"NSCalendar+EEEDateCalculationsException" format:@"Could not find beginning for date %@", date];
    }

    return beginning;
}

- (NSDate *)eee_lastSecondOfDate:(NSDate *)date
{
    NSDateComponents *oneDay = [[NSDateComponents alloc] init];
    [oneDay setDay:1];
    [oneDay setSecond:-1];

    return [self dateByAddingComponents:oneDay toDate:[self eee_firstSecondOfDate:date] options:0];
}

@end