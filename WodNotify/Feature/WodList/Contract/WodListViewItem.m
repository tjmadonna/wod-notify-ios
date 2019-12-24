//
//  WodListViewItem.m
//  WodNotify
//
//  Created by Tyler Madonna on 12/24/19.
//  Copyright © 2019 Tyler Madonna. All rights reserved.
//

#import "WodListViewItem.h"

@implementation WodListViewItem

- (instancetype)initWithUid:(NSString *)uid date:(NSDate *)date title:(NSString *)title author:(NSString *)author {
    self = [super init];
    if (self) {
        _uid = uid;
        _date = date;
        _title = title;
        _author = author;
    }
    return self;
}

@end
