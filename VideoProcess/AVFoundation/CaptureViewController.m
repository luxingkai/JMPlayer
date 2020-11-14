//
//  CaptureViewController.m
//  VideoProcess
//
//  Created by tigerfly on 2020/10/15.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "CaptureViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>
#import <Photos/Photos.h>

@interface CaptureViewController ()<AVCaptureVideoDataOutputSampleBufferDelegate>

@property (nonatomic, strong) AVCaptureSession *captureSession;

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
                    [self setupCaptureSession];
                }
            }];
            
        }
        case AVAuthorizationStatusAuthorized: {
            // The user has previously granted access to the camera
            // setupCaptureSession
            [self setupCaptureSession];
            
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
    
    /*
     AVCaptureSession
     
     An object that manages capture activity and coordinates the flow
     of data from input devices to capture outputs.
     
     To perform real-time capture, you instantiate an AVCaptureSession
     object and add appropriate inputs and outputs. The following code
     fragment illustrates how to configure a capture device to record
     audio.
     
     You invoke startRunning to start the flow of data from the inputs
     to the outputs, and invoke stopRunning to stop the flow.
     
     ⚠️ The startRunning method is a blocking call which can take some
     time, therefore you should perform session setup on a serail queue
     so that the main queue isn't blocked.
     
     You use the sessionPreset property to customize the quality level,
     bitrate, or other settings for the output. Most common capture
     configurations are available through session presets; however,
     some specified options(such as high frame rate) require directly
     setting a capture format on an AVCaptureDevice instance.
     */
    
    /**
     Managing Inputs and Outputs
     */
    //    self.captureSession canAddInput:<#(nonnull AVCaptureInput *)#>
    //    self.captureSession addInput:<#(nonnull AVCaptureInput *)#>
    //    self.captureSession removeInput:<#(nonnull AVCaptureInput *)#>
    //    self.captureSession canAddOutput:<#(nonnull AVCaptureOutput *)#>
    //    self.captureSession addOutput:<#(nonnull AVCaptureOutput *)#>
    //    self.captureSession removeOutput:<#(nonnull AVCaptureOutput *)#>
    
    /**
     Managing Running State
     */
    //    self.captureSession startRunning
    //    self.captureSession stopRunning
    //    self.captureSession.running
    //    self.captureSession.interrupted
    //    AVCaptureSessionRuntimeErrorNotification
    //    AVCaptureSessionDidStartRunningNotification
    //    AVCaptureSessionDidStopRunningNotification
    //    AVCaptureSessionWasInterruptedNotification
    //    AVCaptureSessionErrorKey
    //    AVCaptureSessionInterruptionReasonKey
    //    AVCaptureSessionInterruptionSystemPressureStateKey
    //    AVCaptureSessionInterruptionReason
    
    /**
     Configuration Change
     */
    //    self.captureSession beginConfiguration
    //    self.captureSession commitConfiguration
    
    /**
     Managing Session Presets
     */
    //    self.captureSession.sessionPreset
    //    self.captureSession canSetSessionPreset:<#(nonnull AVCaptureSessionPreset)#>
    
    /**
     Managing Connections
     */
    //    self.captureSession.connections
    //    self.captureSession addConnection:<#(nonnull AVCaptureConnection *)#>
    //    self.captureSession canAddConnection:<#(nonnull AVCaptureConnection *)#>
    //    self.captureSession addInputWithNoConnections:<#(nonnull AVCaptureInput *)#>
    //    self.captureSession addOutputWithNoConnections:<#(nonnull AVCaptureOutput *)#>
    //    self.captureSession removeConnection:<#(nonnull AVCaptureConnection *)#>
    
    /**
     Sharing the Application's Audio Session
     */
    //    self.captureSession.usesApplicationAudioSession
    //    self.captureSession.automaticallyConfiguresApplicationAudioSession
    
    /**
     Synchronizing Multiple Inputs and Outputs
     */
    //    self.captureSession.masterClock
    
    /**
     Managing Color Spaces
     */
    //    self.captureSession automaticallyConfiguresCaptureDeviceForWideColor
    
    
    /*
     AVCaptureMultiCamSession
     
     A capture session that supports simultaneous capture from
     multiple inputs of the same media type.
     
     The session preset for a multicamera session is always
     AVCaptureSessionPresetInputPriority. Set each capture device's
     activeFormat value to the desired quality of service.
     
     You can dynamically enable and disable this session's individual
     camera inputs without interrupting capture preview. To stop
     an individual camera, disable all of its connections or connected
     ports. The camera then stops streaming data to save power and
     bandwidth. Other inputs that are streaming data through the session
     are unaffected.
     
     ⚠️ If your app only needs to capture from a single camera at a
     time, use AVCaptureSession instead.
     */
    
    /**
     Determining Multi-Camera Support
     */
    AVCaptureMultiCamSession *multiCamSession = nil;
    if ([AVCaptureMultiCamSession isMultiCamSupported]) {
        multiCamSession = [[AVCaptureMultiCamSession alloc] init];
    }
    
    /**
     Managing Resources
     */
    //    multiCamSession.hardwareCost
    //    multiCamSession systemPressureCost
    
    
    
#pragma mark -- Capture Devices
    
    /*
     AVCaptureDevice
     
     A device that provides input(such as audio or video) for
     capture sessions and offers controls for hardware-specific
     capture features.
     
     An AVCaptureDevice object represents a physical capture device
     and the properties associated with that device. You use a
     capture device to configure the properties of the underlying
     hardware. A capture device also provides input data (such as
     audio or video) to an AVCaptureSession object.
     
     You use the methods of the AVCaptureDevice class to enumerate
     the available devices, query their capabilities, and be informed
     about when devices come and go. Before you attempt to set
     properties of a capture device(its focus mode, exposure mode,
     and so on), you must first acquire a lock on the device using
     the lockForConfiguration: method. You should also query the device's
     capabilities to ensure that the new modes you intend to set are
     valid for that device. You can then set the properties and
     release the lock using the unlockForConfiguration method. You
     may hold the lock if you want all settable device properties
     to remain unchanged. However, holding the device lock unnecessarily
     may degrade capture quality in other applications sharing the
     device and is not recommended.
     
     Most common configruations of capture settings are available
     through the AVCaptureSession object and its availbale presets.
     However, on iOS devices, some specialized options (such as
     high frame rate) require directly setting a capture format
     on an AVCaptureDevice instance. The following code example
     illustrates how to select an iOS device's highest possible
     frame rate:
     
     ⚠️
     In iOS, directly configuring a capture device’s activeFormat property
     changes the capture session’s preset to AVCaptureSessionPresetInputPriority.
     Upon making this change, the capture session no longer automatically
     configures the capture format when you call the startRunning method
     or call the commitConfiguration method after changing the session topology.
     
     In macOS, a capture session can still automatically configure the
     capture format after you make changes. To prevent automatic changes
     to the capture format in macOS, follow the advice listed under the
     lockForConfiguration: method.
     */
    
    /**
     Discovering Devices
     */
    //    AVCaptureDevice *captureDevice = AVCaptureDevice deviceWithUniqueID:<#(nonnull NSString *)#>
    //    AVCaptureDevice defaultDeviceWithMediaType:<#(nonnull AVMediaType)#>
    //    AVCaptureDevice defaultDeviceWithDeviceType:<#(nonnull AVCaptureDeviceType)#> mediaType:<#(nullable AVMediaType)#> position:<#(AVCaptureDevicePosition)#>
    //    AVCaptureDevicePosition
    //    AVCaptureDeviceType
    //    AVCaptureDeviceDiscoverySession
    //    AVCaptureDeviceWasConnectedNotification
    //    AVCaptureDeviceWasDisconnectedNotification
    AVCaptureDevice *captureDevice = nil;
    
    
    /**
     Verify Authorization
     */
    //    AVCaptureDevice requestAccessForMediaType:<#(nonnull AVMediaType)#> completionHandler:<#^(BOOL granted)handler#>
    //    AVCaptureDevice authorizationStatusForMediaType:<#(nonnull AVMediaType)#>
    //    AVAuthorizationStatus
    
    /**
     Configuring the Device
     */
    //    captureDevice lockForConfiguration:<#(NSError * _Nullable __autoreleasing * _Nullable)#>
    //    captureDevice unlockForConfiguration
    
    /**
     Inspecting Device Characteristics
     */
    //    captureDevice.uniqueID
    //    captureDevice.modelID
    //    captureDevice.localizedName
    //    captureDevice.connected
    //    captureDevice.virtualDevice
    //    captureDevice.deviceType
    //    captureDevice.constituentDevices
    //    captureDevice.lensAperture
    //    captureDevice.position
    //    captureDevice hasMediaType:<#(nonnull AVMediaType)#>
    //    captureDevice supportsAVCaptureSessionPreset:<#(nonnull AVCaptureSessionPreset)#>
    
    /**
     Managing Formats
     */
    //    captureDevice formats
    //    captureDevice.activeFormat
    
    /**
     Managing Image Exposure
     */
    //    captureDevice.exposureDuration
    //    captureDevice setExposureModeCustomWithDuration:<#(CMTime)#> ISO:<#(float)#> completionHandler:<#^(CMTime syncTime)handler#>
    //    captureDevice exposureTargetOffset
    //    captureDevice exposureTargetBias
    //    captureDevice minExposureTargetBias
    //    captureDevice maxExposureTargetBias
    //    captureDevice activeMaxExposureDuration
    //    captureDevice setExposureTargetBias:<#(float)#> completionHandler:<#^(CMTime syncTime)handler#>
    //    AVCaptureExposureTargetBiasCurrent
    //    AVCaptureExposureDurationCurrent
    
    /**
     Manaing Exposure Settings
     */
    //    captureDevice.adjustingExposure
    //    captureDevice.exposureMode
    //    captureDevice isExposureModeSupported:<#(AVCaptureExposureMode)#>
    //    captureDevice.exposurePointOfInterest
    //    captureDevice.exposurePointOfInterestSupported
    //    AVCaptureExposureMode
    
    /**
     Managing Depth Data Settings
     */
    //    captureDevice.activeDepthDataFormat
    //    captureDevice.activeMaxExposureDuration
    
    /**
     Managing Zoom Settings
     */
    //    captureDevice.videoZoomFactor
    //    captureDevice.minAvailableVideoZoomFactor
    //    captureDevice.maxAvailableVideoZoomFactor
    //    captureDevice rampToVideoZoomFactor:<#(CGFloat)#> withRate:<#(float)#>
    //    captureDevice isRampingVideoZoom
    //    captureDevice cancelVideoZoomRamp
    //    captureDevice virtualDeviceSwitchOverVideoZoomFactors
    
    /**
     Managing Focus Settings
     */
    //    captureDevice.focusMode
    //    captureDevice isFocusModeSupported:<#(AVCaptureFocusMode)#>
    //    captureDevice focusPointOfInterest
    //    captureDevice isFocusPointOfInterestSupported
    //    captureDevice isAdjustingFocus
    //    captureDevice isSmoothAutoFocusEnabled
    //    captureDevice isSmoothAutoFocusSupported
    //    captureDevice autoFocusRangeRestriction
    //    captureDevice isAutoFocusRangeRestrictionSupported
    //    AVCaptureFocusMode
    //    AVCaptureAutoFocusRangeRestriction
    
    /**
     Managing Flash Settings
     */
    //    captureDevice.hasFlash
    //    captureDevice.flashAvailable
    //    captureDevice.flashMode
    //    captureDevice isFlashModeSupported:<#(AVCaptureFlashMode)#>
    
    /**
     Managing Torch Settings
     */
    //    captureDevice.hasTorch
    //    captureDevice.torchAvailable
    //    captureDevice.torchActive
    //    captureDevice.torchLevel
    //    captureDevice.torchMode
    //    captureDevice isTorchModeSupported:<#(AVCaptureTorchMode)#>
    //    captureDevice setTorchModeOnWithLevel:<#(float)#> error:<#(NSError * _Nullable __autoreleasing * _Nullable)#>
    //    AVCaptureMaxAvailableTorchLevel
    //    AVCaptureTorchMode
    
    /**
     Managing Low Light Setting
     */
    //    captureDevice.lowLightBoostSupported
    //    captureDevice.lowLightBoostEnabled
    //    captureDevice.automaticallyEnablesLowLightBoostWhenAvailable
    
    /**
     Managing Frame Rate Settings
     */
    //    captureDevice.activeVideoMaxFrameDuration
    //    captureDevice.activeVideoMinFrameDuration
    
    /**
     Monitoring Subject Area Change
     */
    //    captureDevice.subjectAreaChangeMonitoringEnabled
    //    AVCaptureDeviceSubjectAreaDidChangeNotification
    
    /**
     Managing the Lens Position
     */
//    captureDevice.lensPosition
//    captureDevice setFocusModeLockedWithLensPosition:<#(float)#> completionHandler:<#^(CMTime syncTime)handler#>
//    captureDevice lockForConfiguration:<#(NSError * _Nullable __autoreleasing * _Nullable)#>
//    AVCaptureLensPositionCurrent
    
    /**
     Managing the White Balance
     */
//    captureDevice isWhiteBalanceModeSupported:<#(AVCaptureWhiteBalanceMode)#>
//    captureDevice.whiteBalanceMode
//    captureDevice.adjustingWhiteBalance
//    captureDevice chromaticityValuesForDeviceWhiteBalanceGains:<#(AVCaptureWhiteBalanceGains)#>
//    captureDevice.maxWhiteBalanceGain
//    captureDevice deviceWhiteBalanceGainsForChromaticityValues:<#(AVCaptureWhiteBalanceChromaticityValues)#>
//    captureDevice deviceWhiteBalanceGainsForTemperatureAndTintValues:<#(AVCaptureWhiteBalanceTemperatureAndTintValues)#>
//    captureDevice grayWorldDeviceWhiteBalanceGains
//    captureDevice setWhiteBalanceModeLockedWithDeviceWhiteBalanceGains:<#(AVCaptureWhiteBalanceGains)#> completionHandler:<#^(CMTime syncTime)handler#>
//    captureDevice temperatureAndTintValuesForDeviceWhiteBalanceGains:<#(AVCaptureWhiteBalanceGains)#>
//    captureDevice isLockingWhiteBalanceWithCustomDeviceGainsSupported
//    AVCaptureWhiteBalanceGainsCurrent
//    AVCaptureWhiteBalanceChromaticityValues
//    AVCaptureWhiteBalanceTemperatureAndTintValues
//    AVCaptureWhiteBalanceMode
    
    /**
     Managing the ISO
     */
//    captureDevice.ISO
//    AVCaptureISOCurrent
    
    /**
     Managing High Dynamic Range Video
     */
//    captureDevice.automaticallyAdjustsVideoHDREnabled
//    captureDevice.videoHDREnabled
    
    /**
     Managing Color Spaces
     */
//    captureDevice.activeColorSpace
//    AVCaptureColorSpace
    
    /**
     Managing Geometric Distortion
     */
//    captureDevice isGeometricDistortionCorrectionSupported
//    captureDevice.geometricDistortionCorrectionEnabled
    
    /**
     Managing Device Calibration
     */
//    AVCaptureDevice extrinsicMatrixFromDevice:<#(nonnull AVCaptureDevice *)#> toDevice:<#(nonnull AVCaptureDevice *)#>
    
    /**
     Managing System Pressure Changes
     */
//    captureDevice.systemPressureState
//    AVCaptureSystemPressureState
//    AVCaptureSessionInterruptionSystemPressureStateKey
    
    /**
     Managing Tone Mapping
     */
//    captureDevice.globalToneMappingEnabled
    
    
    
    /*
     AVCaptureDeviceInput
     
     A capture input that provides media from a capture device to a
     capture session.
     
     AVCaptureDeviceInput is a concrete subclass of AVCaptureInput
     that you use to capture data from an AVCaptureDevice object.
     */
    
    /**
     Creating an Input
     */
    AVCaptureDeviceInput *deviceInput = nil;
//    [AVCaptureDeviceInput alloc] initWithDevice:<#(nonnull AVCaptureDevice *)#> error:<#(NSError * _Nullable __autoreleasing * _Nullable)#>
//    AVCaptureDeviceInput deviceInputWithDevice:<#(nonnull AVCaptureDevice *)#> error:<#(NSError * _Nullable __autoreleasing * _Nullable)#>
    
    /**
     Accessing the Device
     */
//    deviceInput.device
//    deviceInput portsWithMediaType:<#(nullable AVMediaType)#> sourceDeviceType:<#(nullable AVCaptureDeviceType)#> sourceDevicePosition:<#(AVCaptureDevicePosition)#>
    
    /**
     Setting Input Device Properties
     */
//    deviceInput.unifiedAutoExposureDefaultsEnabled
//    deviceInput videoMinFrameDurationOverride
    
    
#pragma mark -- Photo Capture
    
    /*
     Capturing Still and Live Photos
     
     Configure and capture single or multiple still images, Live Photos,
     and other forms of photography.
     
     Video captured on the iPhone 8, iPhone8 Plus, and iPhone X running
     iOS11 or later uses the HEVC codec by default. If your app shares
     the captured video using a system share sheet, the video will be
     automatically converted to a format compatible with the destination
     device.
     
     AVFoundation supports many ways to capture photos. You can simply
     capture still HEIF or JPEG images, capture in RAW format for custom
     processing, snap several images in one shot, create Live Photos with
     motion and sound, and much more. In iOS, all photography workflows
     use the AVCapturePhotoOutput class.
     */
    
    /**
     Prepare for Photo Capture
     
     First, set up an AVCaptureSession containign a supported camera
     device as one of its inputs and an AVCapturePhotoOutput as one of
     its outputs. Each camera device supports a wide range of resolution
     and frame rate settings. To easily get the best photo quality for
     the user's device, you can use the AVCaptureSessionPresetPhoto
     session preset instead of directly choosing individual settings.
     
     Some capture options affect the internal configuration of the media
     captrue pipeline. Because changing those options causes the pipeline
     to reconfigure itself, which takes time, enable them before offering
     the user the ability to shoot photos with those those settings.
     Otherwise, the configuration delay could prevent the user from
     capturing a photo at the right moment.
     
     For example, to configure the capture pipeline to support Live
     Photos, enable that property on the photo output, as shown below.
     After you're enabld Live Photo capture, you can choose for each
     individual shot whether to use still or Live Photo capture for
     each shot.
     */
    
    /**
     Choose Settings
     
     To capture a photo, first create an AVCapturePhotoSettings object
     describing the settings you want to use for that shot and the
     data format for the resulting still photo. For example:
     
     •  On supported devices, you can use the HEIF/HEVC format for
        improved image quality at samller file sizes: use
        photoSettingWithFormat: and choose AVVideoCodecTypeHEVC for
        the video codec. On devices without HEVC support, use the
        default initializer init to fall back to JPEG format.
     •  To shoot in RAW format, use photoSettingsWithRawPixelFormatType:
        with one of the availableRawPhotoPixelFormatTypes supported
        by the photo output.
     
     After creating a photo settings object, you can choose other settings
     for the photo. For example, the code below creates a settings
     object for HEIF/HEVC shooting, with automatic flash and image
     stabilization.
     
     Other possible photo settings include Live Photos, depth data capture,
     and multi-image capture, as well as options for embedding preview
     or thumbnail images in output images files.
     */
    
    /**
     Capture the Photo
     
     Pass your photo settings object to the capturePhotoWithSettings:delegate:
     method to trigger photo capture with the settings you're chosen.
     
     ⚠️ Calling capturePhotoWithSettings:delegate: is analogous to pressing
     a camera's shutter button - each call starts a new photo capture.
     Each call requires a unique AVCapturePhotoSetting object with the
     settings for that capture. To reuse settings for multiple captures,
     see photoSettingsFromPhotoSettings:
     */
    
    /**
     Handle Capture Results
     
     The delegate you pass to the capturePhotoWithSettings:delegate: method
     is an object to track the progress of and handle results from that
     photo capture. Capturing a photo is an asynchronous process with
     multiple steps that unfold over time. Because your app can trigger
     additional captures while earlier captures are still processing,
     your delegate implementation should be able to handle multiple
     captures at once. An easy way to handle concurrent captures is to
     define a class adopting the AVCapturePhotoCaptureDelegate protocol
     and create a seperate instance of that class for each capture:
     
     When your captured image data is ready for use, the photo output
     calls your delegate's captureOutput:didFinishProcessingPhoto:error:
     method. You can use the resulting AVCapturePhoto object there to
     display, process or save the image.
     */
    
    
    /**
     Saving Captured Photos
     
     Add the image and other data from a photo capture to the Photos
     library.
     
     When you complete a photo capture with AVCapturePhotoOutput,
     you receive an AVCapturePhoto object that contains not only
     the still image data, but also camera metadata and any auxiliary
     images you requested in the capture (like thumbnails or depth
     maps). You can retrieve these types of data individually from
     the AVCapturePhoto, or simply call its fileDataRepresentation
     method to get a Data object ready for writing to disk. using
     the codec and file format you requested for that photo
     AVCapturePhotoSettings.
     
     Typically, after capturing a photo you'll want to add that
     data to the user's Photos library; you can do so using
     the Photos framework.
     */
    
    /**
     Requeset Permission to Use the Photos Library
     
     Just as iOS protects user privacy by requiring user permission
     to access cameras and microphones, the system also requires
     the user to grant your app access to the Photos library.
     
     1. Configure your info.plist.
     2. Verity or request authorization.
     */
    
    /**
     Use a Creation Request to Add a Photo Asset
     
     The AVCapturePhoto fileDataRepresentation method packages all
     image data, auxiliary image data, and metadata from the photo
     capture into a single data object ready for writing to disk.
     To add that data to the Photos library, use the PHPhotoLibrary
     and PHAssetCreationRequest classes:
     
     ⚠️ A performChanges:completionHandler: block can make multiple
     changes to the Photos library in one atomic update. For example,
     you can add a newly created asset to an album. Or, if you perform
     a bracketed capture, you can accumulate multiple
     didFinishProcessingPhoto results and save them to the Photos
     library together.
     */
    
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
               
                // Add the captured photo's file data as the main resource for the
                // the Photos asset.
//                PHAssetCreationRequest *creationRequest = [PHAssetCreationRequest creationRequestForAsset];
//                [creationRequest addResourceWithType:PHAssetResourceTypePhoto data:photo.fileDataRepresentation() options:nil];
                
            } completionHandler:^(BOOL success, NSError * _Nullable error) {
            }];
        }
    }];
    
    
    
    /*
     AVCapturePhoto
     
     A container for image data collected by a photo capture output.
     
     When you capture photos with AVCapturePhotoOutput class, your delegate
     object receives each resulting image and related data in the form of
     an AVCapturePhoto object. This object is an immutable wrapper from
     which you can retrieve various results of the photo capture.
     
     In addition to the photo image pixel buffer, an AVCapturePhoto object
     can also contain a perview-sized pixel buffer, capture metadata, and,
     on supported devices, depth data and camera calibration data. From
     an AVCapturePhoto object, you can generate data appropriate for writing
     to a file, such as HEVC encoded image data containerized in the HEIC file
     format and including a preview image, depth data and other attachments.
     
     
     */
    
    
        
    
    
    
    
