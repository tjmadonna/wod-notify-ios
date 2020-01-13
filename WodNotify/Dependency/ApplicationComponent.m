//
//  ApplicationComponent.m
//  WodNotify
//
//  Created by Tyler Madonna on 12/28/19.
//  Copyright © 2019 Tyler Madonna. All rights reserved.
//

#import "ApplicationComponent.h"
#import <CoreData/CoreData.h>
#import "CoreDataManager.h"
#import "NetworkDataManager.h"
#import "SyncDataManager.h"
#import "NotificationManager.h"
#import "BackgroundTaskManager.h"

@interface ApplicationComponent ()

@property (strong, atomic, readonly) NSPersistentContainer * _Nonnull persistentContainer;

@property (strong, atomic, readonly) NetworkDataManager * _Nonnull networkDataManager;

@end

@implementation ApplicationComponent

@synthesize persistentContainer = _persistentContainer;
@synthesize networkDataManager = _networkDataManager;
@synthesize localDataManager = _localDataManager;
@synthesize syncDateManager = _syncDateManager;
@synthesize notificationManager = _notificationManager;
@synthesize backgroundTaskManager = _backgroundTaskManager;

+ (ApplicationComponent *)sharedComponent {
    static dispatch_once_t pred;
    static ApplicationComponent *shared = nil;

    dispatch_once(&pred, ^{
        shared = [[ApplicationComponent alloc] init];
    });

    return shared;
}

- (NSPersistentContainer *)persistentContainer {
    if (!_persistentContainer) {
        _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Model"];
        [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription * _Nonnull _,
                                                                          NSError * _Nullable error) {
            if (error) {
                NSLog(@"NSPersistentContainer Error: %@", error);
            }
        }];
    }

    return _persistentContainer;
}

- (NetworkDataManager *)networkDataManager {
    if (!_networkDataManager) {
        _networkDataManager = [[NetworkDataManager alloc] init];
    }
    return _networkDataManager;
}

- (id<LocalDataManagerProtocol>)localDataManager {
    if (!_localDataManager) {
        _localDataManager = [[CoreDataManager alloc] initWithPersistentContainer:self.persistentContainer
                                                              notificationCenter:self.notificationCenter];
    }
    return _localDataManager;
}

- (id<SyncDataManagerProtocol>)syncDateManager {
    if (!_syncDateManager) {
        _syncDateManager = [[SyncDataManager alloc] initWithLocalDataManager:self.localDataManager
                                                           remoteDataManager:self.networkDataManager
                                                                userDefaults: [NSUserDefaults standardUserDefaults]];
    }
    return _syncDateManager;
}

- (id<NotificationManagerProtocol>)notificationManager {
    if (!_notificationManager) {
        _notificationManager = [[NotificationManager alloc]
                                initWithUserNotificationCenter:[UNUserNotificationCenter currentNotificationCenter]];
    }
    return _notificationManager;
}

- (id<BackgroundTaskManagerProtocol>)backgroundTaskManager {
    if (!_backgroundTaskManager) {
        _backgroundTaskManager = [[BackgroundTaskManager alloc] initWithTaskScheduler:[BGTaskScheduler sharedScheduler]
                                                                      syncDataManager:self.syncDateManager
                                                                  notificationManager:self.notificationManager];
    }
    return _backgroundTaskManager;
}

- (NSNotificationCenter *)notificationCenter {
    return [NSNotificationCenter defaultCenter];
}

@end
