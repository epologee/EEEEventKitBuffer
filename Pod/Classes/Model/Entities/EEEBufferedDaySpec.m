#import <EventKit/EventKit.h>
#import "EEEEventKitBufferModel.h"
#import "EEEEventStoreHelper.h"

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

        context(@"with several events", ^{
            beforeEach(^{
                eventStore.addFakeEvent.
                        startDate([NSDate date]).
                        title(@"Appointment").
                        location(@"Halfweg").
                        allDay(YES).
                        hasAttendees(YES).
                        hasNotes(YES).
                        hasRecurrenceRules(YES).
                        addRelativeAlarm(-15 * 60);
            });
        });
    });
SPEC_END