#pragma mark -- Depth Data Capture
    
    
    
#pragma mark -- Movie and Video Capture
    
    
    
#pragma mark -- Audio Capture
    
    
    
#pragma mark -- Metadata Capture
    
    
    
#pragma mark -- Synchronized Capture
    
    
    
#pragma mark -- Media Capture Preview
    
    
    
#pragma mark -- Session Configuration
    
    
    
#pragma mark -- File Output
    
    
    
    
}

- (void)setupCaptureSession {
    
    self.captureSession = [[AVCaptureSession alloc] init];
    
    if ([self.captureSession canSetSessionPreset:AVCaptureSessionPresetHigh]) {
        [self.captureSession setSessionPreset:AVCaptureSessionPresetHigh];
    }
    
    AVCaptureDevice *captureDevice = nil;
    NSError *error = nil;
    if (@available(iOS 10.0, *)) {
        AVCaptureDeviceDiscoverySession *discoverySession = [AVCaptureDeviceDiscoverySession discoverySessionWithDeviceTypes:@[AVCaptureDeviceTypeBuiltInWideAngleCamera] mediaType:AVMediaTypeVideo position:AVCaptureDevicePositionBack];
        captureDevice = discoverySession.devices.firstObject;
    } else {
        // Fallback on earlier versions
        NSArray *captureDevices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
        captureDevice = captureDevices.firstObject;
    }
    
    AVCaptureDeviceInput *captureDeviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:captureDevice error:&error];
    if ([self.captureSession canAddInput:captureDeviceInput]) {
        [self.captureSession addInput:captureDeviceInput];
    }
    
    AVCaptureVideoDataOutput *videoDataOutput = [[AVCaptureVideoDataOutput alloc] init];
    [videoDataOutput setSampleBufferDelegate:self queue:dispatch_get_global_queue(0, 0)];
    if ([self.captureSession canAddOutput:videoDataOutput]) {
        [self.captureSession addOutput:videoDataOutput];
    }
    
    if (!self.captureSession.isRunning) {
        [self.captureSession startRunning];
    }
    
}



