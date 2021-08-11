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
#import <SafariServices/SafariServices.h>

@interface ApplicationRouter ()

@property (strong, nonatomic) UIWindow * window;

@property (strong, nonatomic) ApplicationComponent * applicationComponent;

@property (strong, nonatomic) UINavigationController * navigationController;

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

    self.navigationController = [[UINavigationController alloc] initWithRootViewController: viewController];
    self.window.rootViewController =  self.navigationController;
}

- (void)navigateToWodDetailViewController:(WodModel *)wodModel {
    NSURL *url = [[NSURL alloc] initWithString:wodModel.url];
    if (url) {
        SFSafariViewController *safariViewController = [[SFSafariViewController alloc] initWithURL:url];
        [self.navigationController presentViewController:safariViewController animated:YES completion:nil];
    } else {
        NSLog(@"Couldn't present detail view controller: WodModel url was nil");
    }
}

#pragma mark NotificationManagerDelegate

- (void)notificationManager:(nonnull id<NotificationManagerProtocol>)notificationManager didSelectNotificationWithWodModel:(nonnull WodModel *)wodModel {
    [self navigateToWodDetailViewController:wodModel];
}

@end
