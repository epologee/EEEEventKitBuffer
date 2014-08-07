#import <EventKit/EventKit.h>
#import "EEEBufferedEvent.h"

@interface EEEBufferedEvent ()
@end

@implementation EEEBufferedEvent

+ (instancetype)bufferEvent:(EKEvent *)event created:(BOOL *)created inContext:(NSManagedObjectContext *)ctx
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:[self entityName]];
    NSString *format = [NSString stringWithFormat:@"%@ == %%@", EEEBufferedEventAttributes.eventIdentifier];
    request.predicate = [NSPredicate predicateWithFormat:format, event.eventIdentifier];
    request.fetchLimit = 1;

    NSError *error = nil;
    EEEBufferedEvent *bufferedEvent;
    NSArray *existingEvents = [ctx executeFetchRequest:request error:&error];
    if ([existingEvents count] == 1)
    {
        bufferedEvent = [existingEvents lastObject];
        [bufferedEvent updateEvent:event];
        if (created) *created = NO;
        return bufferedEvent;
    }

    bufferedEvent = [self insertInManagedObjectContext:ctx];
    [bufferedEvent updateEvent:event];
    if (created) *created = YES;
    return bufferedEvent;
}

- (void)updateEvent:(EKEvent *)event
{
    if (![self.eventIdentifier isEqualToString:event.eventIdentifier]) self.eventIdentifier = event.eventIdentifier;
}

@end
