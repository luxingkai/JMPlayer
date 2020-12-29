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
     
     
     */
    
    
    
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

