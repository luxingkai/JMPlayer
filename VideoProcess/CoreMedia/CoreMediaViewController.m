//
//  CoreMediaViewController.m
//  VideoProcess
//
//  Created by tigerfly on 2020/10/12.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "CoreMediaViewController.h"
#import <CoreMedia/CoreMedia.h>
#import <CoreFoundation/CoreFoundation.h>

@interface CoreMediaViewController ()

@end

@implementation CoreMediaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /*
     Core Media
     
     Represent time-based audio-visual assets with essential data types.
     
     The Core Media framework defines the media pipeline used by AVFoundation
     and other high-level media frameworks found on Apple platforms. Use
     Core Media's low-level data types and interfaces to efficiently process
     media samples and manage queues of media data.
     */
    
    
    
#pragma mark -- Sample Processing
    
    /*
     CMSampleBuffer
     
     An object containing zero or more media samples of a uniform media type.
     
     CMSampleBuffer is a Core Foundation object containing zero or more compressed
     (or uncompressed) samples of a particular media type(audio, video, muxed, etc),
     that are used to move media sample data through the media pipeline. A
     CMSampleBuffer can contain:
     • A CMBlockBuffer of one or more media samples, or
     • A CVImageBuffer a reference to the format description for
        the stream of CMSampleBuffers, size and timing information for
        each of the contained media samples, and both buffer-level and
        sample-level attachments.
     
     A sample buffer can contain both sample-level and buffer-level attachments.
     Sample-level attachments are associated with each individual sample(frame)
     in a buffer and include information such as timestamps and video frame dependencies.
     You can read and write sample-level attachments using the
     CMSampleBufferGetSampleAttachmentsArray function. Buffer-level attachments
     provide information about the buffer as a whole, such as playback speed and actions
     to be performed upon comsuming the buffer. You can read and write buffer-level
     attachments using the APIs describled in CMAttachment and the keys listed under
     Sample Buffer Attachment Keys.
     
     It is possible for a CMSampleBuffer to describle samples it does not yet contain.
     For example, some media services may have access to sample size, timing and format
     information and insert them into queues early, and attach( or fill) the
     CMBlockBuffers of media data later, when the data becomes ready. To this end,
     CMSampleBuffers have the comcept of data-readiness, which can be tested, set,
     forced to become ready "now" and so on. It is also possible for a CMSampleBuffer
     to contain nothing but a special buffer-level attachment that describles a media
     stream event(for example, "discontinuity:drain and reset decoder before processing
     the next CMSampleBuffer"). Such a special attachment can also be attached to regular
     CMSampleBuffers(i.e. that contain media sample data), and if so, the event it
     describles is defined to occur after the samples in that CMSampleBuffer.
     */
    
    
    /**
     Creating Sample Buffers
     
     CMSampleBufferCreate
     Creates a CMSampleBuffer.
     
     CMSampleBufferCreateReady
     Creates a CMSampleBuffer.
     
     CMSampleBufferCreateForImageBuffer
     Creates a CMSampleBuffer that contains a CVImageBuffer
     instead of a CMBlockBuffer.
     
     CMSampleBufferCreateReadyWithImageBuffer
     Creates a CMSampleBuffer that contains a CVImageBuffer
     instead of a CMBlockBuffer.
     
     CMAudioSampleBufferCreateWithPacketDescriptions
     Creates a CMSampleBuffer containing the audio for a
     given packetDescription instead of the sizing and timing
     information.
     
     CMAudioSampleBufferCreateReadyWithPacketDescriptions
     Creates a CMSampleBuffer containing the audio for a
     given packetDescription instead of the sizing and timing
     information.
     
     CMSampleBufferCreateCopy
     Creates a copy of a CMSampleBuffer
     
     CMSampleBufferCreateCopyWithNewTiming
     Creates a copy of CMSampleBuffer with new timing information.
     */
    
    /**
     Modify Sample Buffers
     
     CMSampleBufferCallBlockForEachSample
     Calls a block for every individual sample in a sample buffer.
     
     CMSampleBufferSetDataFailed
     Marks a sample buffer's data as "failed", to indicate that the data
     will not become ready.
     
     CMSampleBufferSetInvalidateHandler
     Sets the sample buffer's invalidation handler block, which is called
     during CMSampleBufferInvalidate.
     
     CMSampleBufferCallForEachSample
     Calls a function for every individual sample in a sample buffer.
     
     CMSampleBufferCopySampleBufferForRange
     Creates a CMSampleBuffer containing a range of samples from an
     existing CMSampleBuffer.
     
     CMSampleBufferInvalidate
     Makes the sample buffer invalid, calling any installed invalidation
     callback.
     
     CMSampleBufferMakeDataReady
     Makes a CMSampleBuffer data ready, by calling the client's
     CMSampleBufferMakeDataReadyCallback.
     
     CMSampleBufferSetDataBuffer
     Associates a CMSampleBuffer with its CMBlockBuffer of media data.
     
     CMSampleBufferSetDataReady
     Marks a CMSampleBuffer's data as "ready"

     CMSampleBufferSetInvalidateCallback
     Sets the CMSampleBuffer's invalidation callback, which is called
     during CMSampleBufferInvalidate.
     
     CMSampleBufferSetOutputPresentationTimeStamp
     Sets an output presentation timestamp to be used in place of
     a calculated value.
     
     CMSampleBufferTrackDataReadiness
     Associates a CMSampleBuffer's data readiness with another
     CMSampleBuffer's data readiness.
     */
    
    /**
     Inspecting Sample Buffers
     
     CMSampleBufferGetDataBuffer
     Returns a CMSampleBuffer's CMBlockBuffer of media data.
     
     CMSampleBufferGetDecodeTimeStamp
     Returns the numerically earliest decode timestamp of all the
     samples in a  CMSampleBuffer.
     
     CMSampleBufferGetDuration
     Returns the total duration of a CMSamplesBuffer.
     
     CMSampleBufferGetFormatDescription
     Returns the format description of the samples in a CMSampleBuffer.
     
     CMSampleBufferGetImageBuffer
     Returns a sample buffer's CVImageBuffer of media data.
     
     CMSampleBufferGetNumSamples
     Returns the number of media samples in a CMSampleBuffer.
     
     CMSampleBufferGetOutputDecodeTimeStamp
     Returns the output decode timestamp of the CMSampleBuffer.
     
     CMSampleBufferGetOutputDuration
     Returns the output duration of a CMSampleBuffer.
     
     CMSampleBufferGetOutputPresentationTimeStamp
     Returns the output presentation timestamp of the CMSampleBuffer.
     
     CMSampleBufferGetOutputSampleTimingInfoArray
     Retrieves an array of output CMSampleTimingInfo strcuts, one of
     each sample in a CMSampleBuffer.
     
     CMSampleBufferGetPresentationTimeStamp
     Returns the numerically earliest presentation timestamp of all the
     samples in a CMSampleBuffer.
     
     CMSampleBufferGetSampleAttachmentsArray
     Returns a reference to a CMSampleBuffer's immutable array of mutable
     sample attachment dictionaries(one dictionary per sample in the
     CMSampleBuffer.)
     
     CMSampleBufferGetSampeleSize
     Returns the size in bytes of a specified sampel in a CMSampleBuffer.
     
     CMSampleBufferGetSampleSizeArray
     Retrieves an array of sample sizes, one for each sample in a CMSampleBuffer.
     
     CMSampleBufferGetSampleTimingInfo
     Retrieves a CMSampleTimingInfo struct decribing a specified sample in a
     CMSampleBuffer.
     
     CMSampleBufferGetSampleTimingInfoArray
     Retrieves an array of CMSampleTimingInfo structs, one for each sample
     in a CMSampleBuffer.
     
     CMSampleBufferGetTotalSampleSize
     Returns the total size in bytes of sample data in a CMSampleBuffer.
     
     CMSampleBufferHasDataFailed
     Indicates if the sample buffer's data loading request has failed.
     
     CMSampleBufferDataIsReady
     Determines if the sample buffer's data is ready.
     
     CMSampleBufferIsValid
     Queries whether a sample buffer is still valid.
     
     CMSampleBufferGetTypeID
     Returns the CFTypeID of CMSampleBuffer objects.
     */
    
    /**
     Working with Audio Samples
     
     CMSampleBufferGetAudioBufferListWithRetainedBlockBuffer
     Creates an AudioBufferList containing the data from the
     CMSampleBuffer, and a CMBlockBuffer which references the data
     in that AudioBufferList.
     
     CMSampleBufferGetAudioStreamPacketDescriptions
     Creates an array of AudioStreamPacketDescriptions for the variable
     bytes per packet or variable frames per packet audio data in the
     provided CMSampleBuffer.
     
     CMSampleBufferGetAudioStreamPacketDescriptionsPtr
     Retrieves a pointer to a constant array of AudioStreamPacketDescriptions
     for the variable bytes per packet or variable frames per packet audio data
     in the provided CMSampleBuffer.
     
     CMSampleBufferSetDataBufferFromAudioBufferList
     Creates a CMBlockBuffer containing a copy of the data from the
     AudioBufferList.
     
     CMSampleBufferCopyPCMDataIntoAudioBufferList
     Copies PCM audio data from the given sample buffer into a pre-populated
     AudioBufferList
     */
    
    
    /**
     Data Types
     
     CMBufferRef
     A reference to a CMBuffer Object.
     
     CMSampleBufferRef
     A reference to an immutable CMSampleBufferRef object.
     
     CMSampleBufferInvalidateCallback
     Client callback called by CMSampleBufferInvalidate.
     
     CMSampleBufferInvalidateHandler
     Client callback called by CMSampleBufferInvalidate.
     
     CMSampleBufferMakeDataReadyCallback
     Client callback called by CMSampleBufferMakeDataReady.
     
     CMItemIndex
     Data type for the item index.
     
     CMItemCount
     Data type for the item count.
     
     CMPersistentTrackID
     Data type for the persistent track ID.
     
     CMSampleTimingInfo
     A collection of timing information for a sample in a CMSampleBuffer.
     
     CMBufferGetSizeCallback
     Client callback that returns a size_t from a CMBuffer.
     
     CMMuxedStreamType
     Muxed media format/subtype.
     */
    
    /**
     Constants
     
     Sample Buffer Notifications
     Notifications posted by sample buffer objects.
     kCMSampleBufferNotification_DataBecameReady
     kCMSampleBufferNotification_DataFailed
     kCMSampleBufferConduitNotification_InhibitOutputUntil
     kCMSampleBufferConduitNotification_ResetOutput
     kCMSampleBufferConduitNotification_UpcomingOutputPTSRangeChanged
     kCMSampleBufferConsumerNotification_BufferConsumed
     
     
     Sample Buffer Notification Parameters
     Keys used in the userInfo dictionaries of notifications posted by sample buffer objects.
     kCMSampleBufferConduitNotificationParameter_ResumeTag
     kCMSampleBufferConduitNotificationParameter_UpcomingOutputPTSRangeMayOverlapQueuedOutputPTSRange
     kCMSampleBufferConduitNotificationParameter_MinUpcomingOutputPTS
     kCMSampleBufferConduitNotificationParameter_MaxUpcomingOutputPTS
     kCMSampleBufferNotificationParameter_OSStatus
     
     
     Sample Attachment Keys
     Attachments associated with individual samples in a buffer.
     kCMSampleAttachmentKey_NotSync
     kCMSampleAttachmentKey_PartialSync
     kCMSampleAttachmentKey_HasRedundantCoding
     kCMSampleAttachmentKey_IsDependedOnByOthers
     kCMSampleAttachmentKey_DependsOnOthers
     kCMSampleAttachmentKey_EarlierDisplayTimesAllowed
     kCMSampleAttachmentKey_DisplayImmediately
     kCMSampleAttachmentKey_DoNotDisplay

     Sample Buffer Attachment Keys
     Buffer-level attachments associated with a sample buffer.
     kCMSampleBufferAttachmentKey_ForceKeyFrame
     kCMSampleBufferAttachmentKey_StillImageLensStabilizationInfo
     kCMSampleBufferAttachmentKey_ResetDecoderBeforeDecoding
     kCMSampleBufferAttachmentKey_DrainAfterDecoding
     kCMSampleBufferAttachmentKey_PostNotificationWhenConsumed
     kCMSampleBufferAttachmentKey_ResumeOutput
     kCMSampleBufferAttachmentKey_TransitionID
     kCMSampleBufferAttachmentKey_TrimDurationAtStart
     kCMSampleBufferAttachmentKey_TrimDurationAtEnd
     kCMSampleBufferAttachmentKey_SpeedMultiplier
     kCMSampleBufferAttachmentKey_Reverse
     kCMSampleBufferAttachmentKey_FillDiscontinuitiesWithSilence
     kCMSampleBufferAttachmentKey_EmptyMedia
     kCMSampleBufferAttachmentKey_PermanentEmptyMedia
     kCMSampleBufferAttachmentKey_DisplayEmptyMediaImmediately
     kCMSampleBufferAttachmentKey_EndsPreviousSampleDuration
     kCMSampleBufferAttachmentKey_SampleReferenceURL
     kCMSampleBufferAttachmentKey_SampleReferenceByteOffset
     kCMSampleBufferAttachmentKey_GradualDecoderRefresh
     kCMSampleBufferAttachmentKey_DroppedFrameReason
     kCMSampleBufferAttachmentKey_DroppedFrameReasonInfo

     
     Sample Buffer Dropped Frame Reasons
     Values providing the reason for a dropped frame.
     kCMSampleBufferDroppedFrameReason_FrameWasLate
     kCMSampleBufferDroppedFrameReason_OutOfBuffers
     kCMSampleBufferDroppedFrameReason_Discontinuity

     
     Sample Buffer Dropped Frame Reason Information
     Values providing additional information about the reason for a dropped frame.
     kCMSampleBufferDroppedFrameReasonInfo_CameraModeSwitch

     
     Sample Buffer Lens Stabilization Reasons
     Values providing the reason for lens stabilization.
     kCMSampleBufferLensStabilizationInfo_Active
     kCMSampleBufferLensStabilizationInfo_OutOfRange
     kCMSampleBufferLensStabilizationInfo_Unavailable
     kCMSampleBufferLensStabilizationInfo_Off

     
     Audio Buffer Alignment Constants
     Flags passed to various audio-related functions.
     kCMSampleBufferFlag_AudioBufferList_Assure16ByteAlignment
     */
    
    
    /*
     CMBlockBuffer
     
     An object used to move blocks of memory through a processing
     system.
     
     A CMBlockBuffer is a CFType object that represents a contiguous
     range of data offsets (from zero to CMBlockBufferGetDataLength)
     across a possibly noncontiguous memory region. The memory region
     is composed of memory blocks and buffer references. The buffer
     references can in turn refer to additional regions. CMBlockBuffer
     uses CMAttachment protocol to propagate attachments.
     */
    
    /**
     Creating Block Buffers
     
     CMBlockBufferCreateWithMemoryBlock
     Creates a new CMBlockBuffer backed by a memory block (or promise
     thereof).
     
     CMBlockBufferCreateContiguous
     Creates a new CMBlockBuffer containing a contiguous copy of, or
     reference to, the data specified by the parameters.
     
     CMBlockBufferCreateWithBufferReference
     Creates a new CMBlockBuffer that refers to another CMBlockBuffer.
     
     CMBlockBufferCreateEmpty
     Creates an empty CMBlockBuffer.
     */
    
    /**
     Modifying Block Buffers
     
     CMBlockBufferAppendBufferReference
     Adds a CMBlockBuffer reference to an existing CMBlockBuffer.
     
     CMBlockBufferAppendMemoryBlock
     Adds a memory block to an existing CMBlockBuffer.
     
     CMBlockBufferAccessDataBytes
     Accesses potentially noncontiguous data in a CMBlockBuffer.
     
     CMBlockBufferFillDataBytes
     Fills the destination buffer with the specified data byte.
     
     CMBlockBufferReplaceDataBytes
     Copies bytes from a given memory block into a CMBlockBuffer,
     replacing bytes in the underlying data blocks.
     
     CMBlockBufferAssureBlockMemory
     Assures all memory blocks in a CMBlockBuffer are allocated.
     
     CMBlockBufferCopyDataBytes
     Copies bytes from a CMBlockBuffer into a provided memory area.
     */
    
    /**
     Inspecting Block Buffers
     
     CMBlockBufferGetDataLength
     Obtains the total length of data reachable via a CMBlockBuffer
     
     CMBlockBufferGetDataPointer
     Gains access to the data represented by a CMBlockBuffer.
     
     CMBlockBufferIsEmpty
     Determines whether the given CMBlockBuffer is empty.
     
     CMBlockBufferIsRangeContiguous
     Determines whether the specified range within the given CMBlockBuffer
     is contiguous.
     
     CMBlockBufferGetTypeID
     Obtains the CoreFoundation type ID for the CMBlockBuffer type.
     */
    
    /**
     Data Types
     
     CMBlockBufferRef
     A reference to a CMBlockBuffer object.
     
     CMBlockBufferFlags
     Type used for parameters containing CMBlockBuffer feature and control flags.
     
     CMBlockBufferCustomBlockSource
     Structure to support custom memory allocation and/or deallocation for the
     block used in a CMBlockBuffer.
     */
        
    /**
     Constants
     
     CMBlockBuffer Flags
     kCMBlockBufferAssureMemoryNowFlag
     kCMBlockBufferAlwaysCopyDataFlag
     kCMBlockBufferDontOptimizeDepthFlag
     kCMBlockBufferPermitEmptyReferenceFlag

     Custom Block Source Version
     kCMBlockBufferCustomBlockSourceVersion

     Block Buffer Error Codes
     kCMBlockBufferBadCustomBlockSourceErr
     kCMBlockBufferBadLengthParameterErr
     kCMBlockBufferBadOffsetParameterErr
     kCMBlockBufferBadPointerParameterErr
     kCMBlockBufferBlockAllocationFailedErr
     kCMBlockBufferEmptyBBufErr
     kCMBlockBufferInsufficientSpaceErr
     kCMBlockBufferNoErr
     kCMBlockBufferStructureAllocationFailedErr
     kCMBlockBufferUnallocatedBlockErr
     */
    
    
    /*
     CMFormatDescription
     
     A media format descriptor that describes the samples in a sample
     buffer.
     
     CMFormatDescriptions are immutable Core Foundation objects that describe
     media data of various types, including audio, video, and muxed media data.
     There are two types of API: media-type-agnostic APIs (supported by all
     CMFormatDescriptions) and media-type-specific APIs. The media-type-agnostic
     APIs are prefixed with CMFormatDescription, and the media-type-specific APIs
     are prefixed with CMAudioFormatDescription, CMVideoFormatDescription, and so on.
     */
    
    /**
     Common Functions
     
     CMFormatDescriptionCreate
     Creates a generic CMFormatDescription object. You should not call this method
     for the media types that has specific create functions such as audio, video,
     text, muxed, metaData and timeCode.
     
     CMFormatDescriptionEqual
     Compares two CMFormatDescription objects for equality.
     
     CMFormatDescriptionEqualIgnoringExtensionKeys
     Compares two CMFormatDescription objects for equality, ignoring differences
     in the specified lists of format description extension keys and sample
     description extension keys.
     
     CMFormatDescriptionGetExtension
     Returns the specified extension of a CMFormatDescription.
     
     CMFormatDescriptionGetExtensions
     Returns an immutable dictionary containing all the extensions of a CMFormatDescription.
     
     CMFormatDescriptionGetMediaSubType
     Returns the media subtype of a CMFormatDescription.
     
     CMFormatDescriptionGetMediaType
     Returns the media type of a CMFormatDescription.
     
     CMFormatDescriptionGetTypeID
     Returns the CFTypeID of CMFormatDescription objects.
     */
    
    /**
     Audio-Specific Functions
     
     CMAudioFormatDescriptionCreateSummary
     Creates a summary audio format description from an array of audio format
     descriptions.
     
     CMAudioFormatDescriptionCreate
     Creates a format description for an audio media stream.
     
     CMAudioFormatDescriptionEqual
     Evaluates equality for the specified parts of two audio format descriptions.
     
     CMAudioFormatDescriptionGetChannelLayout
     Returns a read-only pointer to (and size of) the AudioChannelLayout
     inside an audio CMFormatDescription.
     
     CMAudioFormatDescriptionGetFormatList
     Returns a read-only pointer to (and size of) the array of AudioFormatListItem
     structs inside an audio CMFormatDescription.
     
     CMAudioFormatDescriptionGetMagicCookie
     Returns a read-only pointer to (and size of) the magic cookie
     inside an audio CMFormatDescription.
     
     CMAudioFormatDescriptionGetMostCompatibleFormat
     Returns a read-only pointer to the appropriate AudioFormatListItem
     inside an audio CMFormatDescription.
     
     CMAudioFormatDescriptionGetRichestDecodableFormat
     Returns a read-only pointer to the appropriate AudioFormatListItem inside
     an audio CMFormatDescription.
     
     CMAudioFormatDescriptionGetStreamBasicDescription
     Returns a read-only pointer to the AudioStreamBasicDescription inside an
     audio CMFormatDescription.
     
     CMDoesBigEndianSoundDescriptionRequireLegacyCBRSampleTableLayout
     Examine a big-endian SoundDescription data structure in a CMBlockBuffer,
     and report whether the sample tables will need to use the legacy CBR layout.
     
     CMSwapBigEndianSoundDescriptionToHost
     Converts a SoundDescription data structure from big-endian to host-endian in place.
     
     CMSwapHostEndianSoundDescriptionToBig
     Converts a SoundDescription data structure from host-endian to big-endian in place.
     
     CMAudioFormatDescriptionCreateFromBigEndianSoundDescriptionData
     Creates a CMAudioFormatDescription from a big-endian SoundDescription data structure.
     
     CMAudioFormatDescriptionCreateFromBigEndianSoundDescriptionBlockBuffer
     Creates a CMAudioFormatDescription from a big-endian SoundDescription data structure
     in a CMBlockBuffer.
     
     CMAudioFormatDescriptionCopyAsBigEndianSoundDescriptionBlockBuffer
     Copies the contents of a CMAudioFormatDescription to a CMBlockBuffer in
     big-endian byte ordering.
     */
    
    
    /**
     Video-Specific Functions
     
     CMVideoFormatDescriptionCreate
     Creates a format description for a video media stream.
     
     CMVideoFormatDescriptionCreateForImageBuffer
     Creates a format description for a video media stream contained in CVImageBuffers
     of the type provided.
     
     CMVideoFormatDescriptionGetCleanAperture
     Returns the clean aperture.
     
     CMVideoFormatDescriptionGetDimensions
     Returns the video dimensions (in encoded pixels).
     
     CMVideoFormatDescriptionGetExtensionKeysCommonWithImageBuffers
     Returns an array of the keys that are used both as CMVideoFormatDescription
     extensions and CVImageBuffer attachments and attributes.
     
     CMVideoFormatDescriptionGetPresentationDimensions
     Returns the dimensions, adjusted to take pixel aspect ratio and/or
     clean aperture into account.
     
     CMVideoFormatDescriptionMatchesImageBuffer
     Checks to see if a given format description matches an image buffer.
     
     CMVideoFormatDescriptionCreateFromH264ParameterSets
     Creates a format description for a video media stream described
     by H.264 parameter set NAL units.
     
     CMVideoFormatDescriptionGetH264ParameterSetAtIndex
     Returns a parameter set contained in a H.264 format description.
     
     CMVideoFormatDescriptionCopyAsBigEndianImageDescriptionBlockBuffer
     Copies the contents of a CMVideoFormatDescription to a CMBlockBuffer
     in big-endian byte ordering.
     
     CMVideoFormatDescriptionCreateFromBigEndianImageDescriptionBlockBuffer
     Creates a CMVideoFormatDescription from a big-endian ImageDescription
     data structure in a CMBlockBuffer.
     
     CMVideoFormatDescriptionCreateFromBigEndianImageDescriptionData
     Creates a CMVideoFormatDescription from a big-endian ImageDescription
     data structure.
     
     CMSwapBigEndianImageDescriptionToHost
     Converts an ImageDescription data structure from big-endian to
     host-endian in place.
     
     CMSwapHostEndianImageDescriptionToBig
     Converts an ImageDescription data structure from host-endian to
     big-endian in place.
     */
    
    
    /**
     Muxed-Specific Function
     
     CMMuxedFormatDescriptionCreate
     Creates a format description for a muxed media stream.
     */
    
    
    /**
     Metadata-Specific Functions
     
     CMMetadataFormatDescriptionCreateWithKeys
     Creates a metadata format description object specified by the key.
     
     CMMetadataFormatDescriptionGetKeyWithLocalID
     Returns the key associated with the metadata for the given local id.
     
     CMMetadataFormatDescriptionCopyAsBigEndianMetadataDescriptionBlockBuffer
     Copies the contents of a CMMetadataFormatDescription to a CMBlockBuffer
     in big-endian byte ordering.
     
     CMMetadataFormatDescriptionCreateByMergingMetadataFormatDescriptions
     
     CMMetadataFormatDescriptionCreateFromBigEndianMetadataDescriptionBlockBuffer
     Creates a CMMetadataFormatDescription from a big-endian MetadataDescription
     data structure in a CMBlockBuffer.
     
     CMMetadataFormatDescriptionCreateFromBigEndianMetadataDescriptionData
     Creates a CMMetadataFormatDescription from a big-endian MetadataDescription
     data structure.
     
     CMMetadataFormatDescriptionCreateWithMetadataFormatDescriptionAndMetadataSpecifications
     Creates a new CMMetadataFormatDescription.
     
     CMMetadataFormatDescriptionCreateWithMetadataSpecifications
     Creates a new CMMetadataFormatDescription.
     
     CMSwapBigEndianMetadataDescriptionToHost
     Converts a MetadataDescription data structure from big-endian to
     host-endian in place.
     
     CMSwapHostEndianMetadataDescriptionToBig
     Converts a MetadataDescription data structure from host-endian to
     big-endian in place.
     
     CMMetadataFormatDescriptionGetIdentifiers
     Gets an array of metadata identifiers from a metadata format description.
     */
    
    
    /**
     Text-Specific Functions
     
     CMTextFormatDescriptionGetDefaultStyle
     Returns the default style.
     
     CMTextFormatDescriptionGetDefaultTextBox
     Returns the default text box.
     
     CMTextFormatDescriptionGetDisplayFlags
     Returns the displayFlags.
     
     CMTextFormatDescriptionGetFontName
     Returns the font name for a local font ID.
     
     CMTextFormatDescriptionGetJustification
     Returns horizontal and vertical justification.
     
     CMTextFormatDescriptionCopyAsBigEndianTextDescriptionBlockBuffer
     Copies the contents of a CMTextFormatDescription to a CMBlockBuffer
     in big-endian byte ordering.
     
     CMTextFormatDescriptionCreateFromBigEndianTextDescriptionBlockBuffer
     Creates a CMTextFormatDescription from a big-endian TextDescription
     data structure in a CMBlockBuffer.
     
     CMTextFormatDescriptionCreateFromBigEndianTextDescriptionData
     Creates a CMTextFormatDescription from a big-endian TextDescription
     data structure.
     
     CMSwapBigEndianTextDescriptionToHost
     Converts a TextDescription data structure from big-endian to host-endian
     in place.
     
     CMSwapHostEndianTextDescriptionToBig
     Converts a TextDescription data structure from host-endian to
     big-endian in place.
     */
    
    
    /**
     TimeCode-Specific Functions
     
     CMTimeCodeFormatDescriptionCreate
     Creates a format description for a timecode media.
     
     CMTimeCodeFormatDescriptionGetFrameDuration
     Returns the duration of each frame (for example 100/2997).
     
     CMTimeCodeFormatDescriptionGetFrameQuanta
     Returns the frames/sec for timecode (for example, 30) or
     frames/tick for counter mode.
     
     CMTimeCodeFormatDescriptionGetTimeCodeFlags
     Returns the flags for kCMTimeCodeFlag_DropFrame,
     kCMTimeCodeFlag_24HourMax, kCMTimeCodeFlag_NegTimesOK
     
     CMTimeCodeFormatDescriptionCopyAsBigEndianTimeCodeDescriptionBlockBuffer
     Copies the contents of a CMTimeCodeFormatDescription to a
     CMBlockBuffer in big-endian byte ordering.
     
     CMTimeCodeFormatDescriptionCreateFromBigEndianTimeCodeDescriptionBlockBuffer
     Creates a CMTimeCodeFormatDescription from a big-endian
     TimeCodeDescription data structure in a CMBlockBuffer.
     
     CMTimeCodeFormatDescriptionCreateFromBigEndianTimeCodeDescriptionData
     Creates a CMTimeCodeFormatDescription from a big-endian
     TimeCodeDescription data structure.
     
     CMSwapBigEndianTimeCodeDescriptionToHost
     Converts a TimeCodeDescription data structure from big-endian
     to host-endian in place.
     
     CMSwapHostEndianTimeCodeDescriptionToBig
     Converts a TimeCodeDescription data structure from host-endian
     to big-endian in place.
     */
    
    
    /**
     Closed Captioning-Functions
     
     CMClosedCaptionFormatDescriptionCopyAsBigEndianClosedCaptionDescriptionBlockBuffer
     Copies the contents of a CMClosedCaptionFormatDescription to a
     CMBlockBuffer in big-endian byte ordering.
     
     CMClosedCaptionFormatDescriptionCreateFromBigEndianClosedCaptionDescriptionBlockBuffer
     Creates a CMClosedCaptionFormatDescription from a big-endian
     ClosedCaptionDescription data structure in a CMBlockBuffer.
     
     CMClosedCaptionFormatDescriptionCreateFromBigEndianClosedCaptionDescriptionData
     Creates a CMClosedCaptionFormatDescription from a big-endian
     ClosedCaptionDescription data structure.
     
     CMSwapHostEndianClosedCaptionDescriptionToBig
     Converts a ClosedCaptionDescription data structure from host-endian
     to big-endian in place.
     
     CMSwapBigEndianClosedCaptionDescriptionToHost
     Converts a ClosedCaptionDescription data structure from
     big-endian to host-endian in place.
     */
    
    
    /**
     Format Description Types
     
     CMFormatDescriptionRef
     A reference to a CMFormatDescription object.
     
     CMAudioFormatDescriptionRef
     A synonym type used for manipulating audio CMFormatDescriptions.
     
     CMClosedCaptionFormatDescriptionRef
     A synonym type used for manipulating closed-caption media CMFormatDescriptions.
     
     CMMetadataFormatDescriptionRef
     A synonym type used for manipulating metadata CMFormatDescriptions.
     
     CMMuxedFormatDescriptionRef
     A synonym type used for manipulating muxed media CMFormatDescriptions.
     
     CMTextFormatDescriptionRef
     
     CMTimeCodeFormatDescriptionRef
     A synonym type used for manipulating TimeCode CMFormatDescriptions.
        
     CMVideoFormatDescriptionRef
     A synonym type used for manipulating video CMFormatDescriptions.
     */
    
    
    /**
     Data Types
     
     CMSubtitleFormatType
     
     CMAudioFormatDescriptionRef
     A synonym type used for manipulating audio CMFormatDescriptions.
     
     CMAudioFormatDescriptionMask
     A type for mask bits passed to (and returned from) CMFormatDescription,
     representing various parts of an audio format description.
     
     CMVideoDimensions
     Type used for video dimensions.
     
     CMMediaType
     The type of media described by a CMFormatDescription.
     
     CMTimeCodeFormatType
     The types of time Code.
     
     CMTextFormatType
     Text media format/subtype.
     
     CMAudioCodecType
     Codes to identify audio codecs.
     
     CMMuxedStreamType
     
     CMClosedCaptionFormatType
     Four-character codes identifying closed-caption media format types.
     
     CMPixelFormatType
     Four-character codes identifying pixel formats.
     
     CMVideoCodecType
     Four-character codes identifying the video codec.
     
     CMAudioCodecType
     
     CMMetadataFormatType
     The types of TimedMetadata.
     
     CMSubtitleFormatType
     
     CMTimeCodeFormatType
     
     CMMetadataFormatType
     
     CMTextDisplayFlags
     Display mode flags for text media.
     
     CMTextJustificationValue
     Justification modes for text media.
     */
    
    /**
     Constants
     
     CMTextFormatDescription Constants
     kCMTextFormatDescriptionExtension_DisplayFlags
     The value is a CFNumber (an SInt32 holding CMTextDisplayFlags).
     
     kCMTextFormatDescriptionExtension_BackgroundColor
     The value is a CFDictionary.
     
     kCMTextFormatDescriptionColor_Red
     The value is a CFNumber (SInt8 for 3G), (SInt16 for QT).
     
     kCMTextFormatDescriptionColor_Green
     The value is a CFNumber (SInt8 for 3G), (SInt16 for QT).
     
     kCMTextFormatDescriptionColor_Blue
     The value is a CFNumber (SInt8 for 3G), (SInt16 for QT).
     
     kCMTextFormatDescriptionColor_Alpha
     The value is a CFNumber (SInt8 for 3G), not applicable for QT text.
     
     kCMTextFormatDescriptionExtension_DefaultTextBox
     The value is a CFDictionary.
     
     kCMTextFormatDescriptionRect_Top
     The value is a CFNumber (SInt16).
     
     kCMTextFormatDescriptionRect_Left
     The value is a CFNumber (SInt16).
     
     kCMTextFormatDescriptionRect_Bottom
     The value is a CFNumber (SInt16).
     
     kCMTextFormatDescriptionRect_Right
     The value is a CFNumber (SInt16).
     
     kCMTextFormatDescriptionExtension_DefaultStyle
     The value is a CFDictionary.
     
     kCMTextFormatDescriptionStyle_StartChar
     The value is a CFNumber (SInt16 for 3G), (SInt32 for QT).
     
     kCMTextFormatDescriptionStyle_Font
     The value is a CFNumber (SInt16).
     
     kCMTextFormatDescriptionStyle_FontFace
     The value is a CFNumber (SInt8).
     
     kCMTextFormatDescriptionStyle_ForegroundColor
     The value is a CFDictionary.
     
     kCMTextFormatDescriptionExtension_HorizontalJustification
     The value is a CFNumber (SInt8) containing a CMTextJustificationValue.
     
     kCMTextFormatDescriptionExtension_VerticalJustification
     The value is a CFNumber (SInt8) containing a CMTextJustificationValue.
     
     kCMTextFormatDescriptionStyle_EndChar
     The value is a CFNumber (SInt16).
     
     kCMTextFormatDescriptionExtension_FontTable
     The value is a CFDictionary.
     
     kCMTextFormatDescriptionExtension_TextJustification
     The value is a CFNumber (SInt8) containing a CMTextJustificationValue.
     
     kCMTextFormatDescriptionStyle_Height
     The value is a CFNumber (SInt16).
     
     kCMTextFormatDescriptionStyle_Ascent
     The value is a CFNumber (SInt16).
     
     kCMTextFormatDescriptionExtension_DefaultFontName
     The value is a CFString.
     
     kCMTextFormatDescriptionStyle_FontSize
     */
    
    
    /*
     CMAttachment
     
     An API for attaching additional metadata to a sample buffer.
     
     This document describes the Core Media attachment protocol. A
     CMAttachmentBearer is a CF-based object that supports the suite
     of key/value/mode attachment APIs. You can attach any CF object to a
     CMAttachmentBearer object to store additional information.
     */
    
    /**
     Processing Attachments
     
     CMGetAttachment
     Returns a specific attachment of a CMAttachmentBearer.
     
     CMSetAttachment
     Sets or adds an attachment of a CMAttachmentBearer.
     
     CMSetAttachments
     Sets a set of attachments for a CMAttachmentBearer.
     
     CMRemoveAttachment
     Removes a specific attachment of a CMAttachmentBearer.
     
     CMRemoveAllAttachments
     Removes all attachments of a CMAttachmentBearer.
     
     CMPropagateAttachments
     Copies all attachments that can be propagated from one
     CMAttachmentBearer to another.

     CMCopyDictionaryOfAttachments
     Returns all attachments of a CMAttachmentBearer.
     */
    
    /**
     Data Types
     
     CMAttachmentBearerRef
     Type for objects that can bear attachments.
     
     CMAttachmentMode
     Type to specify attachment modes.
    */
    
    /**
     Constants
     
     Attachment Modes
     kCMAttachmentMode_ShouldNotPropagate
     Do not propagate this attachment.
     
     kCMAttachmentMode_ShouldPropagate
     Copy this attachment when using the CMPropagateAttachments function.
     */
    
        
