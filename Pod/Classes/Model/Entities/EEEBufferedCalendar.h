#import "_EEEBufferedCalendar.h"

@class EKCalendar;

@interface EEEBufferedCalendar : _EEEBufferedCalendar

+ (instancetype)bufferCalendar:(EKCalendar *)calendar created:(BOOL *)created inContext:(NSManagedObjectContext *)ctx;

- (void)updateCalendar:(EKCalendar *)calendar;

@end
