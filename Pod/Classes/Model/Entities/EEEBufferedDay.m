#import "EEEBufferedDay.h"
#import "NSCalendar+EEEDateFormatting.h"

@interface EEEBufferedDay ()

@end

@implementation EEEBufferedDay

- (void)updateForDate:(NSDate *)date calendar:(NSCalendar *)calendar
{
    self.dateGMT = date;
    self.title = [[calendar eee_bufferedDayTitleFormatter] stringFromDate:date];
}

+ (instancetype)uniqueForDate:(NSDate *)date calendar:(NSCalendar *)calendar inContext:(NSManagedObjectContext *)ctx
{
    BOOL created = NO;
    NSDateComponents *dayComponents = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    NSInteger numericDay = dayComponents.year * 10000 + dayComponents.month * 100 + dayComponents.day;
    EEEBufferedDay *bufferedDay = [EEEBufferedDay uniqueEntityWithValue:@(numericDay)
                                                                 forKey:EEEBufferedDayAttributes.numericDay
                                                                created:&created
                                                              inContext:ctx];
    if (created)
    {
        [bufferedDay updateForDate:date calendar:calendar];
    }

    return bufferedDay;
}

@end
