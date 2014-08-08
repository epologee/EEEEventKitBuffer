#import <EventKit/EventKit.h>
#import "EEEEventKitBufferModel.h"
#import "EEEEventStoreHelper.h"
#import "EKEventStore+EEEBuffering.h"
#import "EEEBufferedDay.h"
#import "EEEBufferedEvent.h"

SPEC_BEGIN(EEEBufferedDaySpec)
    describe(@"EEEBufferedDay", ^{
        beforeAll(^{
            expectEventStoreAccess();
        });

        __block EEEEventKitBufferModel *model;
        __block EEEEventStoreHelper *eventStore;

        beforeEach(^{
            eventStore = [[EEEEventStoreHelper alloc] init];
            model = [[EEEEventKitBufferModel alloc] init];
        });

        context(@"with several fake events", ^{
            __block NSDate *now;
            __block NSDate *then;

            beforeEach(^{
                NSCalendar *cal = [NSCalendar currentCalendar];
                now = [NSDate date];
                NSDateComponents *runner = [[NSDateComponents alloc] init];
                for (int i = 0; i < 10; i++)
                {
                    runner.day = i / 2;
                    runner.hour = i % 2;

                    then = [cal dateByAddingComponents:runner toDate:now options:0];
                    [[then shouldNot] beNil];
                    eventStore.addFakeEvent.
                            startDate(then).
                            title([NSString stringWithFormat:@"Appointment #%i", runner.day]).
                            location(@"Halfweg").
                            allDay(YES).
                            hasAttendees(YES).
                            hasNotes(YES).
                            hasRecurrenceRules(YES).
                            addRelativeAlarm(-15 * 60);
                }

                [eventStore eee_bufferEventsFromStartDate:now toEndDate:then calendars:nil inContext:model.mainContext];
            });

            it(@"creates buffered events", ^{
                NSArray *bufferedEvents = [EEEBufferedEvent allObjectsInContext:model.mainContext error:NULL];
                [[bufferedEvents should] haveCountOf:10];
            });

            it(@"creates buffered days", ^{
                NSArray *bufferedDays = [EEEBufferedDay allObjectsInContext:model.mainContext error:NULL];
                [[bufferedDays should] haveCountOf:4];
            });

            it(@"associates buffered days to events", ^{
                NSArray *bufferedEvents = [EEEBufferedEvent allObjectsInContext:model.mainContext error:NULL];
                EEEBufferedEvent *bufferedEvent = [bufferedEvents lastObject];
                [[[bufferedEvent.days anyObject] shouldNot] beNil];
            });
        });
    });
SPEC_END
