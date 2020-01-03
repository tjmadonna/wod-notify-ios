//
//  WodModel.h
//  WodNotify
//
//  Created by Tyler Madonna on 1/2/20.
//  Copyright © 2020 Tyler Madonna. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WodModel : NSObject

@property (copy, nonatomic, readonly) NSString * uid;

@property (copy, nonatomic, readonly) NSDate * date;

@property (copy, nonatomic, readonly) NSString * title;

@property (copy, nonatomic, readonly) NSString * author;

@property (copy, nonatomic, readonly) NSString * url;

@property (copy, nonatomic, readonly) NSString * summary;

- (instancetype)initWithUid:(NSString *)uid
                       date:(NSDate *)date
                      title:(NSString *)title
                     author:(NSString *)author
                        url:(NSString *)url
                    summary:(NSString *)summary;

@end

NS_ASSUME_NONNULL_END
