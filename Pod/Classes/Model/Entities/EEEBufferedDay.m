#import "EEEBufferedDay.h"
#import "NSCalendar+EEEDateFormatting.h"

@interface EEEBufferedDay ()

@end

@implementation EEEBufferedDay

- (void)updateForDate:(NSDate *)date withComponents:(NSDateComponents *)components calendar:(NSCalendar *)calendar
{
    self.dateGMT = date;
    self.title = [[calendar eee_bufferedDayTitleFormatter] stringFromDate:date];
}

+ (instancetype)uniqueForDate:(NSDate *)date calendar:(NSCalendar *)calendar inContext:(NSManagedObjectContext *)ctx
{
    BOOL created = NO;
    NSDateComponents *dayComponents = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    NSInteger numericDate = dayComponents.year * 10000 + dayComponents.month * 100 + dayComponents.day;
    EEEBufferedDay *bufferedDay = [EEEBufferedDay uniqueEntityWithValue:@(numericDate)
                                                                 forKey:EEEBufferedDayAttributes.numericDate
                                                                created:&created
                                                              inContext:ctx];
    if (created)
    {
        [bufferedDay updateForDate:date withComponents:dayComponents calendar:calendar];
    }

    return bufferedDay;
}

@end
