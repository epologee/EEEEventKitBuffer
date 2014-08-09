#import <EventKit/EventKit.h>
#import "EEEBufferedCalendar.h"

@interface EEEBufferedCalendar ()

@end

@implementation EEEBufferedCalendar

+ (instancetype)bufferCalendar:(EKCalendar *)calendar created:(BOOL *)created inContext:(NSManagedObjectContext *)ctx
{
    EEEBufferedCalendar *bufferedCalendar = [self uniqueEntityWithValue:calendar.calendarIdentifier
                                                                 forKey:EEEBufferedCalendarAttributes.calendarIdentifier
                                                                created:created
                                                              inContext:ctx];
    if (*created)
    {
        [bufferedCalendar updateCalendar:calendar];
    }

    return bufferedCalendar;
}

- (void)updateCalendar:(EKCalendar *)calendar
{
    if (![self.title isEqualToString:calendar.title])
    {
        self.title = calendar.title;
    }

    if (self.calendarTypeValue != calendar.type)
    {
        self.calendarTypeValue = calendar.type;
    }

    CGFloat r = 0;
    CGFloat g = 0;
    CGFloat b = 0;
    CGFloat a = 0;

    const CGFloat *components = CGColorGetComponents(calendar.CGColor);
    if (CGColorGetNumberOfComponents(calendar.CGColor) >= 4)
    {
        r = components[0];
        g = components[1];
        b = components[2];
        a = components[3];
    }
    else
    {
        r = g = b = components[0];
        a = components[1];
    }

    int32_t rgb = 0;
    rgb += ((int32_t) (r * 0xFF) & 0xFF) << 16;
    rgb += ((int32_t) (g * 0xFF) & 0xFF) << 8;
    rgb += ((int32_t) (b * 0xFF) & 0xFF);

    if (self.colorRGBValue != rgb)
    {
        self.colorRGBValue = rgb;
    }
}

@end
