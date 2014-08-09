// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to EEEBufferedCalendar.h instead.

#import <CoreData/CoreData.h>
#import "EEEBaseBufferedManagedObject.h"

extern const struct EEEBufferedCalendarAttributes {
	__unsafe_unretained NSString *calendarIdentifier;
	__unsafe_unretained NSString *calendarType;
	__unsafe_unretained NSString *colorRGB;
	__unsafe_unretained NSString *title;
} EEEBufferedCalendarAttributes;

extern const struct EEEBufferedCalendarRelationships {
	__unsafe_unretained NSString *events;
} EEEBufferedCalendarRelationships;

extern const struct EEEBufferedCalendarFetchedProperties {
} EEEBufferedCalendarFetchedProperties;

@class EEEBufferedEvent;






@interface EEEBufferedCalendarID : NSManagedObjectID {}
@end

@interface _EEEBufferedCalendar : EEEBaseBufferedManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (EEEBufferedCalendarID*)objectID;





@property (nonatomic, strong) NSString* calendarIdentifier;



//- (BOOL)validateCalendarIdentifier:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* calendarType;



@property int16_t calendarTypeValue;
- (int16_t)calendarTypeValue;
- (void)setCalendarTypeValue:(int16_t)value_;

//- (BOOL)validateCalendarType:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* colorRGB;



@property int32_t colorRGBValue;
- (int32_t)colorRGBValue;
- (void)setColorRGBValue:(int32_t)value_;

//- (BOOL)validateColorRGB:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* title;



//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *events;

- (NSMutableSet*)eventsSet;





@end

@interface _EEEBufferedCalendar (CoreDataGeneratedAccessors)

- (void)addEvents:(NSSet*)value_;
- (void)removeEvents:(NSSet*)value_;
- (void)addEventsObject:(EEEBufferedEvent*)value_;
- (void)removeEventsObject:(EEEBufferedEvent*)value_;

@end

@interface _EEEBufferedCalendar (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveCalendarIdentifier;
- (void)setPrimitiveCalendarIdentifier:(NSString*)value;




- (NSNumber*)primitiveCalendarType;
- (void)setPrimitiveCalendarType:(NSNumber*)value;

- (int16_t)primitiveCalendarTypeValue;
- (void)setPrimitiveCalendarTypeValue:(int16_t)value_;




- (NSNumber*)primitiveColorRGB;
- (void)setPrimitiveColorRGB:(NSNumber*)value;

- (int32_t)primitiveColorRGBValue;
- (void)setPrimitiveColorRGBValue:(int32_t)value_;




- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;





- (NSMutableSet*)primitiveEvents;
- (void)setPrimitiveEvents:(NSMutableSet*)value;


@end
