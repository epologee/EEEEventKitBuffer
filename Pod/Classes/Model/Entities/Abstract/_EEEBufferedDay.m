// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to EEEBufferedDay.m instead.

#import "_EEEBufferedDay.h"

const struct EEEBufferedDayAttributes EEEBufferedDayAttributes = {
	.dateGMT = @"dateGMT",
	.numericDate = @"numericDate",
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
	
	if ([key isEqualToString:@"numericDateValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"numericDate"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic dateGMT;






@dynamic numericDate;



- (int32_t)numericDateValue {
	NSNumber *result = [self numericDate];
	return [result intValue];
}

- (void)setNumericDateValue:(int32_t)value_ {
	[self setNumericDate:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveNumericDateValue {
	NSNumber *result = [self primitiveNumericDate];
	return [result intValue];
}

- (void)setPrimitiveNumericDateValue:(int32_t)value_ {
	[self setPrimitiveNumericDate:[NSNumber numberWithInt:value_]];
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