#pragma mark -- Time Representation
    
    /*
     CMTime
     A struct representing a time value such as a timestamp or duration.
     
     This document describles the API for creating and manipulating CMTime
     structs.
     
     CMTime structs are non-opaque mutable structs representing times
     (either timestamps or durations).
     
     A CMTime is represented as a rational number, with a numerator(an
     int64_t value), and a denominator(an int32_t timescale). Conceptually,
     the timescale specifies the fraction of a second each unit in the numerator
     occupies. Thus if the timescale is 4, each unit represents a quarter
     of a second; if the timescale is 10, each unit represents a tenth of a
     second, and so on. In addition to a simple time value, a CMTime can
     represent non-numeric values: +infinity, -infinity, and indefinite.
     Using a flag CMTime indicates whether the time been rounded at some
     point.

     CMTimes contain an epoch number, which is usually set to 0, but
     can be used to distinguish unrelated timelines: for example, it
     could be incremented each time through a presentation loop, to
     differentiate between time N in loop 0 from time N in loop 1.
     
     You can convert CMTimes to and from immutable CFDictionaries
     (see CFDictionaryRef) using CMTimeCopyAsDictionary and
     CMTimeMakeFromDictionary, for use in annotations and various Core
     Foundation containers.
     
     Additional functions for managing dates and times are described in
     Time Utilities. Note that CMTime is designed for media timelines
     whereas functions in Time Utilities Reference are designed for
     working with wall-clock time in Core Foundation framework; see
     also AVFoundation Constants.
     */
    
    /**
     Creating Times
     */
