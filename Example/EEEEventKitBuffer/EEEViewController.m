#import <CoreData/CoreData.h>
#import "EEEViewController.h"
#import "NSDate+EEEHelper.h"
#import "NSCalendar+EEEDateCalculations.h"
#import "EEEEventStoreHelperEventWrapper.h"
#import "EEEEventKitBufferModel.h"
#import "EKEventStore+EEEBuffering.h"
#import "EEEBufferedEvent.h"
#import "EEEBufferedEvent+NSFetchedResultsController.h"
#import "NSFetchedResultsController+EEEBufferedEvents.h"

@interface EEEViewController ()

@property(nonatomic, strong) EEEEventStoreHelper *eventStore;
@property(nonatomic, strong) EEEEventKitBufferModel *model;
@property(nonatomic, strong) NSFetchedResultsController *bufferedEventsController;
@end

@implementation EEEViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];

    if (self)
    {
        _eventStore = [[EEEEventStoreHelper alloc] init];
        _model = [[EEEEventKitBufferModel alloc] init];

        NSCalendar *cal = [NSCalendar currentCalendar];
        NSDate *startDate = [NSDate eee_dateForYear:2014 month:8 day:1];
        NSDateComponents *runner = [[NSDateComponents alloc] init];
        NSDate *endDate;
        for (int i = 0; i < 10; i++)
        {
            runner.day = i / 2;
            runner.hour = i % 2;

            NSDate *date = [cal dateByAddingComponents:runner toDate:startDate options:0];
            _eventStore.addFakeEvent.
                    startDate(date).
                    title([NSString stringWithFormat:@"Appointment #%li", (long) i]).
                    location(@"Halfweg").
                    allDay(YES).
                    hasAttendees(YES).
                    hasNotes(YES).
                    hasRecurrenceRules(YES).
                    addRelativeAlarm(-15 * 60);

            endDate = [cal eee_lastSecondOfDate:date];
        }

        _eventStore.addFakeEvent.
                startDate([NSDate eee_dateForYear:2014 month:8 day:2]).
                endDate([NSDate eee_dateForYear:2014 month:8 day:4]).
                title(@"Multi Appointment").
                location(@"Halfweg").
                allDay(YES).
                hasAttendees(YES).
                hasNotes(YES).
                hasRecurrenceRules(YES).
                addRelativeAlarm(-15 * 60);

        [_eventStore eee_bufferEventsFromStartDate:startDate toEndDate:endDate calendars:nil inContext:_model.mainContext];
        [_model.mainContext save:NULL];
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.bufferedEventsController = [EEEBufferedEvent fetchedResultsControllerInContext:self.model.mainContext];

    NSError *error = nil;
    if ([self.bufferedEventsController performFetch:&error])
    {
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.bufferedEventsController.sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.bufferedEventsController eee_numberOfRowsInSection:section];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.bufferedEventsController eee_titleForHeaderInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    EEEBufferedEvent *bufferedEvent = [self.bufferedEventsController eee_bufferedEventAtIndexPath:indexPath];
    cell.textLabel.text = bufferedEvent.title;
    return cell;
}

@end
