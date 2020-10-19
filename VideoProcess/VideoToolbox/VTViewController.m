//
//  VTViewController.m
//  VideoProcess
//
//  Created by tigerfly on 2020/10/10.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "VTViewController.h"
#import <VideoToolbox/VideoToolbox.h>
#import <CoreVideo/CoreVideo.h>

@interface VTViewController ()

@end

@implementation VTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /*
     Video Toolbox (Availablility for iOS 6.0+, masOS 10.8+, tvOS 10.2+)
     
     Work directly with hardware-accelerated video encoding and
     decoding capabilities.
     
     VideoToolbox is a low-level framework that provides direct
     access to hardware encoders and decoders. It provides services
     for video compression and decompression, and for conversion
     between raster image formats stored in CoreVideo pixel buffers.
     These services are provided in the form of session objects (
     compression, decompression, and pixel transfor), which are vended
     as Core Foundation(CF) types. Apps that don't need direct access
     to hardware encoders and decoders should not need to use VideoToolbox
     directly.
     */
    
    
#pragma mark -- Data Compression
    
    /*
     VTCompressionSession
     
     A session object that manages the compression of incoming video data.
     
     A compression session supports the compression of a sequence of video
     frames. Here's the workflow:
     1. Create a compression session using VTCompressionSessionCreate
     2. Optionally, configure the session with your desired Compression Properties
        by calling VTSessionSetProperty or VTSessionSetProperties
     3. Encode video frames using VTCompressionSessionEncodeFrame and receive the
        compressed video frames in the session's VTCompressionOutputCallback.
     4. To force the completion of some or all pending frames, call
        VTCompressionSessionCompleteFrames.
     5. When you finish with the compression session, call VTCompressionSessionInvalidate
        to invalidate it and CFRelease to free its memory.
     */
    

    /*
     Creating Sessions
     */
//    VTCompressionSessionCreate(<#CFAllocatorRef  _Nullable allocator#>, <#int32_t width#>, <#int32_t height#>, <#CMVideoCodecType codecType#>, <#CFDictionaryRef  _Nullable encoderSpecification#>, <#CFDictionaryRef  _Nullable sourceImageBufferAttributes#>, <#CFAllocatorRef  _Nullable compressedDataAllocator#>, <#VTCompressionOutputCallback  _Nullable outputCallback#>, <#void * _Nullable outputCallbackRefCon#>, <#VTCompressionSessionRef  _Nullable * _Nonnull compressionSessionOut#>)
    
    /**
     Configuring Sessions
     
     Bitstream Configuration
     Buffers
     Clean Aperture and Pixel Aspect Ratio
     Color
     Expected Values
     Frame Dependency
     Hardware Acceleration
     Multipass Storage
     Per-Frame Configuration
     Precompression Processing
     Rate Control
     Runtime Restriction
     */
    
    /**
     Encoding Frames
     */
//    VTCompressionSessionPrepareToEncodeFrames(<#VTCompressionSessionRef  _Nonnull session#>)
//    VTCompressionSessionEncodeFrame(<#VTCompressionSessionRef  _Nonnull session#>, <#CVImageBufferRef  _Nonnull imageBuffer#>, <#CMTime presentationTimeStamp#>, <#CMTime duration#>, <#CFDictionaryRef  _Nullable frameProperties#>, <#void * _Nullable sourceFrameRefcon#>, <#VTEncodeInfoFlags * _Nullable infoFlagsOut#>)
//    VTCompressionSessionEncodeFrameWithOutputHandler(<#VTCompressionSessionRef  _Nonnull session#>, <#CVImageBufferRef  _Nonnull imageBuffer#>, <#CMTime presentationTimeStamp#>, <#CMTime duration#>, <#CFDictionaryRef  _Nullable frameProperties#>, <#VTEncodeInfoFlags * _Nullable infoFlagsOut#>, <#^(OSStatus status, VTEncodeInfoFlags infoFlags, CMSampleBufferRef  _Nullable sampleBuffer)outputHandler#>)
//    VTCompressionSessionCompleteFrames(<#VTCompressionSessionRef  _Nonnull session#>, <#CMTime completeUntilPresentationTimeStamp#>)
    
    /**
     Inspecting Sessions
     */
