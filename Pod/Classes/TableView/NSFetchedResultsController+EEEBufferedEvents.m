#import "NSFetchedResultsController+EEEBufferedEvents.h"
#import "EEEBufferedEvent.h"
#import "EEEBufferedDay.h"

@implementation NSFetchedResultsController (EEEBufferedEvents)

+ (instancetype)eee_bufferedEventsControllerInContext:(NSManagedObjectContext *)ctx
{
    NSFetchRequest *request = [EEEBufferedMarkerEvent fetchRequest];

    request.sortDescriptors = @[
            [NSSortDescriptor sortDescriptorWithKey:EEEBufferedMarkerEventAttributes.numericDay ascending:YES],
            [NSSortDescriptor sortDescriptorWithKey:EEEBufferedMarkerEventAttributes.isMarker ascending:NO],
            [NSSortDescriptor sortDescriptorWithKey:EEEBufferedEventAttributes.allDay ascending:NO],
            [NSSortDescriptor sortDescriptorWithKey:EEEBufferedEventAttributes.startDate ascending:YES]
    ];

    NSString *sectionNameKeyPath = [NSString stringWithFormat:@"%@.%@", EEEBufferedMarkerEventRelationships.day, EEEBufferedDayAttributes.numericDay];
    NSFetchedResultsController *controller = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                                 managedObjectContext:ctx
                                                                                   sectionNameKeyPath:sectionNameKeyPath
                                                                                            cacheName:nil];
    return controller;
}

- (NSInteger)eee_numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = self.sections[(NSUInteger) section];
    return sectionInfo.numberOfObjects;
}

- (NSString *)eee_titleForHeaderInSection:(NSInteger)section
{
    EEEBufferedDay *day = [self eee_bufferedDayForSection:section];
    return [NSString stringWithFormat:@"%@   %@", [day.titleDay uppercaseString], day.titleDate];
}

- (EEEBufferedDay *)eee_bufferedDayForSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = self.sections[(NSUInteger) section];
    return [EEEBufferedDay existingDayForNumericDay:[sectionInfo.name integerValue] inContext:self.managedObjectContext];
}

- (EEEBufferedEvent *)eee_bufferedEventAtIndexPath:(NSIndexPath *)indexPath
{
    EEEBufferedMarkerEvent *bufferedEvent = [self objectAtIndexPath:indexPath];
    if ([bufferedEvent isKindOfClass:[EEEBufferedEvent class]])
    {
        return (EEEBufferedEvent *) bufferedEvent;
    }

    return nil;
}

@end