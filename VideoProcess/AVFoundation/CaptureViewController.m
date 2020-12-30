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
     
     An AVCapturePhoto instance wraps a single image result. For example,
     if you request a bracketed capture of three images, your callback is
     called three times, each time delivering a single AVCapturePhoto object.
     */
    
    /**
     Resolving Photo Capture Requests
     
     ==resolvedSettings
     The settings object that was used to request this photo capture.
     
     ==photoCount
     The 1-based index of this photo capture relative to other results
     from the same capture request.
     
     ==timestamp
     The time at which the image was captured.
     */
    
    /**
     Accessing Photo Pixel Data
     
     ==rawPhoto
     A Boolean value indicating whether this photo object contains RAW format data.
     
     ==pixelBuffer
     The uncompressed or RAW image sample buffer for the photo, if requested.
     */
    
    /**
     Accessing Preview Photo Data
     
     ==embeddedThumbnailPhotoFormat
     A dictionary describing the data format for a preview-sized image
     accompanying the captured photo.
     
     ==previewPixelBuffer
     The pixel data for a preview-sized version of the photo, if requested.
     */
        
    /**
     Accessing Photo Metadata
     
     ==depthData
     Depth or disparity map data captured with the photo.
     
     ==AVDepthData
     A container for per-pixel distance or disparity information
     captured by compatible camera devices.
     
     ==cameraCalibrationData
     Calibration information for the camera device that captured the photo.
     
     ==AVCameraCalibrationData
     Information about the camera characteristics used to capture
     images and depth data.
     
     ==sourceDeviceType
     The type of device that captured the photo.
     
     ==metadata
     A dictionary of metadata describing the captured image.
     
     ==portraitEffectsMatte
     The portrait effects matte captured with the photo.
     */
    
    /**
     Packaging Data for File Output
     
     - fileDataRepresentationWithCustomizer:
     
     ==AVCapturePhotoFileDataRepresentationCustomizer
     A set of delegate callbacks to be implemented by callers of
     fileDataRepresentationWithCustomizer:.
     
     - fileDataRepresentation
     Generates and returns a flat data representation of the photo
     and its attachments.
     
     - CGImageRepresentation
     Extracts and returns the captured photo's primary image as a
     Core Graphics image object.
     
     - previewCGImageRepresentation
     Extracts and returns the captured photo's preview image as a
     CoreGraphics image object.
     */
    
    /**
     Examining Bracketed Capture Information
     
     ==bracketSettings
     The variations available for bracketed capture settings
     for this photo.
     
     ==sequenceCount
     The 1-based index of this photo in a bracketed capture sequence.
     
     ==lensStabilizationStatus
     Information about the use of lens stabilization during bracketed
     photo capture.
     
     ==AVCaptureLensStabilizationStatus
     Constants that indicate the status of optical image stabilization
     hardware during a bracketed photo capture.
     */
    
    /**
     Accessing Segmentation Mattes
     
     - semanticSegmentationMatteForType:
     Retrieves the semantic segmentation matte associated with this photo.
     */
    
    
    /*
     AVCapturePhotoOutput
     
     A capture output for still image, Live Photo, and other
     photography workflows.

     AVCapturePhotoOutput provides a modern interface for capture
     workflows related to still photography. In addition to basic
     capture of still images, a photo output supports RAW-format
     capture, bracketed capture of multiple images, Live Photos,
     and wide-gamut color. You can output captured photos in a
     variety of formats and codecs, including RAW format DNG files,
     HEVC format HEIF files, and JPEG files.
     
     To capture photos with the AVCapturePhotoOutput class,
     follow these steps:
     1. Create an AVCapturePhotoOutput object. Use its properties
        to determine supported capture settings and to enable certain
        features (for example, whether to capture Live Photos).
     2. Create and configure an AVCapturePhotoSettings object to
        choose features and settings for a specific capture (for
        example, whether to enable image stabilization or flash).
     3. Capture an image by passing your photo settings object to
        the capturePhotoWithSettings:delegate: method along with a
        delegate object implementing the AVCapturePhotoCaptureDelegate
        protocol. The photo capture output then calls your delegate to
        notify you of significant events during the capture process.
     
     Some photo capture settings, such as the flashMode property,
     include options for automatic behavior. For such settings,
     the photo output determines whether to use that feature at
     the moment of capture—you don’t know when requesting a capture
     whether the feature will be enabled when the capture completes.
     When the photo capture output calls your
     AVCapturePhotoCaptureDelegate methods with information about
     the completed or in-progress capture, it also provides an
     AVCaptureResolvedPhotoSettings object that details which
     automatic features have been set for that capture. The resolved
     settings object’s uniqueID property matches the uniqueID
     value of the AVCapturePhotoSettings object you used to
     request capture.
     
     Enabling certain photo features (Live Photo capture and
     high resolution capture) requires a reconfiguration of
     the capture render pipeline. To opt into these features,
     set the highResolutionCaptureEnabled, livePhotoCaptureEnabled,
     and livePhotoAutoTrimmingEnabled properties before calling
     your AVCaptureSession object’s startRunning method. Changing
     any of these properties while the session is running disrupts
     the capture render pipeline: Live Photo captures in progress
     end immediately, unfulfilled photo requests abort, and video
     preview temporarily freezes.
     
     Using a photo capture output adds other requirements to
     your AVCaptureSession object:
     •  A capture session cannot support both Live Photo capture
        and movie file output. If your capture session includes an
        AVCaptureMovieFileOutput object, the livePhotoCaptureSupported
        property becomes NO. (As an alternative, you can use the
        AVCaptureVideoDataOutput class to output video buffers at
        the same resolution as a simultaneous Live Photo capture.)
     •  A capture session cannot contain both an AVCapturePhotoOutput
        object and an AVCaptureStillImageOutput object. The
        AVCapturePhotoOutput class includes all functionality of
        (and deprecates) the AVCaptureStillImageOutput class.
     
     The AVCapturePhotoOutput class implicitly supports wide-gamut
     color photography. If the source AVCaptureDevice object’s
     activeColorSpace value is AVCaptureColorSpace_P3_D65, the
     capture output produces photos with wide color information
     (unless your AVCapturePhotoSettings object specifies an output
     format that does not support wide color).
     */
    
    /**
     Creating a Photo Output
     
     - init
     Initializes a new photo capture output object.
     
     + new
     Creates a new photo capture output object.
     */
    
    /**
     Capturing a Photo
     
     - capturePhotoWithSettings:delegate:
     Initiates a photo capture using the specified settings.
     
     ==AVCapturePhotoSettings
     A specification of the features and settings to use for a
     single photo capture request.
     
     ==AVCapturePhotoBracketSettings
     A specification of the features and settings to use for a
     photo capture request that captures multiple images with
     varied settings.
     
     ==AVCaptureResolvedPhotoSettings
     A description of the features and settings in use for an
     in-progress or complete photo capture request.
     */
    
    /**
     Determining Supported Pixel Formats

     ==availablePhotoPixelFormatTypes
     The pixel formats the capture output supports for photo capture.
     
     ==availableRawPhotoPixelFormatTypes
     The pixel formats the capture output supports for RAW photo capture.
     
     - supportedPhotoPixelFormatTypesForFileType:
     Returns the list of uncompressed pixel formats supported for
     photo data in the specified file type.
     
     - supportedRawPhotoPixelFormatTypesForFileType:
     Returns the list of Bayer RAW pixel formats supported for
     photo data in the specified file type.
     
     + isAppleProRAWPixelFormat:
     Returns a Boolean value that indicates whether the pixel
     format is an Apple ProRAW format.
     
     + isBayerRAWPixelFormat:
     Returns a Boolean value that indicates whether the pixel
     format is a Bayer RAW format.
     */
    
    /**
     Determining Supported Codec Types
     
     ==availablePhotoCodecTypes
     The compression codecs this capture output currently
     supports for photo capture.
     
     - supportedPhotoCodecTypesForFileType:
     Returns the list of photo codecs (such as JPEG or HEVC) supported
     for photo data in the specified file type.
     */
    
    /**
     Determining Supported File Types
     
     ==availablePhotoFileTypes
     The list of file types currently supported for photo capture and output.
     
     ==availableRawPhotoFileTypes
     The list of file types currently supported for RAW format capture and output.
     */
    
    /**
     Determining Available Settings
     
     ==lensStabilizationDuringBracketedCaptureSupported
     A Boolean value indicating whether the capture output
     currently supports lens stabilization during bracketed image capture.
     
     ==maxBracketedCapturePhotoCount
     The maximum number of images that the photo capture output
     can support in a single bracketed capture.
     
     ==supportedFlashModes
     The flash settings this capture output currently supports.
     
     ==autoRedEyeReductionSupported
     A Boolean value indicating whether the capture output supports
     automatic red-eye reduction.
     */
    
    /**
     Monitoring the Visible Scene
     
     ==isFlashScene
     A Boolean value indicating whether the scene currently being
     previewed by the camera warrants use of the flash.
     
     ==photoSettingsForSceneMonitoring
     A photo settings object that controls how the photo output
     detects and handles automatic flash and stabilization modes.
     */
    
    /**
     Configuring High-Resolution Still Capture
     
     ==highResolutionCaptureEnabled
     A Boolean value that specifies whether to configure the
     capture pipeline for high resolution still image capture.
     */
    
    /**
     Configuring Live Photo Capture
     
     ==livePhotoCaptureSupported
     A Boolean value indicating whether the capture output
     currently supports Live Photo capture.
     
     ==livePhotoCaptureEnabled
     A Boolean value that specifies whether to configure the capture
     pipeline for Live Photo capture.
     
     ==livePhotoCaptureSuspended
     A Boolean value that specifies whether to suspend, but not
     disable, Live Photo capture.
     
     ==livePhotoAutoTrimmingEnabled
     A Boolean value that specifies whether to automatically trim Live
     Photo movie captures to avoid excessive movement.
     
     ==availableLivePhotoVideoCodecTypes
     The list of video codecs currently available for capturing Live
     Photos with the photo output.
     */
    
    /**
     Configuring Depth Data Capture
     
     ==depthDataDeliverySupported
     A Boolean value indicating whether the capture output currently
     supports depth data capture.
     
     ==depthDataDeliveryEnabled
     A Boolean value that specifies whether to configure the capture
     pipeline for depth data capture.
     */
    
    /**
     Configuring Portrait Effects Matte Capture
     
     ==portraitEffectsMatteDeliveryEnabled
     A Boolean value indicating whether the capture output will
     generate a portrait effects matte.
     
     ==portraitEffectsMatteDeliverySupported
     A Boolean value indicating whether the capture output currently
     supports delivery of a portrait effects matte.
     
     ==portraitEffectsMatte
     The portrait effects matte captured with the photo.
     */
    
    /**
     Configuring Dual Camera Capture
     
     ==cameraCalibrationDataDeliverySupported
     A Boolean value indicating whether the capture output currently
     supports delivery of camera calibration data.
     
     
     virtualDeviceConstituentPhotoDeliveryEnabled
     virtualDeviceConstituentPhotoDeliverySupported
     virtualDeviceFusionSupported
     */
    
    /**
     Preparing for Resource-Intensive Captures
     
     ==preparedPhotoSettingsArray
     An array of photo settings for which the photo output has
     prepared capture resources.
     
     - setPreparedPhotoSettingsArray:completionHandler:
     Tells the photo capture output to prepare resources for future
     capture requests with the specified settings.
     */
    
    /**
     Getting Segmentation Mattes
     
     ==availableSemanticSegmentationMatteTypes
     An array of semantic segmentation matte types that may be
     captured and delivered along with the primary photo.
     
     ==enabledSemanticSegmentationMatteTypes
     The semantic segmentation matte types that the photo
     render pipeline delivers.
     */

    /**
     Setting the Capture Prioritization
     
     ==maxPhotoQualityPrioritization
     The highest quality the photo output should prepare to deliver
     on a capture-by-capture basis.
     
     ==AVCapturePhotoQualityPrioritization
     Constants that indicate how to prioritize photo quality relative
     to capture speed.
     */
    
    
    /*
     AVCapturePhotoCaptureDelegate
     
     Methods for monitoring progress and receiving results from
     a photo capture output.

     You implement methods in the AVCapturePhotoCaptureDelegate
     protocol to be notified of progress and results when capturing
     photos with the AVCapturePhotoOutput class.
     
     To capture a photo, you pass an object implementing this protocol
     to the capturePhotoWithSettings:delegate: method, along with a
     settings object that describes the capture to be performed. As
     the capture proceeds, the photo output calls several of the methods
     in this protocol on your delegate object, providing information
     about the capture’s progress and delivering the resulting photos.
     
     Which delegate methods the photo output calls depends on the photo
     settings you initiate capture with. All methods in this protocol
     are optional at compile time, but at run time your delegate object
     must respond to certain methods depending on your photo settings:
     
     •  If you request a still photo capture (by specifying image
        formats or file types), your delegate either must implement
        the captureOutput:didFinishProcessingPhoto:error: method, or
        must implement methods listed in Receiving Capture Results
        (Deprecated) corresponding to whether you request capture in
        RAW format, processed format, or both.
     •  If you request Live Photo capture (by setting the
        livePhotoMovieFileURL property to a non-nil value),
        your delegate must implement the
        captureOutput:didFinishProcessingLivePhotoToMovieFileAtURL:
        duration:photoDisplayTime:resolvedSettings:error: method.
     
     The capture output validates these requirements when you call the
     capturePhotoWithSettings:delegate: method. If your delegate does
     not meet these requirements, that method raises an exception.
     
     You must use a unique AVCapturePhotoSettings object for each capture
     request. When the photo output calls your delegate methods, it
     provides an AVCaptureResolvedPhotoSettings object whose uniqueID
     property matches that of the photo settings you requested
     capture with. When making multiple captures, use this unique
     ID to determine which delegate method calls correspond to which requests.
     
     The photo output always calls each method listed in Monitoring
     Capture Progress exactly once for each capture request. For
     methods listed in Receiving Capture Results, you may receive
     a call more than once, or not at all, depending on your photo
     settings. See the description of each method for details.
     */
    
    /**
     Monitoring Capture Progress
     
     - captureOutput:willBeginCaptureForResolvedSettings:
     Notifies the delegate that the capture output has resolved
     settings and will soon begin its capture process.
     
     - captureOutput:willCapturePhotoForResolvedSettings:
     Notifies the delegate that photo capture is about to occur.
     
     - captureOutput:didCapturePhotoForResolvedSettings:
     Notifies the delegate that the photo has been taken.
     
     - captureOutput:didFinishCaptureForResolvedSettings:error:
     Notifies the delegate that the capture process is complete.
     */
    
    /**
     Receiving Capture Results
     
     - captureOutput:didFinishProcessingPhoto:error:
     Provides the delegate with the captured image and associated metadata
     resulting from a photo capture.
     
     - captureOutput:didFinishRecordingLivePhotoMovieForEventualFileAtURL:resolvedSettings:
     Notifies the delegate that the movie content of a Live Photo has finished recording.
     
     - captureOutput:didFinishProcessingLivePhotoToMovieFileAtURL:duration:
     photoDisplayTime:resolvedSettings:error:
     Provides the delegate the movie file URL resulting from a Live Photo capture.
     */
    
    
