//
//  WodListPresenter.m
//  WodNotify
//
//  Created by Tyler Madonna on 12/24/19.
//  Copyright © 2019 Tyler Madonna. All rights reserved.
//

#import "WodListPresenter.h"

@interface WodListPresenter ()

@property (strong, nonatomic) id<LocalDataManagerProtocol> localDataManager;

@end

@implementation WodListPresenter

NSString * const kDateDelimiter = @"-";

NSString * const kDateFormat = @"MMMM-dd-EEEE";

- (instancetype)initWithLocalDataManager:(id<LocalDataManagerProtocol>)localDataManager {
    self = [super init];
    if (self) {
        _localDataManager = localDataManager;
    }
    return self;
}

- (void)setView:(id<WodListViewProtocol>)view {
    _view = view;
    [self fetchWods];
    NSLog(@"View set on presenter");
}

- (void)fetchWods {
    [self.localDataManager getAllWodsWithCompletion:^(NSArray<WodModel *> * _Nullable wods, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error Fetching Wods: %@", error);
            return;
        }

        if (!wods) {
            NSLog(@"Error Fetching Wods: Wods are nil");
            return;
        }

        NSArray<WodListViewItem *> *wodListViewItemArray = [self mapWodModelArrayToWodListViewItemArray:wods];

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view presentWodList:wodListViewItemArray];
        });
    }];
}

- (NSArray<WodListViewItem *> *)mapWodModelArrayToWodListViewItemArray:(NSArray<WodModel *> *)wodModelArray {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = kDateFormat;

    NSMutableArray <WodListViewItem *> *wodListViewItemArray = [[NSMutableArray alloc]
                                                                initWithCapacity:wodModelArray.count];

    for (WodModel *wodModel in wodModelArray) {
        NSString *dateString = [dateFormatter stringFromDate:wodModel.date];
        NSArray<NSString *> *dateComponents = [dateString componentsSeparatedByString:kDateDelimiter];
        [wodListViewItemArray addObject:[[WodListViewItem alloc] initWithUid:wodModel.uid
                                                                       month:dateComponents[0]
                                                                  dayOfMonth:dateComponents[1]
                                                                   dayOfWeek:dateComponents[2]
                                                                       title:wodModel.title
                                                                      author:wodModel.author]];
    }

    return wodListViewItemArray;
}

@end
