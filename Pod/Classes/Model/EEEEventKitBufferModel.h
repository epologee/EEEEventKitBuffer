#import <Foundation/Foundation.h>

@class NSManagedObjectContext;

@interface EEEEventKitBufferModel : NSObject

@property(nonatomic, strong) NSManagedObjectContext *mainContext;

- (NSManagedObjectContext *)newPrivateContext;

@end