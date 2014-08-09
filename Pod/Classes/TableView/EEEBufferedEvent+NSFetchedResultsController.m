#import "EEEBufferedEvent+NSFetchedResultsController.h"
#import "EEEBufferedDay.h"

@implementation EEEBufferedEvent (NSFetchedResultsController)

+ (NSFetchedResultsController *)fetchedResultsControllerInContext:(NSManagedObjectContext *)ctx
{
    NSFetchRequest *request = [EEEBufferedEvent fetchRequest];
    request.sortDescriptors = @[
            [NSSortDescriptor sortDescriptorWithKey:EEEBufferedEventAttributes.numericDay ascending:YES],
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

@end