#import <Foundation/Foundation.h>
#import <EventKit/EventKit.h>

@class NSManagedObjectContext;

@interface EKEventStore (EEEBuffering)

- (void)eee_bufferEventsFromStartDate:(NSDate *)startDate
                            toEndDate:(NSDate *)endDate
                            calendars:(NSArray *)eventCalendars
                            inContext:(NSManagedObjectContext *)ctx;

@end