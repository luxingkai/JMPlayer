//
//  VPCameraManager.m
//  VideoProcess
//
//  Created by tigerfly on 2020/5/26.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "VPCameraManager.h"

@implementation VPCameraManager {
    
    //    AVCaptureDevice *_captureDevice;
}

+ (instancetype)cameraManager {
    
    VPCameraManager *manager = [[VPCameraManager alloc] init];
    return manager;
}

- (instancetype)init {
    if (self = [super init]) {
        
        // Verifying Authorization
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
    }
    return self;
}

- (void)setupCaptureSession {
    
    self.captureSession = [[AVCaptureSession alloc] init];
    
    
    // Configuration Change
    [self.captureSession beginConfiguration];
    
    
    // Managing Inputs and Outputs
    NSError *error = nil;
    self.captureInput = [AVCaptureDeviceInput deviceInputWithDevice:[self chooseCaptureDevice] error:&error];
    if (error) {
        NSLog(@"deviceInput initial error: %@",error.description);
        return;
    }
    if ([self.captureSession canAddInput:self.captureInput]) {
        [self.captureSession addInput:self.captureInput];
    }
//    self.captureSession.unifiedAutoExposureDefaultsEnabled = true;
//    self.captureSession.videoMinFrameDurationOverride = CMTimeMake(1, 60);
    
    self.captureOutput = [[AVCaptureStillImageOutput alloc] init];
    if ([self.captureSession canAddOutput:self.captureOutput]) {
        [self.captureSession addOutput:self.captureOutput];
    }
    
    
    // Managing Session Presets
    if ([self.captureSession canSetSessionPreset:AVCaptureSessionPresetHigh]) {
        self.captureSession.sessionPreset = AVCaptureSessionPresetHigh;
    }
    
    
    // Managing Connections
    AVCaptureConnection *captureConnection = [AVCaptureConnection connectionWithInputPorts:self.captureInput.ports output:self.captureOutput];
    if ([self.captureSession canAddConnection:captureConnection]) {
        [self.captureSession addConnection:captureConnection];
    }
    
    
    //Sharing the Application's Audio Session
    self.captureSession.usesApplicationAudioSession = true;
    self.captureSession.automaticallyConfiguresApplicationAudioSession = true;
    
    
    //Synchronizing Multiple Inputs and Outputs
    NSLog(@"%@",self.captureSession.masterClock);
    
    
    //Managing Color Spaces
    if (@available(iOS 10.0, *)) {
        self.captureSession.automaticallyConfiguresCaptureDeviceForWideColor = true;
    } else {
        // Fallback on earlier versions
    }
    
    
    [self.captureSession commitConfiguration];
    
}

#pragma mrak -- Managing Running State

- (void)startRunning {
    if (![self.captureSession isRunning]) {
        [self.captureSession startRunning];
    }
}

- (void)stopRunning {
    if ([self.captureSession isRunning]) {
        [self.captureSession stopRunning];
    }
}

#pragma mark -- Capture Device

- (AVCaptureDevice *)chooseCaptureDevice {
    
    // Discovering Devices
    if (@available(iOS 10.0, *)) {
        AVCaptureDeviceDiscoverySession *discoverySession = [AVCaptureDeviceDiscoverySession discoverySessionWithDeviceTypes:@[AVCaptureDeviceTypeBuiltInMicrophone,AVCaptureDeviceTypeBuiltInWideAngleCamera,AVCaptureDeviceTypeBuiltInTelephotoCamera] mediaType:AVMediaTypeVideo position:AVCaptureDevicePositionBack];
        for (AVCaptureDevice *device in discoverySession.devices) {
            NSLog(@"device %@",device.deviceType);
        }
    } else {
        // Fallback on earlier versions
        NSArray *devices = [AVCaptureDevice devices];
        for (AVCaptureDevice *device in devices) {
            NSLog(@"device %@",device.localizedName);
        }
    }
    
    AVCaptureDevice *captureDevice = nil;
    if (@available(iOS 10.0, *)) {
        captureDevice = [AVCaptureDevice defaultDeviceWithDeviceType:AVCaptureDeviceTypeBuiltInWideAngleCamera mediaType:AVMediaTypeVideo position:AVCaptureDevicePositionBack];
    } else {
        // Fallback on earlier versions
        captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceWasConnectNotification:) name:AVCaptureDeviceWasConnectedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceWasDisconnectedNotification:) name:AVCaptureDeviceWasDisconnectedNotification object:nil];
    
    
    //Configuring the Device
    NSError *lockError = nil;
    [captureDevice lockForConfiguration:&lockError];
    if (lockError) {
        NSLog(@"lockError %@",lockError.description);
    }
    [captureDevice unlockForConfiguration];
    
    
    //Inspecting Device Characteristics
    NSLog(@"uniqueID %@",captureDevice.uniqueID);
    NSLog(@"modelID %@",captureDevice.modelID);
    NSLog(@"localizedName %@",captureDevice.localizedName);
    NSLog(@"connected %d",captureDevice.connected);
    NSLog(@"virtualDevice %d",captureDevice.virtualDevice);
    NSLog(@"deviceType %d",captureDevice.deviceType);
    NSLog(@"constituentDevices %@",captureDevice.constituentDevices);
    NSLog(@"lensAperture %f",captureDevice.lensAperture);
    NSLog(@"position %d",captureDevice.position);
    BOOL mediaType = [captureDevice hasMediaType:AVMediaTypeVideo];
    NSLog(@"mediaType %d",mediaType);
    BOOL supportPreset = [captureDevice supportsAVCaptureSessionPreset:AVCaptureSessionPresetHigh];
    NSLog(@"supportPreset %d",supportPreset);
    
    
   // Managing Formats
    NSLog(@"formats %@",captureDevice.formats);
    NSLog(@"activeFormat %@",captureDevice.activeFormat);
    
    
    //Managing Image Exposure
    CMTimeShow(captureDevice.exposureDuration);
