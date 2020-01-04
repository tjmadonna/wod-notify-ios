#import "SceneDelegate.h"
#import "ApplicationRouter.h"

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
}

@end
