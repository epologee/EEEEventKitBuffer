#import "EEEAppDelegate.h"
#import "EEEViewController.h"

@implementation EEEAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[EEEViewController alloc] init]];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
