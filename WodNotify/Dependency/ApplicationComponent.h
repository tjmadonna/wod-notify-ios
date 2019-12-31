//
//  ApplicationComponent.h
//  WodNotify
//
//  Created by Tyler Madonna on 12/28/19.
//  Copyright © 2019 Tyler Madonna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface ApplicationComponent : NSObject

@property (strong, atomic, readonly) id<LocalDataManagerProtocol> _Nullable localDataManager;

@end

NS_ASSUME_NONNULL_END
