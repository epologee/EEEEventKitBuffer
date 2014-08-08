// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to EEEBufferedDay.m instead.

#import "_EEEBufferedDay.h"

const struct EEEBufferedDayAttributes EEEBufferedDayAttributes = {
	.dateGMT = @"dateGMT",
	.numericDay = @"numericDay",
	.title = @"title",
};

const struct EEEBufferedDayRelationships EEEBufferedDayRelationships = {
	.events = @"events",
};

const struct EEEBufferedDayFetchedProperties EEEBufferedDayFetchedProperties = {
};

@implementation EEEBufferedDayID
@end

@implementation _EEEBufferedDay

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Day" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Day";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Day" inManagedObjectContext:moc_];
}

- (EEEBufferedDayID*)objectID {
	return (EEEBufferedDayID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"numericDayValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"numericDay"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic dateGMT;






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





@dynamic title;






@dynamic events;

	
- (NSMutableSet*)eventsSet {
	[self willAccessValueForKey:@"events"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"events"];
  
	[self didAccessValueForKey:@"events"];
	return result;
}
	






@end
