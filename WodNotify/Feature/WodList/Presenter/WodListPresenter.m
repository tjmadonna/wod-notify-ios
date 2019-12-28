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

- (instancetype)initWithLocalDataManager:(id<LocalDataManagerProtocol>)localDataManager {
    self = [super init];
    if (self) {
        _localDataManager = localDataManager;
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
            WodListViewItem *viewWod = [[WodListViewItem alloc] initWithUid:wod.uid date:wod.date title:wod.title author:wod.author];
            [viewWods addObject:viewWod];
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view presentWodList:viewWods];
        });
    }];
}

@end
