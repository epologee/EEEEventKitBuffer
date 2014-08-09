#import <EventKit/EventKit.h>
#import "EEEEventKitBufferModel.h"
#import "EEEEventStoreHelper.h"
#import "EKEventStore+EEEBuffering.h"
#import "EEEBufferedDay.h"
#import "EEEBufferedEvent.h"
#import "NSDate+EEEHelper.h"
#import "NSCalendar+EEEDateCalculations.h"

SPEC_BEGIN(EEEBufferedDaySpec)
    describe(@"EEEBufferedDay", ^{
        beforeAll(^{
//            expectEventStoreAccess();
        });

        __block EEEEventKitBufferModel *model;
        __block EEEEventStoreHelper *eventStore;

        beforeEach(^{
            eventStore = [[EEEEventStoreHelper alloc] init];
            model = [[EEEEventKitBufferModel alloc] init];
        });

        context(@"with several fake events", ^{
            __block NSDate *startDate;
            __block NSDate *endDate;

            beforeEach(^{
                NSCalendar *cal = [NSCalendar currentCalendar];
                startDate = [NSDate eee_dateForYear:2014 month:8 day:1];
                NSDateComponents *runner = [[NSDateComponents alloc] init];
                for (int i = 0; i < 10; i++)
                {
                    runner.day = i / 2;
                    runner.hour = i % 2;

                    NSDate *date = [cal dateByAddingComponents:runner toDate:startDate options:0];
                    eventStore.addFakeEvent.
                            startDate(date).
                            title([NSString stringWithFormat:@"Appointment #%li", (long) runner.day]).
                            location(@"Halfweg").
                            notes(@"Some notes").
                            allDay(YES).
                            hasAttendees(YES).
                            hasRecurrenceRules(YES).
                            addRelativeAlarm(-15 * 60);

                    endDate = [cal eee_lastSecondOfDate:date];
                }

                [eventStore eee_bufferEventsFromStartDate:startDate toEndDate:endDate calendars:nil inContext:model.mainContext];
                [[theValue([model.mainContext save:NULL]) should] beYes];
            });

            it(@"creates buffered events", ^{
                NSArray *bufferedEvents = [EEEBufferedEvent allObjectsInContext:model.mainContext error:NULL];
                [[bufferedEvents should] haveCountOf:10];
            });

            it(@"creates buffered days", ^{
                NSArray *bufferedDays = [EEEBufferedDay allObjectsInContext:model.mainContext error:NULL];
                [[bufferedDays should] haveCountOf:5];
            });

            context(@"associating buffered days with events", ^{
                __block EEEBufferedEvent *bufferedEvent;
                __block EEEBufferedDay *bufferedDay;

                beforeEach(^{
                    NSArray *bufferedEvents = [EEEBufferedEvent allObjectsInContext:model.mainContext error:NULL];
                    bufferedEvents = [bufferedEvents sortedArrayUsingComparator:^NSComparisonResult(EEEBufferedEvent *a, EEEBufferedEvent *b) {
                        return [a.startDate compare:b.startDate];
                    }];
                    bufferedEvent = bufferedEvents[0];
                    bufferedDay = bufferedEvent.day;
                });

                it(@"sets a numeric date, for sorting", ^{
                    [[bufferedDay.numericDay should] equal:@20140801];
                });

                it(@"sets titleDate, to display", ^{
                    [[bufferedDay.titleDate should] equal:@"August 1, 2014"];
                });

                it(@"sets titleDay, to display", ^{
                    [[bufferedDay.titleDay should] equal:@"Friday"];
                });
            });
        });
    });
SPEC_END
