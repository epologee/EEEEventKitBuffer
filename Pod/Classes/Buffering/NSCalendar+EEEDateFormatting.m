#import "NSCalendar+EEEDateFormatting.h"

@implementation NSCalendar (EEEDateFormatting)

- (NSDateFormatter *)eee_bufferedDayTitleFormatter
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [NSLocale autoupdatingCurrentLocale];
    formatter.timeZone = self.timeZone;
    formatter.dateFormat = [NSDateFormatter dateFormatFromTemplate:@"yyyydMMMM" options:0 locale:formatter.locale];
    return formatter;
}

@end