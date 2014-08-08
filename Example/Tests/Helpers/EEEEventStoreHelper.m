#import "EEEEventStoreHelper.h"
#import "EEEEventStoreHelperEventWrapper.h"

@interface EEEEventStoreHelper ()

@property(nonatomic, strong) NSMutableSet *fakeEvents;

@end

@implementation EEEEventStoreHelper

- (NSArray *)eventsMatchingPredicate:(NSPredicate *)predicate
{
    return [self.fakeEvents allObjects];
}

- (NSMutableSet *)fakeEvents
{
    if (!_fakeEvents)
    {
        self.fakeEvents = [NSMutableSet set];
    }

    return _fakeEvents;
}

- (id <EEEBlockChainEvent> (^)(EKEvent **))fakeEvent
{
    return ^id <EEEBlockChainEvent>(EKEvent **eventPtr) {
        EKEvent *event = [EKEvent eventWithEventStore:self];
        [event stub:@selector(eventIdentifier) andReturn:[self createGUID]];
        event.calendar = self.defaultCalendarForNewEvents;
        [self.fakeEvents addObject:event];

        if (eventPtr) *eventPtr = event;

        return [[EEEEventStoreHelperEventWrapper alloc] initWithEvent:event];
    };
}

- (id <EEEBlockChainEvent>)addFakeEvent
{
    return self.fakeEvent(NULL);
}

- (NSString *)createGUID
{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return (__bridge_transfer NSString *) string;
}

@end