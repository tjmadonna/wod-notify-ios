//
//  LocalDataManager.h
//  WodNotify
//
//  Created by Tyler Madonna on 12/24/19.
//  Copyright © 2019 Tyler Madonna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WodEntity+CoreDataProperties.h"

#ifndef LocalDataManager_h
#define LocalDataManager_h

NS_ASSUME_NONNULL_BEGIN

typedef void (^WodQueryCompletion)( NSArray<WodEntity *> * _Nullable , NSError * _Nullable );

@protocol LocalDataManagerProtocol <NSObject>

- (void)getAllWodsWithCompletion:(WodQueryCompletion)completion;

@end

NS_ASSUME_NONNULL_END


#endif /* LocalDataManager_h */
