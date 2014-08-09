#import <Foundation/Foundation.h>

@class NSFetchedResultsController;
@class NSManagedObjectContext;
@class EKEventStore;

@interface EEEEventKitBufferModel : NSObject

@property(nonatomic, strong) NSManagedObjectContext *mainContext;

@property(nonatomic, strong, readonly) NSFetchedResultsController *bufferedEventsController;

- (instancetype)initWithMainEventStore:(EKEventStore *)mainEventStore;

- (NSManagedObjectContext *)newPrivateContext;

- (void)bufferEventsForDate:(NSDate *)date withinCalendars:(NSArray *)calendars;

- (void)prepareDaysFromStartDate:(NSDate *)startDate toEndDate:(NSDate *)endDate;
@end