#import "SceneDelegate.h"
#import "ViewController.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate

#pragma mark - UIWindowSceneDelegate

- (void)scene:(UIScene *)scene
willConnectToSession:(UISceneSession *)session
      options:(UISceneConnectionOptions *)connectionOptions {
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.rootViewController = [[ViewController alloc] init];
    [self.window makeKeyAndVisible];
    self.window.windowScene = (UIWindowScene *)scene;
}

@end
