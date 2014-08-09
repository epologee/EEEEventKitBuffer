// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to EEEBufferedMarkerEvent.m instead.

#import "_EEEBufferedMarkerEvent.h"

const struct EEEBufferedMarkerEventAttributes EEEBufferedMarkerEventAttributes = {
	.isMarker = @"isMarker",
	.numericDay = @"numericDay",
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
	if ([key isEqualToString:@"numericDayValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"numericDay"];
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





@dynamic numericDay;



- (int32_t)numericDayValue {
	NSNumber *result = [self numericDay];
	return [result intValue];
}

- (void)setNumericDayValue:(int32_t)value_ {
	[self setNumericDay:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveNumericDayValue {
	NSNumber *result = [self primitiveNumericDay];
	return [result intValue];
}

- (void)setPrimitiveNumericDayValue:(int32_t)value_ {
	[self setPrimitiveNumericDay:[NSNumber numberWithInt:value_]];
}





@dynamic day;

	






@end
