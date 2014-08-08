#import "EEEEventStoreHelper.h"
#import "EEEEventStoreHelperEventWrapper.h"
#import "_EEEBufferedEvent.h"

@interface EEEEventStoreHelper ()

@property(nonatomic, strong) NSMutableSet *fakeEvents;

@end

@implementation EEEEventStoreHelper

- (NSArray *)eventsMatchingPredicate:(NSPredicate *)predicate
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateFormatter *reverseFormatter = [[NSDateFormatter alloc] init];
    reverseFormatter.calendar = cal;
    reverseFormatter.timeZone = cal.timeZone;
    reverseFormatter.dateFormat = [NSDateFormatter dateFormatFromTemplate:@"dMyhm" options:0 locale:[NSLocale currentLocale]];

    NSDate *lowerBounds;
    {
        NSRegularExpression *startRegEx = [NSRegularExpression regularExpressionWithPattern:@"(?<=start:)([^;]+);" options:0 error:NULL];
        NSTextCheckingResult *startResult = [startRegEx firstMatchInString:predicate.predicateFormat
                                                                   options:NSMatchingWithTransparentBounds
                                                                     range:NSMakeRange(0, [predicate.predicateFormat length])];
        NSString *startString = [predicate.predicateFormat substringWithRange:[startResult rangeAtIndex:1]];
        lowerBounds = [reverseFormatter dateFromString:startString];
    }

    NSDate *upperBounds;
    {
        NSRegularExpression *endRegEx = [NSRegularExpression regularExpressionWithPattern:@"(?<=end:)([^;]+);" options:0 error:NULL];
        NSTextCheckingResult *endResult = [endRegEx firstMatchInString:predicate.predicateFormat
                                                               options:NSMatchingWithTransparentBounds
                                                                 range:NSMakeRange(0, [predicate.predicateFormat length])];
        NSString *endString = [predicate.predicateFormat substringWithRange:[endResult rangeAtIndex:1]];
        upperBounds = [reverseFormatter dateFromString:endString];
    }

    NSString *format = [NSString stringWithFormat:@"%@ <= %%@ AND %%@ <= %@", EEEBufferedEventAttributes.startDate, EEEBufferedEventAttributes.endDate];
    NSPredicate *entityPredicate = [NSPredicate predicateWithFormat:format, upperBounds, lowerBounds];
    return [[self.fakeEvents filteredSetUsingPredicate:entityPredicate] allObjects];
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