//
//  ApplicationRouter.m
//  WodNotify
//
//  Created by Tyler Madonna on 12/31/19.
//  Copyright © 2019 Tyler Madonna. All rights reserved.
//

#import "ApplicationRouter.h"
#import "WodListPresenter.h"
#import "WodListViewController.h"

@interface ApplicationRouter ()

@property (strong, nonatomic) UIWindow * window;

@property (strong, nonatomic) ApplicationComponent * applicationComponent;

@end

@implementation ApplicationRouter

- (instancetype)initWithWindow:(UIWindow *)window applicationComponent:(ApplicationComponent *)applicationComponent {
    self = [super init];
    if (self) {
        _window = window;
        _applicationComponent = applicationComponent;
        [_window makeKeyAndVisible];
    }
    return self;
}

- (void)navigateToWodListViewController {
    id<LocalDataManagerProtocol> localDataManager = self.applicationComponent.localDataManager;
    id<SyncDataManagerProtocol> syncDataManager = self.applicationComponent.syncDateManager;
    WodListPresenter *presenter = [[WodListPresenter alloc] initWithLocalDataManager:localDataManager
                                                                     syncDataManager:syncDataManager
                                                                  notificationCenter: self.applicationComponent.notificationCenter
                                                                              router: self];
    WodListViewController *viewController = [[WodListViewController alloc] initWithPresenter:presenter];

    self.window.rootViewController =  [[UINavigationController alloc] initWithRootViewController: viewController];
}

@end
