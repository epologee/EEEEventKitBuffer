#import <CoreData/CoreData.h>
#import "EKEventStore+EEEBuffering.h"
#import "EEEBufferedDay.h"
#import "EEEBufferedEvent.h"

@implementation EKEventStore (EEEBuffering)

- (void)eee_bufferEventsMatchingPredicate:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)ctx
{
    NSArray *events = [self eventsMatchingPredicate:predicate];
    [events enumerateObjectsUsingBlock:^(EKEvent *event, NSUInteger idx, BOOL *stop) {
        BOOL created = NO;
        [EEEBufferedEvent bufferEvent:event created:&created inContext:ctx];
    }];
}

@end