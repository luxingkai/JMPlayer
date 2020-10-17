//
//  CoreVideoController.m
//  VideoProcess
//
//  Created by tigerfly on 2020/10/12.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "CoreVideoController.h"

@interface CoreVideoController ()

@end

@implementation CoreVideoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /*
     CoreVideo
     
     Process digital video -- including manipulation of individual frames
     -- using a pipeline-based API and support for both Metal and OpenGL.
     
     Core video provides a pipeline model for digital video. It simplifies
     working with video by partitioning the process into discrete steps.
     This makes it easier for developers to access and manipulate individual
     frames without having to worry about translating between data types or
     display synchronization issues. Apps that don't need to manipulate
     individual video frames should never need to use Core Video directly.
     */
    
    
#pragma mark -- Data Processing
    
    /*
     CVBuffer
     An abstract base class that defines how to interact with data buffers.
     
     A CVBuffer serves as an abstract base class that defines how to
     interact with buffers of data. A buffer object can hold video, audio,
     or possibly other types of data. All the other buffer types defined by
     Core Video, such as CVImageBuffer and CVPixelBuffer, are derived from
     CVBuffer. You can use the CVBuffer programming interface on any Core
     Video buffer.
     */

    /**
     Working with Attachments
     
     CVBufferGetAttachment
     Retrieves a specific attachment of a Core Video buffer.
     
     CVBufferGetAttachments
     Retrieves all attchments of a Core Video buffer.
     
     CVBufferSetAttachment
     Sets or adds an attachment to a Core Video buffer.
     
     CVBufferSetAttachments
     Sets a dictionary of attachments on a Core Video buffer.
     
     CVBufferRemoveAttachment
     Removes a specific attachment from a Core Video buffer.
     
     CVBufferRemoveAllAttachments
     Removes all attachments from a Core Video  buffer.
     
     CVBufferPropagateAttachments
     Copies all attachments that can be propagated from one Core Video
     buffer to another.
     */
    
    /**
     Retaining and Releasing Buffers
     
     CVBufferRetain
     Retains a Core Video buffer.
     
     CVBufferRelease
     Releases a Core Video buffer.
     */
    
    /**
     Data Types
     
     CVBufferRef
     A reference to a Core Video buffer.
     
     CVAttachmentMode
     The propagation modes of a Core video buffer attachment.
     */
    
    /**
     Constants
     
     CVBuffer Attribute Keys
     kCVBufferPropagatedAttachmentsKey
     kCVBufferNonPropagatedAttachmentsKey

     CVBuffer Attachment Keys
     kCVBufferMovieTimeKey
     kCVBufferTimeValueKey
     kCVBufferTimeScaleKey
     */
    
    
    /*
     CVImageBuffer
     
     An interface for managing different types of image data.
     
     Core Video image buffers provides a convenient interface for
     managing different types of image data. Pixel buffers and Core
     video OpenGL buffers derive from the Core Video image buffer.
     */
    
    /**
     Inspecting Image Buffers
     
     CVImageBufferGetCleanRect
     Returns the source rectangle of a Core Video image buffer that
     represents the clean aperture of the buffer in encoded pixels.
     
     CVImageBufferGetColorSpace
     Returns the color space of a CoreVideo Image buffer.
     
     CVImageBufferGetDisplaySize
     Returns the nominal output display size, in square pixels,
     of a Core Video image buffer.
     
     CVImageBufferGetEncodedSize
     Returns the full encoded dimensions of a Core Video image buffer.
     
     CVImageBufferIsFlipped
     Returns a Boolean value indicating whether the image is flipped
     vertically.
     */
    
    /**
     Creating Color Spaces
     
     CVImageBufferCreateColorSpaceFromAttachments
     Attempts to create a CGColorSpace from an image buffer's
     attachments.
     */
    
    /**
     Data Types
     
     CVImageBufferRef
     A reference to a Core Video image buffer.
     */
    
    /**
     Converting Between Strings and Integer Code Points
     
     CVColorPrimariesGetIntegerCodePointForString
     CVColorPrimariesGetStringForIntegerCodePoint
     CVTransferFunctionGetIntegerCodePointForString
     CVTransferFunctionGetStringForIntegerCodePoint
     CVYCbCrMatrixGetIntegerCodePointForString
     CVYCbCrMatrixGetStringForIntegerCodePoint
     */
    
    /**
     Constants
     
     Image Buffer Attachment Keys
     kCVImageBufferCGColorSpaceKey
     kCVImageBufferCleanApertureKey
     kCVImageBufferPreferredCleanApertureKey
     kCVImageBufferFieldCountKey
     kCVImageBufferFieldDetailKey
     kCVImageBufferPixelAspectRatioKey
     kCVImageBufferDisplayDimensionsKey
     kCVImageBufferGammaLevelKey
     kCVImageBufferICCProfileKey
     kCVImageBufferYCbCrMatrixKey
     kCVImageBufferColorPrimariesKey
     kCVImageBufferTransferFunctionKey
     kCVImageBufferChromaLocationTopFieldKey
     kCVImageBufferChromaLocationBottomFieldKey
     kCVImageBufferChromaSubsamplingKey
     kCVImageBufferAlphaChannelIsOpaque
     kCVImageBufferContentLightLevelInfoKey
     kCVImageBufferMasteringDisplayColorVolumeKey
     
     Image Buffer Clean Aperture Keys
     kCVImageBufferCleanApertureWidthKey
     kCVImageBufferCleanApertureHeightKey
     kCVImageBufferCleanApertureHorizontalOffsetKey
     kCVImageBufferCleanApertureVerticalOffsetKey

     Image Buffer Pixel Aspect Ratio Keys
     kCVImageBufferPixelAspectRatioHorizontalSpacingKey
     kCVImageBufferPixelAspectRatioVerticalSpacingKey

     Image Buffer Display Dimensions Keys
     kCVImageBufferDisplayWidthKey
     kCVImageBufferDisplayHeightKey

     Image Buffer Field Detail Constants
     kCVImageBufferFieldDetailTemporalTopFirst
     kCVImageBufferFieldDetailTemporalBottomFirst
     kCVImageBufferFieldDetailSpatialFirstLineEarly
     kCVImageBufferFieldDetailSpatialFirstLineLate

     Image Buffer YCbCr Matrix Constants
     kCVImageBufferYCbCrMatrix_ITU_R_2020
     kCVImageBufferYCbCrMatrix_ITU_R_709_2
     kCVImageBufferYCbCrMatrix_ITU_R_601_4
     kCVImageBufferYCbCrMatrix_SMPTE_240M_1995

     Image Buffer Color Primaries Constants
     kCVImageBufferColorPrimaries_ITU_R_709_2
     kCVImageBufferColorPrimaries_EBU_3213
     kCVImageBufferColorPrimaries_SMPTE_C
     kCVImageBufferColorPrimaries_DCI_P3
     kCVImageBufferColorPrimaries_ITU_R_2020
     kCVImageBufferColorPrimaries_P3_D65
     kCVImageBufferColorPrimaries_P22

     Image Buffer Transfer Function Constants
     kCVImageBufferTransferFunction_ITU_R_709_2
     kCVImageBufferTransferFunction_SMPTE_240M_1995
     kCVImageBufferTransferFunction_UseGamma
     kCVImageBufferTransferFunction_sRGB
     kCVImageBufferTransferFunction_ITU_R_2020
     kCVImageBufferTransferFunction_SMPTE_ST_428_1
     kCVImageBufferTransferFunction_ITU_R_2100_HLG
     kCVImageBufferTransferFunction_SMPTE_ST_2084_PQ
     
     Image Buffer Chroma Location Constants
     kCVImageBufferChromaLocation_Left
     kCVImageBufferChromaLocation_Center
     kCVImageBufferChromaLocation_TopLeft
     kCVImageBufferChromaLocation_Top
     kCVImageBufferChromaLocation_BottomLeft
     kCVImageBufferChromaLocation_Bottom
     kCVImageBufferChromaLocation_DV420

     Image Buffer Chroma Subsampling Constants
     kCVImageBufferChromaSubsampling_420
     kCVImageBufferChromaSubsampling_422
     kCVImageBufferChromaSubsampling_411
     */

    /*
     CVPixelBuffer
     
     An image buffer that holds pixels in main memory.
     
     A Core Video pixel buffer is an image buffer that holds pixels in
     main memory. Applications generating frames, compressing or
     decompressing video, or using Core Image can all make use of
     Core Video pixel buffers.
     */
    
    /**
     Creating Pixel Buffers
     
     CVPixelBufferCreate
     Creates a single pixel buffer for a given size and pixel format.
     
     CVPixelBufferCreateWithBytes
     Creates a pixel buffer for a given size and pixel format containing
     data specified by a memory location.
     
     CVPixelBufferCreateWithPlannarBytes
     Creates a single pixel buffer in planar format for a given size and
     pixel format containing data specified by a memory location.
     
     CVPixelBufferCreateWithIOSurface
     Call to create a single pixel buffer for a passed-in IOSurface.
     */
    
    /**
     Inspecting Pixel Buffers
     
     CVPixelBufferGetBaseAddress
     Returns the base adderss of the pixel buffer.
     
     CVPixelBufferGetBaseAddressOfPlane
     Returns the base address of the plane at the specified
     plane index.
     
     CVPixelBufferGetBytesPerRow
     Returns the number of bytes per row of the pixel buffer.
     
     CVPixelBufferGetBytesPerRowOfPlane
     Returns the number of bytes per row for a plane at the specified
     index in the pixel buffer.
     
     CVPixelBufferGetHeight
     Returns the height of the pixel buffer.
     
     CVPixelBufferGetHeightOfPlane
     Returns the height of the plane at planeIndex in the pixel buffer.
     
     CVPixelBufferGetWidth
     Returns the width of the pixel buffer.
     
     CVPixelBufferGetWidthOfPlane
     Returns the width of the plane at a given index in the pixel buffer.
     
     CVPixelBufferIsPlanar
     Determines whether the pixel buffer is planar.
     
     CVPixelBufferGetPlaneCount
     Returns number of planes of the pixel buffer.
     
     CVPixelBufferGetDataSize
     Returns the data size for contiguous planes of the pixel buffer.
     
     CVPixelBufferGetPixelFormatType
     Returns the pixel format type of the pixel buffer.
     
     CVPixelBufferGetExtendedPixels
     Returns the amount of extended pixel padding in the pixel buffer.
     
     CVPixelBufferGetIOSurface
     Returns the IOSurface backing the pixel buffer, or NULL if
     it is not backed by an IOSurface.
     
     CVPixelBufferCreateResolvedAttributesDictionary
     Resolves an array of CFDictionary objects describing various
     pixel buffer attributes into a single dictionary.
     
     CVPixelBufferGetTypeID
     Returns the Core Foundation type identifier of the pixel buffer type.
     */

    /**
     Modifying Pixel Buffers
     
     CVPixelBufferFillExtendedPixels
     Fills the extented pixels of the pixel buffer.
     
     CVPixelBufferLockBaseAddress
     Locks the base address of the pixel buffer.
     
     CVPixelBufferUnlockBaseAddress
     Unlocks the base address of the pixel buffer.
    */
    
    /**
     Retaining and Releasing Pixel Buffers
     
     CVPixelBufferRetain
     Retains a pixel buffer.
     
     CVPixelBufferRelease
     Releases a pixel buffer.
     */
    
    /**
     Data  Types
     
     CVPixelBufferRef
     A reference to a Core Video pixel buffer object.
     
     CVPixelBufferLockFlags
     The flags to pass to CVPixelBufferLockBaseAddress
     and CVPixelBufferUnlockBaseAddress.
     
     CVPlanarComponentInfo
     A structure for describing planar components
     
     CVPlanarPixelBufferInfo
     A structure for describing planar buffers
     
     CVPlanarPixelBufferInfo_YCbCrPlanar
     A structure for describing YCbCr planar buffers.
     
     CVPlanarPixelBufferInfo_YCbCrBiPlanar
     A structure for describing YCbCr biplanar buffers.
     */
    
    /**
     Callbacks
     
     CVPixelBufferReleaseBytesCallback
     A type that defines a release callback function.
     
     CVPixelBufferReleasePlanarBytesCallback
     Defines a pointer to a pixel buffer release callback
     function, which is called when a pixel buffer created
     by CVPixelBufferCreatedWithPlanarBytes is released.
     */
    
    /**
     Constants
     
     Pixel Buffer Attribute Keys
     kCVPixelBufferMemoryAllocatorKey
     kCVPixelBufferPixelFormatTypeKey
     kCVPixelBufferWidthKey
     kCVPixelBufferHeightKey
     kCVPixelBufferExtendedPixelsLeftKey
     kCVPixelBufferExtendedPixelsTopKey
     kCVPixelBufferExtendedPixelsRightKey
     kCVPixelBufferExtendedPixelsBottomKey
     kCVPixelBufferBytesPerRowAlignmentKey
     kCVPixelBufferCGBitmapContextCompatibilityKey
     kCVPixelBufferCGImageCompatibilityKey
     kCVPixelBufferOpenGLCompatibilityKey
     kCVPixelBufferPlaneAlignmentKey
     kCVPixelBufferIOSurfacePropertiesKey
     kCVPixelBufferOpenGLESCompatibilityKey
     kCVPixelBufferMetalCompatibilityKey
     kCVPixelBufferIOSurfaceCoreAnimationCompatibilityKey
     kCVPixelBufferIOSurfaceOpenGLFBOCompatibilityKey
     kCVPixelBufferIOSurfaceOpenGLTextureCompatibilityKey
     kCVPixelBufferOpenGLESTextureCacheCompatibilityKey
     kCVPixelBufferOpenGLTextureCacheCompatibilityKey
     kCVPixelBufferIOSurfaceOpenGLESFBOCompatibilityKey
     kCVPixelBufferIOSurfaceOpenGLESTextureCompatibilityKey
     */
    
    /*
     CVPixelBufferPool
     
     A utility object for managing a recyclable set of pixel
     buffer objects.
     */
    
    /**
     Creating Pools
     
     CVPixelBufferPoolCreate
     Creates a pixel buffer pool.
     
     CVPixelBufferPoolCreatePixelBuffer
     Creates a pixel buffer from a pixel buffer pool.
     
     CVPixelBufferPoolCreatePixelBufferWithAuxAttributes
     Creates a new pixel buffer with some auxiliary attributes
     from the pool.
     */
    
    /**
     Flushing Pools
     
     CVPixelBufferPoolFlush
     Frees as many buffers from the pool as possible.
     */
     
    /**
     Inspecting Pools
     
     CVPixelBufferPoolGetAttributes
     Returns the pool attributes dictionary for a pixel buffer pool.
     
     CVPixelBufferPoolGetPixelBufferAttributes
     Returns the attributes of pixel buffers that will be created from
     this pool.
     
     CVPixelBufferPoolTypeID
     Returns the Core Foundation type identifier of the pixel buffer pool type.
     */
    
    /**
     Retaining and Releasing Poolss
     
     CVPixelBufferPoolRetain
     Retains a pixel buffer pool.
     
     CVPixelBufferPoolRelease
     Releases a pixel buffer pool.
     */
    
    /**
     Data Types
     
     CVPixelBufferPoolRef
     A refefence to a pixel buffer pool object.
     
     CVPixelBufferPoolFlushFlags
     Flags to pass to when flushing the pool.
     */
    
    /**
     Constants
     
     KCVPixelBufferPoolMinimumBufferCountKey
     The minimum number of buffers allowed in the pixel buffer
     pool (type CFNumber).
     
     kCVPixelBufferPoolMaximumBufferAgeKey
     The maximum allowable age for a buffer in the pixel buffer
     pool (type CFAbsoluteTime).
     
     kCVPixelBufferPoolAllocationThresholdKey
     When set, the value associated with this key indicates that a new pixel
     buffer should not be allocated if the pool already has this many or
     more pixel buffers allocated. This doesn’t prevent buffers that have
     already been allocated from being recycled. If this key causes
     CVPixelBufferPoolCreatePixelBufferWithAuxAttributes to fail,
     it will return kCVReturnWouldExceedAllocationThreshold. (type CFNumberRef)
     */
    
    /**
     Notifications
     
     kCVPixelBufferPoolFreeBufferNotification
     This notification is posted if a buffer becomes available after
     the CVPixelBufferPoolCreatePixelBufferWithAuxAttributes function
     has failed due to the value of the kCVPixelBufferPoolAllocationThresholdKey
     key. This notification will not be posted by the pool if a value
     for the kCVPixelBufferPoolAllocationThresholdKey key has never been
     passed to the CVPixelBufferPoolCreatePixelBufferWithAuxAttributes function.
     */
    
    
    /*
     CVPixelFormatDesciption
     
     An API that provides functions and types for defining custom pixel formats.
     The Core Video pixel format description API defines functions and types
     for defining custom pixel formats. You should only use pixel format
     descriptions if you need to define a custom pixel format.
     */
    
    /**
     Creating Format Descriptions
     
     CVPixelFormatDescriptionCreateWithPixelFormatType
     Creates a pixel format descrption from a given OSType identifier.
     
     CVPixelFormatDescriptionRegisterDescriptionWithPixelFormatType
     Registers a pixel format description with Core Video.
     */
    
    /**
     Retrieving Format Descriptions
     
     CVPixelFormatDescriptionArrayCreateWithAllPixelFormatTypes.
     Returns all the pixel format descriptions known to Core Video.
     */
    
    /**
     Data Types
     
     CVFillExtentedPixelsCallBackData
     A structure for holding information that describes a custom
     extented pixel fill algorithm.
     */
    
    /**
     Callbacks
     
     CVFillExtentedPixelsCallBack
     Define a pointer to a custom extended pixel-fill function, which
     is called whenever the system needs to pad a buffer holding your
     custom pixel format.
     */
    
    /**
     Constants
     
     Pixel Format Description Keys
     kCVPixelFormatComponentRange
     kCVPixelFormatComponentRange_FullRange
     kCVPixelFormatComponentRange_VideoRange
     kCVPixelFormatComponentRange_WideRange
     kCVPixelFormatContainsRGB
     kCVPixelFormatContainsYCbCr
     kCVPixelFormatName
     kCVPixelFormatConstant
     kCVPixelFormatCodecType
     kCVPixelFormatFourCC
     kCVPixelFormatContainsAlpha
     kCVPixelFormatPlanes
     kCVPixelFormatBlockWidth
     kCVPixelFormatBlockHeight
     kCVPixelFormatBitsPerBlock
     kCVPixelFormatBlockHorizontalAlignment
     kCVPixelFormatBlockVerticalAlignment
     kCVPixelFormatBlackBlock
     kCVPixelFormatHorizontalSubsampling
     kCVPixelFormatVerticalSubsampling
     kCVPixelFormatOpenGLFormat
     kCVPixelFormatOpenGLType
     kCVPixelFormatOpenGLInternalFormat
     kCVPixelFormatCGBitmapInfo
     kCVPixelFormatQDCompatibility
     kCVPixelFormatCGBitmapContextCompatibility
     kCVPixelFormatCGImageCompatibility
     kCVPixelFormatOpenGLCompatibility
     kCVPixelFormatOpenGLESCompatibility
     kCVPixelFormatFillExtendedPixelsCallback
     */
    

