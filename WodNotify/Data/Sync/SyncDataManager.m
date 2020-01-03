//
//  SyncDataManager.m
//  WodNotify
//
//  Created by Tyler Madonna on 1/2/20.
//  Copyright © 2020 Tyler Madonna. All rights reserved.
//

#import "SyncDataManager.h"

@interface SyncDataManager ()

@property (strong, nonatomic) id<LocalDataManagerProtocol> localDataManager;

@property (strong, nonatomic) id<RemoteDataManagerProtocol> remoteDataManager;

@end

@implementation SyncDataManager

- (instancetype)initWithLocalDataManager:(id<LocalDataManagerProtocol>)localDataManager
                       remoteDataManager:(id<RemoteDataManagerProtocol>)remoteDataManager {
    self = [super init];
    if (self) {
        _localDataManager = localDataManager;
        _remoteDataManager = remoteDataManager;
    }
    return self;
}

- (void)syncNewWodsWithCompletion:(nonnull NewWodCompletion)completion {

    // Get remote wods
    [self.remoteDataManager getWodsWithCompletion:^(NSArray<WodModel *> * _Nullable remoteWodModels,
                                                    NSError * _Nullable remoteError) {
        if (remoteError) {
            completion(nil, remoteError);
            return;
        }

        // Get local wods
        [self.localDataManager getAllWodsWithCompletion:^(NSArray<WodModel *> * _Nullable localWodModels,
                                                          NSError * _Nullable localError) {
            if (localError) {
                completion(nil, localError);
                return;
            }

            // Compare remote wods and local wods to find new wods
            NSSet<NSString *> *localWodIds = [self createWodModelSet:localWodModels];
            NSMutableArray <WodModel *> *newWodModels = [[NSMutableArray alloc] init];

            for (WodModel *remoteWodModel in remoteWodModels) {
                if (![localWodIds containsObject:remoteWodModel.uid]) {
                    // Local date store does not contain the wod id, it must be new
                    [newWodModels addObject:remoteWodModel];
                }
            }

            // Save remote wods
            [self.localDataManager saveWods:remoteWodModels withCompletion:^(NSError * _Nullable saveWodsError) {

                if (saveWodsError) {
                    completion(nil, saveWodsError);
                    return;
                }

                // Return wods
                completion(newWodModels, nil);
            }];
        }];
    }];
}

- (NSSet<NSString *> *)createWodModelSet:(NSArray<WodModel *> *)wodModelArray {
    NSMutableSet *set = [[NSMutableSet alloc] initWithCapacity:wodModelArray.count];
    for (WodModel *wodModel in wodModelArray) {
        [set addObject:wodModel.uid];
    }
    return set;
}

@end
