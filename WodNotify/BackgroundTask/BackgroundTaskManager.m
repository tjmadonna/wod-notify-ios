//
//  BackgroundTaskManager.m
//  WodNotify
//
//  Created by Tyler Madonna on 1/4/20.
//  Copyright © 2020 Tyler Madonna. All rights reserved.
//

#import "BackgroundTaskManager.h"

@interface BackgroundTaskManager ()

@property (strong, nonatomic) BGTaskScheduler * taskScheduler;

@property (strong, nonatomic) id<SyncDataManagerProtocol> syncDataManager;

@property (strong, nonatomic) id<NotificationManagerProtocol> notificationManager;

@end

@implementation BackgroundTaskManager

NSString * const kWodSyncTaskId = @"com.madonnaapps.WodNotify.SyncWodTask";

- (instancetype)initWithTaskScheduler:(BGTaskScheduler *)taskScheduler
                      syncDataManager:(id<SyncDataManagerProtocol>)syncDataManager
                  notificationManager:(id<NotificationManagerProtocol>)notificationManager {
    self = [super init];
    if (self) {
        _taskScheduler = taskScheduler;
        _syncDataManager = syncDataManager;
        _notificationManager = notificationManager;
    }
    return self;
}

- (void)registerWodSyncBackgroundTask {
    [self.taskScheduler registerForTaskWithIdentifier:kWodSyncTaskId
                                           usingQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)
                                        launchHandler:^(__kindof BGTask * _Nonnull task) {
        [self executeWodSyncBackgroundTask:task];
        [self scheduleWodSyncBackgroundTask];
    }];
}

- (void)scheduleWodSyncBackgroundTask {
    BGAppRefreshTaskRequest *request = [[BGAppRefreshTaskRequest alloc] initWithIdentifier:kWodSyncTaskId];
    request.earliestBeginDate = [[NSDate alloc] initWithTimeIntervalSinceNow:3600];
    [self.taskScheduler submitTaskRequest:request error:nil];
}

- (void)executeWodSyncBackgroundTask:(BGTask *)task {
    [self.syncDataManager syncNewWodsWithCompletion:^(NSArray<WodModel *> * _Nullable newWodArray,
                                                      NSError * _Nullable error) {
        if (error) {
            [task setTaskCompletedWithSuccess:NO];
            return;
        }

        if (newWodArray.count > 0) {
            [self.notificationManager createNotificationWithWodModelArray:newWodArray];
        }

        [task setTaskCompletedWithSuccess:YES];
    }];
}

@end