//    VTCompressionSessionGetPixelBufferPool(<#VTCompressionSessionRef  _Nonnull session#>)
//    VTCompressionSessionGetTypeID()
    
    /**
     Performing Multipass Compression
     */
//    VTCompressionSessionBeginPass(<#VTCompressionSessionRef  _Nonnull session#>, <#VTCompressionSessionOptionFlags beginPassFlags#>, <#uint32_t * _Nullable reserved#>)
//    VTCompressionSessionEndPass(<#VTCompressionSessionRef  _Nonnull session#>, <#Boolean * _Nullable furtherPassesRequestedOut#>, <#uint32_t * _Nullable reserved#>)
//    VTCompressionSessionGetTimeRangesForNextPass(<#VTCompressionSessionRef  _Nonnull session#>, <#CMItemCount * _Nonnull timeRangeCountOut#>, <#const CMTimeRange * _Nullable * _Nonnull timeRangeArrayOut#>)
    
    /**
     Ending Sessions
     */
//    VTCompressionSessionInvalidate(<#VTCompressionSessionRef  _Nonnull session#>)
    
    /**
     Data Types
     */
//    VTCompressionSessionRef
//    VTCompressionOutputCallback
//    VTCompressionOutputHandler
    
    /**
     Enumerations
     */
//    VTCompressionSessionOptionFlags
//    VTEncodeInfoFlags
    
    

#pragma mark -- Data Decompression
    
    /*
     VTDecompressionSession
     
     A session object that manages the decompression of incoming video data.
     
     A decompression session supports the decompression of a sequence of video
     frames. Here's the basic workflow:
     1. Create a decompression session by calling VTDecompressionSessionCreate.
     2. Optionally, configure the session with your desired Decompression Properties
        by calling VTSessionSetProperty or VTSessionSetProperties.
     3. Decode video frames using VTDecompressionSessionDecodeFrame.
     4. When you finish with the decompression session, call VTDecompressionSessionInvalidate
        to tear it down, and call CFRelease to free its memory.
    */
    
    
    /*
     Creating Sessions
     */
//    VTDecompressionSessionCreate(<#CFAllocatorRef  _Nullable allocator#>, <#CMVideoFormatDescriptionRef  _Nonnull videoFormatDescription#>, <#CFDictionaryRef  _Nullable videoDecoderSpecification#>, <#CFDictionaryRef  _Nullable destinationImageBufferAttributes#>, <#const VTDecompressionOutputCallbackRecord * _Nullable outputCallback#>, <#VTDecompressionSessionRef  _Nullable * _Nonnull decompressionSessionOut#>)
    
    
    /*
     Configuring Sessions
     
     Asynchronous State
     Media Content
     Decoder Behavior
     Hardware Acceleration
     Pixel Buffer Pools
     Post-Decompression Processing
     Quality of Service
     */
    
    
    /*
     Decoding Sample Buffers
     */
//    VTDecompressionSessionDecodeFrame(<#VTDecompressionSessionRef  _Nonnull session#>, <#CMSampleBufferRef  _Nonnull sampleBuffer#>, <#VTDecodeFrameFlags decodeFlags#>, <#void * _Nullable sourceFrameRefCon#>, <#VTDecodeInfoFlags * _Nullable infoFlagsOut#>)
//    VTDecompressionSessionDecodeFrameWithOutputHandler(<#VTDecompressionSessionRef  _Nonnull session#>, <#CMSampleBufferRef  _Nonnull sampleBuffer#>, <#VTDecodeFrameFlags decodeFlags#>, <#VTDecodeInfoFlags * _Nullable infoFlagsOut#>, <#^(OSStatus status, VTDecodeInfoFlags infoFlags, CVImageBufferRef  _Nullable imageBuffer, CMTime presentationTimeStamp, CMTime presentationDuration)outputHandler#>)
//    VTDecompressionSessionFinishDelayedFrames(<#VTDecompressionSessionRef  _Nonnull session#>)
//    VTDecompressionSessionWaitForAsynchronousFrames(<#VTDecompressionSessionRef  _Nonnull session#>)
//    VTDecompressionSessionCopyBlackPixelBuffer(<#VTDecompressionSessionRef  _Nonnull session#>, <#CVPixelBufferRef  _Nullable * _Nonnull pixelBufferOut#>)
    
    
    /*
     Inspecting Sessions
     */
