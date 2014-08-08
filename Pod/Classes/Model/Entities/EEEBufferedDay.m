#import "EEEBufferedDay.h"
#import "NSCalendar+EEEDateFormatting.h"

@interface EEEBufferedDay ()

@end

@implementation EEEBufferedDay

- (void)updateForDate:(NSDate *)date withComponents:(NSDateComponents *)components
{
    self.dateGMT = date;
    self.title = [[components.calendar eee_bufferedDayTitleFormatter] stringFromDate:date];
}

@end
