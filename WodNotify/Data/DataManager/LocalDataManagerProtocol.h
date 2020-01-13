//
//  LocalDataManager.h
//  WodNotify
//
//  Created by Tyler Madonna on 12/24/19.
//  Copyright © 2019 Tyler Madonna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WodModel.h"

#ifndef LocalDataManager_h
#define LocalDataManager_h

NS_ASSUME_NONNULL_BEGIN

typedef void (^WodQueryCompletion)( NSArray<WodModel *> * _Nullable , NSError * _Nullable );

typedef void (^WodSingleWodQueryCompletion)( WodModel * _Nullable , NSError * _Nullable );

typedef void (^WodSaveCompletion)( NSError * _Nullable );

FOUNDATION_EXPORT NSString *const kLocalDataManagerWodModelDataChangedNotification;

@protocol LocalDataManagerProtocol <NSObject>

- (void)getAllWodsWithCompletion:(WodQueryCompletion)completion;

- (void)getWodByUid:(NSString *)uid completion:(WodSingleWodQueryCompletion)completion;

- (void)saveWods:(NSArray<WodModel *> *)wodModelArray withCompletion:(WodSaveCompletion)completion;

@end

NS_ASSUME_NONNULL_END


#endif /* LocalDataManager_h */