//     VTDecompressionSessionCanAcceptFormatDescription(<#VTDecompressionSessionRef  _Nonnull session#>, <#CMFormatDescriptionRef  _Nonnull newFormatDesc#>)
//    VTDecompressionSessionGetTypeID()
    
    /*
     Ending Sessions
     */
//    VTDecompressionSessionInvalidate(<#VTDecompressionSessionRef  _Nonnull session#>)
    
    /*
     Data Types
     */
//    VTDecompressionSessionRef
//    VTDecompressionOutputHandler
//    VTDecompressionOutputCallback
//    VTDecompressionOutputCallbackRecord
    
    /*
     Enumerations
     */
//    VTDecodeFrameFlags
//    VTDecodeInfoFlags
    
    
#pragma mark -- Data Conversion
    
    /*
     VTPixelTransferSession
     
     A session object used to copy and/or convert video data from
     source pixel buffers to destination pixel buffers.
     
     A pixel transfer session supports the copying and/or conversion
     of images from source pixel buffers to destination pixel buffers.
     The basic workflow used when working with a pixel transfer session
     is as follows:
     1. Create a pixel transfer session by calling VTPixelTransferSessionCreate.
     2. Optionally, configure the session with your desired Pixel Transfer
        Properties by calling VTSessionSetProperty or VTSessionSetProperties.
     3. Transfer images by calling VTPixelTransferSessionTransferImage.
     4. When you finish with the pixel transfer session, call
        VTPixelTransferSessionInvalidate to tear it down, and CFRelease to free its memory.
     */
    
    /*
     Creating Sessions
     */
    
    
    
#pragma mark -- Session Configuration
    
    /*
     VTSession
     
     An abstract object that provides the commom interface to configure
     VideoToolbox session objects.
     */
    
    /*
     Setting Propertise
     */
//    VTSessionSetProperty(<#VTSessionRef  _Nonnull session#>, <#CFStringRef  _Nonnull propertyKey#>, <#CFTypeRef  _Nullable propertyValue#>)
//    VTSessionSetProperties(<#VTSessionRef  _Nonnull session#>, <#CFDictionaryRef  _Nonnull propertyDictionary#>)
    
    /*
     Getting Properties
     */
//    VTSessionCopyProperty(<#VTSessionRef  _Nonnull session#>, <#CFStringRef  _Nonnull propertyKey#>, <#CFAllocatorRef  _Nullable allocator#>, <#void * _Nullable propertyValueOut#>)
//    VTSessionCopySerializableProperties(<#VTSessionRef  _Nonnull session#>, <#CFAllocatorRef  _Nullable allocator#>, <#CFDictionaryRef  _Nullable * _Nonnull dictionaryOut#>)
//    VTSessionCopySupportedPropertyDictionary(<#VTSessionRef  _Nonnull session#>, <#CFDictionaryRef  _Nullable * _Nonnull supportedPropertyDictionaryOut#>)
    
    /*
     Supported Property Dictionary Constants
     
     kVTPropertyTypeKey
     kVTPropertyReadWriteStatusKey
     kVTPropertyShouldBeSerializedKey
     kVTPropertySupportedValueListKey
     kVTPropertySupportedValueMaximumKey
     kVTPropertySupportedValueMinimumKey
     kVTPropertyDocumentationKey
     */
    
    /*
     Data Types
     
     A reference to a VideoToolbox compression session, decompression session
     or pixel transfer session
     */
//    VTSessionRef
    
    
#pragma mark -- Multipass Compression
    
    /*
     VTMultiPassStorage
     
     An object used for the storage of multipass video encoding metadata.
     */
    
    /*
     Creating Storage Objects
     Creates a multipass storage object using a temporary file.
     */
//    VTMultiPassStorageCreate(<#CFAllocatorRef  _Nullable allocator#>, <#CFURLRef  _Nullable fileURL#>, <#CMTimeRange timeRange#>, <#CFDictionaryRef  _Nullable options#>, <#VTMultiPassStorageRef  _Nullable * _Nonnull multiPassStorageOut#>)
    
    /*
     Closing Storage Objects
     Ensures that any pending data is written to the multipass
     storage file and closes the file.
     */
