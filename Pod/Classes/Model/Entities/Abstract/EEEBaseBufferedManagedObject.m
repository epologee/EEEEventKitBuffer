#import "EEEBaseBufferedManagedObject.h"

@interface EEEBaseBufferedManagedObject ()

@end

@implementation EEEBaseBufferedManagedObject

+ (NSArray *)allObjectsInContext:(NSManagedObjectContext *)ctx error:(NSError **)error
{
    NSFetchRequest *request = [self fetchRequest];
    return [ctx executeFetchRequest:request error:error];
}

+ (instancetype)uniqueEntityWithValue:(id)value forKey:(NSString *)key created:(BOOL *)created inContext:(NSManagedObjectContext *)ctx
{
    NSFetchRequest *request = [self fetchRequest];
    NSString *format = [NSString stringWithFormat:@"%@ == %%@", key];
    request.predicate = [NSPredicate predicateWithFormat:format, value];
    request.fetchLimit = 1;

    NSError *error = nil;
    EEEBaseBufferedManagedObject *entity;
    NSArray *existingEvents = [ctx executeFetchRequest:request error:&error];
    if ([existingEvents count] == 1)
    {
        entity = [existingEvents lastObject];
        if (created) *created = NO;
        return entity;
    }

    entity = [self insertInManagedObjectContext:ctx];
    [entity setValue:value forKey:key];
    if (created) *created = YES;
    return entity;
}

+ (NSFetchRequest *)fetchRequest
{
    return [[NSFetchRequest alloc] initWithEntityName:[self entityName]];
}

+ (id)insertInManagedObjectContext:(NSManagedObjectContext *)ctx
{
    // Overridden by mogenerator
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

+ (NSString *)entityName
{
    // Overridden by mogenerator
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

@end