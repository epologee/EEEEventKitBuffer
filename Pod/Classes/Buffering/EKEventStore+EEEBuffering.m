#import <CoreData/CoreData.h>
#import "EKEventStore+EEEBuffering.h"
#import "EEEBufferedDay.h"
#import "EEEBufferedEvent.h"

@implementation EKEventStore (EEEBuffering)

- (void)eee_bufferEventsFromStartDate:(NSDate *)startDate
                            toEndDate:(NSDate *)endDate
                            calendars:(NSArray *)calendars
                            inContext:(NSManagedObjectContext *)ctx
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *startComponents = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:startDate];
    NSDateComponents *runnerComponents = [startComponents copy];

    NSInteger days = [calendar components:NSCalendarUnitDay
                                 fromDate:startDate
                                   toDate:endDate
                                  options:0].day;

    for (NSInteger day = 0; day < days; day++)
    {
        runnerComponents.day += day;
        NSDate *dayDate = [calendar dateFromComponents:runnerComponents];
        NSDateComponents *dayComponents = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:dayDate];
        NSInteger numericDate = dayComponents.year * 10000 + dayComponents.month * 100 + dayComponents.day;
        BOOL created = NO;
        EEEBufferedDay *bufferedDay = [EEEBufferedDay uniqueEntityWithValue:@(numericDate)
                                                                     forKey:EEEBufferedDayAttributes.numericDate
                                                                    created:&created
                                                                  inContext:ctx];
        if (created)
        {
            [bufferedDay updateForDate:dayDate withComponents:dayComponents];
        }
    }

    NSPredicate *predicate = [self predicateForEventsWithStartDate:startDate endDate:endDate calendars:calendars];
    NSArray *events = [self eventsMatchingPredicate:predicate];
    [events enumerateObjectsUsingBlock:^(EKEvent *event, NSUInteger idx, BOOL *stop) {
        BOOL created = NO;
        EEEBufferedEvent *bufferedEvent = [EEEBufferedEvent bufferEvent:event created:&created inContext:ctx];
    }];
}

@end