//     VTMultiPassStorageClose(<#VTMultiPassStorageRef  _Nonnull multiPassStorage#>)
    
    /*
     Inspecting Storage Objects
     Retrieves the Core Foundation type identifier for the multipass
     storage object.
     */
//    VTMultiPassStorageGetTypeID()
    
    /*
     Data Types
     An object for storing information for each frame of a multipass
     compression session.
     */
//    VTMultiPassStorageRef
    
    /*
     Constants
     */
//    kVTMultiPassStorageCreationOption_DoNotDelete
    
    
    /*
     VTFrameSilo
     
     An object that stores a large number of sample buffers, as produced
     by a multipass compression session.
     
     A frame silo object starts out empty and is populated by calls to
     VTFrameSiloAddSampleBuffer to add sample buffers in ascending decode
     order. After the first full pass, addtional passes may be performed to
     replace sample buffers. Each such pass must begin with a call to
     VTFrameSiloSetTimeRangesForNextPass, which takes a list of time ranges.
     Samples in the these time range are deleted, and calls to
     VTFrameSiloAddSampleBuffer can then be made to provide replacements.
     
     Call VTFrameSiloCallFunctionForEachSampleBuffer or
     VTFrameSiloCallBlockForEachSampleBuffer to retrieve sample buffers.
     The frame silo object may write sample buffers and data to the backing
     file between addtion and retrieval; do not expect to get identical
     object pointers back.
     
     The sample buffers are ordered by decode timestamp.
     */
    
    /*
     Creating Frame Silos
     Creates a frame silo object using a temporary file.
     */
//    VTFrameSiloCreate(<#CFAllocatorRef  _Nullable allocator#>, <#CFURLRef  _Nullable fileURL#>, <#CMTimeRange timeRange#>, <#CFDictionaryRef  _Nullable options#>, <#VTFrameSiloRef  _Nullable * _Nonnull frameSiloOut#>)
    
    /*
     Configuring Frame Silos
     */
//    VTFrameSiloAddSampleBuffer(<#VTFrameSiloRef  _Nonnull silo#>, <#CMSampleBufferRef  _Nonnull sampleBuffer#>)
//    VTFrameSiloSetTimeRangesForNextPass(<#VTFrameSiloRef  _Nonnull silo#>, <#CMItemCount timeRangeCount#>, <#const CMTimeRange * _Nonnull timeRangeArray#>)
//    VTFrameSiloCallBlockForEachSampleBuffer(<#VTFrameSiloRef  _Nonnull silo#>, <#CMTimeRange timeRange#>, <#CF_NOESCAPE OSStatus (^handler)(CMSampleBufferRef _Nonnull)#>)
//    VTFrameSiloCallFunctionForEachSampleBuffer(<#VTFrameSiloRef  _Nonnull silo#>, <#CMTimeRange timeRange#>, <#void * _Nullable refcon#>, <#CF_NOESCAPE OSStatus (*callback)(void * _Nullable, CMSampleBufferRef _Nonnull)#>)
    
    /*
     Inspecting Frame Silos
     */
//    VTFrameSiloGetProgressOfCurrentPass(<#VTFrameSiloRef  _Nonnull silo#>, <#Float32 * _Nonnull progressOut#>)
//    VTFrameSiloGetTypeID()
    
    /*
     Data Types
     */
//    VTFrameSiloRef
    
    
#pragma mark -- Utilities
    
    /*
     Creates a Core Graphics bitmap image or image mask using
     the provided pixel buffer.
     */
//    VTCreateCGImageFromCVPixelBuffer(<#CVPixelBufferRef  _Nonnull pixelBuffer#>, <#CFDictionaryRef  _Nullable options#>, <#CGImageRef  _Nullable * _Nonnull imageOut#>)
    
    /*
     Builds a list of available video encoders.
     */
//    VTCopyVideoEncoderList(<#CFDictionaryRef  _Nullable options#>, <#CFArrayRef  _Nullable * _Nonnull listOfVideoEncodersOut#>)
    
    /*
     Video Encoder List Keys
     kVTVideoEncoderList_EncoderID
     kVTVideoEncoderList_EncoderName
     kVTVideoEncoderList_DisplayName
     kVTVideoEncoderList_CodecType
     kVTVideoEncoderList_CodecName
     */
    
    

    
    
    
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
