#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface EEEBaseBufferedManagedObject : NSManagedObject

+ (NSArray *)allObjectsInContext:(NSManagedObjectContext *)ctx error:(NSError **)error;

+ (instancetype)uniqueEntityWithValue:(id)value forKey:(NSString *)key created:(BOOL *)created inContext:(NSManagedObjectContext *)ctx;

+ (NSFetchRequest *)fetchRequest;

@end