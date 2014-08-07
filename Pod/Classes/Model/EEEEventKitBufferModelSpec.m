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

        it(@"has a persistent store", ^{
            [[[sut.mainContext.persistentStoreCoordinator.persistentStores should] have:1] persistentStore];
        });

        it(@"saves to the main context", ^{
            NSManagedObjectContext *ctx = [sut newPrivateContext];
            EEEBufferedDay *day = [EEEBufferedDay insertInManagedObjectContext:ctx];
            day.dateGMT = [NSDate date];
            [[theValue([ctx save:NULL]) should] beYes];

            NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:[EEEBufferedDay entityName]];
            NSError *fetchError = nil;
            NSArray *results = [sut.mainContext executeFetchRequest:request error:&fetchError];
            [[[results should] have:1] day];
        });
    });
SPEC_END
