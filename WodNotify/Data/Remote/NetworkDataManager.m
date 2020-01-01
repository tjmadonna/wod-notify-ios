//
//  NetworkDataManager.m
//  WodNotify
//
//  Created by Tyler Madonna on 12/31/19.
//  Copyright © 2019 Tyler Madonna. All rights reserved.
//

#import "NetworkDataManager.h"

@implementation NetworkDataManager

- (void)getWodsWithCompletion:(WodRemoteCompletion)completion {
    NSURL *url = [[NSURL alloc] initWithString:@"https://www.crossfitathletics.com/wods?format=json"];

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

        completion(result, nil);
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

@end
