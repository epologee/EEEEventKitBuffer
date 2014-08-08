#import <Foundation/Foundation.h>
#import "EEEBufferedEvent.h"

@interface EEEBufferedEvent (NSFetchedResultsController)
+ (NSFetchedResultsController *)fetchedResultsControllerInContext:(NSManagedObjectContext *)ctx;
@end