#import <CoreData/CoreData.h>
#import "EEEViewController.h"
#import "NSDate+EEEHelper.h"
#import "NSCalendar+EEEDateCalculations.h"
#import "EEEEventStoreHelperEventWrapper.h"
#import "EEEEventKitBufferModel.h"
#import "EKEventStore+EEEBuffering.h"
#import "EEEBufferedEvent.h"
#import "NSFetchedResultsController+EEEBufferedEvents.h"
#import "EEEBufferedDay.h"

@interface EEEViewController ()

@property(nonatomic, strong) EEEEventKitBufferModel *model;

@end

@implementation EEEViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];

    if (self)
    {
        EEEEventStoreHelper *eventStoreHelper = [[EEEEventStoreHelper alloc] init];
        _model = [[EEEEventKitBufferModel alloc] initWithMainEventStore:eventStoreHelper];

        NSCalendar *cal = [NSCalendar currentCalendar];
        NSDate *startDate = [NSDate eee_dateForYear:2014 month:8 day:1];
        NSDateComponents *runner = [[NSDateComponents alloc] init];
        NSDate *endDate;
        for (int i = 0; i < 10; i++)
        {
            runner.day = i / 2;
            runner.hour = i % 2;

            NSDate *date = [cal dateByAddingComponents:runner toDate:startDate options:0];
            eventStoreHelper.addFakeEvent.
                    startDate(date).
                    title([NSString stringWithFormat:@"Appointment #%li", (long) i]).
                    location(@"Halfweg").
                    notes(@"Some notes").
                    allDay(YES).
                    hasAttendees(YES).
                    hasRecurrenceRules(YES).
                    addRelativeAlarm(-15 * 60);

            endDate = [cal eee_lastSecondOfDate:date];
        }

        eventStoreHelper.addFakeEvent.
                startDate([NSDate eee_dateForYear:2014 month:8 day:2]).
                endDate([NSDate eee_dateForYear:2014 month:8 day:4]).
                title(@"Multi Appointment").
                location(@"Halfweg").
                notes(@"Some notes").
                allDay(YES).
                hasAttendees(YES).
                hasRecurrenceRules(YES).
                addRelativeAlarm(-15 * 60);

        [_model bufferEventsFromStartDate:startDate toEndDate:endDate withinEventCalendars:nil];
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSError *error = nil;
    if ([self.model.bufferedEventsController performFetch:&error])
    {
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.model.bufferedEventsController.sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.model.bufferedEventsController eee_numberOfRowsInSection:section];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.model.bufferedEventsController eee_titleForHeaderInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    EEEBufferedEvent *bufferedEvent = [self.model.bufferedEventsController eee_bufferedEventAtIndexPath:indexPath];
    cell.textLabel.text = bufferedEvent.title;
    return cell;
}

@end
