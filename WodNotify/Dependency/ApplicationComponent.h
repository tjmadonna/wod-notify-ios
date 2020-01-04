//
//  ApplicationComponent.h
//  WodNotify
//
//  Created by Tyler Madonna on 12/28/19.
//  Copyright © 2019 Tyler Madonna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocalDataManagerProtocol.h"
#import "SyncDataManagerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface ApplicationComponent : NSObject

@property (strong, atomic, readonly) id<LocalDataManagerProtocol> localDataManager;

@property (strong, atomic, readonly) id<SyncDataManagerProtocol> syncDateManager;

+ (ApplicationComponent *)shared;

@end

NS_ASSUME_NONNULL_END
