#import "_EEEBufferedDay.h"

@interface EEEBufferedDay : _EEEBufferedDay

+ (instancetype)uniqueForDate:(NSDate *)date calendar:(NSCalendar *)calendar inContext:(NSManagedObjectContext *)ctx;

- (void)updateForDate:(NSDate *)date withComponents:(NSDateComponents *)components calendar:(NSCalendar *)calendar;

@end
