//
//  NetworkDataManager.m
//  WodNotify
//
//  Created by Tyler Madonna on 12/31/19.
//  Copyright © 2019 Tyler Madonna. All rights reserved.
//

#import "NetworkDataManager.h"

@implementation NetworkDataManager

NSString * const kNetworkDataManagerDateFormat = @"MMddyyyy";

NSString * const kNetworkDataManagerBaseUrl = @"https://www.crossfitathletics.com";

- (void)getWodsWithCompletion:(WodRemoteCompletion)completion {
    NSString *urlString = [[NSString alloc] initWithFormat:@"%@/wods?format=json", kNetworkDataManagerBaseUrl];
    NSURL *url = [[NSURL alloc] initWithString:urlString];

    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url
                                                         completionHandler:^(NSData * _Nullable data,
                                                                             NSURLResponse * _Nullable response,
                                                                             NSError * _Nullable error) {
        if (error) {
            completion(nil, error);
            return;
        }

        NSError *jsonError;
        NSArray<NSDictionary *> *result = [self parseDataToJson:data error:jsonError];

        if (jsonError) {
            completion(nil, jsonError);
            return;
        }

        completion([self mapJsonToWodModelArray:result], nil);
    }];

    [task resume];
}

- (NSArray<NSDictionary *> *)parseDataToJson:(NSData *)data error:(NSError *)error {
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data
                                                             options:NSJSONReadingMutableContainers
                                                               error:&error];
    if (error) { return nil; }

    return jsonDict[@"items"];
}

- (NSArray<WodModel *> *)mapJsonToWodModelArray:(NSArray<NSDictionary *> *)jsonDictArray {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = kNetworkDataManagerDateFormat;

    NSMutableArray<WodModel *> *wodModelArray = [[NSMutableArray alloc] init];

    for (NSDictionary *jsonDict in jsonDictArray) {
        NSString *uid = jsonDict[@"id"];
        NSString *title = jsonDict[@"title"];
        NSString *author = jsonDict[@"author"][@"displayName"];
        NSString *relativeUrl = jsonDict[@"fullUrl"];
        NSString *summary = jsonDict[@"body"];

        if (uid && title && author && relativeUrl && summary) {

            NSDate *date = [dateFormatter dateFromString:title];
            NSString *url = [[NSString alloc] initWithFormat:@"%@%@", kNetworkDataManagerBaseUrl, relativeUrl];

            if (date && url) {
                [wodModelArray addObject: [[WodModel alloc] initWithUid:uid
                                                                   date:date
                                                                  title:title
                                                                 author:author
                                                                    url:url
                                                                summary:summary]];
            }
        }
    }

    return wodModelArray;
}

@end
