//
//  BackgroundTaskManagerProtocol.h
//  WodNotify
//
//  Created by Tyler Madonna on 1/4/20.
//  Copyright © 2020 Tyler Madonna. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef BackgroundTaskManagerProtocol_h
#define BackgroundTaskManagerProtocol_h

NS_ASSUME_NONNULL_BEGIN

@protocol BackgroundTaskManagerProtocol <NSObject>

- (void)registerWodSyncBackgroundTask;

- (void)scheduleWodSyncBackgroundTask;

@end

NS_ASSUME_NONNULL_END

#endif /* BackgroundTaskManagerProtocol_h */
