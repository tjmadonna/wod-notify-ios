#import "SceneDelegate.h"
#import "ApplicationRouter.h"

#import <BackgroundTasks/BackgroundTasks.h>

@interface SceneDelegate ()

@property (strong, nonatomic) ApplicationRouter * appRouter;

@end

@implementation SceneDelegate

#pragma mark - UIWindowSceneDelegate

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    [self.window makeKeyAndVisible];
    self.window.windowScene = (UIWindowScene *)scene;

    ApplicationComponent *applicationComponent = [ApplicationComponent shared];
    self.appRouter = [[ApplicationRouter alloc] initWithWindow:self.window applicationComponent:applicationComponent];
    [self.appRouter navigateToWodListViewController];

    [self registerBackgroundTask];
}

- (void)sceneDidEnterBackground:(UIScene *)scene {
    [self scheduleBackgroundTask];
}

#pragma mark - Background tasks

- (void)registerBackgroundTask {
    [[BGTaskScheduler sharedScheduler] registerForTaskWithIdentifier:@"com.madonnaapps.WodNotify.Refresh"
                                                          usingQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0) launchHandler:^(__kindof BGTask * _Nonnull task) {
        [self executeBackgroundTask:task];
        [self scheduleBackgroundTask];
    }];
}

- (void)scheduleBackgroundTask {
    BGAppRefreshTaskRequest *request = [[BGAppRefreshTaskRequest alloc] initWithIdentifier:@"com.madonnaapps.WodNotify.Refresh"];
    request.earliestBeginDate = [[NSDate alloc] initWithTimeIntervalSinceNow:3600];
    [[BGTaskScheduler sharedScheduler] submitTaskRequest:request error:nil];
}

- (void)executeBackgroundTask:(BGTask *)task {
    ApplicationComponent *applicationComponent = [ApplicationComponent shared];
    [[applicationComponent syncDateManager] syncNewWodsWithCompletion:^(NSArray<WodModel *> * _Nullable newWodArray,
                                                                        NSError * _Nullable error) {
        if (error) {
            [task setTaskCompletedWithSuccess:NO];
            return;
        }

        [task setTaskCompletedWithSuccess:YES];
    }];
}

@end
