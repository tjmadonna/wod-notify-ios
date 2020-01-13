//
//  SyncDataManager.h
//  WodNotify
//
//  Created by Tyler Madonna on 1/2/20.
//  Copyright © 2020 Tyler Madonna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SyncDataManagerProtocol.h"
#import "LocalDataManagerProtocol.h"
#import "RemoteDataManagerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface SyncDataManager : NSObject <SyncDataManagerProtocol>

- (instancetype)initWithLocalDataManager:(id<LocalDataManagerProtocol>)localDataManager
                       remoteDataManager:(id<RemoteDataManagerProtocol>)remoteDataManager
                            userDefaults:(NSUserDefaults *)userDefaults;

@end

NS_ASSUME_NONNULL_END
