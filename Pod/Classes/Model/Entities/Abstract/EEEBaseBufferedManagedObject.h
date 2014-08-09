#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface EEEBaseBufferedManagedObject : NSManagedObject

+ (NSArray *)allObjectsInContext:(NSManagedObjectContext *)ctx error:(NSError **)error;

+ (instancetype)uniqueEntityWithValue:(id)value forKey:(NSString *)key created:(BOOL *)created inContext:(NSManagedObjectContext *)ctx;

+ (instancetype)uniqueEntityWithKeyedValues:(NSDictionary *)keyedValues created:(BOOL *)created inContext:(NSManagedObjectContext *)ctx;

+ (instancetype)existingEntityWithValue:(id)value forKey:(NSString *)key inContext:(NSManagedObjectContext *)ctx;

+ (instancetype)existingEntityWithKeyedValues:(NSDictionary *)keyedValues inContext:(NSManagedObjectContext *)ctx;

+ (NSFetchRequest *)fetchRequest;

@end