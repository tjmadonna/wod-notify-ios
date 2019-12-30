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

@property (strong, nonatomic) NSDateFormatter * dateFormatter;

@end

@implementation WodListPresenter

NSString * const kDateDelimiter = @"-";

NSString * const kDateFormat = @"MMMM-dd-EEEE";

- (instancetype)initWithLocalDataManager:(id<LocalDataManagerProtocol>)localDataManager {
    self = [super init];
    if (self) {
        _localDataManager = localDataManager;
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateFormat = kDateFormat;
    }
    return self;
}

- (void)setView:(id<WodListViewProtocol>)view {
    _view = view;
    NSLog(@"View set on presenter");
}

- (void)fetchWods {
    [self.localDataManager getAllWodsWithCompletion:^(NSArray<WodEntity *> * _Nullable wods, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error Fetching Wods: %@", error);
            return;
        }

        if (!wods) {
            NSLog(@"Error Fetching Wods: Wods are nil");
            return;
        }

        NSMutableArray<WodListViewItem *> *viewWods = [[NSMutableArray alloc] initWithCapacity:wods.count];
        for (WodEntity *wod in wods) {
            WodListViewItem *viewWod = [self mapWodEntityToWodListViewItem:wod];
            [viewWods addObject:viewWod];
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view presentWodList:viewWods];
        });
    }];
}

- (WodListViewItem *)mapWodEntityToWodListViewItem:(WodEntity *)wodEntity {
    NSString *dateString = [self.dateFormatter stringFromDate:wodEntity.date];
    NSArray<NSString *> *dateComponents = [dateString componentsSeparatedByString:kDateDelimiter];

    return [[WodListViewItem alloc] initWithUid:wodEntity.uid
                                          month:dateComponents[0]
                                     dayOfMonth:dateComponents[1]
                                      dayOfWeek:dateComponents[2]
                                          title:wodEntity.title
                                         author:wodEntity.author];
}

@end
