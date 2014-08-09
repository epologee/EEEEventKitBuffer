#import <Foundation/Foundation.h>

@class NSFetchedResultsController;
@class NSManagedObjectContext;
@class EKEventStore;

@interface EEEEventKitBufferModel : NSObject

@property(nonatomic, strong) NSManagedObjectContext *mainContext;

@property(nonatomic, strong, readonly) NSFetchedResultsController *bufferedEventsController;

@property(nonatomic, strong, readonly) EKEventStore *mainEventStore;

- (instancetype)initWithMainEventStore:(EKEventStore *)mainEventStore;

- (NSManagedObjectContext *)newPrivateContext;

- (void)bufferEventsFromStartDate:(NSDate *)startDate toEndDate:(NSDate *)endDate withinEventCalendars:(NSArray *)calendars;

- (void)bufferEventsForDate:(NSDate *)date withinEventCalendars:(NSArray *)calendars;

- (void)prepareDaysFromStartDate:(NSDate *)startDate toEndDate:(NSDate *)endDate;

@end