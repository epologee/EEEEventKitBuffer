#import "EEEAppDelegate.h"

int main(int argc, char *argv[]) {
    @autoreleasepool
    {
        BOOL runningTests = (NSClassFromString(@"EEETestsAppDelegate") != nil);
        if (runningTests)
        {
            return UIApplicationMain(argc, argv, nil, @"EEETestsAppDelegate");
        }

        return UIApplicationMain(argc, argv, nil, NSStringFromClass([EEEAppDelegate class]));
    }
}
