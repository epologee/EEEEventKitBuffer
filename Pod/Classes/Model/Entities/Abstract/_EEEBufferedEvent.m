// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to EEEBufferedEvent.m instead.

#import "_EEEBufferedEvent.h"

const struct EEEBufferedEventAttributes EEEBufferedEventAttributes = {
	.allDay = @"allDay",
	.availability = @"availability",
	.endDate = @"endDate",
	.eventIdentifier = @"eventIdentifier",
	.hasAlarms = @"hasAlarms",
	.hasAttendees = @"hasAttendees",
	.hasNotes = @"hasNotes",
	.hasRecurrenceRules = @"hasRecurrenceRules",
	.location = @"location",
	.notes = @"notes",
	.numericDay = @"numericDay",
	.startDate = @"startDate",
	.title = @"title",
};

const struct EEEBufferedEventRelationships EEEBufferedEventRelationships = {
	.calendar = @"calendar",
	.day = @"day",
};

const struct EEEBufferedEventFetchedProperties EEEBufferedEventFetchedProperties = {
};

@implementation EEEBufferedEventID
@end

@implementation _EEEBufferedEvent

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Event";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Event" inManagedObjectContext:moc_];
}

- (EEEBufferedEventID*)objectID {
	return (EEEBufferedEventID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"allDayValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"allDay"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"availabilityValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"availability"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"hasAlarmsValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"hasAlarms"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"hasAttendeesValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"hasAttendees"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"hasNotesValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"hasNotes"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"hasRecurrenceRulesValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"hasRecurrenceRules"];
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




@dynamic allDay;



- (BOOL)allDayValue {
	NSNumber *result = [self allDay];
	return [result boolValue];
}

- (void)setAllDayValue:(BOOL)value_ {
	[self setAllDay:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveAllDayValue {
	NSNumber *result = [self primitiveAllDay];
	return [result boolValue];
}

- (void)setPrimitiveAllDayValue:(BOOL)value_ {
	[self setPrimitiveAllDay:[NSNumber numberWithBool:value_]];
}





@dynamic availability;



- (int16_t)availabilityValue {
	NSNumber *result = [self availability];
	return [result shortValue];
}

- (void)setAvailabilityValue:(int16_t)value_ {
	[self setAvailability:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveAvailabilityValue {
	NSNumber *result = [self primitiveAvailability];
	return [result shortValue];
}

- (void)setPrimitiveAvailabilityValue:(int16_t)value_ {
	[self setPrimitiveAvailability:[NSNumber numberWithShort:value_]];
}





@dynamic endDate;






@dynamic eventIdentifier;






@dynamic hasAlarms;



- (BOOL)hasAlarmsValue {
	NSNumber *result = [self hasAlarms];
	return [result boolValue];
}

- (void)setHasAlarmsValue:(BOOL)value_ {
	[self setHasAlarms:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveHasAlarmsValue {
	NSNumber *result = [self primitiveHasAlarms];
	return [result boolValue];
}

- (void)setPrimitiveHasAlarmsValue:(BOOL)value_ {
	[self setPrimitiveHasAlarms:[NSNumber numberWithBool:value_]];
}





@dynamic hasAttendees;



- (BOOL)hasAttendeesValue {
	NSNumber *result = [self hasAttendees];
	return [result boolValue];
}

- (void)setHasAttendeesValue:(BOOL)value_ {
	[self setHasAttendees:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveHasAttendeesValue {
	NSNumber *result = [self primitiveHasAttendees];
	return [result boolValue];
}

- (void)setPrimitiveHasAttendeesValue:(BOOL)value_ {
	[self setPrimitiveHasAttendees:[NSNumber numberWithBool:value_]];
}





@dynamic hasNotes;



- (BOOL)hasNotesValue {
	NSNumber *result = [self hasNotes];
	return [result boolValue];
}

- (void)setHasNotesValue:(BOOL)value_ {
	[self setHasNotes:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveHasNotesValue {
	NSNumber *result = [self primitiveHasNotes];
	return [result boolValue];
}

- (void)setPrimitiveHasNotesValue:(BOOL)value_ {
	[self setPrimitiveHasNotes:[NSNumber numberWithBool:value_]];
}





@dynamic hasRecurrenceRules;



- (BOOL)hasRecurrenceRulesValue {
	NSNumber *result = [self hasRecurrenceRules];
	return [result boolValue];
}

- (void)setHasRecurrenceRulesValue:(BOOL)value_ {
	[self setHasRecurrenceRules:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveHasRecurrenceRulesValue {
	NSNumber *result = [self primitiveHasRecurrenceRules];
	return [result boolValue];
}

- (void)setPrimitiveHasRecurrenceRulesValue:(BOOL)value_ {
	[self setPrimitiveHasRecurrenceRules:[NSNumber numberWithBool:value_]];
}





@dynamic location;






@dynamic notes;






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





@dynamic startDate;






@dynamic title;






@dynamic calendar;

	

@dynamic day;

	






@end
