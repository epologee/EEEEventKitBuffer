// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to EEEBufferedCalendar.m instead.

#import "_EEEBufferedCalendar.h"

const struct EEEBufferedCalendarAttributes EEEBufferedCalendarAttributes = {
	.calendarIdentifier = @"calendarIdentifier",
	.calendarType = @"calendarType",
	.colorRGB = @"colorRGB",
	.title = @"title",
};

const struct EEEBufferedCalendarRelationships EEEBufferedCalendarRelationships = {
	.events = @"events",
};

const struct EEEBufferedCalendarFetchedProperties EEEBufferedCalendarFetchedProperties = {
};

@implementation EEEBufferedCalendarID
@end

@implementation _EEEBufferedCalendar

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Calendar" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Calendar";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Calendar" inManagedObjectContext:moc_];
}

- (EEEBufferedCalendarID*)objectID {
	return (EEEBufferedCalendarID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"calendarTypeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"calendarType"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"colorRGBValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"colorRGB"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic calendarIdentifier;






@dynamic calendarType;



- (int16_t)calendarTypeValue {
	NSNumber *result = [self calendarType];
	return [result shortValue];
}

- (void)setCalendarTypeValue:(int16_t)value_ {
	[self setCalendarType:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveCalendarTypeValue {
	NSNumber *result = [self primitiveCalendarType];
	return [result shortValue];
}

- (void)setPrimitiveCalendarTypeValue:(int16_t)value_ {
	[self setPrimitiveCalendarType:[NSNumber numberWithShort:value_]];
}





@dynamic colorRGB;



- (int32_t)colorRGBValue {
	NSNumber *result = [self colorRGB];
	return [result intValue];
}

- (void)setColorRGBValue:(int32_t)value_ {
	[self setColorRGB:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveColorRGBValue {
	NSNumber *result = [self primitiveColorRGB];
	return [result intValue];
}

- (void)setPrimitiveColorRGBValue:(int32_t)value_ {
	[self setPrimitiveColorRGB:[NSNumber numberWithInt:value_]];
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
