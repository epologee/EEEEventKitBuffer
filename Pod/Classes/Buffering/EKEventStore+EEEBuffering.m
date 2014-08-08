#import <CoreData/CoreData.h>
#import "EKEventStore+EEEBuffering.h"
#import "EEEBufferedDay.h"
#import "EEEBufferedEvent.h"
#import "NSCalendar+EEEDateCalculations.h"

@implementation EKEventStore (EEEBuffering)

- (void)eee_bufferEventsFromStartDate:(NSDate *)startDate
                            toEndDate:(NSDate *)endDate
                            calendars:(NSArray *)eventCalendars
                            inContext:(NSManagedObjectContext *)ctx
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *startComponents = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:startDate];
    NSDateComponents *runnerComponents = [startComponents copy];

    NSInteger days = [calendar components:NSCalendarUnitDay
                                 fromDate:startDate
                                   toDate:endDate
                                  options:0].day;

    for (NSInteger day = 0; day <= days; day++)
    {
        runnerComponents.day = startComponents.day + day;
        NSDate *dayDate = [calendar dateFromComponents:runnerComponents];
        EEEBufferedDay *bufferedDay = [EEEBufferedDay uniqueForDate:dayDate calendar:calendar inContext:ctx];
        bufferedDay.events = [NSSet setWithArray:[self eee_bufferEventsForDayAtDate:dayDate
                                                                           calendar:calendar
                                                                     eventCalendars:eventCalendars
                                                                          inContext:ctx]];
    }
}

- (NSMutableArray *)eee_bufferEventsForDayAtDate:(NSDate *)dayDate
                                        calendar:(NSCalendar *)calendar
                                  eventCalendars:(NSArray *)eventCalendars
                                       inContext:(NSManagedObjectContext *)ctx
{
    NSDate *startDate = [calendar eee_firstSecondOfDate:dayDate];
    NSDate *endDate = [calendar eee_lastSecondOfDate:dayDate];
    NSPredicate *predicate = [self predicateForEventsWithStartDate:startDate endDate:endDate calendars:eventCalendars];
    NSArray *events = [self eventsMatchingPredicate:predicate];
    NSMutableArray *bufferedEvents = [NSMutableArray arrayWithCapacity:events.count];
    [events enumerateObjectsUsingBlock:^(EKEvent *event, NSUInteger idx, BOOL *stop) {
        BOOL created = NO;
        EEEBufferedEvent *bufferedEvent = [EEEBufferedEvent bufferEvent:event created:&created inContext:ctx];
        [bufferedEvents addObject:bufferedEvent];
    }];

    return bufferedEvents;
}
@end