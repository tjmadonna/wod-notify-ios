//
//  NotificationManager.h
//  WodNotify
//
//  Created by Tyler Madonna on 1/3/20.
//  Copyright © 2020 Tyler Madonna. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UserNotifications/UserNotifications.h>
#import "NotificationCenterProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface NotificationManager : NSObject <NotificationCenterProtocol>

- (instancetype)initWithUserNotificationCenter:(UNUserNotificationCenter *)userNotificationCenter;

- (void)requestPermissions;

- (void)createNotificationWithWodModelArray:(NSArray<WodModel *> *)wodModelArray;

@end

NS_ASSUME_NONNULL_END