#pragma mark -- Depth Data Capture
    
    /*
     Capturing Photos with Depth
     
     Get a depth map with a photo to create effects like the system
     camera’s Portrait mode (on compatible devices).

     On iOS devices with a back-facing dual camera or a front-facing
     TrueDepth camera, the capture system can record depth
     information. A depth map is like an image; however, instead
     of each pixel providing a color, it indicates distance from
     the camera to that part of the image (either in absolute terms,
     or relative to other pixels in the depth map).
     
     You can use a depth map together with a photo to create
     image-processing effects that treat foreground and background
     elements of a photo differently, like the Portrait mode in
     the iOS Camera app. By saving color and depth data separately,
     you can even apply and change these effects long after a
     photo has been captured.
     
     You can add depth capture to many of the other photography
     workflows covered in Capturing Still and Live Photos by
     adding the following steps.
     */
    
    /**
     Prepare for Depth Photo Capture

     To capture depth maps, you’ll need to first select a
     AVCaptureDeviceTypeBuiltInDualCamera or
     AVCaptureDeviceTypeBuiltInTrueDepthCamera capture device
     as your session’s video input. Even if an iOS device has
     a dual camera or TrueDepth camera, selecting the default
     back- or front-facing camera does not enable depth capture.
     
     Capturing depth also requires an internal reconfiguration
     of the capture pipeline, briefly delaying capture and
     interrupting any in-progress captures. Before shooting
     your first depth photo, make sure you configure the pipeline
     appropriately by enabling depth capture on your
     AVCapturePhotoOutput object.
     
     
     // Select a depth-capable capture device.
     guard let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera,
         for: .video, position: .unspecified)
         else { fatalError("No dual camera.") }
     guard let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice),
         self.captureSession.canAddInput(videoDeviceInput)
         else { fatalError("Can't add video input.") }
     self.captureSession.beginConfiguration()
     self.captureSession.addInput(videoDeviceInput)

     // Set up photo output for depth data capture.
     let photoOutput = AVCapturePhotoOutput()
     photoOutput.isDepthDataDeliveryEnabled = photoOutput.isDepthDataDeliverySupported
     guard self.captureSession.canAddOutput(photoOutput)
         else { fatalError("Can't add photo output.") }
     self.captureSession.addOutput(photoOutput)
     self.captureSession.sessionPreset = .photo
     self.captureSession.commitConfiguration()
     
     ⚠️ Enabling depth capture on a dual camera locks the zoom
        factor of both the wide and telephoto cameras.
     */
    
    /**
     Choose Settings

     Once your photo output is ready for depth capture, you can
     request that any individual photos capture a depth map along
     with the color image. Create an AVCapturePhotoSettings object,
     choosing the format for the color image. Then, enable depth
     capture and depth output (and any other settings you’d like
     for that photo) and call the capturePhotoWithSettings:delegate:
     method.
     
     let photoSettings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.hevc])
     photoSettings.isDepthDataDeliveryEnabled = photoOutput.isDepthDataDeliverySupported

     // Shoot the photo, using a custom class to handle capture delegate callbacks.
     let captureProcessor = PhotoCaptureProcessor()
     photoOutput.capturePhoto(with: photoSettings, delegate: captureProcessor)
     */
    
    /**
     Handle Results

     After a capture, the photo output calls your delegate’s
     captureOutput:didFinishProcessingPhoto:error: method,
     providing the photo and captured depth data as an
     AVCapturePhoto object.
     
     If you plan to use the captured depth data immediately—for
     example, to display a preview of a depth-based image processing
     effect—you can find it in the photo object’s depthData property.
     
     Otherwise, the capture output embeds depth data and depth-related
     metadata when you use the fileDataRepresentation method to
     produce file data for saving the photo. If you add the resulting
     file to the Photos library, other apps (including the system
     Photos app) automatically recognize the depth data within and
     can apply depth-based image processing effects. (If you need
     to disable this option, see the embedsDepthDataInPhoto setting).
     */
    
    /**
     About Disparity, Depth, and Accuracy

     When you enable depth capture with the back-facing dual
     camera on compatible devices (see iOS Device Compatibility
     Reference), the system captures imagery using both cameras.
     Because the two parallel cameras are a small distance apart
     on the back of the device, similar features found in both
     images show a parallax shift: objects that are closer to the
     camera shift by a greater distance between the two images. The
     capture system uses this difference, or disparity, to infer the
     relative distances from the camera to objects in the image,
     as shown below.
     
     Each point in a depth map captured by a dual camera device
     measures disparity in units of 1/meters, and offers
     AVDepthDataAccuracyRelative accuracy. That is, an individual
     point isn’t a good estimate of real-world distance, but the
     variation between points is consistent enough to use for
     depth-based image processing effects.
     
     The TrueDepth camera projects an infrared light pattern in
     front of the camera and images that pattern with an infrared
     camera. By observing how the pattern is distorted by objects
     in the scene, the capture system can calculate the distance
     from the camera to each point in the image.
     
     The TrueDepth camera produces disparity maps by default so
     that the resulting depth data is similar to that produced
     by a dual camera device. However, unlike a dual camera device,
     the TrueDepth camera can directly measure depth (in meters)
     with AVDepthDataAccuracyAbsolute accuracy. To capture depth
     instead of disparity, set the activeDepthDataFormat of the
     capture device before starting your capture session:
     
     // Select a depth (not disparity) format that works with the active color format.
     let availableFormats = captureDevice.activeFormat.supportedDepthDataFormats

     let depthFormat = availableFormats.filter { format in
         let pixelFormatType =
             CMFormatDescriptionGetMediaSubType(format.formatDescription)
         
         return (pixelFormatType == kCVPixelFormatType_DepthFloat16 ||
                 pixelFormatType == kCVPixelFormatType_DepthFloat32)
     }.first

     // Set the capture device to use that depth format.
     captureSession.beginConfiguration()
     captureDevice.activeDepthDataFormat = depthFormat
     captureSession.commitConfiguration()
     */
    
    
    /*
     AVCaptureDepthDataOutput
     
     A capture output that records scene depth information on compatible
     camera devices.
     
     This out captures AVDepthData objects containing per-pixel depth or
     disparity information, following a streaming delivery model similar
     to that used by AVCaptureVideoDataOutput. Alternatively, you can
     capture depth data alongside photos using AVCapturePhotoOutput
     (see the AVCapturePhotoSettings depthDataDeliveryEnabled property).
     
     A depth data output always provides depth data in the format
     expressed by the source AVCaptureDevice object’s activeDepthDataFormat
     property. If you wish to receive depth data in another format,
     choose a new value for that property from those listed in the
     supportedDepthDataFormats array of the device's activeFormat object.
     */
    
    /**
     Creating a Depth Data Output
     
     - init
     Initializes a depth data output object.
     
     + new
     Creates a depth data output object.
     */
    
    /**
     Configuring Depth Data Capture
     
     ==alwaysDiscardsLateDepthData
     A Boolean value that determines whether the capture output should
     discard any depth data that is not processed before the next
     depth data is captured.
     
     ==filteringEnabled
     A Boolean value that determines whether the depth data output
     should filter depth data to smooth out noise and fill invalid values.
     */
    
    /**
     Receiving Captured Depth Data
     
     - setDelegate:callbackQueue:
     Designates a delegate object to receive depth data and a dispatch
     queue for delivering that data.
     
     ==delegate
     A delegate object that receives depth data.
     
     ==delegateCallbackQueue
     A dispatch queue for delivering depth data.
     
     ==AVCaptureDepthDataOutputDelegate
     Methods for receiving depth data produced by a depth capture output.
     */
    
    
    /*
     AVDepthData
     
     A container for per-pixel distance or disparity information
     captured by compatible camera devices.

     Depth data is a generic term for a map of per-pixel data containing
     depth-related information. A depth data object wraps a disparity or
     depth map and provides conversion methods, focus information, and
     camera calibration data to aid in using the map for rendering or
     computer vision tasks.
     
     A depth map describes at each pixel the distance to an object,
     in meters.
     
     A disparity map describes normalized shift values for use in
     comparing two images. The value for each pixel in the map is
     in units of 1/meters: (pixelShift / (pixelFocalLength * baselineInMeters)).
     
     The capture pipeline generates disparity or depth maps from camera
     images containing nonrectilinear data. Camera lenses have small
     imperfections that cause small distortions in their resultant
     images compared to an ideal pinhole camera model, so AVDepthData
     maps contain nonrectilinear (nondistortion-corrected) data as
     well. The maps' values are warped to match the lens distortion
     characteristics present in the YUV image pixel buffers captured
     at the same time.
     
     Because a depth data map is nonrectilinear, you can use an
     AVDepthData map as a proxy for depth when rendering effects to
     its accompanying image, but not to correlate points in 3D space.
     To use depth data for computer vision tasks, use the data in
     the cameraCalibrationData property to rectify the depth data.
     
     There are two ways to capture depth data:
     •  The AVCaptureDepthDataOutput class captures and delivers depth
        data in a stream (similar to how the AVCaptureVideoDataOutput
        delivers video data).
     •  The AVCapturePhotoOutput class delivers depth data as a property
        of an AVCapturePhoto object containing the captured image.
     
     You can also create AVDepthData objects using information obtained
     from image files with the Image I/O framework.
     
     When editing images containing depth information, use the methods
     listed in Transforming and Processing to generate derivative
     AVDepthData objects reflecting the edits that have been performed.
     */
    
    /**
     Creating Depth Data
     
     + depthDataFromDictionaryRepresentation:error:
     Creates a depth data object from depth information such as that
     found in an image file.
     
     - dictionaryRepresentationForAuxiliaryDataType:
     Returns a dictionary representation of the depth data suitable
     for writing into an image file.
     */
    
    /**
     Reading Pixel Depth Information
     
     depthDataMap
     A pixel buffer containing the depth data's per-pixel depth or
     disparity data map.
     
     depthDataType
     The pixel format of the depth data map.
     */
    
    /**
     Evaluating Depth Data
     
     ==depthDataFiltered
     A Boolean value indicating whether the depth map contains temporally
     smoothed data.
     
     ==depthDataAccuracy
     The general accuracy of depth data map values.
     
     ==AVDepthDataAccuracy
     Values indicating the general accuracy of a depth data map.
     
     ==depthDataQuality
     The overall quality of the depth map.
     
     ==AVDepthDataQuality
     Values indicating the overall quality of a depth data map.
     */
    
    
    /**
     Transforming and Processing
     
     - depthDataByApplyingExifOrientation:
     Returns a derivative depth data object by mirroring or rotating
     it to the specified orientation.
     
     - depthDataByConvertingToDepthDataType:
     Returns a derivative depth data object by converting the depth
     data map to the specified data type.
     
     availableDepthDataTypes
     The list of depth data formats to which this depth data can be converted.
     
     - depthDataByReplacingDepthDataMapWithPixelBuffer:error:
     Returns a derivative depth data object by replacing the depth data map.
     */
    
    /**
     Using Calibration Data
     
     cameraCalibrationData
     The imaging parameters with which this depth data was captured.
     
     AVCameraCalibrationData
     Information about the camera characteristics used to capture
     images and depth data.
     */
    
    
    