//    CMTimeMake(<#int64_t value#>, <#int32_t timescale#>)
//    CMTimeMakeFromDictionary(<#CFDictionaryRef  _Nullable dictionaryRepresentation#>)
//    CMTimeMakeWithEpoch(<#int64_t value#>, <#int32_t timescale#>, <#int64_t epoch#>)
//    CMTimeMakeWithSeconds(<#Float64 seconds#>, <#int32_t preferredTimescale#>)
    
    /**
     Performing Common Operations
     */
//    CMTimeAdd(<#CMTime lhs#>, <#CMTime rhs#>)
//    CMTimeSubtract(<#CMTime lhs#>, <#CMTime rhs#>)
//    CMTimeMultiply(<#CMTime time#>, <#int32_t multiplier#>)
//    CMTimeMultiplyByFloat64(<#CMTime time#>, <#Float64 multiplier#>)
//    CMTimeMultiplyByRatio(<#CMTime time#>, <#int32_t multiplier#>, <#int32_t divisor#>)
//    CMTimeConvertScale(<#CMTime time#>, <#int32_t newTimescale#>, <#CMTimeRoundingMethod method#>)
    
    /**
     Inspecting and Evaluating Times
     */
//    CMTimeCompare(<#CMTime time1#>, <#CMTime time2#>)
//    CMTimeAbsoluteValue(<#CMTime time#>)
//    CMTimeGetSeconds(<#CMTime time#>)
//    CMTimeMaximum(<#CMTime time1#>, <#CMTime time2#>)
//    CMTimeMinimum(<#CMTime time1#>, <#CMTime time2#>)
//    CMTIME_IS_VALID
//    CMTIME_IS_INVALID
//    CMTIME_IS_POSITIVE_INFINITY
//    CMTIME_IS_NEGATIVE_INFINITY
//    CMTIME_IS_INDEFINITE
//    CMTIME_IS_NUMERIC
//    CMTIME_HAS_BEEN_ROUNDED
//    CMTIME_COMPARE_INLINE

    /**
     Utility Functions
     */
