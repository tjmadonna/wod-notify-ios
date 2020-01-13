//
//  SyncDataManagerProtocol.h
//  WodNotify
//
//  Created by Tyler Madonna on 1/2/20.
//  Copyright © 2020 Tyler Madonna. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "WodModel.h"

#ifndef SyncDataManagerProtocol_h
#define SyncDataManagerProtocol_h

NS_ASSUME_NONNULL_BEGIN

typedef void (^NewWodCompletion)( NSArray<WodModel *> * _Nullable , NSError * _Nullable );

@protocol SyncDataManagerProtocol <NSObject>

- (BOOL)needsSynced;

- (void)syncNewWodsWithCompletion:(NewWodCompletion)completion;

@end

NS_ASSUME_NONNULL_END


#endif /* SyncDataManagerProtocol_h */
