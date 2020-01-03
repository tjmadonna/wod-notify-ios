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

@end

@implementation CoreDataManager

- (instancetype)initWithPersistentContainer:(NSPersistentContainer *)persistentContainer {
    self = [super init];
    if (self) {
        _persistentContainer = persistentContainer;
    }
    return self;
}

- (void)getAllWodsWithCompletion:(nonnull WodQueryCompletion)completion {
    [self.persistentContainer.viewContext performBlock:^{

        NSFetchRequest *fetchRequest = [WodLocalModel fetchRequest];
        fetchRequest.predicate = [NSPredicate predicateWithValue:YES];
        fetchRequest.sortDescriptors = @[ [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES] ];

        NSError *error;
        NSArray<WodLocalModel *> *wods = [self.persistentContainer.viewContext executeFetchRequest:fetchRequest
                                                                                             error:&error];

        if (error) {
            completion(nil, error);
            return;
        }

        NSArray<WodModel *> *wodModels = [self mapLocalWodModelArrayToWodModelArray:wods];

        completion(wodModels, nil);
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
