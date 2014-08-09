#import "NSFetchedResultsController+EEEBufferedEvents.h"
#import "EEEBufferedEvent.h"
#import "EEEBufferedDay.h"

@implementation NSFetchedResultsController (EEEBufferedEvents)

- (NSInteger)eee_numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = self.sections[(NSUInteger) section];
    return sectionInfo.numberOfObjects;
}

- (NSString *)eee_titleForHeaderInSection:(NSInteger)section
{
    EEEBufferedDay *day = [self eee_bufferedDayForSection:section];
    return day.titleDate;
}

- (EEEBufferedDay *)eee_bufferedDayForSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = self.sections[(NSUInteger) section];
    return [EEEBufferedDay existingDayForNumericDay:[sectionInfo.name integerValue] inContext:self.managedObjectContext];
}

- (EEEBufferedEvent *)eee_bufferedEventAtIndexPath:(NSIndexPath *)indexPath
{
    return [self objectAtIndexPath:indexPath];
}

@end