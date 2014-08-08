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
                for (runner.day = 0; runner.day < 10; runner.day++)
                {
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
            });

            it(@"creates buffered events", ^{
                NSPredicate *predicate = [eventStore predicateForEventsWithStartDate:now endDate:then calendars:nil];
                [eventStore eee_bufferEventsMatchingPredicate:predicate inContext:model.mainContext];

                NSError *error = nil;
                NSArray *bufferedEvents = [EEEBufferedEvent allObjectsInContext:model.mainContext error:&error];
                [[bufferedEvents should] haveCountOf:10];
            });
        });
    });
SPEC_END