#pragma mark -- Movie and Video Capture
    
    
    /*
     Capturing Video in Alternative Formats
     
     Change the format used for capturing movie files.
     
     Video captured on iPhone 8, iPhone 8 Plus, and iPhone X, and
     running iOS 11 or later, uses the HEVC Format by default.
     When you use AVFoundation to capture videos, you can
     change the default format if you know in advance that
     you need a different format.
     
     If your app shares the captured video using a system share
     sheet, the video is automatically converted to a format
     compatible with the destination device, and no more
     work is needed.
     
     However, if your app saves or shares captured video internally,
     for applications outside the system share sheet, you must
     use a video-capture format compatible with all target devices.
     This article shows you how to change the capture format dynamically,
     so that videos captured in your app begin in the desired
     format.
     */
    
    /**
     Change the default Format Used in Capture
     
     Change the default format at capture time by specifying it
     in the output settings for capturing movie files. Each capture
     device has a dictionary of settings that you tweak to control
     properties of the output movie file. For example, to capture
     video in H.264/MPEG-4 AVC, set the output settings key
     AVVideoCodecKey to AVVideoCodecTypeH264:
     =================================================================
     #import <AVFoundation/AVFoundation.h>

     AVCaptureMovieFileOutput* movieFileOutput = // Your AVCaptureMovieFileOutput //;
     AVCaptureConnection* connection = [movieFileOutput connectionWithMediaType:AVMediaTypeVideo];
         
     if ([movieFileOutput.availableVideoCodecTypes containsObject:AVVideoCodecTypeH264]) {
         // Use the H.264 codec to encode the video.
         [movieFileOutput setOutputSettings:@{AVVideoCodecKey: AVVideoCodecTypeH264} forConnection:connection];
     }
     =================================================================

     For a list of supported capture codecs, see AVVideoCodecType and
     the Related Documentation section.
     */
    
    /**
     Convert Previously Captured Movie Files
     
     In addition to saving or sharing captured video using a different
     default format, you can also convert existing movie file content.
     For more information, see Exporting Video to Alternative Formats.
     */
    
    
    /*
     AVCaptureMovieFileOutput
     
     A capture output that records video and audio to a QuickTime movie file.
     
     This class is the movie file equivalent of AVCapturePhotoOutput.
     Use it to export or save movie files from capture session content.
     
     ⚠️ This class supports exporting or saving to QuickTime movie
        (.mov)files only. It doesn't support formats such as MPEG-4
        (.mp4) and others.
     
     The timeMapping.target.start of the first track segment must
     be kCMTimeZero, and the timeMapping.target.start of each subsequent
     track segment must equal CMTimeRangeGetEnd, when passing in the
     previous AVCompositionTrackSegment's timeMapping.target. You can
     use validateTrackSegments:error: to ensure that an array of track
     segments conforms to this rule.
     
     Starting in iOS 12, photo formats no longer list the
     AVCaptureMovieFileOutput.class as being unsupported.
     If you construct a session with a photo format as input and a
     movie file output, you can record movies. The resolution of the
     video track in the movie follows the conventions established by
     the AVCaptureVideoDataOutput; namely, when using the photo preset,
     you receive video buffers with size approximating the screen size.
     Video outputs are a proxy for photo preview in this configuration.
     
     If you set the AVCaptureDevice format to a high-resolution photo
     format, you receive full-resolution (5,8, or 12 MP depending on
     the device) video buffers into your movie. If the capture
     session's automaticallyConfiguresCaptureDeviceForWideColor property
     is YES, the session selects sRGB as the video colorspace in your
     movie. you can override this behavior by adding an
     AVCapturePhotoOutput to your session and configuring its photo
     format or AVCaptureSessionPresetPhoto preset for a photo output.
     */
    
    
    /**
     Initializing Movies
     
     - init
     */
    
    /**
     Configuring Movies
     
     movieFragmentInterval
     The number of seconds of output that are written per fragment.
     
     metadata
     The metadata for the output file.
     */
    
    /**
     Managing Output Settings
     
     - supportedOutputSettingsKeysForConnection:
     The list of supported keys for the output settings dictionary.
     
     - outputSettingsForConnection:
     Returns the options used to reencode media from a given connection
     as it's being recorded.
          
     - setOutputSettings:forConnection:
     Sets the options dictionary used to reencode media from the given
     connection as it's being recorded.
     
     availableVideoCodecTypes
     The video codec types currently supported for recording movie files.
     
     Video Settings
     Define output image and video formats by using the key and
     value constants.
     
     AVVideoCodecType
     A set of constants used to describe codecs for video capture.
     */
    
    /**
     Setting Orientation
     
     - recordsVideoOrientationAndMirroringChangesAsMetadataTrackForConnection:
     A Boolean indicating whether the capture device records video orientation.
     
     - setRecordsVideoOrientationAndMirroringChanges:asMetadataTrackForConnection:
     A Boolean indicating whether the capture device sets video orientation.
     */
    
    
    /*
     AVCaptureVideoDataOutput
     
     A capture output that records video and provides access to video
     frames for processing.
     
     You use this output to process compressed or uncompressed frames
     from the captured video. You can access the frames with the
     captureOutput:didOutputSampleBuffer:fromConnection: delegate method.
     
     ⚠️ AVCaptureVideoDataOutput supports compressed video data output
     for macOS only.
     */
    
    /**
     Configuring Video Capture
     
     videoSettings
     The compression settings for the output.
     
     alwaysDiscardsLateVideoFrames
     Indicates whether to drop video frames if they arrive late.
     
     automaticallyConfiguresOutputBufferDimensions
     A Boolean value that indicates whether the output automatically
     configures the size of output buffers.

     deliversPreviewSizedOutputBuffers
     A Boolean value that indicates whether the output is configured
     to deliver preview-sized buffers.
     
     - recommendedVideoSettingsForVideoCodecType:assetWriterOutputFileType:
     Returns a video settings dictionary appropriate for capturing video
     to be recorded to a file with the specified codec and type.

     - recommendedVideoSettingsForAssetWriterWithOutputFileType:
     Specifies the recommended settings for use with an AVAssetWriterInput.
     */

    
    /**
     Retrieving Supported Video Types
     
     availableVideoCVPixelFormatTypes
     Indicates the supported video pixel formats that can be specified
     in videoSettings.
     
     availableVideoCodecTypes
     Indicates the supported video codec formats that can be specified
     in videoSettings.
     
     - availableVideoCodecTypesForAssetWriterWithOutputFileType:

     AVVideoCodecType
     A set of constants used to describe codecs for video capture.
     */
    
    /**
     Receiving Captured Video Data
     
     - setSampleBufferDelegate:queue:
     Sets the sample buffer delegate and the queue on which callbacks
     should be invoked.
     
     sampleBufferDelegate
     The capture object’s delegate.
     
     sampleBufferCallbackQueue
     The queue on which delegate callbacks should be invoked
     
     AVCaptureVideoDataOutputSampleBufferDelegate
     Methods for receiving sample buffers from and monitoring the
     status of a video data output.
     */
    
    /**
     Creating Video Capture Output
     
     - init
     Creates a new video file output.
     
     + new
     Creates a new video file output.
     */
    
    
    
