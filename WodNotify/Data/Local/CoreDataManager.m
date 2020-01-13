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

@property (strong, nonatomic) NSPersistentContainer * persistentContainer;

@property (strong, nonatomic) NSNotificationCenter * notificationCenter;

@end

@implementation CoreDataManager

NSString *const kLocalDataManagerWodModelDataChangedNotification = @"kLocalDataManagerWodModelDataChangedNotification";

- (instancetype)initWithPersistentContainer:(NSPersistentContainer *)persistentContainer
                         notificationCenter:(NSNotificationCenter *)notificationCenter {
    self = [super init];
    if (self) {
        _persistentContainer = persistentContainer;
        _notificationCenter = notificationCenter;
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
    NSManagedObjectContext *backgroundContext = [self.persistentContainer newBackgroundContext];
    [backgroundContext performBlock:^{

        NSFetchRequest *fetchRequest = [WodLocalModel fetchRequest];
        fetchRequest.predicate = [NSPredicate predicateWithValue:YES];
        fetchRequest.sortDescriptors = @[ [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO] ];

        NSError *error;
        NSArray<WodLocalModel *> *wods = [backgroundContext executeFetchRequest:fetchRequest error:&error];

        if (error) {
            completion(nil, error);
            return;
        }

        NSArray<WodModel *> *wodModels = [self mapLocalWodModelArrayToWodModelArray:wods];

        completion(wodModels, nil);
    }];
}

- (void)getWodByUid:(NSString *)uid completion:(WodSingleWodQueryCompletion)completion {
    NSManagedObjectContext *backgroundContext = [self.persistentContainer newBackgroundContext];
    [backgroundContext performBlock:^{

        NSFetchRequest *fetchRequest = [WodLocalModel fetchRequest];
        fetchRequest.fetchLimit = 1;
        fetchRequest.predicate = [NSPredicate predicateWithFormat:@"%K == %@", @"uid", uid];

        NSError *error;
        NSArray<WodLocalModel *> *wods = [backgroundContext executeFetchRequest:fetchRequest error:&error];

        if (error) {
            completion(nil, error);
            return;
        }

        NSArray<WodModel *> *wodModels = [self mapLocalWodModelArrayToWodModelArray:wods];

        completion(wodModels.firstObject, nil);
    }];
}

- (void)saveWods:(NSArray<WodModel *> *)wodModelArray withCompletion:(WodSaveCompletion)completion {
    NSManagedObjectContext *backgroundContext = [self.persistentContainer newBackgroundContext];
    backgroundContext.mergePolicy = NSOverwriteMergePolicy;
    [backgroundContext performBlock:^{

        for (WodModel *wodModel in wodModelArray) {
            WodLocalModel *wodLocalModel = [[WodLocalModel alloc] initWithContext:backgroundContext];
            wodLocalModel.uid = wodModel.uid;
            wodLocalModel.date = wodModel.date;
            wodLocalModel.title = wodModel.title;
            wodLocalModel.url = wodModel.url;
            wodLocalModel.author = wodModel.author;
            wodLocalModel.summary = wodModel.summary;
        }

        NSError *error;
        [backgroundContext save:&error];

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
