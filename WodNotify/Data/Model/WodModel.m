//
//  WodModel.m
//  WodNotify
//
//  Created by Tyler Madonna on 1/2/20.
//  Copyright © 2020 Tyler Madonna. All rights reserved.
//

#import "WodModel.h"

@implementation WodModel

- (instancetype)initWithUid:(NSString *)uid
                       date:(NSDate *)date
                      title:(NSString *)title
                     author:(NSString *)author
                        url:(NSString *)url
                    summary:(NSString *)summary {
    self = [super init];
    if (self) {
        _uid = uid;
        _date = date;
        _title = title;
        _author = author;
        _url = url;
        _summary = summary;
    }
    return self;
}

@end