#pragma mark -- Audio Capture
    
    /*
     AVCaptureAudioFileOutput
     
     A capture output that records audio and saves the recorded
     audio to a file.
     
     AVCaptureAudioFileOutput implements the complete file recording
     interface declared by AVCaptureFileOutput for writing media
     data to audio files. In addition, you can configure options
     specific to the audio file formats, including writing metadata
     collections to each file and specifying audio encoding options,
     AVCaptureAudioFileOutput does not, however, support
     startRecordingToOutputFileURL:recordingDelegate:
     -- use startRecordingToOutputFileURL:outputFileType:recordingDelegate:
     instead.
     */
    
    /**
     Discovering Supported Types
     
     + availableOutputFileTypes
     Returns an array containing UTIs identifying the file types
     AVCaptureAudioFileOutput can write.
     */
    
    /**
     Starting a Recording
     
     - startRecordingToOutputFileURL:outputFileType:recordingDelegate:
     Tells the receiver to start recording to a new file of the specified
     format, and specifies a delegate that will be notified when
     recording is finished.
     */
    
    /**
     Configuring Output
     
     audioSettings
     The settings used to decode or re-encode audio before it is output by
     the receiver.
     
     metadata
     A collection of metadata to be written to the receiver's output files.
     */
    
    /**
     Creating Output
     
     - init
     Creates a new audio file output.
     
     + new
     Creates a new audio file output.
     */
    
    
    /*
     AVCaptureAudioDataOutput
     
     A capture output that records audio and provides access to audio
     sample buffers as they are recorded.
     */
    
    /**
     Creating an audio Capture Output
     
     - init
     + new
     */
    
    /**
     Configuring Audio Capture
     
     audioSettings
     The settings used to decode or re-encode audio before it is output.

     - recommendedAudioSettingsForAssetWriterWithOutputFileType:
     Specifies the recommended settings for use with an AVAssetWriterInput.
     */
    
    /**
     Receiving Captured Audio Data
     
     - setSampleBufferDelegate:queue:
     Sets the delegate that will accept captured buffers and the dispatch
     queue on which the delegate will be called.
     
     sampleBufferDelegate
     The capture object’s delegate.
     
     sampleBufferCallbackQueue
     The queue on which delegate callbacks are invoked
     
     AVCaptureAudioDataOutputSampleBufferDelegate
     Methods for receiving audio sample data from an audio capture.
     */
    
    
    
