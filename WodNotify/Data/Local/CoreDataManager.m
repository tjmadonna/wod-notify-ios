//
//  CoreDataManager.m
//  WodNotify
//
//  Created by Tyler Madonna on 12/24/19.
//  Copyright © 2019 Tyler Madonna. All rights reserved.
//

#import "CoreDataManager.h"
#import "WodLocalModel+CoreDataProperties.h"

@interface CoreDataManager ()

@property (strong, nonatomic) NSManagedObjectContext * managedObjectContext;

@property (strong, nonatomic) NSNotificationCenter * notificationCenter;

@end

@implementation CoreDataManager

NSString *const kLocalDataManagerWodModelDataChangedNotification = @"kLocalDataManagerWodModelDataChangedNotification";

- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
                          notificationCenter:(NSNotificationCenter *)notificationCenter {
    self = [super init];
    if (self) {
        _managedObjectContext = managedObjectContext;
        _notificationCenter = notificationCenter;
        _managedObjectContext.mergePolicy = NSOverwriteMergePolicy;
        [self registerNotification];
    }
    return self;
}

- (void)registerNotification {
    [self.notificationCenter addObserver:self
                                selector:@selector(wodDataDidChangeForNotification:)
                                    name:NSManagedObjectContextDidSaveNotification
                                  object:nil];
}

- (void)wodDataDidChangeForNotification:(NSNotification *)notification {
    NSLog(@"wodDataDidChangeForNotification");
    [self.notificationCenter postNotificationName:kLocalDataManagerWodModelDataChangedNotification object:nil];
}

- (void)getAllWodsWithCompletion:(nonnull WodQueryCompletion)completion {
    [self.managedObjectContext performBlock:^{

        NSFetchRequest *fetchRequest = [WodLocalModel fetchRequest];
        fetchRequest.predicate = [NSPredicate predicateWithValue:YES];
        fetchRequest.sortDescriptors = @[ [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO] ];
        fetchRequest.fetchLimit = 100;

        NSError *error;
        NSArray<WodLocalModel *> *wods = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];

        if (error) {
            completion(nil, error);
            return;
        }

        NSArray<WodModel *> *wodModels = [self mapLocalWodModelArrayToWodModelArray:wods];

        completion(wodModels, nil);
    }];
}

- (void)getWodByUid:(NSString *)uid completion:(WodSingleWodQueryCompletion)completion {
    [self.managedObjectContext performBlock:^{

        NSFetchRequest *fetchRequest = [WodLocalModel fetchRequest];
        fetchRequest.fetchLimit = 1;
        fetchRequest.predicate = [NSPredicate predicateWithFormat:@"%K == %@", @"uid", uid];

        NSError *error;
        NSArray<WodLocalModel *> *wods = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];

        if (error) {
            completion(nil, error);
            return;
        }

        NSArray<WodModel *> *wodModels = [self mapLocalWodModelArrayToWodModelArray:wods];

        completion(wodModels.firstObject, nil);
    }];
}

- (void)saveWods:(NSArray<WodModel *> *)wodModelArray withCompletion:(WodSaveCompletion)completion {
    [self.managedObjectContext performBlock:^{

        for (WodModel *wodModel in wodModelArray) {
            WodLocalModel *wodLocalModel = [[WodLocalModel alloc] initWithContext:self.managedObjectContext];
            wodLocalModel.uid = wodModel.uid;
            wodLocalModel.date = wodModel.date;
            wodLocalModel.title = wodModel.title;
            wodLocalModel.url = wodModel.url;
            wodLocalModel.author = wodModel.author;
            wodLocalModel.summary = wodModel.summary;
        }

        NSError *error;
        [self.managedObjectContext save:&error];

        completion(error);
    }];
}

- (NSArray<WodModel *> *)mapLocalWodModelArrayToWodModelArray:(NSArray<WodLocalModel *> *)localWodModelArray {
    NSMutableArray<WodModel *> *wodModelArray = [[NSMutableArray alloc] initWithCapacity:localWodModelArray.count];

    for (WodLocalModel *wodLocalModel in localWodModelArray) {

        if (wodLocalModel.uid && wodLocalModel.date &&
            wodLocalModel.title && wodLocalModel.author &&
            wodLocalModel.url && wodLocalModel.summary) {

            [wodModelArray addObject: [[WodModel alloc] initWithUid:wodLocalModel.uid
                                                               date:wodLocalModel.date
                                                              title:wodLocalModel.title
                                                             author:wodLocalModel.author
                                                                url:wodLocalModel.url
                                                            summary:wodLocalModel.summary]];
        }
    }

    return wodModelArray;
}

@end
