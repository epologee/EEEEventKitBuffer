#import <Foundation/Foundation.h>

@interface NSCalendar (EEEDateCalculations)

- (BOOL)eee_date:(NSDate *)date isEqualToOtherDate:(NSDate *)otherDate forUnits:(NSCalendarUnit)units;

- (BOOL)eee_date:(NSDate *)date isOnSameDayAs:(NSDate *)otherDate;

- (NSDate *)eee_firstSecondOfDate:(NSDate *)date;

- (NSDate *)eee_lastSecondOfDate:(NSDate *)date;

@end