#import "SceneDelegate.h"
#import "WodListViewController.h"
#import "WodListPresenter.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate

#pragma mark - UIWindowSceneDelegate

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {

    WodListPresenter *presenter = [[WodListPresenter alloc] init];
    WodListViewController *viewController = [[WodListViewController alloc] initWithPresenter:presenter];

    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.rootViewController = viewController;
    [self.window makeKeyAndVisible];
    self.window.windowScene = (UIWindowScene *)scene;
}

@end
