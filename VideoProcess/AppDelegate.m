//
//  AppDelegate.m
//  VideoProcess
//
//  Created by tiger fly on 2020/3/2.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>
#import "AudioViewController.h"
#import "AssetHandleViewController.h"
#import "MediaPlayViewController.h"
#import "MetadataManipulationController.h"
#import "CameraViewController.h"
#import "MediaItemTransferController.h"
#import "HTTPLiveStreamingViewController.h"
#import "SampleBufferManipulationController.h"
#import "MediaCompositionEditingViewController.h"
#import "MediaSelectionViewController.h"
#import "ContentKeyDecryptionController.h"
#import "SupportingTypesController.h"
#import "SpeechSynthesisControls.h"
#import "SpeechSynthesisController.h"
#import "SpeechViewController.h"
#import "RSILAViewController.h"
#import "AssetsViewController.h"
#import "CaptureViewController.h"
#import "AVFoundationController.h"
#import "AVAudioEngineController.h"
#import "AudioController.h"
#import "EditingViewController.h"

#import <objc/runtime.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

//https://developer.apple.com/library/archive/documentation/MusicAudio/Conceptual/AudioQueueProgrammingGuide/AboutAudioQueues/AboutAudioQueues.html#//apple_ref/doc/uid/TP40005343-CH5-SW1

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    AVAudioSession *audioSesion = [AVAudioSession sharedInstance];
    @try {
        NSError *error = nil;
        if (@available(iOS 10.0, *)) {
            [audioSesion setCategory:AVAudioSessionCategoryPlayback mode:AVAudioSessionModeMoviePlayback options:AVAudioSessionCategoryOptionMixWithOthers error:&error];
        } else {
            // Fallback on earlier versions
        }
    } @catch (NSException *exception) {
        NSLog(@"Setting category to AVAudioSessionCategoryPlayback failed.");
    } @finally {
        
    }
        
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    AudioController *vc = [AudioController new];
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

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}




@end