#pragma mark -- Metadata Capture
    
    /*
     AVMetadataBodyObject
     
     An abstract class that defines the interface for a metadata body
     object.
     
     A metadata body object represents a single detected body in a
     picture. It's the base object used to represent bodies, for
     example AVMetadataHumanBodyObject, AVMetadataDogBodyObject,
     and AVMetadataCatBodyObject.
     */
    
    /**
     Inspecting Metadata
    
     bodyID
     An integer value that defines the unique identifier of an
     object in a picture.
     */
    
    
    /*
     AVMetadataCatBodyObject
     
     An object representing a single detected cat body in a picture.
     
     This object is an immutable type that describles the various features
     found in the cat body in a picture.
     */
    
    
    /*
     AVMetadataDogBodyObject
     
     An object representing a single detected dog body in a picture.
     
     This object is an immutable type that describes the various features
     found in the dog body in a picture.
     */
    
    
    /*
     AVMetadataHumanBodyObject
     
     An object representing a single detected human body in a picture.
     
     This object is an immutable type that describes the various features
     found in the human body in a picture.
    */
    
    
    /*
     AVMetadataSalientObject
     
     An object representing a single salient area in a picture.
     
     This object is an immutable type that describes the various
     features of the salient object in a picture.
     */
    
    /**
     Inspecting Metadata
     
     objectID
     An integer value that defines the unique identifier of an
     object in a picture.
     */
    
    
    /*
     AVCaptureMetadataInput
     
     A capture input for providing timed metadata to a capture
     session.
     
     This class provides input to an AVCaptureSession.
     An instance of AVCaptureMetadataInput can present one and
     only one AVCaptureInputPort connected to an AVCaptureMovieFileOutput.
     Provide metadata through the input port by conforming to
     a CMFormatDescription and supplying AVMetadataItem objects
     in an AVTimedMetadataGroup.
     */
    
    /**
     Creating Metadata Input
     
     - initWithFormatDescription:clock:
     Creates capture metadata input to provide timed groups to a capture session.
     
     + metadataInputWithFormatDescription:clock:
     Returns a metadata input instance that allows clients to provide
     timed metadata groups to a capture session.
     */
    
    /**
     Providing Metadata
     
     - appendTimedMetadataGroup:error:
     Provides metadata to the capture session.
     */
    
    
    /*
     AVCaptureMetadataOutput
     
     A capture output for processing timed metadata produced by a
     capture session.
     
     An AVCaptureMetadataOutput object intercepts metadata objects
     emitted by its associated capture connection and forwards
     them to a delegate object for processing. You can use instances
     of this class to process specific types of metadata included
     with the input data. You use this class the way you do other
     output objects, typically by adding it as an output to an
     AVCaptureSession object.
     */
    
    /**
     Configuring Metadata Capture
     
     availableMetadataObjectTypes
     An array of strings identifying the types of metadata
     objects that can be captured.

     metadataObjectTypes
     An array of strings identifying the types of metadata
     objects to process.
     
     rectOfInterest
     A rectangle of interest for limiting the search area
     for visual metadata.
     */
    
    /**
     Receiving Captured Metadata Objects
     
     - setMetadataObjectsDelegate:queue:
     Sets the delegate and dispatch queue to use handle callbacks.
     
     metadataObjectsDelegate
     The delegate of the capture metadata output object.
     
     metadataObjectsCallbackQueue
     The dispatch queue on which to execute the delegate’s methods.
     
     AVCaptureMetadataOutputObjectsDelegate
     Methods for receiving metadata produced by a metadata capture output.
     */
    
    /**
     Creating Metadata Output
     
     - init
     Creates a new capture metadata output.
     + new
     Creates a new capture metadata output.
     */
    
    
    /*
     AVMetadataFaceObject
     
     Face information detected by a metadata capture output.

     The AVMetadataFaceObject class is a concrete subclass of
     AVMetadataObject that defines the features of a single
     detected face. You can retrieve instances of this class
     from the output of an AVCaptureMetadataOutput object on
     devices that support face detection.
     */
    
    /**
     Getting the Face Identifier
     
     faceID
     The unique ID for this face metadata object.
     */
    
    /**
     Accessing the Face Detection Data
     
     hasRollAngle
     A Boolean value indicating whether there is a valid roll angle
     associated with the face.
     
     rollAngle
     The roll angle of the face specified in degrees.
     
     hasYawAngle
     A Boolean value indicating whether there is a valid yaw angle
     associated with the face.
     
     yawAngle
     The yaw angle of the face specified in degrees.
     */
    
    
    /*
     AVMetadataMachineReadableCodeObject

     Barcode information detected by a metadata capture output.

     The AVMetadataMachineReadableCodeObject class is a concrete
     subclass of AVMetadataObject defining the features of a
     detected one-dimensional or two-dimensional barcode.

     An AVMetadataMachineReadableCodeObject instance represents
     a single detected machine readable code in an image.  It’s
     an immutable object describing the features and payload of
     a barcode.

     On supported platforms, the AVCaptureMetadataOutput class
     outputs arrays of detected machine readable code objects.
     */
    
    /**
     Getting Machine Readable Code Values
     
     corners
     The points defining the (x, y) locations of the corners.
     
     descriptor
     A barcode description for use in Core Image.
     
     stringValue
     Returns the error-corrected data decoded into a
     human-readable string.
     */
    
    /*
     AVMetadataObject
     
     The abstract superclass for objects provided by a metadata
     capture output.

     The AVMetadataObject class is an abstract class that defines
     the basic properties associated with a piece of metadata.
     These attributes reflect information either about the metadata
     itself or the media from which the metadata originated.
     Subclasses are responsible for providing appropriate values
     for each of the relevant properties.

     You shouldn’t subclass AVMetadataObject directly. Instead,
     you use one of the defined subclasses provided by the
     AVFoundation framework. Similarly, you don’t create
     instances of this class yourself but use an
     AVCaptureMetadataOutput object to retrieve them from
     the captured data.
     */
    
    /**
     Getting the Type of Metadata
     
     type
     The type of the metadata.
     
     AVMetadataObjectType
     Values identifying the type of metadata object.
     */
    
    /**
     Getting the Media-Related Attributes
     
     time
     The media time value associated with the metadata object.
     
     duration
     The duration of the media associated with this metadata object.
     
     bounds
     The bounding rectangle associated with the metadata.
     */
    
    
