#import "NSFetchedResultsController+EEEBufferedEvents.h"
#import "EEEBufferedEvent.h"

@implementation NSFetchedResultsController (EEEBufferedEvents)

- (NSInteger)eee_numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = self.sections[(NSUInteger) section];
    return sectionInfo.numberOfObjects;
}

- (NSString *)eee_titleForHeaderInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = self.sections[(NSUInteger) section];
    return sectionInfo.name;
}

- (EEEBufferedEvent *)eee_bufferedEventAtIndexPath:(NSIndexPath *)indexPath
{
    return [self objectAtIndexPath:indexPath];
}

@end