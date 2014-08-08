#import <EventKit/EventKit.h>
#import <Kiwi/KWValue.h>
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
    NSArray *dates = @[
            EEEBufferedEventAttributes.startDate,
            EEEBufferedEventAttributes.endDate
    ];
    [dates enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop) {
        NSDate *value = [event valueForKey:key];
        if (![[self valueForKey:key] isEqualToDate:value])
        {
            [self setValue:value forKey:key];
        }
    }];

    NSArray *strings = @[
            EEEBufferedEventAttributes.title,
            EEEBufferedEventAttributes.location,
            EEEBufferedEventAttributes.eventIdentifier
    ];
    [strings enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop) {
        NSString *value = [event valueForKey:key];
        if (![[self valueForKey:key] isEqualToString:value])
        {
            [self setValue:value forKey:key];
        }
    }];

    NSArray *numerics = @[
            EEEBufferedEventAttributes.allDay,
            EEEBufferedEventAttributes.hasAlarms,
            EEEBufferedEventAttributes.hasAttendees,
            EEEBufferedEventAttributes.hasNotes,
            EEEBufferedEventAttributes.hasRecurrenceRules,
            EEEBufferedEventAttributes.availability
    ];
    [numerics enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop) {
        NSNumber *value = [event valueForKey:key];
        if (![[self valueForKey:key] isEqualToNumber:value])
        {
            [self setValue:value forKey:key];
        }
    }];
}

@end
