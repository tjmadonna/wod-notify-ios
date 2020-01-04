//
//  NotificationCenterProtocol.h
//  WodNotify
//
//  Created by Tyler Madonna on 1/4/20.
//  Copyright © 2020 Tyler Madonna. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "WodModel.h"

#ifndef NotificationCenterProtocol_h
#define NotificationCenterProtocol_h

NS_ASSUME_NONNULL_BEGIN

@protocol NotificationCenterProtocol <NSObject>

- (void)requestPermissions;

- (void)createNotificationWithWodModelArray:(NSArray<WodModel *> *)wodModelArray;

@end

NS_ASSUME_NONNULL_END

#endif /* NotificationCenterProtocol_h */
