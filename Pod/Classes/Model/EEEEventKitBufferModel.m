#import <CoreData/CoreData.h>
#import <EventKit/EventKit.h>
#import "EEEEventKitBufferModel.h"
#import <EEEEventKitBuffer/EEEBufferedEvent.h>
#import <EEEEventKitBuffer/EEEBufferedEvent+NSFetchedResultsController.h>
#import <EEEEventKitBuffer/EKEventStore+EEEBuffering.h>

@interface EEEEventKitBufferModel ()

@property(nonatomic, strong) EKEventStore *mainEventStore;
@property(nonatomic, strong, readwrite) NSFetchedResultsController *bufferedEventsController;
@property(nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property(nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property(nonatomic, strong) NSBundle *modelBundle;

@end

@implementation EEEEventKitBufferModel

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
            [[NSException exceptionWithName:@"EEEEventKitBufferModelException"
                                     reason:@"Could not add store"
                                   userInfo:@{NSUnderlyingErrorKey : error}] raise];
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
    [self.mainEventStore eee_bufferEventsFromStartDate:date
                                             toEndDate:date
                                             calendars:calendars
                                             inContext:self.mainContext];
}

@end