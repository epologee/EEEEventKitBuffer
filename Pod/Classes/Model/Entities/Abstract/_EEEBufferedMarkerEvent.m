// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to EEEBufferedMarkerEvent.m instead.

#import "_EEEBufferedMarkerEvent.h"

const struct EEEBufferedMarkerEventAttributes EEEBufferedMarkerEventAttributes = {
	.isMarker = @"isMarker",
};

const struct EEEBufferedMarkerEventRelationships EEEBufferedMarkerEventRelationships = {
	.day = @"day",
};

const struct EEEBufferedMarkerEventFetchedProperties EEEBufferedMarkerEventFetchedProperties = {
};

@implementation EEEBufferedMarkerEventID
@end

@implementation _EEEBufferedMarkerEvent

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"MarkerEvent" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"MarkerEvent";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"MarkerEvent" inManagedObjectContext:moc_];
}

- (EEEBufferedMarkerEventID*)objectID {
	return (EEEBufferedMarkerEventID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"isMarkerValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"isMarker"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic isMarker;



- (BOOL)isMarkerValue {
	NSNumber *result = [self isMarker];
	return [result boolValue];
}

- (void)setIsMarkerValue:(BOOL)value_ {
	[self setIsMarker:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveIsMarkerValue {
	NSNumber *result = [self primitiveIsMarker];
	return [result boolValue];
}

- (void)setPrimitiveIsMarkerValue:(BOOL)value_ {
	[self setPrimitiveIsMarker:[NSNumber numberWithBool:value_]];
}





@dynamic day;

	






@end
