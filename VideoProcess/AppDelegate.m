//
//  AppDelegate.m
//  VideoProcess
//
//  Created by tiger fly on 2020/3/2.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>
#import "AudioViewController.h"
#import "VideoPlayerViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    AVAudioSession *audioSesion = [AVAudioSession sharedInstance];
    @try {
        NSError *error = nil;
        [audioSesion setCategory:AVAudioSessionCategoryPlayback error:&error];
    } @catch (NSException *exception) {
        NSLog(@"Setting category to AVAudioSessionCategoryPlayback failed.");
    } @finally {
        
    }
        
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    MainViewController *vc = [MainViewController new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    return UIInterfaceOrientationMaskPortrait;
}

- (void)applicationWillTerminate:(UIApplication *)application{
    
}

- (void)application:(UIApplication *)application didUpdateUserActivity:(NSUserActivity *)userActivity {

}




@end
