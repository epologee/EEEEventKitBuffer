// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to EEEBufferedEvent.h instead.

#import <CoreData/CoreData.h>
#import "EEEBufferedMarkerEvent.h"

extern const struct EEEBufferedEventAttributes {
	__unsafe_unretained NSString *allDay;
	__unsafe_unretained NSString *availability;
	__unsafe_unretained NSString *endDate;
	__unsafe_unretained NSString *eventIdentifier;
	__unsafe_unretained NSString *hasAlarms;
	__unsafe_unretained NSString *hasAttendees;
	__unsafe_unretained NSString *hasNotes;
	__unsafe_unretained NSString *hasRecurrenceRules;
	__unsafe_unretained NSString *location;
	__unsafe_unretained NSString *notes;
	__unsafe_unretained NSString *startDate;
	__unsafe_unretained NSString *title;
} EEEBufferedEventAttributes;

extern const struct EEEBufferedEventRelationships {
	__unsafe_unretained NSString *calendar;
} EEEBufferedEventRelationships;

extern const struct EEEBufferedEventFetchedProperties {
} EEEBufferedEventFetchedProperties;

@class EEEBufferedCalendar;














@interface EEEBufferedEventID : NSManagedObjectID {}
@end

@interface _EEEBufferedEvent : EEEBufferedMarkerEvent {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (EEEBufferedEventID*)objectID;





@property (nonatomic, strong) NSNumber* allDay;



@property BOOL allDayValue;
- (BOOL)allDayValue;
- (void)setAllDayValue:(BOOL)value_;

//- (BOOL)validateAllDay:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* availability;



@property int16_t availabilityValue;
- (int16_t)availabilityValue;
- (void)setAvailabilityValue:(int16_t)value_;

//- (BOOL)validateAvailability:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* endDate;



//- (BOOL)validateEndDate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* eventIdentifier;



//- (BOOL)validateEventIdentifier:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* hasAlarms;



@property BOOL hasAlarmsValue;
- (BOOL)hasAlarmsValue;
- (void)setHasAlarmsValue:(BOOL)value_;

//- (BOOL)validateHasAlarms:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* hasAttendees;



@property BOOL hasAttendeesValue;
- (BOOL)hasAttendeesValue;
- (void)setHasAttendeesValue:(BOOL)value_;

//- (BOOL)validateHasAttendees:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* hasNotes;



@property BOOL hasNotesValue;
- (BOOL)hasNotesValue;
- (void)setHasNotesValue:(BOOL)value_;

//- (BOOL)validateHasNotes:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* hasRecurrenceRules;



@property BOOL hasRecurrenceRulesValue;
- (BOOL)hasRecurrenceRulesValue;
- (void)setHasRecurrenceRulesValue:(BOOL)value_;

//- (BOOL)validateHasRecurrenceRules:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* location;



//- (BOOL)validateLocation:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* notes;



//- (BOOL)validateNotes:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* startDate;



//- (BOOL)validateStartDate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* title;



//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) EEEBufferedCalendar *calendar;

//- (BOOL)validateCalendar:(id*)value_ error:(NSError**)error_;





@end

@interface _EEEBufferedEvent (CoreDataGeneratedAccessors)

@end

@interface _EEEBufferedEvent (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveAllDay;
- (void)setPrimitiveAllDay:(NSNumber*)value;

- (BOOL)primitiveAllDayValue;
- (void)setPrimitiveAllDayValue:(BOOL)value_;




- (NSNumber*)primitiveAvailability;
- (void)setPrimitiveAvailability:(NSNumber*)value;

- (int16_t)primitiveAvailabilityValue;
- (void)setPrimitiveAvailabilityValue:(int16_t)value_;




- (NSDate*)primitiveEndDate;
- (void)setPrimitiveEndDate:(NSDate*)value;




- (NSString*)primitiveEventIdentifier;
- (void)setPrimitiveEventIdentifier:(NSString*)value;




- (NSNumber*)primitiveHasAlarms;
- (void)setPrimitiveHasAlarms:(NSNumber*)value;

- (BOOL)primitiveHasAlarmsValue;
- (void)setPrimitiveHasAlarmsValue:(BOOL)value_;




- (NSNumber*)primitiveHasAttendees;
- (void)setPrimitiveHasAttendees:(NSNumber*)value;

- (BOOL)primitiveHasAttendeesValue;
- (void)setPrimitiveHasAttendeesValue:(BOOL)value_;




- (NSNumber*)primitiveHasNotes;
- (void)setPrimitiveHasNotes:(NSNumber*)value;

- (BOOL)primitiveHasNotesValue;
- (void)setPrimitiveHasNotesValue:(BOOL)value_;




- (NSNumber*)primitiveHasRecurrenceRules;
- (void)setPrimitiveHasRecurrenceRules:(NSNumber*)value;

- (BOOL)primitiveHasRecurrenceRulesValue;
- (void)setPrimitiveHasRecurrenceRulesValue:(BOOL)value_;




- (NSString*)primitiveLocation;
- (void)setPrimitiveLocation:(NSString*)value;




- (NSString*)primitiveNotes;
- (void)setPrimitiveNotes:(NSString*)value;




- (NSDate*)primitiveStartDate;
- (void)setPrimitiveStartDate:(NSDate*)value;




- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;





- (EEEBufferedCalendar*)primitiveCalendar;
- (void)setPrimitiveCalendar:(EEEBufferedCalendar*)value;


@end