//    CMTimeShow(<#CMTime time#>)
//    CMTimeCopyDescription(<#CFAllocatorRef  _Nullable allocator#>, <#CMTime time#>)
//    CMTimeCopyAsDictionary(<#CMTime time#>, <#CFAllocatorRef  _Nullable allocator#>)
    
    /**
     Data Types
     */
//    CMTime
//    CMTimeValue
//    CMTimeScale
//    CMTimeEpoch
//    CMTimeFlags
//    CMTimeRoundingMethod
    
    /**
     Constants
     
     Time Constants
     kCMTimeInvalid
     kCMTimeIndefinite
     kCMTimePositiveInfinity
     kCMTimeNegativeInfinity
     kCMTimeZero

     Maximum Timescale
     kCMTimeMaxTimescale

     Rounding Methods
     kCMTimeRoundingMethod_RoundHalfAwayFromZero
     kCMTimeRoundingMethod_RoundTowardZero
     kCMTimeRoundingMethod_RoundAwayFromZero
     kCMTimeRoundingMethod_QuickTime
     kCMTimeRoundingMethod_RoundTowardPositiveInfinity
     kCMTimeRoundingMethod_RoundTowardNegativeInfinity
     kCMTimeRoundingMethod_Default

     Dictionary Keys
     kCMTimeValueKey
     kCMTimeScaleKey
     kCMTimeEpochKey
     kCMTimeFlagsKey
     */
    
    
    /*
     CMTimeRange
     
     This document describes the API for creating and manipulating
     CMTimeRange structures.
     
     CMTimeRange structs are non-opaque mutable structures that
     represent time ranges. A CMTimeRange is represented as two
     CMTime structs, one that specifies the start time of the range
     and another that specifies the duration of the range. A time
     range does not include the end time that would be calculated
     by adding the duration to the start time. The following expression
     will always evaluate to false:

     You can convert CMTimeRanges to and from CFDictionaries
     (see CFDictionaryRef) using CMTimeRangeCopyAsDictionary
     and CMTimeRangeMakeFromDictionary, for use in annotations
     and various Core Foundation containers.
     
     The epoch in a CMTime that represents a duration should
     always be 0, and the value must be non-negative. The epoch
     in a CMTime that represents a timestamp may be non-zero,
     but range operations (such as CMTimeRangeGetUnion) can only
     be performed on ranges whose start fields have the same epoch.
     CMTimeRanges cannot span different epochs.
     
     Additional functions for managing dates and times are described
     in Time Utilities; see also AVFoundation Constants.
     */
    
    /**
     Creating Time Ranges
     */
