#import <CoreData/CoreData.h>
#import <EventKit/EventKit.h>
#import "EEEEventKitBufferModel.h"
#import <EEEEventKitBuffer/EEEBufferedEvent.h>
#import <EEEEventKitBuffer/EEEBufferedEvent+NSFetchedResultsController.h>
#import <EEEEventKitBuffer/EKEventStore+EEEBuffering.h>
#import <EEEEventKitBuffer/EEEBufferedDay.h>

@interface EEEEventKitBufferModel ()

@property(nonatomic, strong) EKEventStore *mainEventStore;
@property(nonatomic, strong, readwrite) NSFetchedResultsController *bufferedEventsController;
@property(nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property(nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property(nonatomic, strong) NSBundle *modelBundle;

@end

@implementation EEEEventKitBufferModel

+ (dispatch_queue_t)bufferQueue
{
    static dispatch_queue_t bufferQueue;
    static dispatch_once_t bufferQueueCreation;
    dispatch_once(&bufferQueueCreation, ^{
        bufferQueue = dispatch_queue_create("com.epologee.eventkitbuffer.queue", DISPATCH_QUEUE_SERIAL);
    });
    return bufferQueue;
}

+ (EKEventStore *)bufferEventStore
{
    static dispatch_once_t eventStoreCreation;
    static EKEventStore *bufferEventStore;
    dispatch_once(&eventStoreCreation, ^{
        bufferEventStore = [[EKEventStore alloc] init];
    });
    return bufferEventStore;
}

- (instancetype)initWithMainEventStore:(EKEventStore *)mainEventStore
{
    self = [super init];

    if (self)
    {
        _mainEventStore = mainEventStore;
    }

    return self;
}

- (NSFetchedResultsController *)bufferedEventsController
{
    if (!_bufferedEventsController)
    {
        self.bufferedEventsController = [EEEBufferedEvent fetchedResultsControllerInContext:self.mainContext];
    }

    return _bufferedEventsController;
}

- (NSManagedObjectContext *)mainContext
{
    if (!_mainContext)
    {
        NSParameterAssert([NSThread isMainThread]);
        self.mainContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        _mainContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
        _mainContext.undoManager = nil;
    }

    return _mainContext;
}

- (NSManagedObjectContext *)newPrivateContext
{
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy;
    context.undoManager = nil;
    context.parentContext = self.mainContext;
    return context;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (!_persistentStoreCoordinator)
    {
        NSParameterAssert([NSThread isMainThread]);
        self.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
        NSError *error = nil;
        NSPersistentStore *store = [_persistentStoreCoordinator addPersistentStoreWithType:NSInMemoryStoreType
                                                                             configuration:nil
                                                                                       URL:nil
                                                                                   options:nil
                                                                                     error:&error];
        if (!store)
        {
            [NSException raise:@"EEEEventKitBufferModelException" format:@"Could not add store: %@", error];
        }
    }

    return _persistentStoreCoordinator;
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (!_managedObjectModel)
    {
        self.managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:@[self.modelBundle]];
    }

    return _managedObjectModel;
}

- (NSBundle *)modelBundle
{
    if (!_modelBundle)
    {
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"EEEventKitBufferModel" withExtension:@"bundle"];
        self.modelBundle = [NSBundle bundleWithURL:url];
    }

    return _modelBundle;
}

- (void)bufferEventsForDate:(NSDate *)date withinCalendars:(NSArray *)calendars
{
    dispatch_async([[self class] bufferQueue], ^{
        NSManagedObjectContext *ctx = [self newPrivateContext];
        [[[self class] bufferEventStore] eee_bufferEventsFromStartDate:date
                                                             toEndDate:date
                                                             calendars:calendars
                                                             inContext:ctx];
        NSError *saveError = nil;
        if ([ctx save:&saveError])
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"Buffering complete");
            });
        }
        else
        {
            [NSException raise:@"EEEEventKitBufferModelException" format:@"Could not save context: %@", saveError];
        }
    });
}

- (void)prepareDaysFromStartDate:(NSDate *)startDate toEndDate:(NSDate *)endDate
{
    NSCalendar *cal = [NSCalendar currentCalendar];

    NSDateComponents *delta = [cal components:NSCalendarUnitDay
                                     fromDate:startDate
                                       toDate:endDate
                                      options:0];

    NSDateComponents *startComponents = [cal components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:startDate];
    NSDateComponents *runnerComponents = [startComponents copy];

    for (NSInteger d = 0; d <= delta.day; d++)
    {
        runnerComponents.day = startComponents.day + d;
        NSDate *date = [cal dateFromComponents:runnerComponents];
        [EEEBufferedDay uniqueForDate:date calendar:cal inContext:self.mainContext];
    }
}
@end