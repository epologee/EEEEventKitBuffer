#import <Foundation/Foundation.h>

@interface NSCalendar (EEEDateCalculations)

- (void)eee_enumerateDaysFromStartDate:(NSDate *)startDate
                             toEndDate:(NSDate *)endDate
                             withBlock:(void (^)(NSDate *date, NSUInteger idx, BOOL *stop))enumerationBlock;

- (BOOL)eee_date:(NSDate *)date isEqualToOtherDate:(NSDate *)otherDate forUnits:(NSCalendarUnit)units;

- (NSInteger)eee_numericDayForDate:(NSDate *)date;

- (NSDate *)eee_dateForNumericDay:(NSInteger)numericDay;

- (BOOL)eee_date:(NSDate *)date isOnSameDayAs:(NSDate *)otherDate;

- (NSDate *)eee_firstSecondOfDate:(NSDate *)date;

- (NSDate *)eee_lastSecondOfDate:(NSDate *)date;

@end