#pragma mark -- Time Management
    
    /*
     CVTime
     
     A structure used for storing Core Video time values
     
     CoreVideo uses the CVTime and CVTimeStamp structures for storing
     Core Video time values. You use them to interact with the Core
     Video display link.
     */
    
    /**
     Inspecting the Host Clock
     
     CVGetCurrentHostTime
     Returns the current system time.
     
     CVGetHostClockFrequency
     Returns the frequency of updates to the system time.
     
     CVGetHostClockMinimumTimeDelta
     Returns the smallest possible increment in the system time.
     */
    
    /**
     Data Types
     
     CVTime
     A structure for reporting Core Video time values.
     
     CVSMPTETime
     A structure for holding an SMPTE time.
     */
    
    /**
     Constants
     
     CVTime Values
     kCVZeroTime
     kCVIndefiniteTime
     */
    
    /*
     CVDisplayLink (available for macOS)
     
     A high-priority thread that notifies your app when a given display
     will need each frame.
     
     A Core Video display link provides a separate high-priority thread
     to notify your application when a given display will need each frame.
     You can use a display link to easily synchronize with the refresh rate
     of a display. The display link API uses the Core Foundation class system
     internally to provide reference counting behavior and other useful properties.
     */
    
    /**
     Creating Display Links
     
     CVDisplayLinkCreateWithCGDisplay
     Creates a display link for a single display.
     
     CVDisplayLinkCreateWithCGDisplays
     Creates a display link for an array of displays.
     
     CVDisplayLinkCreateWithActiveCGDisplays
     */
    
    
