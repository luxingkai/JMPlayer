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
     Video Toolbox
     
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
    
    /*
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
    
    /*
     Encoding Frames
     */
//    VTCompressionSessionPrepareToEncodeFrames(<#VTCompressionSessionRef  _Nonnull session#>)
//    VTCompressionSessionEncodeFrame(<#VTCompressionSessionRef  _Nonnull session#>, <#CVImageBufferRef  _Nonnull imageBuffer#>, <#CMTime presentationTimeStamp#>, <#CMTime duration#>, <#CFDictionaryRef  _Nullable frameProperties#>, <#void * _Nullable sourceFrameRefcon#>, <#VTEncodeInfoFlags * _Nullable infoFlagsOut#>)
//    VTCompressionSessionEncodeFrameWithOutputHandler(<#VTCompressionSessionRef  _Nonnull session#>, <#CVImageBufferRef  _Nonnull imageBuffer#>, <#CMTime presentationTimeStamp#>, <#CMTime duration#>, <#CFDictionaryRef  _Nullable frameProperties#>, <#VTEncodeInfoFlags * _Nullable infoFlagsOut#>, <#^(OSStatus status, VTEncodeInfoFlags infoFlags, CMSampleBufferRef  _Nullable sampleBuffer)outputHandler#>)
//    VTCompressionSessionCompleteFrames(<#VTCompressionSessionRef  _Nonnull session#>, <#CMTime completeUntilPresentationTimeStamp#>)
    
    /*
     Inspecting Sessions
     */
//    VTCompressionSessionGetPixelBufferPool(<#VTCompressionSessionRef  _Nonnull session#>)
//    VTCompressionSessionGetTypeID()
    
    /*
     Performing Multipass Compression
     */
//    VTCompressionSessionBeginPass(<#VTCompressionSessionRef  _Nonnull session#>, <#VTCompressionSessionOptionFlags beginPassFlags#>, <#uint32_t * _Nullable reserved#>)
//    VTCompressionSessionEndPass(<#VTCompressionSessionRef  _Nonnull session#>, <#Boolean * _Nullable furtherPassesRequestedOut#>, <#uint32_t * _Nullable reserved#>)
//    VTCompressionSessionGetTimeRangesForNextPass(<#VTCompressionSessionRef  _Nonnull session#>, <#CMItemCount * _Nonnull timeRangeCountOut#>, <#const CMTimeRange * _Nullable * _Nonnull timeRangeArrayOut#>)
    
    /*
     Ending Sessions
     */
//    VTCompressionSessionInvalidate(<#VTCompressionSessionRef  _Nonnull session#>)
    
    /*
     Data Types
     */
//    VTCompressionSessionRef
//    VTCompressionOutputCallback
//    VTCompressionOutputHandler
    
    /*
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
    
    
#pragma mark -- VTMultiPassStorage
    
    /*
     
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
