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
    return [self uniqueEntityWithKeyedValues:@{key : value} created:created inContext:ctx];
}

+ (instancetype)uniqueEntityWithKeyedValues:(NSDictionary *)keyedValues created:(BOOL *)created inContext:(NSManagedObjectContext *)ctx
{
    EEEBaseBufferedManagedObject *entity = [self existingEntityWithKeyedValues:keyedValues inContext:ctx];
    if (entity)
    {
        if (created) *created = NO;
        return entity;
    }

    entity = [self insertInManagedObjectContext:ctx];
    [keyedValues enumerateKeysAndObjectsUsingBlock:^(NSString *key, id value, BOOL *stop) {
        [entity setValue:value forKey:key];
    }];
    if (created) *created = YES;
    return entity;
}

+ (instancetype)existingEntityWithValue:(id)value forKey:(NSString *)key inContext:(NSManagedObjectContext *)ctx
{
    return [self existingEntityWithKeyedValues:@{key : value} inContext:ctx];
}

+ (instancetype)existingEntityWithKeyedValues:(NSDictionary *)keyedValues inContext:(NSManagedObjectContext *)ctx
{
    NSFetchRequest *request = [self fetchRequest];
    NSMutableArray *formats = [NSMutableArray array];
    NSMutableArray *values = [NSMutableArray array];
    [keyedValues enumerateKeysAndObjectsUsingBlock:^(NSString *key, id value, BOOL *stop) {
        [formats addObject:[NSString stringWithFormat:@"%@ == %%@", key]];
        [values addObject:value];
    }];

    NSString *format = [formats componentsJoinedByString:@" AND "];
    request.predicate = [NSPredicate predicateWithFormat:format argumentArray:values];
    request.fetchLimit = 1;

    NSError *error = nil;
    EEEBaseBufferedManagedObject *entity;
    NSArray *existingEvents = [ctx executeFetchRequest:request error:&error];
    if ([existingEvents count] == 1)
    {
        entity = [existingEvents lastObject];
        return entity;
    }

    return nil;
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