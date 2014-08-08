#import "NSCalendar+EEEDateCalculations.h"

@implementation NSCalendar (EEEDateCalculations)

- (BOOL)eee_date:(NSDate *)date isEqualToOtherDate:(NSDate *)otherDate forUnits:(NSCalendarUnit)units
{
    NSDateComponents *simpleDate = [self components:units fromDate:date];
    NSDateComponents *simpleOtherDate = [self components:units fromDate:otherDate];

    BOOL equality = [simpleDate isEqual:simpleOtherDate];
    return equality;
}

- (BOOL)eee_date:(NSDate *)date isOnSameDayAs:(NSDate *)otherDate
{
    if (!otherDate) return NO;

    return [self eee_date:date isEqualToOtherDate:otherDate forUnits:NSYearCalendarUnit | NSMonthCalendarUnit | NSCalendarUnitDay];
}

@end