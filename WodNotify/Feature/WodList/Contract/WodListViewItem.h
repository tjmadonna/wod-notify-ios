//
//  WodListViewItem.h
//  WodNotify
//
//  Created by Tyler Madonna on 12/24/19.
//  Copyright © 2019 Tyler Madonna. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WodListViewItem: NSObject

@property (copy, nonatomic, readonly) NSString * uid;

@property (copy, nonatomic, readonly) NSString * month;

@property (copy, nonatomic, readonly) NSString * dayOfMonth;

@property (copy, nonatomic, readonly) NSString * dayOfWeek;

@property (copy, nonatomic, readonly) NSString * title;

@property (copy, nonatomic, readonly) NSString * author;

- (instancetype)initWithUid:(NSString *)uid
                      month:(NSString *)month
                 dayOfMonth:(NSString *)dayOfMonth
                  dayOfWeek:(NSString *)dayOfWeek
                      title:(NSString *)title
                     author:(NSString *)author;

@end

NS_ASSUME_NONNULL_END