#pragma mark -- Synchronized Capture
    
    /*
     AVCaptureDataOutputSynchronizer
     
     An object that coordinates time-matched delivery of data
     from multiple capture outputs.
     
     Use this class when you need to capture media from multiple
     capture outputs and want to receive all data samples from
     the same timestamp in a single delegate callback.

     For example, when you use an AVCaptureDataOutputSynchronizer
     object to coordinate the output of AVCaptureVideoDataOutput
     and AVCaptureDepthDataOutput objects, you can easily match
     each captured video frame to depth information captured at
     the same moment.
     */
    
    /**
     Configuring Synchronized Capture
     
     - initWithDataOutputs:
     Creates a capture output synchronizer for the specified
     capture outputs.
     
     dataOutputs
     The list of data outputs governed by this data output synchronizer.
     */
    
    /**
     Receiving Synchronized Capture Data
     
     - setDelegate:queue:
     Designates a delegate object to receive synchronized data and
     a dispatch queue for delivering that data.
     
     delegate
     A delegate object that receives synchronized capture data.
     
     delegateCallbackQueue
     A dispatch queue for delivering synchronized capture data.
     
     AVCaptureDataOutputSynchronizerDelegate
     Methods for receiving captured data from multiple capture
     outputs synchronized to the same timestamp.
     */
    
    /*
     AVCaptureSynchronizedDataCollection
     
     A set of data samples collected simultaneously from multiple
     capture outputs.
     */
    
    /**
     Accessing Synchronized Data
     
     count
     The number of synchronized data objects in the collection.
     
     - synchronizedDataForCaptureOutput:
     Returns synchronized data captured by the specified capture output.
     
     - objectForKeyedSubscript:
     Returns data captured by the specified capture output, using
     subscript syntax.
     */
    
    
    /*
     AVCaptureSynchronizedDepthData

     A container for scene depth information collected using
     synchronized capture.
     */
    
    /**
     Accessing Synchronized Data
     
     depthData
     The depth data captured at this synchronization point.
     */
    
    /**
     Handling Dropped Data
     
     depthDataWasDropped
     A Boolean value indicating whether depth data was discarded
     between capture and processing.

     droppedReason
     A value indicating why the capture output failed to deliver
     depth data, if applicable.
     */
    
    
    /*
     AVCaptureSynchronizedMetadataObjectData
     
     A container for metadata objects collected using synchronized
     capture.
     */
    
    /**
     Accessing Synchronized Data
     
     metadataObjects
     The list of metadata objects captured at this synchronization
     timestamp.
     */
    
    
    /*
     AVCaptureSynchronizedSampleBufferData
     
     A container for video or audio samples collected using synchronized
     capture.
     */
    
    /**
     Accessing Synchronized Data
     
     sampleBuffer
     The depth data captured at this synchronization point.
     */
    
    /**
     Handling Dropped Data
     
     sampleBufferWasDropped
     A Boolean value indicating whether sample buffers were
     discarded between capture and processing.
     
     droppedReason
     A value indicating why the capture output failed to
     deliver sample buffers, if applicable.
     */
    
    
    /*
     AVCaptureSynchronizedData
     
     The abstract superclass for media samples collected
     using synchronized capture.
     */
    
    /**
     Correlating Synchronized Data
     
     timestamp
     The time at which this synchronized data was captured.
     */
    
    