#pragma mark -- Metal
    
    /*
     CVMetalTextureCache
     
     A cache used to create and manage Metal texture objects.
     
     A Core Video Metal texture cache creates and manages CVMetalTextureRef
     textures. You use a CVMetalTextureCache object to directly read from
     or write to GPU-based Core Video image buffers in rendering or GPU
     compute tasks that use the Metal framework. For example, you can use
     a Metal texture cache to present live output from a device's camera
     in a 3D scene rendered with Metal.
     */
    
    /**
     Functions
     
     CVMetalTextureCacheCreate
     Creates a new texture cache.
     
     CVMetalTextureCacheCreateTextureFromImage
     Creates a Core Video Metal texture buffer from an existing image buffer.
     
     CVMetalTextureCacheFlush
     Performs internal housekeeping/recycling operations on a texture cache.
     
     CVMetalTextureCacheGetTypeID
     Returns the Core Foundation type identifier for a Core Video Metal texture cache.
     */
    
    /**
     Data Types
     
     CVMetalTextureCacheRef
     A reference to a Core Video Metal texture cache.
     */
    
    /**
     Constants
     
     Cache Attributes
     kCVMetalTextureCacheMaximumTextureAgeKey
     kCVMetalTextureUsage
     */
    
    /*
     CVMetalTexture
     
     A texture-based image buffer that supplies source image data for
     use with the Metal framework.
     
     A Core Video Metal Texture is a texture-based image buffer that
     supplies source image data for use with the Metal framework.
     */
    
    /**
     Inspecting Textures
     
     CVMetalTextureGetTexture
     Returns the Metal texture object for the image buffer.
     
     CVMetalTextureGetCleanTexCoords
     Returns convenient normalized texture coordinates for
     the part of the image that should be displayed.
     
     CVMetalTextureIsFlipped
     Returns a Boolean value indicating whether the texture
     image is vertically flipped.
     
     CVMetalTextureGetTypeID
     Returns the Core Foundation type identifier for a
     CoreVideo Metal texture-based image buffer.
     */

    /**
     Data Types
     
     CVMetalTextureRef
     A reference to a CoreVideo Metal texture-based image buffer.
     */
    
