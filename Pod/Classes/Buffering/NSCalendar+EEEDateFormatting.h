#import <Foundation/Foundation.h>

@interface NSCalendar (EEEDateFormatting)

- (NSDateFormatter *)eee_bufferedDateFormatter;

- (NSDateFormatter *)eee_bufferedDayFormatter;

@end