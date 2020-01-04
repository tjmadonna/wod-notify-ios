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
#import "NotificationManagerProtocol.h"
#import "BackgroundTaskManagerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface ApplicationComponent : NSObject

@property (strong, atomic, readonly) id<LocalDataManagerProtocol> localDataManager;

@property (strong, atomic, readonly) id<SyncDataManagerProtocol> syncDateManager;

@property (strong, atomic, readonly) id<NotificationManagerProtocol> notificationManager;

@property (strong, atomic, readonly) id<BackgroundTaskManagerProtocol> backgroundTaskManager;

+ (ApplicationComponent *)sharedComponent;

@end

NS_ASSUME_NONNULL_END
