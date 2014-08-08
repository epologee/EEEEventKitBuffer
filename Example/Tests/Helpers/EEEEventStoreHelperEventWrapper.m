#import "EEEEventStoreHelperEventWrapper.h"

@interface EEEEventStoreHelperEventWrapper ()

@property(nonatomic, strong) EKEvent *event;

@end

@implementation EEEEventStoreHelperEventWrapper

- (id)initWithEvent:(EKEvent *)event
{
    self = [super init];

    if (self)
    {
        _event = event;
    }

    return self;
}

- (id <EEEBlockChainEvent> (^)(NSDate *))startDate
{
    return ^id <EEEBlockChainEvent>(NSDate *startDate) {
        self.event.startDate = startDate;
        self.event.endDate = [startDate dateByAddingTimeInterval:60 * 60];
        return self;
    };
}

- (id <EEEBlockChainEvent> (^)(NSString *))title
{
    return ^id <EEEBlockChainEvent>(NSString *title) {
        self.event.title = title;
        return self;
    };
}

- (id <EEEBlockChainEvent> (^)(NSString *))location
{
    return ^id <EEEBlockChainEvent>(NSString *location) {
        self.event.location = location;
        return self;
    };
}

- (id <EEEBlockChainEvent> (^)(BOOL))allDay
{
    return ^id <EEEBlockChainEvent>(BOOL allDay) {
        self.event.allDay = allDay;
        return self;
    };
}

- (id <EEEBlockChainEvent> (^)(BOOL))hasAttendees
{
    return ^id <EEEBlockChainEvent>(BOOL hasAttendees) {
        [self.event stub:@selector(hasAttendees) andReturn:theValue(hasAttendees)];
        return self;
    };
}

- (id <EEEBlockChainEvent> (^)(BOOL))hasNotes
{
    return ^id <EEEBlockChainEvent>(BOOL hasNotes) {
        [self.event stub:@selector(hasNotes) andReturn:theValue(hasNotes)];
        return self;
    };
}

- (id <EEEBlockChainEvent> (^)(BOOL))hasRecurrenceRules
{
    return ^id <EEEBlockChainEvent>(BOOL hasRecurrenceRules) {
        [self.event stub:@selector(hasRecurrenceRules) andReturn:theValue(hasRecurrenceRules)];
        return self;
    };
}

- (id <EEEBlockChainEvent> (^)(NSTimeInterval))addRelativeAlarm
{
    return ^id <EEEBlockChainEvent>(NSTimeInterval offset) {
        [self.event addAlarm:[EKAlarm alarmWithRelativeOffset:offset]];
        return self;
    };
}

@end