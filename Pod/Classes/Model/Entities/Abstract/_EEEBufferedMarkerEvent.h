// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to EEEBufferedMarkerEvent.h instead.

#import <CoreData/CoreData.h>
#import "EEEBaseBufferedManagedObject.h"

extern const struct EEEBufferedMarkerEventAttributes {
	__unsafe_unretained NSString *isMarker;
} EEEBufferedMarkerEventAttributes;

extern const struct EEEBufferedMarkerEventRelationships {
	__unsafe_unretained NSString *day;
} EEEBufferedMarkerEventRelationships;

extern const struct EEEBufferedMarkerEventFetchedProperties {
} EEEBufferedMarkerEventFetchedProperties;

@class EEEBufferedDay;



@interface EEEBufferedMarkerEventID : NSManagedObjectID {}
@end

@interface _EEEBufferedMarkerEvent : EEEBaseBufferedManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (EEEBufferedMarkerEventID*)objectID;





@property (nonatomic, strong) NSNumber* isMarker;



@property BOOL isMarkerValue;
- (BOOL)isMarkerValue;
- (void)setIsMarkerValue:(BOOL)value_;

//- (BOOL)validateIsMarker:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) EEEBufferedDay *day;

//- (BOOL)validateDay:(id*)value_ error:(NSError**)error_;





@end

@interface _EEEBufferedMarkerEvent (CoreDataGeneratedAccessors)

@end

@interface _EEEBufferedMarkerEvent (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveIsMarker;
- (void)setPrimitiveIsMarker:(NSNumber*)value;

- (BOOL)primitiveIsMarkerValue;
- (void)setPrimitiveIsMarkerValue:(BOOL)value_;





- (EEEBufferedDay*)primitiveDay;
- (void)setPrimitiveDay:(EEEBufferedDay*)value;


@end
