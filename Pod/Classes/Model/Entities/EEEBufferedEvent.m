#import <EventKit/EventKit.h>
#import <Kiwi/KWValue.h>
#import "EEEBufferedEvent.h"

@interface EEEBufferedEvent ()
@end

@implementation EEEBufferedEvent

+ (instancetype)bufferEvent:(EKEvent *)event forNumericDay:(NSInteger)numericDay created:(BOOL *)created inContext:(NSManagedObjectContext *)ctx
{
    NSDictionary *keyedValues = @{
            EEEBufferedEventAttributes.eventIdentifier : event.eventIdentifier,
            EEEBufferedEventAttributes.numericDay : @(numericDay)
    };

    EEEBufferedEvent *bufferedEvent = [self uniqueEntityWithKeyedValues:keyedValues
                                                                created:created
                                                              inContext:ctx];
    [bufferedEvent updateEvent:event];
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
