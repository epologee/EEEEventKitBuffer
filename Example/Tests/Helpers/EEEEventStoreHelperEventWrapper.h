#import <Foundation/Foundation.h>
#import <EventKit/EventKit.h>
#import "EEEEventStoreHelper.h"

@interface EEEEventStoreHelperEventWrapper : NSObject <EEEBlockChainEvent>

- (id)initWithEvent:(EKEvent *)event;

@end