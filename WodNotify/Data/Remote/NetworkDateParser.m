//
//  NetworkDateParser.m
//  WodNotify
//
//  Created by Tyler Madonna on 6/18/21.
//  Copyright © 2021 Tyler Madonna. All rights reserved.
//

#import "NetworkDateParser.h"

@interface NetworkDateParser ()

@property (readonly, nonatomic) NSDateFormatter * dateFormatter;

@end

@implementation NetworkDateParser

// Regex pattern used to extract date from url
NSString *const kNetworkDateParserUrlPattern = @"^\\/wods\\/([0-9]{4}\\/[0-9]{1,2}\\/[0-9]{1,2})\\/(?:[a-zA-Z0-9-]+)$";

// Date formatter used to convert extract date string to date
NSString *const kNetworkDataManagerDateFormat = @"yyyy/MM/dd";

/// Initialize a NetworkDateParser
- (instancetype)init {
    self = [super init];
    if (self) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateFormat = kNetworkDataManagerDateFormat;
    }
    return self;
}

/// Get the date from the given url with the format /wods/yyyy/MM/dd/{some-time}
/// @param urlString url which date should be extracted
/// @returns date that was extracted from the url (nullable)
- (NSDate *)parseDate:(NSString *)urlString {

    // This seems to be the most reliable way of parsing the date since url scheme should not change

    NSError *error = nil;
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:kNetworkDateParserUrlPattern
                                                                                options:NSRegularExpressionCaseInsensitive
                                                                                  error:&error];
    if (error) {
        return nil;
    }

    NSArray<NSTextCheckingResult *> *matches = [expression matchesInString:urlString
                                                                   options:0
                                                                     range:NSMakeRange(0, [urlString length])];

    for (NSTextCheckingResult *match in matches) {

        if ([match numberOfRanges] == 2) {
            NSRange captureRange = [match rangeAtIndex:1];
            NSString *capturedDate = [urlString substringWithRange:captureRange];
            NSDate *date =[self.dateFormatter dateFromString:capturedDate];
            if (date) {
                return date;
            }
        }
    }

    return nil;
}

@end
