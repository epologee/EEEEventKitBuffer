// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to EEEBufferedDay.h instead.

#import <CoreData/CoreData.h>
#import "EEEBaseBufferedManagedObject.h"

extern const struct EEEBufferedDayAttributes {
	__unsafe_unretained NSString *dateGMT;
	__unsafe_unretained NSString *numericDay;
	__unsafe_unretained NSString *titleDate;
	__unsafe_unretained NSString *titleDay;
} EEEBufferedDayAttributes;

extern const struct EEEBufferedDayRelationships {
	__unsafe_unretained NSString *events;
} EEEBufferedDayRelationships;

extern const struct EEEBufferedDayFetchedProperties {
} EEEBufferedDayFetchedProperties;

@class EEEBufferedMarkerEvent;






@interface EEEBufferedDayID : NSManagedObjectID {}
@end

@interface _EEEBufferedDay : EEEBaseBufferedManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (EEEBufferedDayID*)objectID;





@property (nonatomic, strong) NSDate* dateGMT;



//- (BOOL)validateDateGMT:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* numericDay;



@property int32_t numericDayValue;
- (int32_t)numericDayValue;
- (void)setNumericDayValue:(int32_t)value_;

//- (BOOL)validateNumericDay:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* titleDate;



//- (BOOL)validateTitleDate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* titleDay;



//- (BOOL)validateTitleDay:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *events;

- (NSMutableSet*)eventsSet;





@end

@interface _EEEBufferedDay (CoreDataGeneratedAccessors)

- (void)addEvents:(NSSet*)value_;
- (void)removeEvents:(NSSet*)value_;
- (void)addEventsObject:(EEEBufferedMarkerEvent*)value_;
- (void)removeEventsObject:(EEEBufferedMarkerEvent*)value_;

@end

@interface _EEEBufferedDay (CoreDataGeneratedPrimitiveAccessors)


- (NSDate*)primitiveDateGMT;
- (void)setPrimitiveDateGMT:(NSDate*)value;




- (NSNumber*)primitiveNumericDay;
- (void)setPrimitiveNumericDay:(NSNumber*)value;

- (int32_t)primitiveNumericDayValue;
- (void)setPrimitiveNumericDayValue:(int32_t)value_;




- (NSString*)primitiveTitleDate;
- (void)setPrimitiveTitleDate:(NSString*)value;




- (NSString*)primitiveTitleDay;
- (void)setPrimitiveTitleDay:(NSString*)value;





- (NSMutableSet*)primitiveEvents;
- (void)setPrimitiveEvents:(NSMutableSet*)value;


@end
