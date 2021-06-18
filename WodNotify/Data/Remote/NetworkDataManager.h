//
//  NetworkDataManager.h
//  WodNotify
//
//  Created by Tyler Madonna on 12/31/19.
//  Copyright © 2019 Tyler Madonna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RemoteDataManagerProtocol.h"
#import "NetworkDateParser.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetworkDataManager : NSObject <RemoteDataManagerProtocol>

- (instancetype)initWithURLSession:(NSURLSession *)urlSession dateParser:(NetworkDateParser *)dateParser;

@end

NS_ASSUME_NONNULL_END