#pragma mark -- Media Capture Preview
    
    /*
     AVCaptureVideoPreviewLayer
     
     A Core Animation layer that displays the video as it's captured.
     
     AVCaptureVideoPreviewLayer is a subclass of CALayer that you
     use to display video as it's captured by an input device.
     
     You use this preview layer in conjunction with a capture
     session, as shown in the following code fragment.
     
     ==========================================================
     // Create a preview layer.
     let previewLayer = AVCaptureVideoPreviewLayer()

     // Connect the preview layer with the capturing session.
     previewLayer.session = captureSession

     // Add the preview layer into the view's layer hierarchy.
     view.layer.addSublayer(previewLayer)
     ==========================================================
     */
    
    /**
     Creating a Preview Layer
     
     + layerWithSession:
     Returns a preview layer initialized with a given capture session.
     
     - initWithSession:
     Initializes a preview layer with a given capture session.
     
     - initWithSessionWithNoConnection:
     Initializes a preview layer using a given capture session but
     without making any connections.
     
     + layerWithSessionWithNoConnection:
     Returns a preview layer using a given capture session but without
     making any connections.
     */
    
    /**
     Layer Configuration
     
     videoGravity
     Indicates how the layer displays the video content within its bounds.
     
     previewing
     A Boolean value that indicates whether the layer is rendering
     video frames from its source.
     */
    
    /**
     Session Configuration
     
     session
     The previewed capture session.
     
     connection
     The capture connection describing the AVCaptureInputPort to which
     the preview layer is connected.
     
     - setSessionWithNoConnection:
     Attaches the layer to a given session without implicitly forming a connection.
     */
    
    /**
     Converting Between Coordinate Systems
     
     - captureDevicePointOfInterestForPoint:
     Converts a point from layer coordinates to the coordinate space of
     the capture device.
     
     - pointForCaptureDevicePointOfInterest:
     Converts a point from the coordinate space of the capture device
     to the coordinate space of the layer.
     
     - rectForMetadataOutputRectOfInterest:
     Converts a rectangle in the coordinate system used for metadata outputs
     to one in the preview layer’s coordinate system.
     
     - metadataOutputRectOfInterestForRect:
     Converts a rectangle in the preview layer’s coordinate system to one
     in the coordinate system used for metadata outputs.
     
     - transformedMetadataObjectForMetadataObject:
     Converts a metadata object’s visual properties to layer coordinates.
     */
    
    
    /*
     AVCaptureAudioPreviewOutput
     
     A capture output that provides preview playback for audio being
     recorded in a capture session.

     Instances of AVCaptureAudioPreviewOutput are associated with a
     Core Audio output device that can be used to play audio being
     captured by the capture session. You can obtain the unique ID
     of a Core Audio device using its kAudioDevicePropertyDeviceUID
     property.
     */
    
    /**
     Configuring Preview Output

     outputDeviceUniqueID
     Indicates the unique ID of the Core Audio output device being
     used to play preview audio.
     
     volume
     Indicates the preview volume of the output.
     */
    
    /**
     Creating Preview Output
     
     - init
     Creates a new audio preview output.
     + new
     Creates a new audio preview output.
     */
    
    