//    CMTimeRangeMake(<#CMTime start#>, <#CMTime duration#>)
//    CMTimeRangeMakeFromDictionary(<#CFDictionaryRef  _Nonnull dictionaryRepresentation#>)
//    CMTimeRangeFromTimeToTime(<#CMTime start#>, <#CMTime end#>)
    
    /**
     Comparing Time Ranges
     */
//    CMTimeRangeEqual(<#CMTimeRange range1#>, <#CMTimeRange range2#>)
//    CMTimeRangeContainsTime(<#CMTimeRange range#>, <#CMTime time#>)
//    CMTimeRangeContainsTimeRange(<#CMTimeRange range#>, <#CMTimeRange otherRange#>)
    
    /**
     Inspecting Time Ranges
     
     CMTIMERANGE_IS_EMPTY
     CMTIMERANGE_IS_INDEFINITE
     CMTIMERANGE_IS_INVALID
     CMTIMERANGE_IS_VALID
     */
//    CMTimeRangeGetEnd(<#CMTimeRange range#>)
//    CMTimeRangeGetIntersection(<#CMTimeRange range#>, <#CMTimeRange otherRange#>)
//    CMTimeRangeGetUnion(<#CMTimeRange range#>, <#CMTimeRange otherRange#>)
    
    /**
     Utility Functions
     */
