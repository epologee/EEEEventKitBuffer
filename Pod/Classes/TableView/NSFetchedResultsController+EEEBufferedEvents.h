#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class EEEBufferedEvent;

@interface NSFetchedResultsController (EEEBufferedEvents)

- (NSInteger)eee_numberOfRowsInSection:(NSInteger)section;

- (NSString *)eee_titleForHeaderInSection:(NSInteger)section;

- (EEEBufferedEvent *)eee_bufferedEventAtIndexPath:(NSIndexPath *)indexPath;

@end