#pragma mark -- OpenGL
    

#pragma mark -- OpenGL ES
    
    /*
     CVOpenGLESTextureCache
     
     A cache used to create and manage OpenGL ES texture object.
     Core video OpenGL ES texture caches are used to cache and manage
     CVOpenGLESTextureRef textures. These texture caches provide you
     with a way to directly read and write buffers with various pixel
     formats, such as 420v or BGRA, from GL ES.
     */
    
    /**
     The functions in this section operate on Core Video texture
     caches derived from the CVOpenGLESTextureCacheRef type.
     
     CVOpenGLESTextureCacheCreate
     Creates a new Core Video texture cache.
     
     CVOpenGLESTextureCacheCreateTextureFromImage
     Creates a CVOpenGLESTextureRef object from an existing CVImageBufferRef.
     
     CVOpenGLESTextureCacheFlush
     Performs interal housekeeping/recycling operations on a texture cache.
     
     CVOpenGLESTextureCacheGetTypeID
     Returns the Core Foundation type identifier for a Core Video texture cache.
     */
    
    /**
     Data Types
     
     CVOpenGLESTextureCacheRef
     A reference to a Core Video OpenGLES texture cache.
     
     CVEAGLContext
     A type that resolves to an EAGLContext pointer when appropriate.
     */
    
    /**
     Constants
     
     Cache Attributes
     kCVOpenGLESTextureCacheMaximumTextureAgeKey
     */
    
    /*
     CVOpenGLESTexture
     
     A texture-based image buffer that supplies source image data
     to OpenGL ES.
     
     Core Video OpenGL ES textures are texture-based image buffers used
     for supplying source image data to OpenGL.
     */
    
    /**
     Inspecting Textures
     
     CVOpenGLESTextureGetTarget
     Returns the texture target for a CVOpenGLESTextureRef.
     
     CVOpenGLESTextureGetName
     Returns the texture target name for a CVOpenGLESTextureRef.
     
     CVOpenGLESTextureGetCleanTexCoords
     Returns convenient normalized texture coordinates for the part
     of the image that should be displayed.
     
     CVOpenGLESTextureIsFlipped
     Returns whether the image is flipped vertically or not.
     
     CVOpenGLESTextureGetTypeID
     Returns the Core Foundation type identifier for a Core Video
     texture-based image buffer.
     */
    
    /**
     Data Types
     
     CVOpenGLESTextureRef
     A reference to a Core Video texture-based image buffer.
     */
    
    
