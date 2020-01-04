//
//  NotificationManager.m
//  WodNotify
//
//  Created by Tyler Madonna on 1/3/20.
//  Copyright © 2020 Tyler Madonna. All rights reserved.
//

#import "NotificationManager.h"

@interface NotificationManager ()

@property (strong, nonatomic) UNUserNotificationCenter * userNotificationCenter;

@end

@implementation NotificationManager

NSString * const kNewWodNotificationId = @"com.madonnaapps.WodNotify.NewWodNotification";

- (instancetype)initWithUserNotificationCenter:(UNUserNotificationCenter *)userNotificationCenter {
    self = [super init];
    if (self) {
        _userNotificationCenter = userNotificationCenter;
    }
    return self;
}

- (void)requestPermissions {
    UNAuthorizationOptions options = UNAuthorizationOptionAlert + UNAuthorizationOptionSound;
    [self.userNotificationCenter requestAuthorizationWithOptions:options
                                               completionHandler:^(BOOL granted, NSError * _Nullable error) {
    }];
}

- (void)createNotificationWithWodModelArray:(NSArray<WodModel *> *)wodModelArray {
    [self.userNotificationCenter getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {

        if (settings.authorizationStatus == UNAuthorizationStatusAuthorized) {
            [self sendNotification:wodModelArray];
        }

    }];
}

- (void)sendNotification:(NSArray<WodModel *> *)wodModelArray {
    UNMutableNotificationContent *content = [UNMutableNotificationContent new];
    content.title = wodModelArray.firstObject.title;
    content.body = @"A new wod was posted";
    content.sound = [UNNotificationSound defaultSound];

    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:1 repeats:NO];

    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:kNewWodNotificationId
                                                                          content:content
                                                                          trigger:trigger];

    [self.userNotificationCenter addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error sending notification");
        }
    }];
}

@end
