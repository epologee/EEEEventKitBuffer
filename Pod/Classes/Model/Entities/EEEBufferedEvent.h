#import "_EEEBufferedEvent.h"

@class EKEvent;

@interface EEEBufferedEvent : _EEEBufferedEvent

+ (instancetype)bufferEvent:(EKEvent *)event forNumericDay:(NSInteger)numericDay created:(BOOL *)created inContext:(NSManagedObjectContext *)ctx;

- (void)updateEvent:(EKEvent *)event;

@end
