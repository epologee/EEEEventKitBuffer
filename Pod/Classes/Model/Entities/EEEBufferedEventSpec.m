#import <EventKit/EventKit.h>
#import "EEEEventKitBufferModel.h"
#import "EEEBufferedEvent.h"

SPEC_BEGIN(EEEBufferedEventSpec)

    describe(@"EEEBufferedEvent", ^{
        beforeAll(^{
            __block BOOL resumed = NO;
            __block BOOL granted = NO;

            [[[EKEventStore alloc] init] requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL g, NSError *error) {
                granted = g;
                resumed = YES;
            }];

            [[expectFutureValue(theValue(resumed)) shouldEventuallyBeforeTimingOutAfter(20)] beYes];
            [[theValue(granted) should] beYes];
        });

        __block EEEEventKitBufferModel *model;
        __block EKEventStore *eventStore;

        beforeEach(^{
            eventStore = [[EKEventStore alloc] init];
            model = [[EEEEventKitBufferModel alloc] init];
        });

        it(@"uniques events", ^{
            EKEvent *event = [EKEvent eventWithEventStore:eventStore];
            event.startDate = [NSDate date];
            event.endDate = [event.startDate dateByAddingTimeInterval:60 * 60];
            event.calendar = eventStore.defaultCalendarForNewEvents;
            NSError *saveError = nil;
            BOOL saved = [eventStore saveEvent:event span:EKSpanThisEvent commit:YES error:&saveError];
            [[theValue(saved) should] beYes];
            [[saveError should] beNil];
            [[event.eventIdentifier shouldNot] beNil];

            BOOL created = NO;
            EEEBufferedEvent *bufferedEvent = [EEEBufferedEvent bufferEvent:event created:&created inContext:model.mainContext];
            [[theValue(created) should] beYes];
            [[bufferedEvent.eventIdentifier should] equal:event.eventIdentifier];

            [EEEBufferedEvent bufferEvent:event created:&created inContext:model.mainContext];
            [[theValue(created) should] beNo];
        });
    });
SPEC_END