#pragma mark -- Session Configuration
    
    /*
     AVCaptureInput
     
     The abstract superclass for objects that provide input
     data to a capture session.

     To associate an AVCaptureInput object with a session,
     call addInput: on the session.

     AVCaptureInput objects have one or more ports (instances
     of AVCaptureInputPort), one for each data stream they can
     produce. For example, an AVCaptureDevice object presenting
     one video data stream has one port.
     */
    
    /**
     Accessing Ports
     
     AVCaptureInputPort
     A specific stream of data provided by a capture input.
     
     ports
     The capture input’s ports.
     */
    
    /*
     AVCaptureOutput
     
     The abstract superclass for objects that output the media
     recorded in a capture session.

     AVCaptureOutput is an abstract base class describing an
     output destination of an AVCaptureSession object.

     AVCaptureOutput provides an abstract interface for connecting
     capture output destinations, such as files and video previews,
     to a capture session (an instance of AVCaptureSession). A
     capture output can have multiple connections represented by
     AVCaptureConnection objects, one for each stream of media
     that it receives from an AVCaptureInput. A capture output
     does not have any connections when it is first created. When
     you add an output to a capture session, the capture session
     creates connects that map media data from that session’s
     inputs to its outputs.

     You can add concrete AVCaptureOutput instances to a capture
     session using addOutput:.
     */
    
    /**
     Accessing Connections
     
     connections
     The capture output object’s connections.
     
     - connectionWithMediaType:
     Returns the first connection in the connections array with
     an input port of a specified media type.
     
     AVCaptureOutputDataDroppedReason
     Information about why capture data was not delivered.
     */
    
    /**
     Converting Between Coordinate Systems
     
     - transformedMetadataObjectForMetadataObject:connection:
     Converts the visual properties of an AVMetadataObject to
     the output’s coordinates.
     
     - metadataOutputRectOfInterestForRect:
     Converts a rectangle in the capture output object’s coordinate
     system to one in the coordinate system used for metadata outputs.
     
     - rectForMetadataOutputRectOfInterest:
     Converts a rectangle in the coordinate system used for metadata
     outputs to one in the capture output object’s coordinate system.
     */
    
    
    /*
     AVCaptureConnection
     
     A connection between a specific pair of capture input and
     capture output objects in a capture session.

     Capture inputs have one or more input ports (instances of
     AVCaptureInputPort). Capture outputs can accept data from
     one or more sources (for example, an AVCaptureMovieFileOutput
     object accepts both video and audio data).

     You can add an AVCaptureConnection instance to a session using
     the addConnection: method only if the canAddConnection: method
     returns YES. When using the addInput: or addOutput: method,
     the session forms connections automatically between all
     compatible inputs and outputs. You only need to add connections
     manually when adding an input or output with no connections.
     You can also use connections to enable or disable the flow of
     data from a given input or to a given output.
     */
    
    /**
     Creating a Connection

     + connectionWithInputPorts:output:
     Returns a capture connection describing a connection between the
     specified input ports and the specified output.
     
     - initWithInputPorts:output:
     Initializes a capture connection to describe a connection between
     the specified input ports and the specified output.
     
     + connectionWithInputPort:videoPreviewLayer:
     Returns a capture connection describing a connection between the
     specified input port and the specified video preview layer.
     
     - initWithInputPort:videoPreviewLayer:
     Initializes a capture connection to describe a connection between
     the specified input port and the specified video preview layer.
     */
    
    /**
     Configuration
     
     enabled
     Indicates whether the connection is enabled.
     
     active
     Indicates whether the connection is active.
     
     inputPorts
     The connection’s input ports.
     
     output
     The connection’s output port.
     
     videoPreviewLayer
     The video preview layer associated with the connection.
     
     audioChannels
     An array of AVCaptureAudioChannel objects.
     */
    
    /**
     Managing Video Configuration
     
     videoOrientation
     Indicates whether to rotate the video flowing through the
     connection to a given orientation.
     
     supportsVideoOrientation
     A Boolean value that indicates whether the connection
     supports changing the orientation of the video.
     
     AVCaptureVideoOrientation
     Constants indicating video orientation.
     
     videoFieldMode
     An indicator of how interlaced video flowing through the connection
     should be treated
     
     supportsVideoFieldMode
     A Boolean value that indicates whether the connection supports
     setting the videoFieldMode property.
     
     videoMinFrameDuration
     The minimum time interval between which the receiver should
     output consecutive video frames.
     
     supportsVideoMinFrameDuration
     A Boolean value that indicates whether the connection supports
     setting the videoMinFrameDuration property.
     
     videoMaxFrameDuration
     The maximum time interval between which the receiver should
     output consecutive video frames.
     
     supportsVideoMaxFrameDuration
     A Boolean value that indicates whether the connection
     supports setting the videoMaxFrameDuration property.
     
     videoScaleAndCropFactor
     The current video scale and crop factor in use by the receiver.
     
     videoMaxScaleAndCropFactor
     The maximum video scale and crop factor by the connection.
     */
    
    /**
     Managing the Video Mirroring Settings

     automaticallyAdjustsVideoMirroring
     A Boolean value that indicates whether the value of videoMirrored
     can change based on configuration of the session.
     
     supportsVideoMirroring
     A Boolean value that indicates whether the connection supports
     video mirroring.
     
     videoMirrored
     A Boolean value that indicates whether the video flowing through
     the connection should be mirrored about its vertical axis.
     */
    
    /**
     Managing the Video Stabilization Settings
     
     supportsVideoStabilization
     A Boolean value that indicates whether this connection supports
     video stabilization.
     
     activeVideoStabilizationMode
     The stabilization mode currently active for the connection.
     
     preferredVideoStabilizationMode
     The stabilization mode most appropriate for use with the connection.
     */
    
    /**
     Managing Camera Calibration Delivery Settings

     cameraIntrinsicMatrixDeliverySupported
     A Boolean value indicating whether the capture connection currently
     supports delivery of camera intrinsics information.
     
     cameraIntrinsicMatrixDeliveryEnabled
     A Boolean value that specifies whether to configure the capture
     pipeline for delivery of camera intrinsics information.
     */
    
    
    /*
     AVCaptureAudioChannel
     
     An object that monitors average and peak power levels for
     an audio channel in a capture connection.

     You do not create AVCaptureAudioChannel instance directly.
     Instead, an AVCaptureConnection object that connects an input
     producing audio to an output receiving audio exposes an array
     of AVCaptureAudioChannel objects, one for each channel of audio
     available. You can poll for audio levels by iterating through
     these audio channel objects.
     */
    
    /**
     Accessing Power Levels
     
     averagePowerLevel
     The instantaneous average power level, in dB.
     
     peakHoldLevel
     The peak hold power level, in dB.
     
     volume
     The current volume (gain) of the channel.
     */

    /**
     Managing Enabled State

     enabled
     Indicates whether the channel is currently enabled for data capture.
     */
    
#pragma mark -- File Output
    
    
    /*
     AVCaptureFileOutput
     
     The abstract superclass for capture outputs that can record
     captured data to a file.
     */
    
    /**
     Setting File Output Properties

     delegate
     The delegate object for the capture file output.
     
     maxRecordedDuration
     The longest duration allowed for the recording.
     
     maxRecordedFileSize
     The maximum size, in bytes, of the data that should be
     recorded by the receiver.
     
     minFreeDiskSpaceLimit
     The minimum amount of free space, in bytes, required
     for recording to continue on a given volume.
     
     outputFileURL
     The URL to which output is directed.
     
     recordedDuration
     Indicates the duration of the media recorded to the current
     output file.
     
     recordedFileSize
     Indicates the size, in bytes, of the data recorded to the
     current output file.
     
     recording
     Indicates whether recording is in progress.
     
     recordingPaused
     Indicates whether recording to the current output file is paused.
     */
    
    /**
     Starting, Stopping, Pausing, and Resuming Playback

     - startRecordingToOutputFileURL:recordingDelegate:
     Starts recording media to the specified output URL.
     
     - stopRecording
     Tells the receiver to stop recording to the current file.
     
     - pauseRecording
     Pauses recording to the current output file.
     
     - resumeRecording
     Resumes recording to the current output file after it was
     previously paused using pauseRecording.
     */
    
    
    /*
     AVCaptureFileOutputDelegate
     
     Methods for monitoring or controlling the output of a media file capture.

     The AVCaptureFileOutputDelegate protocol defines an interface for
     delegates of an AVCaptureFileOutput object to monitor and control
     recordings along exact sample boundaries.
     */
    
    /**
     Sample Processing
     
     - captureOutputShouldProvideSampleAccurateRecordingStart:
     Allows a client to opt in to frame accurate recording in
     captureOutput:didOutputSampleBuffer:fromConnection:.
     
     Required.
     - captureOutput:didOutputSampleBuffer:fromConnection:
     Gives the delegate the opportunity to inspect samples as they
     are received by the output and start and stop recording at exact times.
     */
    
    
    /*
     AVCaptureFileOutputRecordingDelegate
     
     Methods for responding to events that occur while
     recording captured media to a file.

     Defines an interface for delegates of AVCaptureFileOutput to
     respond to events that occur in the process of recording a single file.

     The delegate of an AVCaptureFileOutput object must adopt the
     AVCaptureFileOutputRecordingDelegate protocol.
     */
    
    /**
     Delegate Methods

     - captureOutput:didStartRecordingToOutputFileAtURL:fromConnections:
     Informs the delegate when the output has started writing to a file.
     
     - captureOutput:willFinishRecordingToOutputFileAtURL:fromConnections:error:
     Informs the delegate when the output will stop writing new samples to a file.
     
     - captureOutput:didFinishRecordingToOutputFileAtURL:fromConnections:error:
     Informs the delegate when all pending data has been written to an output file.
     Required.
     
     - captureOutput:didPauseRecordingToOutputFileAtURL:fromConnections:
     Called whenever the output is recording to a file and successfully pauses
     the recording at the request of a client.
     
     - captureOutput:didResumeRecordingToOutputFileAtURL:fromConnections:
     Called whenever the output, at the request of the client, successfully
     resumes a file recording that was paused.
     */
    
    
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

