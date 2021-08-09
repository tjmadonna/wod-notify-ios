//
//  NetworkDateParser.m
//  WodNotify
//
//  Created by Tyler Madonna on 6/18/21.
//  Copyright © 2021 Tyler Madonna. All rights reserved.
//

#import "NetworkDateParser.h"

@interface NetworkDateParser ()

@property (readonly, nonatomic) NSArray<NSDateFormatter *> * dateFormatters;

@property (strong, nonatomic) NSDateFormatter * preferredDateFormatter;

@property (assign, nonatomic) NSUInteger preferredIndex;

@end

@implementation NetworkDateParser

const NSString *kNetworkDataManagerDateFormats[] = {@"MM/dd/yy", @"MMddyyyy"};

const int kNetworkDataManagerDateFormatsSize = 2;

- (instancetype)init {
    self = [super init];
    if (self) {
        _dateFormatters = [self generateDateFormatters];
        _preferredDateFormatter = [_dateFormatters firstObject];
        _preferredIndex = 0;
    }
    return self;
}

- (NSArray<NSDateFormatter *> *)generateDateFormatters {
    NSArray<NSString *> *dateFormats = [[NSArray alloc] initWithObjects:kNetworkDataManagerDateFormats
                                                                  count:kNetworkDataManagerDateFormatsSize];
    NSMutableArray<NSDateFormatter *> *dateFormatters = [[NSMutableArray alloc] initWithCapacity:dateFormats.count];
    for (NSString *dateFormat in dateFormats) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = dateFormat;
        [dateFormatters addObject:dateFormatter];
    }
    return dateFormatters;
}

- (NSDate *)parseDate:(NSString *)dateString {

    // We try to parse with the preferred dateformatter and word index. This is an optimization
    NSArray<NSString *> *splitDateString = [dateString componentsSeparatedByCharactersInSet:
                                            [NSCharacterSet whitespaceCharacterSet]];
    NSString *potentialDateString = [splitDateString objectAtIndex:self.preferredIndex];
    if (potentialDateString) {
        NSDate *potentialDate = [self.preferredDateFormatter dateFromString:potentialDateString];
        if (potentialDate)
            return potentialDate;
    }

    // Try splitting the title into words and parsing each word
    NSUInteger index = 0;
    for (NSString *word in splitDateString) {
        // Many date format possibilities
        for (NSDateFormatter *dateFormatter in self.dateFormatters) {
            NSDate *date = [dateFormatter dateFromString:word];
            if (date) {
                // We found the date and format, mark them as preferred
                self.preferredDateFormatter = dateFormatter;
                self.preferredIndex = index;
                return date;
            }
        }
        index++;
    }

    return nil;
}

@end
