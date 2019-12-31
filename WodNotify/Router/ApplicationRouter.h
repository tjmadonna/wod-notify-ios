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

NS_ASSUME_NONNULL_BEGIN

@interface ApplicationRouter : NSObject

- (instancetype)initWithWindow:(UIWindow *)window applicationComponent:(ApplicationComponent *)applicationComponent;

- (void)navigateToWodListViewController;

@end

NS_ASSUME_NONNULL_END
