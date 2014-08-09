#import <EventKit/EventKit.h>
#import "EEEEventKitBufferModel.h"
#import "EEEBufferedEvent.h"
#import "EEEEventStoreHelper.h"
#import "NSCalendar+EEEDateCalculations.h"

SPEC_BEGIN(EEEBufferedEventSpec)
    describe(@"EEEBufferedEvent", ^{
        beforeAll(^{
//            expectEventStoreAccess();
        });

        __block EEEEventKitBufferModel *model;
        __block EEEEventStoreHelper *eventStore;

        beforeEach(^{
            eventStore = [[EEEEventStoreHelper alloc] init];
            model = [[EEEEventKitBufferModel alloc] init];
        });

        context(@"with an event", ^{
            __block EKEvent *event = nil;
            __block NSDate *eventDate;
            __block NSInteger eventNumericDay;

            beforeEach(^{
                eventDate = [NSDate date];
                eventNumericDay = [[NSCalendar currentCalendar] eee_numericDayForDate:eventDate];
                eventStore.fakeEvent(&event).
                        startDate([NSDate date]).
                        title(@"Appointment").
                        location(@"Halfweg").
                        notes(@"Some notes").
                        allDay(YES).
                        hasAttendees(YES).
                        hasRecurrenceRules(YES).
                        addRelativeAlarm(-15 * 60);
            });

            context(@"which is then buffered", ^{
                __block EEEBufferedEvent *bufferedEvent;

                beforeEach(^{
                    BOOL created = NO;
                    bufferedEvent = [EEEBufferedEvent bufferEvent:event forNumericDay:eventNumericDay created:&created inContext:model.mainContext];
                    [[theValue([model.mainContext save:NULL]) should] beYes];
                    [[theValue(created) should] beYes];
                    [[bufferedEvent.eventIdentifier should] equal:event.eventIdentifier];
                });

                it(@"uniques on event identifier", ^{
                    BOOL created = NO;
                    [EEEBufferedEvent bufferEvent:event forNumericDay:eventNumericDay created:&created inContext:model.mainContext];
                    [[theValue(created) should] beNo];
                    [[theValue(model.mainContext.hasChanges) should] beNo];
                });

                describe(@"buffering attributes", ^{
                    it(@"allDay", ^{[[theValue(bufferedEvent.allDayValue) should] equal:theValue(event.allDay)];});
                    it(@"availability", ^{[[theValue(bufferedEvent.availabilityValue) should] equal:theValue(event.availability)];});
                    it(@"endDate", ^{[[bufferedEvent.endDate should] equal:event.endDate];});
                    it(@"hasAlarms", ^{[[theValue(bufferedEvent.hasAlarmsValue) should] beYes];});
                    it(@"hasAttendees", ^{[[theValue(bufferedEvent.hasAttendeesValue) should] beYes];});
                    it(@"hasNotes", ^{[[theValue(bufferedEvent.hasNotesValue) should] beYes];});
                    it(@"hasRecurrenceRules", ^{[[theValue(bufferedEvent.hasRecurrenceRulesValue) should] beYes];});
                    it(@"location", ^{[[bufferedEvent.location should] equal:event.location];});
                    it(@"notes", ^{[[bufferedEvent.notes should] equal:event.notes];});
                    it(@"startDate", ^{[[bufferedEvent.startDate should] equal:event.startDate];});
                    it(@"titleDate", ^{[[bufferedEvent.title should] equal:event.title];});
                });
            });
        });
    });
SPEC_END
