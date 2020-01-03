//
//  RemoteDataManagerProtocol.h
//  WodNotify
//
//  Created by Tyler Madonna on 12/31/19.
//  Copyright © 2019 Tyler Madonna. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "WodModel.h"

#ifndef RemoteDataManagerProtocol_h
#define RemoteDataManagerProtocol_h

NS_ASSUME_NONNULL_BEGIN

typedef void (^WodRemoteCompletion)( NSArray<WodModel *> * _Nullable , NSError * _Nullable );

@protocol RemoteDataManagerProtocol <NSObject>

- (void)getWodsWithCompletion:(WodRemoteCompletion)completion;

@end

NS_ASSUME_NONNULL_END


#endif /* RemoteDataManagerProtocol_h */
