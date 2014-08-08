#import "NSDate+EEEHelper.h"

@implementation NSDate (EEEHelper)

+ (instancetype)eee_dateForYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    NSCalendar *calendar = [NSCalendar currentCalendar];

    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.timeZone = calendar.timeZone;
    components.year = year;
    components.month = month;
    components.day = day;

    return [calendar dateFromComponents:components];
}

@end