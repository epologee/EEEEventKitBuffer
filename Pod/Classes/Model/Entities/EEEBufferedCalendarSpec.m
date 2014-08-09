#import <UIKit/UIKit.h>
#import "EEEEventKitBufferModel.h"
#import "EEEEventStoreHelper.h"
#import "NSCalendar+EEEDateCalculations.h"
#import "EEEBufferedEvent.h"
#import "EEEBufferedCalendar.h"

SPEC_BEGIN(EEEBufferedCalendarSpec)

    describe(@"EEEBufferedCalendar", ^{
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
                eventStore.defaultCalendarForNewEvents.CGColor = [UIColor redColor].CGColor;
                eventStore.defaultCalendarForNewEvents.title = @"Calendar Title";
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

                it(@"is associated to a buffered calendar", ^{
                    [[bufferedEvent.calendar should] beKindOfClass:[EEEBufferedCalendar class]];
                });

                describe(@"calendar attributes", ^{
                    it(@"identifier", ^{[[bufferedEvent.calendar.calendarIdentifier should] equal:eventStore.defaultCalendarForNewEvents.calendarIdentifier];});
                    it(@"titleDate", ^{[[bufferedEvent.calendar.title should] equal:@"Calendar Title"];});
                    it(@"color", ^{[[theValue(bufferedEvent.calendar.colorRGBValue) should] equal:theValue(0xFF0000)];});
                    it(@"type", ^{[[theValue(bufferedEvent.calendar.calendarTypeValue) should] equal:theValue(EKCalendarTypeLocal)];});
                });
            });
        });
    });
SPEC_END