//    CMTimeClampToRange(CMTime time, <#CMTimeRange range#>)
//    CMTimeMapDurationFromRangeToRange(<#CMTime dur#>, <#CMTimeRange fromRange#>, <#CMTimeRange toRange#>)
//    CMTimeMapTimeFromRangeToRange(<#CMTime t#>, <#CMTimeRange fromRange#>, <#CMTimeRange toRange#>)
//    CMTimeRangeCopyDescription(<#CFAllocatorRef  _Nullable allocator#>, <#CMTimeRange range#>)
//    CMTimeRangeCopyAsDictionary(<#CMTimeRange range#>, <#CFAllocatorRef  _Nullable allocator#>)
//    CMTimeRangeShow(<#CMTimeRange range#>)
    
    /**
     Data types
     */
//    CMTimeRange
    
    /**
     Constants
     
     CFDictionary Keys
     kCMTimeRangeStartKey
     kCMTimeRangeDurationKey

     Pre-Specified Time Ranges
     kCMTimeRangeZero
     kCMTimeRangeInvalid
     */
    
    
    /*
     CMTimeMapping
     
     A struct used to specify the mapping of a segment of one
     time line into another.
     
     A CMTimeMapping specifies the mapping of a segment of one
     time line (called the source) into another time line
     (called the target). When used for movie edit lists, the
     source time line is the media and the target time line is
     the track or movie.
     */
    
    /**
     Creating Time Mappings
     */
