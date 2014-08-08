#import "EEETestsAppDelegate.h"

@implementation EEETestsAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UIViewController *tableViewController = [[UIViewController alloc] init];
    tableViewController.title = @"Running tests...";
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:tableViewController];
    [self.window makeKeyAndVisible];
    return YES;
}

@end