//    [captureDevice setExposureModeCustomWithDuration:kCMTimeZero ISO:AVCaptureISOCurrent completionHandler:^(CMTime syncTime) {
//        CMTimeShow(syncTime);
//    }];
    NSLog(@"exposureTargetOffset %f",captureDevice.exposureTargetOffset);
    NSLog(@"exposureTargetBias %f",captureDevice.exposureTargetBias);
    NSLog(@"minExposureTargetBias %f",captureDevice.minExposureTargetBias);
    NSLog(@"maxExposureTargetBias %f",captureDevice.maxExposureTargetBias);
    CMTimeShow(captureDevice.activeMaxExposureDuration);
//    [captureDevice setExposureTargetBias:1.0 completionHandler:^(CMTime syncTime) {
//        CMTimeShow(syncTime);
//    }];
    
    
    // Managing Exposure Setting
    NSLog(@"isAdjustingExposure %d",captureDevice.isAdjustingExposure);
    [captureDevice lockForConfiguration:nil];
    BOOL supportExposureModeLocked = [captureDevice isExposureModeSupported:AVCaptureExposureModeContinuousAutoExposure];
    if (supportExposureModeLocked && captureDevice.adjustingExposure == 0) {
        captureDevice.exposureMode = AVCaptureExposureModeContinuousAutoExposure;
    }
    [captureDevice unlockForConfiguration];
    
    
    //Managing Depth Data Setting
    [captureDevice lockForConfiguration:nil];
//    captureDevice.activeDepthDataFormat = captureDevice.formats.firstObject;
//    captureDevice.activeDepthDataMinFrameDuration = CMTimeMake(1, 60);
    [captureDevice unlockForConfiguration];
    
    
    //Managing Focus Settings
    [captureDevice lockForConfiguration:nil];
    if ([captureDevice isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus]) {
        captureDevice.focusMode = AVCaptureFocusModeContinuousAutoFocus;
    }
    NSLog(@"focusPointOfInterestSupported %d",captureDevice.focusPointOfInterestSupported);
    NSLog(@"adjustingFocus %d",captureDevice.adjustingFocus);
    NSLog(@"adjustingFocus %d",captureDevice.smoothAutoFocusEnabled);
    NSLog(@"adjustingFocus %d",captureDevice.smoothAutoFocusSupported);
    captureDevice.autoFocusRangeRestriction = AVCaptureAutoFocusRangeRestrictionNear;
    NSLog(@"autoFocusRangeRestrictionSupported %d",captureDevice.autoFocusRangeRestrictionSupported);
    [captureDevice unlockForConfiguration];
    
    
    //Managing Flash Setting
    [captureDevice lockForConfiguration:nil];
//    NSLog(@"hasFlash %d",captureDevice.hasFlash);
//    NSLog(@"flashAvailable %d",captureDevice.flashAvailable);
//    if ([captureDevice isFlashModeSupported:AVCaptureFlashModeAuto]) {
//        captureDevice.flashMode = AVCaptureFlashModeAuto;
//    }
    [captureDevice unlockForConfiguration];
    
    
    //Managing Torch Setting
    [captureDevice lockForConfiguration:nil];
