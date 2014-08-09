#import "EEEBufferedDay.h"
#import "NSCalendar+EEEDateFormatting.h"
#import "NSCalendar+EEEDateCalculations.h"

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
    NSInteger numericDay = [calendar eee_numericDayForDate:date];
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
