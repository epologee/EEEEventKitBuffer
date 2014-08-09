#import <Foundation/Foundation.h>
#import <EventKit/EventKit.h>

#define expectEventStoreAccess() { \
    __block BOOL resumed = NO; \
    __block BOOL granted = NO; \
    [[[EKEventStore alloc] init] requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL g, NSError *error) { \
        granted = g; \
        resumed = YES; \
    }]; \
    [[expectFutureValue(theValue(resumed)) shouldEventuallyBeforeTimingOutAfter(30)] beYes]; \
    [[theValue(granted) should] beYes]; }

@protocol EEEBlockChainEvent

@property(nonatomic, readonly) id <EEEBlockChainEvent> (^startDate)(NSDate *startDate);
@property(nonatomic, readonly) id <EEEBlockChainEvent> (^endDate)(NSDate *startDate);
@property(nonatomic, readonly) id <EEEBlockChainEvent> (^title)(NSString *title);
@property(nonatomic, readonly) id <EEEBlockChainEvent> (^location)(NSString *location);
@property(nonatomic, readonly) id <EEEBlockChainEvent> (^notes)(NSString *notes);
@property(nonatomic, readonly) id <EEEBlockChainEvent> (^allDay)(BOOL allDay);
@property(nonatomic, readonly) id <EEEBlockChainEvent> (^hasAttendees)(BOOL hasAttendees);
@property(nonatomic, readonly) id <EEEBlockChainEvent> (^hasRecurrenceRules)(BOOL hasRecurrenceRules);
@property(nonatomic, readonly) id <EEEBlockChainEvent> (^addRelativeAlarm)(NSTimeInterval offset);

@end

@interface EEEEventStoreHelper : EKEventStore

@property(nonatomic, readonly) id <EEEBlockChainEvent> (^fakeEvent)(EKEvent **event);
@property(nonatomic, readonly) id <EEEBlockChainEvent> addFakeEvent;

@end