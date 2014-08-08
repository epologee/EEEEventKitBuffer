#import <Foundation/Foundation.h>
#import <EventKit/EventKit.h>

@interface EKEventStore (EEEBuffering)
- (void)eee_bufferEventsMatchingPredicate:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)ctx;
@end