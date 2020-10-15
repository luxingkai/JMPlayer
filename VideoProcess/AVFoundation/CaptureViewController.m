//
//  CaptureViewController.m
//  VideoProcess
//
//  Created by tigerfly on 2020/10/15.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "CaptureViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface CaptureViewController ()

@end

@implementation CaptureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    /*
     Cameras and Media Capture
     
     Capture photos and record video and audio; configure build-in cameras
     and microphones or external capture devices.
     
     The AVFoundation Capture subsystem provides a common high-level
     architecture for  video, photo, and audio capture services in
     iOS and macOS. Use this system if you want to:
     •  Build a custom camera UI to integrate shooting photos or
     videos into your app's user experience.
     •  Give users more direct control over photo and video capture,
     such as focus, exposure, and stabilization options.
     •  Produce different results than the system camera UI, such as
     RAW format photos, depth maps, or videos with custom timed
     metadata.
     •  Get live access to pixel or audio data streaming directly
     from a capture device.
     
     ⚠️ To instead let the user capture media with the system camera
     UI within your app, see UIImagePickerController.
     
     The main parts of the capture architecture are sessions, inputs,
     and outputs: Capture sessions connect one or more inputs to one
     or more outputs. Inputs are sources of media, including capture
     devices like the cameras and microphones built into an iOS device
     or Mac. Outputs acquire media from inputs to produce useful data,
     such as movie files written to disk or raw pixel buffers available
     for live processing.
     
     AVCaptureDevice________________ AVCaptureSession _____________ AVCaptureOutput
     AVCaptureDeviceInput
     
     */
    
    
#pragma mark -- User Privacy
    
    /**
     Requesting Authorization for Media Capture on iOS
     
     Respect user privacy by seeking permission to capture and
     store photos, audio, and video.
     
     In iOS, the user must explicitly grant permission for each
     app to access cameras and microphones. Before your app can
     use the capture system for the first time, iOS shows an alert
     asking the user to grant your app access to the camera, as
     shown below. iOS remembers the user's response to this alert,
     so subsequent uses of the capture system don't cause it to
     appear again. The user can change permission setting for your
     app in Settings > Privacy.
     
     To make sure your app has permission before capturing media,
     follow the steps below.
     */
    
    /**
     Configure You App's Info.plist File
     
     iOS requires that your app provide static messages to display
     to the user when the system asks for camera or microphone permission:
     •  If your app uses device cameras, include the
     NSCameraUsageDescription key in your app's Info.plist file.
     •  If your app uses device microphones, include the
     NSMicrophoneUsageDescription key in your app's Info.plist file.
     
     For each key, provide a message that explains to the user why
     your app needs to capture media, so that the user can feel
     confident granting permission to your app.
     
     ⚠️ If the appropriate key is not present in your app's Info.plist
     file when your app requests authorization or attempts to use a
     capture device, the system terminates your app.
     */
    
    /**
     Verify and Request Authorization for Capture
     */
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (status) {
        case AVAuthorizationStatusDenied: // The user has previously denied access.
        case AVAuthorizationStatusRestricted: { // The user can't grant access due to restrictions.
        }
            break;
        case AVAuthorizationStatusNotDetermined: {
            // The user has not yet been asked for camera access.
            
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    // setupCaptureSession
                }
            }];
            
        }
        case AVAuthorizationStatusAuthorized: {
            // The user has previously granted access to the camera
            // setupCaptureSession
            
        }
        default:
            break;
    }
    
    
    /**
     Request Authorization Before Saving Captured Media
     
     After capturing photos or video, you may want to save them into
     the user's Photos library. Accessing the Photos library also
     requires user permission (separate from camera and microphone
     permission). How and when you request permission depends on which
     features you use for saving media:
     •  For most photo and video capture workflows (including Live Photos
        and RAW format capture), use the PHPhotoLibrary and
        PHAssetCreationRequest classes. These classes require read/write
        access to the Photos library, so you must use the
        NSPhotoLibraryUsageDescription key in your info.plist to provide a
        message to the user when asking for access.
     
     •  If your app needs only to save movie files to the Photos library,
        the UISaveVideoAtPathToSavedPhotosAlbum function provides a simpler
        alternative to PHPhotoLibrary. This function requires only write access
        to the library, so use the NSPhotoLibraryAddUsageDescription key in
        your Info.plist to provide a message to the user when asking for
        permission to save to the Photos library.
     
     ⚠️ The UIImageWriteToSavedPhotosAlbum function is not recommended for
     use with photos captured with AVCapturePhotoOutput, because the UIImage
     class does not support the features and metadata included in photo output.
     */
    
    
#pragma mark -- Capture Sessions
    
    /**
     AVCaptureSession
     
     An object that manages capture activity and coordinates the flow
     of data from input devices to capture outputs.
     */
    AVCaptureSession
    
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

