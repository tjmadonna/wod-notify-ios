#import "SceneDelegate.h"
#import "ApplicationRouter.h"

@interface SceneDelegate ()

@property (strong, nonatomic) ApplicationRouter * appRouter;

@property (strong, nonatomic) ApplicationComponent * appComponent;

@end

@implementation SceneDelegate

#pragma mark - UIWindowSceneDelegate

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    [self.window makeKeyAndVisible];
    self.window.windowScene = (UIWindowScene *)scene;

    self.appComponent = [ApplicationComponent sharedComponent];
    self.appRouter = [[ApplicationRouter alloc] initWithWindow:self.window applicationComponent:self.appComponent];

    [self.appComponent.notificationManager requestPermissions];
    [self.appComponent.backgroundTaskManager registerWodSyncBackgroundTask];

    self.appComponent.notificationManager.delegate = self.appRouter;

    [self.appRouter navigateToWodListViewController];
}

- (void)sceneDidEnterBackground:(UIScene *)scene {
    [self.appComponent.backgroundTaskManager scheduleWodSyncBackgroundTask];
}

- (void)sceneDidBecomeActive:(UIScene *)scene {
    [self.appComponent.notificationManager clearNotifications];
}

@end