//    NSLog(@"hasTorch %d",captureDevice.hasTorch);
//    NSLog(@"torchAvailable %d",captureDevice.torchAvailable);
//    NSLog(@"torchActive %d",captureDevice.torchActive);
//    NSLog(@"torchLevel %f",captureDevice.torchLevel);
//    if ([captureDevice isTorchModeSupported:AVCaptureTorchModeOff]) {
//        captureDevice.torchMode = AVCaptureTorchModeOff;
//    }
//    [captureDevice setTorchModeOnWithLevel:AVCaptureMaxAvailableTorchLevel error:nil];
    [captureDevice unlockForConfiguration];
    
    
    //Managing Low light Setting
    NSLog(@"lowLightBoostSupported %d",captureDevice.lowLightBoostSupported);
    NSLog(@"lowLightBoostEnabled %d",captureDevice.lowLightBoostEnabled);
    NSLog(@"automaticallyEnablesLowLightBoostWhenAvailable %d",captureDevice.automaticallyEnablesLowLightBoostWhenAvailable);
    
    
    //Managing Frame Rate Setting
    //Unsupported frame duration - use -activeFormat.videoSupportedFrameRateRanges to discover valid ranges
    //captureDevice.activeVideoMaxFrameDuration = CMTimeMake(1, 30);
    //captureDevice.activeVideoMinFrameDuration = CMTimeMake(1, 60);
    
    //Managing Transport Controls --- iOS不可用
    //captureDevice.transportControlsSupported
    
    
    //Managing the Lens Position
    [captureDevice lockForConfiguration:nil];
    NSLog(@"lensPosition %f",captureDevice.lensPosition);
//    if ([captureDevice isLockingFocusWithCustomLensPositionSupported]) {
//        [captureDevice setFocusModeLockedWithLensPosition:AVCaptureLensPositionCurrent completionHandler:^(CMTime syncTime) {
//        }];
//    }
    [captureDevice unlockForConfiguration];
    
    
    //Managing the White Balance
//    [captureDevice lockForConfiguration:nil];
//    NSLog(@"adjustingWhiteBalance %d",captureDevice.adjustingWhiteBalance);
//    if ([captureDevice isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeLocked]) {
//        captureDevice.whiteBalanceMode = AVCaptureWhiteBalanceModeLocked;
//    }
//    NSLog(@"deviceWhiteBalanceGains.blueGain %f",captureDevice.deviceWhiteBalanceGains.blueGain);
//    NSLog(@"maxWhiteBalanceGain %f",captureDevice.maxWhiteBalanceGain);
//    NSLog(@"grayWorldDeviceWhiteBalanceGains %f",captureDevice.grayWorldDeviceWhiteBalanceGains);
//    NSLog(@"lockingWhiteBalanceWithCustomDeviceGainsSupported %f",captureDevice.lockingWhiteBalanceWithCustomDeviceGainsSupported);
//    AVCaptureWhiteBalanceGains gains = {1.0,1.0,1.0};
//    [captureDevice chromaticityValuesForDeviceWhiteBalanceGains:gains];
//    AVCaptureWhiteBalanceChromaticityValues values = {1.0, 1.0};
//    [captureDevice deviceWhiteBalanceGainsForChromaticityValues:values];
//    AVCaptureWhiteBalanceTemperatureAndTintValues tintValues = {1.0, 1.0};
//    [captureDevice deviceWhiteBalanceGainsForTemperatureAndTintValues:tintValues];
//    [captureDevice setWhiteBalanceModeLockedWithDeviceWhiteBalanceGains:gains completionHandler:^(CMTime syncTime) {
//    }];
//    [captureDevice temperatureAndTintValuesForDeviceWhiteBalanceGains:gains];
//    [captureDevice unlockForConfiguration];
    
    // Managing the ISO
    NSLog(@"ISO %d",captureDevice.ISO);
    
    // Managing High Dynamic Range Video
    [captureDevice lockForConfiguration:nil];
    captureDevice.automaticallyAdjustsVideoHDREnabled = true;
    NSLog(@"videoHDREnabled %d",captureDevice.videoHDREnabled);
    [captureDevice unlockForConfiguration];
    
    //Managing Color Spaces
    [captureDevice lockForConfiguration:nil];
    captureDevice.activeColorSpace = AVCaptureColorSpace_sRGB;
    [captureDevice unlockForConfiguration];
    
    //Managing Geometric Distortion
    NSLog(@"geometricDistortionCorrectionSupported %d",captureDevice.geometricDistortionCorrectionSupported);
    NSLog(@"geometricDistortionCorrectionEnabled %d",captureDevice.geometricDistortionCorrectionEnabled);
    
    return captureDevice;
}

#pragma mark --

- (void)deviceWasConnectNotification:(NSNotification *)notification {
    if (notification.name == AVCaptureDeviceWasConnectedNotification) {
        NSLog(@"输入设备连接完成");
    }
}

- (void)deviceWasDisconnectedNotification:(NSNotification *)notification {
    if (notification.name == AVCaptureDeviceWasDisconnectedNotification) {
        NSLog(@"输入设备断开连接");
    }
}



@end
