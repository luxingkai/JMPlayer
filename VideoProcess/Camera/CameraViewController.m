//
//  CameraViewController.m
//  VideoProcess
//
//  Created by tigerfly on 2020/5/25.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "CameraViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface CameraViewController ()

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (status) {
        case AVAuthorizationStatusAuthorized: {
            // The user has previously granted access to the camera.
            [self setupCaptureSession];
        }
            break;
        case AVAuthorizationStatusNotDetermined: {
            // The user has not yet been asked for camera access.
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    [self setupCaptureSession];
                }
            }];
        }
            break;
        case AVAuthorizationStatusDenied: {
            // The user has previously denied access.
        }
            break;
            
        case AVAuthorizationStatusRestricted: {
            // The user can't grant access due to restrictions.
        }
            break;
    }
    
    
    
    // Do any additional setup after loading the view.
}

- (void)setupCaptureSession {
    
    
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
