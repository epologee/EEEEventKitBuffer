#import "_EEEBufferedEvent.h"

@class EKEvent;

@interface EEEBufferedEvent : _EEEBufferedEvent

+ (instancetype)bufferEvent:(EKEvent *)event created:(BOOL *)created inContext:(NSManagedObjectContext *)ctx;

- (void)updateEvent:(EKEvent *)event;

@end
