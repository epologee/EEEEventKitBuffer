#import <Foundation/Foundation.h>
#import <EventKit/EventKit.h>

@class NSManagedObjectContext;

@interface EKEventStore (EEEBuffering)

- (void)eee_bufferEventsFromStartDate:(NSDate *)startDate
                            toEndDate:(NSDate *)endDate
                            calendars:(NSArray *)calendars
                            inContext:(NSManagedObjectContext *)ctx;

@end