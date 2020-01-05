//
//  CoreDataManager.h
//  WodNotify
//
//  Created by Tyler Madonna on 12/24/19.
//  Copyright © 2019 Tyler Madonna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "LocalDataManagerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoreDataManager : NSObject <LocalDataManagerProtocol>

- (instancetype)initWithPersistentContainer:(NSPersistentContainer *)persistentContainer
                         notificationCenter:(NSNotificationCenter *)notificationCenter;

@end

NS_ASSUME_NONNULL_END
