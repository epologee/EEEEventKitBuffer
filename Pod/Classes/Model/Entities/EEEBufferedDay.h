#import "_EEEBufferedDay.h"

@interface EEEBufferedDay : _EEEBufferedDay

+ (instancetype)uniqueForDate:(NSDate *)date calendar:(NSCalendar *)calendar inContext:(NSManagedObjectContext *)ctx;

+ (instancetype)existingDayForNumericDay:(NSInteger)numericDay inContext:(NSManagedObjectContext *)ctx;

- (void)updateForDate:(NSDate *)date calendar:(NSCalendar *)calendar;

@end
