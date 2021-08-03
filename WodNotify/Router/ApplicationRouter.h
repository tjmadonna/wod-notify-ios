//
//  ApplicationRouter.h
//  WodNotify
//
//  Created by Tyler Madonna on 12/31/19.
//  Copyright © 2019 Tyler Madonna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ApplicationComponent.h"
#import "NotificationManagerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface ApplicationRouter : NSObject <NotificationManagerDelegate>

- (instancetype)initWithWindow:(UIWindow *)window applicationComponent:(ApplicationComponent *)applicationComponent;

- (void)navigateToWodListViewController;

- (void)navigateToWodDetailViewController:(WodModel *)wodModel;

@end

NS_ASSUME_NONNULL_END
