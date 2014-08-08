// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to EEEBufferedDay.h instead.

#import <CoreData/CoreData.h>
#import "EEEBaseBufferedManagedObject.h"

extern const struct EEEBufferedDayAttributes {
	__unsafe_unretained NSString *dateGMT;
	__unsafe_unretained NSString *numericDate;
	__unsafe_unretained NSString *title;
} EEEBufferedDayAttributes;

extern const struct EEEBufferedDayRelationships {
	__unsafe_unretained NSString *events;
} EEEBufferedDayRelationships;

extern const struct EEEBufferedDayFetchedProperties {
} EEEBufferedDayFetchedProperties;

@class EEEBufferedEvent;





@interface EEEBufferedDayID : NSManagedObjectID {}
@end

@interface _EEEBufferedDay : EEEBaseBufferedManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (EEEBufferedDayID*)objectID;





@property (nonatomic, strong) NSDate* dateGMT;



//- (BOOL)validateDateGMT:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* numericDate;



@property int32_t numericDateValue;
- (int32_t)numericDateValue;
- (void)setNumericDateValue:(int32_t)value_;

//- (BOOL)validateNumericDate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* title;



//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *events;

- (NSMutableSet*)eventsSet;





@end

@interface _EEEBufferedDay (CoreDataGeneratedAccessors)

- (void)addEvents:(NSSet*)value_;
- (void)removeEvents:(NSSet*)value_;
- (void)addEventsObject:(EEEBufferedEvent*)value_;
- (void)removeEventsObject:(EEEBufferedEvent*)value_;

@end

@interface _EEEBufferedDay (CoreDataGeneratedPrimitiveAccessors)


- (NSDate*)primitiveDateGMT;
- (void)setPrimitiveDateGMT:(NSDate*)value;




- (NSNumber*)primitiveNumericDate;
- (void)setPrimitiveNumericDate:(NSNumber*)value;

- (int32_t)primitiveNumericDateValue;
- (void)setPrimitiveNumericDateValue:(int32_t)value_;




- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;





- (NSMutableSet*)primitiveEvents;
- (void)setPrimitiveEvents:(NSMutableSet*)value;


@end