#pragma mark -- Core Video Error Constants
    
    /**
     Common
     
     kCVReturnAllocationFailed
     Memory allocation for a buffer or buffer pool failed.
     
     kCVReturnError
     An otherwise undefined error occurred.
     
     kCVReturnInvalidArgument
     Invalid function parameter. For example, out of range or the wrong type.
     
     kCVReturnSuccess
     Indicates the operation completed successfully.
     
     kCVReturnUnsupported
     kCVReturnLast
     kCVReturnFirst
     
     */
    
    /**
     Pixel Buffer
     
     kCVReturnInvalidPixelBufferAttributes
     A buffer cannot be created with the specified attributes.
     
     kCVReturnInvalidPixelFormat
     The buffer does not support the specified pixel format.
     
     kCVReturnInvalidSize
     The buffer cannot support the requested buffer size (usually too big).
     
     kCVReturnPixelBufferNotMetalCompatible
     The pixel buffer is not compatible with Metal due to an
     unsupported buffer size, pixel format, or attribute.
     
     kCVReturnPixelBufferNotOpenGLCompatible
     The pixel buffer is not compatible with OpenGL due to an unsupported
     buffer size, pixel format, or attribute.
     */
    
    /**
     Buffer Pool
     
     kCVReturnRetry
     A scan hasn't completely traversed the CVBufferPool due to a concurrent operation.
     
     kCVReturnInvalidPoolAttributes
     A buffer pool cannot be created with the specified attributes.
     
     kCVReturnPoolAllocationFailed
     Allocation for a buffer pool failed, most likely due to a lack of resources.
     Check to make sure your parameters are in range.
     
     kCVReturnWouldExceedAllocationThreshold
     Allocation for a pixel buffer failed because the threshold value set for the
     kCVPixelBufferPoolAllocationThresholdKey key in the
     CVPixelBufferPoolCreatePixelBufferWithAuxAttributes function would be surpassed.
     
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
