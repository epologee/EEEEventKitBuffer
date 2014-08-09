#import "EEEBufferedDay.h"
#import "NSCalendar+EEEDateFormatting.h"
#import "NSCalendar+EEEDateCalculations.h"

#define EEEBufferedDateThreadKey @"EEEBufferedDateThreadKey"
#define EEEBufferedDayThreadKey @"EEEBufferedDayThreadKey"

@interface EEEBufferedDay ()

@end

@implementation EEEBufferedDay

+ (NSDateFormatter *)dateFormatterForCalendar:(NSCalendar *)calendar
{
    NSMutableDictionary *dictionary = [[NSThread currentThread] threadDictionary];
    NSDateFormatter *eventStore = dictionary[EEEBufferedDateThreadKey];

    if (eventStore == nil)
    {
        eventStore = [calendar eee_bufferedDateFormatter];
        dictionary[EEEBufferedDateThreadKey] = eventStore;
    }

    return eventStore;
}

+ (NSDateFormatter *)dayFormatterForCalendar:(NSCalendar *)calendar
{
    NSMutableDictionary *dictionary = [[NSThread currentThread] threadDictionary];
    NSDateFormatter *eventStore = dictionary[EEEBufferedDayThreadKey];

    if (eventStore == nil)
    {
        eventStore = [calendar eee_bufferedDayFormatter];
        dictionary[EEEBufferedDayThreadKey] = eventStore;
    }

    return eventStore;
}

- (void)updateForDate:(NSDate *)date calendar:(NSCalendar *)calendar
{
    self.dateGMT = date;
    self.titleDate = [[[self class] dateFormatterForCalendar:calendar] stringFromDate:date];
    self.titleDay = [[[self class] dayFormatterForCalendar:calendar] stringFromDate:date];
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
