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

@property (strong, nonatomic) id<SyncDataManagerProtocol> syncDataManager;

@property (strong, nonatomic) NSNotificationCenter * notificationCenter;

@property (weak, nonatomic) ApplicationRouter * router;

@property (assign, nonatomic) BOOL fetchingWods;

@end

@implementation WodListPresenter

NSString * const kDateDelimiter = @"-";

NSString * const kDateFormat = @"MMMM-dd-EEEE";

- (instancetype)initWithLocalDataManager:(id<LocalDataManagerProtocol>)localDataManager
                         syncDataManager:(id<SyncDataManagerProtocol>)syncDataManager
                      notificationCenter:(NSNotificationCenter *)notificationCenter
                                  router:(ApplicationRouter *)router {
    self = [super init];
    if (self) {
        _localDataManager = localDataManager;
        _syncDataManager = syncDataManager;
        _notificationCenter = notificationCenter;
        _router = router;
        _fetchingWods = NO;
        [self registerWodModelDataChangeNotification];
    }
    return self;
}

- (void)registerWodModelDataChangeNotification {
    [self.notificationCenter addObserver:self
                                selector:@selector(fetchWodsFromLocalDataManager)
                                    name:kLocalDataManagerWodModelDataChangedNotification
                                  object:nil];
}

- (void)setView:(id<WodListViewProtocol>)view {
    _view = view;
    [self fetchWods];
    NSLog(@"View set on presenter");
}

- (void)handleWodListViewItemSelection:(WodListViewItem *)item {
    [self.localDataManager getWodByUid:item.uid completion:^(WodModel * _Nullable wod, NSError * _Nullable error) {

        if (error) {
            NSLog(@"Error Fetching Wods: %@", error);
            return;
        }

        if (!wod) {
            NSLog(@"LocalDataManager getWodByUid returned a nil wod result");
            return;
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.router navigateToWodDetailViewController:wod];
        });
    }];
}

- (void)fetchWods {
    NSLog(@"Fetching wods from local data");
    [self fetchWodsFromLocalDataManager];
}

- (void)loadData {
    if ([self.syncDataManager needsSynced]) {
        // Sync remote wods to the local data manager
        NSLog(@"Syncing wods to local data");
        [self.syncDataManager syncNewWodsWithCompletion:^(NSArray<WodModel *> * _Nullable newWods,
                                                          NSError * _Nullable syncError) {
            if (syncError) {
                NSLog(@"Error Syncing Wods: %@", syncError);
            } else {
                NSLog(@"%lu new wods saved to local data", newWods.count);
            }
        }];
    } else {
        [self.view hideRefreshControl];
    }
}

- (void)fetchWodsFromLocalDataManager {
    if (self.fetchingWods)
        return;

    [self setFetchingWods:YES];
    [self.localDataManager getAllWodsWithCompletion:^(NSArray<WodModel *> * _Nullable wods,
                                                      NSError * _Nullable error) {
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
            [self setFetchingWods:NO];
            [self.view hideRefreshControl];
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
