#import "_EEEBufferedMarkerEvent.h"

@interface EEEBufferedMarkerEvent : _EEEBufferedMarkerEvent
+ (instancetype)uniqueMarkerEventForNumericDay:(NSInteger)numericDay inContext:(NSManagedObjectContext *)ctx;
@end
