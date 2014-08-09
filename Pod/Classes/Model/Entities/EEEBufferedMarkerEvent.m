#import "EEEBufferedMarkerEvent.h"

@interface EEEBufferedMarkerEvent ()

@end

@implementation EEEBufferedMarkerEvent

+ (instancetype)uniqueMarkerEventForNumericDay:(NSInteger)numericDay inContext:(NSManagedObjectContext *)ctx
{
    return [self uniqueEntityWithKeyedValues:@{
            EEEBufferedMarkerEventAttributes.isMarker : @YES,
            EEEBufferedMarkerEventAttributes.numericDay : @(numericDay)
    }                                created:NULL inContext:ctx];
}

@end
