#import <EventKit/EventKit.h>
#import "EEEEventKitBufferModel.h"
#import "EEEBufferedEvent.h"
#import "EEEEventStoreHelper.h"

SPEC_BEGIN(EEEBufferedEventSpec)

    describe(@"EEEBufferedEvent", ^{
        beforeAll(^{
            expectEventStoreAccess();
        });

        __block EEEEventKitBufferModel *model;
        __block EEEEventStoreHelper *eventStore;

        beforeEach(^{
            eventStore = [[EEEEventStoreHelper alloc] init];
            model = [[EEEEventKitBufferModel alloc] init];
        });

        context(@"with an event", ^{
            __block EKEvent *event = nil;

            beforeEach(^{
                eventStore.fakeEvent(&event).
                        startDate([NSDate date]).
                        title(@"Appointment").
                        location(@"Halfweg").
                        allDay(YES).
                        hasAttendees(YES).
                        hasNotes(YES).
                        hasRecurrenceRules(YES).
                        addRelativeAlarm(-15 * 60);
            });

            context(@"which is then buffered", ^{
                __block EEEBufferedEvent *bufferedEvent;

                beforeEach(^{
                    BOOL created = NO;
                    bufferedEvent = [EEEBufferedEvent bufferEvent:event created:&created inContext:model.mainContext];
                    [[theValue([model.mainContext save:NULL]) should] beYes];
                    [[theValue(created) should] beYes];
                    [[bufferedEvent.eventIdentifier should] equal:event.eventIdentifier];
                });

                it(@"uniques on event identifier", ^{
                    BOOL created = YES;
                    [EEEBufferedEvent bufferEvent:event created:&created inContext:model.mainContext];
                    [[theValue(created) should] beNo];
                    [[theValue(model.mainContext.hasChanges) should] beNo];
                });

                describe(@"buffering attributes", ^{
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