//    CMTimeMappingMake(<#CMTimeRange source#>, <#CMTimeRange target#>)
//    CMTimeMappingMakeEmpty(<#CMTimeRange target#>)
//    CMTimeMappingMakeFromDictionary(<#CFDictionaryRef  _Nonnull dictionaryRepresentation#>)
    
    /**
     Performing Utility Operations
     */
//    CMTimeMappingCopyAsDictionary(<#CMTimeMapping mapping#>, <#CFAllocatorRef  _Nullable allocator#>)
//    CMTimeMappingCopyDescription(<#CFAllocatorRef  _Nullable allocator#>, <#CMTimeMapping mapping#>)
//    CMTimeMappingShow(<#CMTimeMapping mapping#>)
    
    /**
     Data Types
     */
//    CMTimeMapping
    
    /**
     Constants
     
     kCMTimeMappingInvalid
     kCMTimeMappingSourceKey
     kCMTimeMappingTargetKey
     */
    
    
#pragma mark -- Media Synchronization
    
    /*
     CMClock
     
     A reference clock used to synchronization applications and devices.
     
     The CMSync API provides a reference clock that you can use
     to synchronize applications and devices. This API also
     provides functions to monitor relative drift between CMClocks
     and functions that are associated with timer services.
     */
    
    
    
    
    
#pragma mark -- Text Markup
    
    
    
#pragma mark -- Metadata
    
    
    
#pragma mark -- Queues
    
    
    
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
