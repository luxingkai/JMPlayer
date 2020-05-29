//
//  CameraViewController.m
//  VideoProcess
//
//  Created by tigerfly on 2020/5/25.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "CameraViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import <PhotosUI/PhotosUI.h>
#import "PreviewView.h"
#import "OperationView.h"
#import "VPCameraManager.h"

@interface CameraViewController ()<OperationDelegate,AVCapturePhotoCaptureDelegate,AVCaptureFileOutputRecordingDelegate>

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

#pragma mark -- Capture

- (void)operation {
    
    if ([_cameraManager.captureOutput isKindOfClass:[AVCaptureStillImageOutput class]]) {
        AVCaptureStillImageOutput *stillImageOutput = (AVCaptureStillImageOutput *)_cameraManager.captureOutput;
        if (!stillImageOutput.capturingStillImage) {
            AVCaptureConnection *connection = [stillImageOutput connectionWithMediaType:AVMediaTypeVideo];
            [stillImageOutput captureStillImageAsynchronouslyFromConnection:connection completionHandler:^(CMSampleBufferRef  _Nullable imageDataSampleBuffer, NSError * _Nullable error) {
                NSData *data = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
            }];
        }
    }else if([_cameraManager.captureOutput isKindOfClass:[AVCapturePhotoOutput class]]){
        
        //Capture Still Photo
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
        
        // Capture a Bracketed Photo Sequence
        /*
         NSArray *exposureValues = @[@(-2),@(0),@(+2)];
         AVCaptureAutoExposureBracketedStillImageSettings *makeAutoExposureSetting = [AVCaptureAutoExposureBracketedStillImageSettings autoExposureSettingsWithExposureTargetBias:2.0];
         
         AVCapturePhotoBracketSettings *photoSetting = [AVCapturePhotoBracketSettings photoBracketSettingsWithRawPixelFormatType:0 processedFormat:@{AVVideoCodecKey:AVVideoCodecTypeHEVC} bracketedSettings:makeAutoExposureSetting];
         [photoOutput capturePhotoWithSettings:photoSetting delegate:self];
         */
        
        //Capturing Photos in RAW Format
        /*
         NSNumber *availableRawFormat = photoOutput.availableRawPhotoPixelFormatTypes.firstObject;
         if (!availableRawFormat) return;
         AVCapturePhotoSettings *photoSetting = [AVCapturePhotoSettings photoSettingsWithRawPixelFormatType:[availableRawFormat intValue] processedFormat:@{AVVideoCodecKey:AVVideoCodecTypeHEVC}];
         photoSetting.autoStillImageStabilizationEnabled = false;
         [photoOutput capturePhotoWithSettings:photoSetting delegate:self];
         */

    }else {
         
        NSURL *url = [NSURL fileURLWithPath:[NSHomeDirectory() stringByAppendingPathComponent:@"zhangxu.mov"]];
        NSLog(@"url %@",url);
        AVCaptureMovieFileOutput *movieFileOutput = (AVCaptureMovieFileOutput *)_cameraManager.captureOutput;
        if (!movieFileOutput.isRecording) {
            [movieFileOutput startRecordingToOutputFileURL:url recordingDelegate:self];
        }else {
            [movieFileOutput stopRecording];
        }
    }
}

#pragma mark -- AVCapturePhotoCaptureDelegate

/// Get Resolved Capture Settings
- (void)captureOutput:(AVCapturePhotoOutput *)output willBeginCaptureForResolvedSettings:(AVCaptureResolvedPhotoSettings *)resolvedSettings {
    
}

///Handle Exposure Start
- (void)captureOutput:(AVCapturePhotoOutput *)output willCapturePhotoForResolvedSettings:(AVCaptureResolvedPhotoSettings *)resolvedSettings {
    
}
///Handle Exposure End
- (void)captureOutput:(AVCapturePhotoOutput *)output didCapturePhotoForResolvedSettings:(AVCaptureResolvedPhotoSettings *)resolvedSettings {
    
}

///Handle Photo Results
- (void)captureOutput:(AVCapturePhotoOutput *)output didFinishProcessingPhoto:(AVCapturePhoto *)photo error:(nullable NSError *)error {
    // Resolving Photo Capture Requests
    NSLog(@"resolvedSettings %@",photo.resolvedSettings);
    NSLog(@"photoCount %d",photo.photoCount);
    CMTimeShow(photo.timestamp);
    
    //Accessing Photo Pixel Data
    NSLog(@"rawPhoto %d",photo.rawPhoto);
    NSLog(@"pixelBuffer %@",photo.pixelBuffer);
    
    //Accessing Preview Photo Data
    NSLog(@"embeddedThumbnailPhotoFormat %@",photo.embeddedThumbnailPhotoFormat);
    NSLog(@"previewPixelBuffer %@",photo.previewPixelBuffer);
    
    //Accessing Photo Metadata
    NSLog(@"depthData %d",photo.depthData);
    NSLog(@"cameraCalibrationData %@",photo.cameraCalibrationData);
    NSLog(@"sourceDeviceType %@",photo.sourceDeviceType);
    NSLog(@"metadata %@",photo.metadata);
    NSLog(@"portraitEffectsMatte %@",photo.portraitEffectsMatte);
    
    //Packaging Data for File Output
    NSLog(@"fileDataRepresentation %@",photo.fileDataRepresentation);
    NSLog(@"CGImageRepresentation %@",photo.CGImageRepresentation);
    NSLog(@"previewCGImageRepresentation %@",photo.previewCGImageRepresentation);
    
    //Examining Bracketed Capture Information
    NSLog(@"bracketSettings %@", photo.bracketSettings);
    NSLog(@"sequencesCount %d", photo.sequenceCount);
    NSLog(@"lensStabilizationStatus %d", photo.lensStabilizationStatus);
    
    //Saving Captured Photos
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status != PHAuthorizationStatusAuthorized) return;
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            PHAssetCreationRequest *creationRequest = [PHAssetCreationRequest creationRequestForAsset];
            [creationRequest addResourceWithType:PHAssetResourceTypePhoto data:photo.fileDataRepresentation options:nil];
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            
        }];
    }];
    
}

#pragma mark -- AVCaptureFileOutputRecordingDelegate
 
- (void)captureOutput:(AVCaptureFileOutput *)output didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray<AVCaptureConnection *> *)connections error:(nullable NSError *)error {
    
    NSLog(@"outputFileURL %@",outputFileURL);
    //Saving Captured Photos
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status != PHAuthorizationStatusAuthorized) return;
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            PHAssetCreationRequest *creationRequest = [PHAssetCreationRequest creationRequestForAsset];
            [creationRequest addResourceWithType:PHAssetResourceTypeVideo fileURL:outputFileURL options:nil];
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
        }];
    }];
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
