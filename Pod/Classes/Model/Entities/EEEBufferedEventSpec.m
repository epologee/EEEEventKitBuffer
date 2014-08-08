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

            [[expectFutureValue(theValue(resumed)) shouldEventuallyBeforeTimingOutAfter(30)] beYes];
            [[theValue(granted) should] beYes];
        });

        __block EEEEventKitBufferModel *model;
        __block EKEventStore *eventStore;

        beforeEach(^{
            eventStore = [[EKEventStore alloc] init];
            model = [[EEEEventKitBufferModel alloc] init];
        });

        context(@"with an event", ^{
            __block EKEvent *event;

            beforeEach(^{
                event = [EKEvent eventWithEventStore:eventStore];
                event.startDate = [NSDate date];
                event.endDate = [event.startDate dateByAddingTimeInterval:60 * 60];
                event.location = @"Halfweg";
                event.title = @"Appointment";
                event.allDay = YES;
                [event addAlarm:[EKAlarm alarmWithRelativeOffset:-15 * 60]];
                [event stub:@selector(hasAttendees) andReturn:theValue(YES)];
                [event stub:@selector(hasNotes) andReturn:theValue(YES)];
                [event stub:@selector(hasRecurrenceRules) andReturn:theValue(YES)];

                event.calendar = eventStore.defaultCalendarForNewEvents;

                NSError *saveError = nil;
                BOOL saved = [eventStore saveEvent:event span:EKSpanThisEvent commit:YES error:&saveError];
                [[theValue(saved) should] beYes];
                [[saveError should] beNil];
                [[event.eventIdentifier shouldNot] beNil];
            });

            context(@"which is then buffered", ^{
                __block EEEBufferedEvent *bufferedEvent;

                beforeEach(^{
                    BOOL created = NO;
                    bufferedEvent = [EEEBufferedEvent bufferEvent:event created:&created inContext:model.mainContext];
                    [[theValue(created) should] beYes];
                    [[bufferedEvent.eventIdentifier should] equal:event.eventIdentifier];
                });

                it(@"uniques on event identifier", ^{
                    BOOL created = YES;
                    [EEEBufferedEvent bufferEvent:event created:&created inContext:model.mainContext];
                    [[theValue(created) should] beNo];
                });

                describe(@"properties", ^{
                    it(@"allDay", ^{[[theValue(bufferedEvent.allDayValue) should] equal:theValue(event.allDay)];});
                    it(@"availability", ^{[[theValue(bufferedEvent.availabilityValue) should] equal:theValue(event.availability)];});
                    it(@"endDate", ^{[[bufferedEvent.endDate should] equal:event.endDate];});
                    it(@"hasAlarms", ^{[[theValue(bufferedEvent.hasAlarmsValue) should] equal:theValue(event.hasAlarms)];});
                    it(@"hasAttendees", ^{[[theValue(bufferedEvent.hasAttendeesValue) should] equal:theValue(event.hasAttendees)];});
                    it(@"hasNotes", ^{[[theValue(bufferedEvent.hasNotesValue) should] equal:theValue(event.hasNotes)];});
                    it(@"hasRecurrenceRules", ^{[[theValue(bufferedEvent.hasRecurrenceRulesValue) should] equal:theValue(event.hasRecurrenceRules)];});
                    it(@"location", ^{[[bufferedEvent.location should] equal:event.location];});
                    it(@"startDate", ^{[[bufferedEvent.startDate should] equal:event.startDate];});
                    it(@"title", ^{[[bufferedEvent.title should] equal:event.title];});
                });
            });
        });
    });
SPEC_END
