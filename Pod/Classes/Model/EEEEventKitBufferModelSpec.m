//
//  EEEEventKitBufferModelSpec.m
//  EEEEventKitBuffer
//
//  Created by Eric-Paul Lecluse on 07-08-14.
//  Copyright 2014 Eric-Paul Lecluse. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "EEEEventKitBufferModel.h"
#import "EEEBufferedDay.h"

SPEC_BEGIN(EEEEventKitBufferModelSpec)

    describe(@"EEEEventKitBufferModel", ^{
        __block EEEEventKitBufferModel *sut;

        beforeEach(^{
            sut = [[EEEEventKitBufferModel alloc] init];
        });

        it(@"has one persistent store", ^{
            [[[sut.mainContext.persistentStoreCoordinator.persistentStores should] have:1] persistentStore];
        });

        it(@"merges changes into the main context", ^{
            NSManagedObjectContext *ctx = [sut newPrivateContext];
            [EEEBufferedDay insertInManagedObjectContext:ctx];
            [[theValue([ctx save:NULL]) should] beYes];

            NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:[EEEBufferedDay entityName]];
            NSError *fetchError = nil;
            NSArray *results = [sut.mainContext executeFetchRequest:request error:&fetchError];
            [[[results should] have:1] day];
        });
    });
SPEC_END
