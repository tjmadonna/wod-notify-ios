//
//  WodListPresenterImpl.h
//  WodNotify
//
//  Created by Tyler Madonna on 12/24/19.
//  Copyright © 2019 Tyler Madonna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WodListContract.h"

NS_ASSUME_NONNULL_BEGIN

@interface WodListPresenterImpl : NSObject <WodListPresenterProtocol>

@property (weak, nonatomic) id<WodListViewProtocol> view;

@end

NS_ASSUME_NONNULL_END