#pragma mark -- AVCaptureVideoDataOutputSampleBufferDelegate

- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    
    //Inspecting Sample Buffers
    CMBlockBufferRef blockBufferRef = CMSampleBufferGetDataBuffer(sampleBuffer);
    CMTime decodeTimeStamp = CMSampleBufferGetDecodeTimeStamp(sampleBuffer);
    CMTimeShow(decodeTimeStamp);
    CMTimeShow(CMSampleBufferGetDuration(sampleBuffer));
    CMSampleBufferGetFormatDescription(sampleBuffer);
    
    CVImageBufferRef imageBufferRef = CMSampleBufferGetImageBuffer(sampleBuffer);
    CMItemCount itemCount = CMSampleBufferGetNumSamples(sampleBuffer);
    NSLog(@"itemCount %d",itemCount);
    CMTime outputDecodeTimeStamp = CMSampleBufferGetOutputDecodeTimeStamp(sampleBuffer);
    CMTimeShow(outputDecodeTimeStamp);
    CMTime duration = CMSampleBufferGetOutputDuration(sampleBuffer);
    CMTimeShow(duration);
    CMTime outputPresentationTimeStamp = CMSampleBufferGetOutputPresentationTimeStamp(sampleBuffer);
    CMTimeShow(outputPresentationTimeStamp);
    //    CMSampleBufferGetOutputSampleTimingInfoArray(sampleBuffer, itemCount, <#CMSampleTimingInfo * _Nullable timingArrayOut#>, <#CMItemCount * _Nullable timingArrayEntriesNeededOut#>)
    size_t totalSampleSize = CMSampleBufferGetTotalSampleSize(sampleBuffer);
    NSLog(@"totalSampleSize %d",totalSampleSize);
    OSStatus statusOut = 0;
    CMSampleBufferHasDataFailed(sampleBuffer, &statusOut);
    NSLog(@"%d",CMSampleBufferDataIsReady(sampleBuffer));
    NSLog(@"%d",CMSampleBufferIsValid(sampleBuffer));
    NSLog(@"%d",CMSampleBufferGetTypeID());
    
    
    // Modifying Sample Buffers
    //    CMSampleBufferCallBlockForEachSample(sampleBuffer, <#CF_NOESCAPE OSStatus (^handler)(CMSampleBufferRef _Nonnull, CMItemCount)#>)
    OSStatus setDataFailed = CMSampleBufferSetDataFailed(sampleBuffer, 1);
    NSLog(@"%d", setDataFailed);
    CMSampleBufferSetInvalidateHandler(sampleBuffer, ^(CMSampleBufferRef  _Nonnull sbuf) {
    });
    //    CMSampleBufferCallForEachSample(sampleBuffer, <#CF_NOESCAPE OSStatus (*callback)(CMSampleBufferRef _Nonnull, CMItemCount, void * _Nullable)#>, <#void * _Nullable refcon#>)
    //    CMSampleBufferCopySampleBufferForRange(<#CFAllocatorRef  _Nullable allocator#>, <#CMSampleBufferRef  _Nonnull sbuf#>, <#CFRange sampleRange#>, <#CMSampleBufferRef  _Nullable * _Nonnull sampleBufferOut#>)
    CMSampleBufferInvalidate(sampleBuffer);
    CMSampleBufferMakeDataReady(sampleBuffer);
    CMSampleBufferSetDataBuffer(sampleBuffer, blockBufferRef);
    CMSampleBufferSetDataReady(sampleBuffer);
    //    CMSampleBufferSetInvalidateHandler(<#CMSampleBufferRef  _Nonnull sbuf#>, <#^(CMSampleBufferRef  _Nonnull sbuf)invalidateHandler#>)
    //    CMSampleBufferSetOutputPresentationTimeStamp(<#CMSampleBufferRef  _Nonnull sbuf#>, <#CMTime outputPresentationTimeStamp#>)
    //    CMSampleBufferTrackDataReadiness(<#CMSampleBufferRef  _Nonnull sbuf#>, <#CMSampleBufferRef  _Nonnull sampleBufferToTrack#>)
    
    
    
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

