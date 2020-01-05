//
//  WodListPresenter.h
//  WodNotify
//
//  Created by Tyler Madonna on 12/24/19.
//  Copyright © 2019 Tyler Madonna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WodListContract.h"
#import "LocalDataManagerProtocol.h"
#import "SyncDataManagerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface WodListPresenter : NSObject <WodListPresenterProtocol>

@property (weak, nonatomic) id<WodListViewProtocol> view;

- (instancetype)initWithLocalDataManager:(id<LocalDataManagerProtocol>)localDataManager
                         syncDataManager:(id<SyncDataManagerProtocol>)syncDataManager
                      notificationCenter:(NSNotificationCenter *)notificationCenter;

@end

NS_ASSUME_NONNULL_END
