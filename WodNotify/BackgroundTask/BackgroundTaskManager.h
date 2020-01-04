//
//  BackgroundTaskManager.h
//  WodNotify
//
//  Created by Tyler Madonna on 1/4/20.
//  Copyright © 2020 Tyler Madonna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BackgroundTaskManagerProtocol.h"
#import "SyncDataManagerProtocol.h"
#import "NotificationManagerProtocol.h"
#import <BackgroundTasks/BackgroundTasks.h>

NS_ASSUME_NONNULL_BEGIN

@interface BackgroundTaskManager : NSObject <BackgroundTaskManagerProtocol>

- (instancetype)initWithTaskScheduler:(BGTaskScheduler *)taskScheduler
                      syncDataManager:(id<SyncDataManagerProtocol>)syncDataManager
                  notificationManager:(id<NotificationManagerProtocol>)notificationManager;

@end

NS_ASSUME_NONNULL_END
