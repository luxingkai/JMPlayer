//
//  CameraViewController.m
//  VideoProcess
//
//  Created by tigerfly on 2020/5/25.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "CameraViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "PreviewView.h"
#import "OperationView.h"
#import "VPCameraManager.h"

@interface CameraViewController ()<OperationDelegate,AVCapturePhotoCaptureDelegate>

@property (nonatomic, strong) AVCaptureSession *captureSession;

@end

@implementation CameraViewController {
    VPCameraManager *_cameraManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = true;
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    _cameraManager = [VPCameraManager cameraManager];
    PreviewView *previewView = [[PreviewView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    previewView.previewLayer.session = _cameraManager.captureSession;
    [self.view addSubview:previewView];
    [_cameraManager startRunning];
    
    OperationView *operationView = [[OperationView alloc] initWithFrame:CGRectMake(0, screenSize.height - 100, screenSize.width, 100)];
    operationView.delegate = self;
    [self.view addSubview:operationView];
    
    // Do any additional setup after loading the view.
}

- (void)operation {
    if ([_cameraManager.captureOutput isKindOfClass:[AVCaptureStillImageOutput class]]) {
        AVCaptureStillImageOutput *stillImageOutput = (AVCaptureStillImageOutput *)_cameraManager.captureOutput;
        if (!stillImageOutput.capturingStillImage) {
            AVCaptureConnection *connection = [stillImageOutput connectionWithMediaType:AVMediaTypeVideo];
            [stillImageOutput captureStillImageAsynchronouslyFromConnection:connection completionHandler:^(CMSampleBufferRef  _Nullable imageDataSampleBuffer, NSError * _Nullable error) {
                NSData *data = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
                
            }];
        }
    }else {
        AVCapturePhotoOutput *photoOutput = (AVCapturePhotoOutput *)_cameraManager.captureOutput;
        AVCapturePhotoSettings *photoSetting = nil;
        if ([[photoOutput availablePhotoCodecTypes] containsObject:AVVideoCodecTypeHEVC]) {
            photoSetting = [AVCapturePhotoSettings photoSettingsWithFormat:@{AVVideoCodecKey:AVVideoCodecTypeHEVC}];
        }else {
            photoSetting = [AVCapturePhotoSettings new];
        }
        photoSetting.flashMode = AVCaptureFlashModeAuto;
        //photoSetting.isAutoStillImageStabilizationEnabled = photoOutput.isStillImageStabilizationSupported;
        [photoOutput capturePhotoWithSettings:photoSetting delegate:self];
    }
    
}

#pragma mark -- AVCapturePhotoCaptureDelegate

- (void)captureOutput:(AVCapturePhotoOutput *)output didFinishProcessingPhoto:(AVCapturePhoto *)photo error:(nullable NSError *)error {
    
}






//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [super touchesBegan:touches withEvent:event];
//    if (![self.captureSession isRunning]) {
//    }
//}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
