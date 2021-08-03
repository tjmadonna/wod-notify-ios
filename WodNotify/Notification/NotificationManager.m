//
//  NotificationManager.m
//  WodNotify
//
//  Created by Tyler Madonna on 1/3/20.
//  Copyright © 2020 Tyler Madonna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotificationManager.h"

@interface NotificationManager ()

@property (strong, nonatomic) UNUserNotificationCenter * userNotificationCenter;

@end

@implementation NotificationManager

NSString * const kNewWodNotificationId = @"com.madonnaapps.WodNotify.NewWodNotification";

NSString * const kWodModelKey = @"wodModel";

@synthesize delegate;

- (instancetype)initWithUserNotificationCenter:(UNUserNotificationCenter *)userNotificationCenter {
    self = [super init];
    if (self) {
        _userNotificationCenter = userNotificationCenter;
        _userNotificationCenter.delegate = self;
    }
    return self;
}

- (void)requestPermissions {
    UNAuthorizationOptions options = UNAuthorizationOptionAlert + UNAuthorizationOptionSound + UNAuthorizationOptionBadge;
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
    content.sound = [UNNotificationSound defaultSound];
    content.badge = @1;

    if (wodModelArray.count == 1) {
        WodModel *model = wodModelArray.firstObject;
        content.title = model.title;
        content.body = @"A new wod was posted";
        content.userInfo = @{kWodModelKey : model};
    } else {
        content.title = wodModelArray.firstObject.title;
        content.body = [[NSString alloc] initWithFormat:@"%lu new wods were posted", (unsigned long)wodModelArray.count];
    }

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

- (void)clearNotifications {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

# pragma mark UNUserNotificationCenterDelegate

- (void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
         withCompletionHandler:(void (^)(void))completionHandler {

    [self clearNotifications];

    WodModel *model = response.notification.request.content.userInfo[kWodModelKey];
    if (model && delegate) {
        [delegate notificationManager:self didSelectNotificationWithWodModel:model];
    }

    completionHandler();
}

@end
