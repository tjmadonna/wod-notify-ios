//
//  NetworkDateParser.h
//  WodNotify
//
//  Created by Tyler Madonna on 6/18/21.
//  Copyright © 2021 Tyler Madonna. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetworkDateParser : NSObject

- (instancetype)init;

- (NSDate * _Nullable)parseDate:(NSString *)dateString;

@end

NS_ASSUME_NONNULL_END
