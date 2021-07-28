//
//  EditingViewController.m
//  VideoProcess
//
//  Created by tigerfly on 2020/10/15.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "EditingViewController.h"

@interface EditingViewController ()<AVVideoCompositionValidationHandling,AVVideoCompositing>
@property (nonatomic, strong) AVPlayerItem *playerItemForSnapshottedComposition;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@end

@implementation EditingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
#pragma mark -- Media Composition
    
    
//    AVComposition->AVCompositionTrack->AVCompositionTrackSegment
    /*
     AVComposition
     
     An object that combines media data from multiple file-based
     sources to present or process media data from multiple sources.
     
     At its top-level, AVComposition is a collection of tracks,
     each presenting media of a specific media type, e.g. audio or
     video, according to a timeline. Each track is represented by an
     instance of AVCompositionTrack. Each track is comprised of an
     array of track segments, represented by instances of
     AVCompositionTrackSegment. Each segment presents a portion
     of the media data stored in a source container, specified by
     URL, a track identifier, and a time mapping. The URL specifies
     the source container, and the track identifier indicates the
     track of the source container to be presented. All file-based
     audiovisual assets are eligible to be combined, regardless of
     container type.
     
     The time mapping specifies the temporal range of the source track
     that's to be presented and also specifies the temporal range of
     its presentation in the composition track. If the durations of
     the source and destination ranges of the time mapping are the
     same, the media data for the segment will be presented at its
     natural rate. Otherwise, the segment will be presented at a rate
     equal to the ratio source.duration / target.duration.
     
     You can access the track segments of a track using the segments
     property (an array of AVCompositionTrackSegment objects) of
     AVCompositionTrack. The collection of tracks with media type
     information for each, and each with its array of track segments
     (URL, track identifier, and time mapping), form a complete
     low-level representation of a composition. This representation
     can be written out by clients in any convenient form, and
     subsequently the composition can be reconstituted by instantiating
     a new AVMutableComposition with AVMutableCompositionTrack objects
     of the appropriate media type, each with its segments property set
     according to the stored array of URL, track identifier, and time
     mapping.
     
     A higher-level interface for constructing compositions is also
     presented by AVMutableComposition and AVMutableCompositionTrack,
     offering insertion, removal, and scaling operations without direct
     manipulation of the trackSegment arrays of composition tracks.
     This interface makes use of higher-level constructs such as AVAsset
     and AVAssetTrack, allowing the client to make use of the same
     references to candidate sources that it would have created in
     order to inspect or preview them prior to inclusion in a composition.
     */
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"sofia.mp4" withExtension:nil];
    NSURL *url_2 = [[NSBundle mainBundle] URLForResource:@"tiger fly 2020-10-10 15.58.59.mp4" withExtension:nil];
    AVAsset *asset = [AVAsset assetWithURL:url];
    AVAsset *asset_2 = [AVAsset assetWithURL:url_2];
    
    /**
     Accessing Initialization Options
     
     URLAssetInitializationOptions
     The initializationOptions for the creation of URL asset by the
     receiver.
     */
    AVComposition *composition = [AVComposition assetWithURL:url];
    NSLog(@"%@",composition.URLAssetInitializationOptions);
    
    
    
    /**
     Accessing Tracks
     
     tracks
     An array of composition track objects contained by the composition.
     
     - trackWithTrackID:
     Provides a composition track associated with the specified track ID.
     
     - tracksWithMediaCharacteristic:
     Provides the composition tracks of the specified media characteristic
     associated with an asset.
     
     - tracksWithMediaType:
     Provides the composition tracks of the specified media type associated
     with an asset.
     */
    NSLog(@"tracks %@",composition.tracks);
    NSLog(@"mediaType %@",[composition tracksWithMediaType:AVMediaTypeVideo]);

    
    /**
     Determining the Visual Dimensions
     
     naturalSize
     The authored size of the visual portion of the composition.
     */
    NSLog(@"naturalSize %@",NSStringFromCGSize(composition.naturalSize));
    
    
    
    /*
     AVCompositionTrack
     
     A track in a composition object, consisting of a media type, a track
     identifier, and track segments.
     
     The timeMapping.target.start of the first track segment in a
     composition track is kCMTimeZero, and the timeMapping.target.start
     of each subsequent track segment equals
     CMTimeRangeGetEnd(<#previousTrackSegment#>.timeMapping.target).

     The AVFoundation framework also provides a mutable subclass,
     AVMutableCompositionTrack.
     */
     
    
    
    /**
     Accessing Track segments
     
     segments
     The composition track’s track segments.
     
     - segmentForTrackTime:
     Returns the composition track segment from the segment array
     that either contains or is closest to the supplied track time.
     */
    
    
    /**
     Managing Format Descriptions
     
     formatDescriptionReplacements
     The replacement format descriptions.
     
     AVCompositionTrackFormatDescriptionReplacement
     An object that specifies an original format description together
     with its replacement format description.
     */

    
    
    /*
     AVCompositionTrackSegment
     
     A segment of a track, consisting of a URL, a track identifier,
     and a time mapping from the source track to the composition track.

     You typically use this class to save the low-level representation
     of a composition to storage formats of your choosing and to
     reconstitute them from storage.
     */
    
    /**
     Creating a Segment
     
     + compositionTrackSegmentWithTimeRange:
     Returns a composition track segment that presents an empty track segment.
     
     - initWithTimeRange:
     Initializes a track segment that presents an empty track segment.
     
     + compositionTrackSegmentWithURL:trackID:sourceTimeRange:targetTimeRange:
     Returns a composition track segment that presents a portion of a
     file referenced by a given URL.
     
     - initWithURL:trackID:sourceTimeRange:targetTimeRange:
     Initializes a track segment that presents a portion of a file
     referenced by a given URL.
     */

    
    /**
     Getting Segment Properties
     
     sourceURL
     The container file of the media presented by the track segment.
     
     sourceTrackID
     The track ID of the container file of the media presented
     by the track segment.
     
     empty
     A Boolean value that indicates whether the segment is empty.
     */
    
    
    
    /*
     AVMutableComposition

     A mutable object used to create a new composition from
     existing assets.

     This class provides the ability to add and remove tracks,
     and you can add, remove, and scale time ranges. You can make
     an immutable snapshot of a mutable composition for playback
     or inspection as follows:
     =======================================================
     AVMutableComposition *myMutableComposition =
         <#a mutable composition you want to inspect or play in its current state#>;
      
     AVComposition *immutableSnapshotOfMyComposition = [myMutableComposition copy];
      
     // Create a player to inspect and play the composition.
     AVPlayerItem *playerItemForSnapshottedComposition =
         [[AVPlayerItem alloc] initWithAsset:immutableSnapshotOfMyComposition
     =======================================================
     */

    /**
     Creating a Mutable Composition
     
     + compositionWithURLAssetInitializationOptions:
     Returns a new, empty, mutable composition.
     
     + composition
     Returns a new, empty, mutable composition.
     */
    AVMutableComposition *mutableComposition = [AVMutableComposition composition];
    
    /**
     Managing Time Ranges
     
     - insertEmptyTimeRange:
     Adds or extends an empty time range within all tracks of the
     composition.
     
     - insertTimeRange:ofAsset:atTime:error:
     Inserts all the tracks within a given time range of a specified
     asset into the receiver.
     
     - removeTimeRange:
     Removes a specified time range from all tracks of the composition.
     
     - scaleTimeRange:toDuration:
     Changes the duration of all tracks in a given time range.
     */
    
    NSError *error = nil;
    [mutableComposition insertTimeRange:CMTimeRangeMake(kCMTimeZero, CMTimeMake(10, 1)) ofAsset:asset_2 atTime:kCMTimeZero error:nil];
    [mutableComposition insertTimeRange:CMTimeRangeMake(kCMTimeZero, CMTimeMake(10, 1)) ofAsset:asset atTime:CMTimeMake(10, 1) error:&error];
    NSLog(@"error %@",error);
    
    /**
     Managing Tracks

     tracks
     An array of mutable composition tracks contained by the composition.
     
     - addMutableTrackWithMediaType:preferredTrackID:
     Adds an empty track to the receiver.
     
     - removeTrack:
     Removes a specified track from the receiver.
     
     - mutableTrackCompatibleWithTrack:
     Returns a track in the receiver into which any time range of a
     given asset track can be inserted.
     
     - trackWithTrackID:
     Provides a composition track associated with the specified
     track ID.
     
     - tracksWithMediaCharacteristic:
     Provides the composition tracks of the specified media characteristic
     associated with an asset.
     
     - tracksWithMediaType:
     Provides the composition tracks of the specified media type associated
     with an asset.
     */

    
    /**
     Configuring Video Size

     naturalSize
     The encoded or authored size of the visual portion of the asset.
     */
//    mutableComposition.naturalSize = CGSizeMake(100, 100);
    
    self.playerItemForSnapshottedComposition =
    [[AVPlayerItem alloc] initWithAsset:mutableComposition];
    self.player = [[AVPlayer alloc] initWithPlayerItem:self.playerItemForSnapshottedComposition];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    self.playerLayer.frame = [UIScreen mainScreen].bounds;
    [self.view.layer addSublayer:self.playerLayer];
    [self.player play];
    
    
    /*
     AVMutableCompositionTrack
     
     A mutable track in a composition object that you use to insert,
     remove, and scale track segments without affecting their
     low-level representation.

     AVCompositionTrack defines constraints for the temporal
     alignment of the track segments. If you set the array
     of track segments in a mutable composition (see segments),
     you can test whether the segments meet the constraints
     using validateTrackSegments:error:.
     */
    
    /**
     Configuring Track Properties
     
     enable
     
     languageCode
     The language associated with the track, as an ISO 639-2/T
     language code.

     extendedLanguageTag
     The language tag associated with the track, as an RFC 4646
     language tag.
     
     naturalTimeScale
     The time scale in which time values for the track can be operated
     upon without extraneous numerical conversion.
     
     preferredTransform
     The preferred transformation of the visual media data for
     display purposes.
     
     preferredVolume
     The preferred volume of the audible media data.
     */
    
    
    /**
     Managing Format Descriptions

     - replaceFormatDescription:withFormatDescription:
     */

    
    /**
     Associating Tracks
     
     - addTrackAssociationToTrack:type:
     Establishes a track association of a specific type between two tracks.
     
     - removeTrackAssociationToTrack:type:
     Removes a specific association type between two tracks.
     
     AVTrackAssociationType
     Constants that define the possible track association types.
     */
    
    
    /**
     Managing Time Ranges
     
     - insertEmptyTimeRange:
     Adds or extends an empty time range within the receiver.
     
     - insertTimeRange:ofTrack:atTime:error:
     Inserts a time range of a source track into a track of a composition.
     
     - insertTimeRanges:ofTracks:atTime:error:
     Inserts the time ranges of multiple source tracks into a track
     of a composition.
     
     - removeTimeRange:
     Removes a specified time range from the receiver.
     
     - scaleTimeRange:toDuration:
     Changes the duration of a time range in the receiver.
     
     segments
     The track segments from a composition track.
     */
    
    
    /**
     Validating Segments
     
     - validateTrackSegments:error:
     Returns a Boolean value that indicates whether a given
     array of track segments conform to the timing rules for a
     composition track.
     */
    
    
    
#pragma mark -- Moive Editing
    
    /*
     AVMovie
     
     An object that represents the audiovisual containers that
     conform to a QuickTime or ISO-based media file format.

     AVMovie supports operations involving the format-specific
     portions of the QuickTime movie model that aren't supported
     by AVAsset. For instance, retrieving the movie header from
     an existing QuickTime movie file. You can also use AVMovie
     to write a movie header into a new file, thereby creating
     a reference movie.
     */
    
    
    /**
     Creating a Movie

     - initWithURL:options:
     Creates a movie object from a movie header stored in a QuickTime
     movie file of ISO base media file.
     
     + movieWithURL:options:
     Returns a movie object from a movie header stored in a QuickTime
     movie file of ISO base media file.
     
     - initWithData:options:
     Creates a movie object from a movie stored in an NSData object.
     
     + movieWithData:options:
     Returns a movie object from a movie stored in an NSData object.
     */

    
    /**
     Accessing Movie Information
     
     URL
     The URL used to initialize the movie instance.
     
     canContainMovieFragments
     A Boolean value that indicates whether the movie file can be
     extended by fragments.
     
     containsMovieFragments
     A Boolean value that indicates whether the movie file is
     extended by at least one movie fragment.
     
     data
     The data block used to initialize the movie.
     
     defaultMediaDataStorage
     The default storage container for media data added to a movie.
     
     tracks
     An array of tracks in a movie.
     
     + movieTypes
     Returns the file types the AVMovie class can process.
     */
    
    
    /**
     Crreating Movie Tracks
     
     - trackWithTrackID:
     Provides a movie track associated with the specified track ID.
     
     - tracksWithMediaCharacteristic:
     Provides the movie tracks of the specified media characteristic
     associated with an asset.
     
     - tracksWithMediaType:
     Provides the movie tracks of the specified media type associated
     with an asset.
     */
    
    
    /**
     Creating and Writing Headers

     - movieHeaderWithFileType:error:
     Creates a data object containing the movie header for a movie object.
     
     - writeMovieHeaderToURL:fileType:options:error:
     Writes the movie header to the specified URL.
     
     AVMovieWritingOptions
     A set of options to control the writing of a movie header to a
     destination URL.
     
     - isCompatibleWithFileType:
     Returns a Boolean value that indicates whether a movie header
     of the specified type can be created.
     */
    
    
    
    /*
     AVMovieTrack
     
     A track that conforms to a QuickTime or ISO-based media file format.
     */
    
    /**
     Retrieving Movies Track Information
     
     alternateGroupID
     A value that identifies the track as a member of a particular
     alternate group.
     
     mediaDataStorage
     The storage container for media data added to a track.
     
     mediaDecodeTimeRange
     A range of decode times for the track's media.
     
     mediaPresentationTimeRange
     A range of presentation times for the track's media.
     */
    
    
    
    /*
     AVMutableMovie
     
     A mutable object that represents the audiovisual containers
     that conform to a QuickTime - or ISO-based media file format.
     
     A mutable subclass of AVMovie, AVMutablMovie, provides methods
     that support the familiar movie editing model; for instance,
     you can use AVMutableMovie to copy media data from one track
     and paste that data into another track. You can also use
     AVMutableMovie to establish track references from one track
     to another(for another, to set one track as a chapter track
     of another track). If you want to perform editing operations
     on individual tracks, you can use the associated classes
     AVMovieTrack and AVMutableMovieTrack.
     
     You only use AVMovie and AVMutableMovie when operating on
     format-specific features of a QuickTime or ISO base media file.
     You generally do not need to use these classes just to open
     and play QuickTime movie files or ISO base media files.
     Instead, you use AVURLAsset and AVPlayerItem.

     When performing media insertions, AVMutableMovie interleaves
     the media data from the tracks in the source asset in order
     to create movie files that are optimized for playback.
     However, performing a series of media insertions may result
     in a movie file that is not optimally interleaved. You can
     create a well-interleaved, self-contained, fast-start
     movie file from an instance of AVMutableMovie by passing
     that instance to an AVAssetExportSession object using the
     export preset AVAssetExportPresetPassthrough and setting
     the shouldOptimizeForNetworkUse property to YES.
     */
    
    
    /**
     Creating a Mutable Movie
     
     - initWithURL:options:error:
     Creates a mutable movie object from a movie header stored in
     a QuickTime movie file of ISO base media file.
     
     + movieWithURL:options:error:
     Creates a mutable movie object from a movie header stored
     in a QuickTime movie file of ISO base media file.
     
     - initWithData:options:error:
     Creates a mutable movie object from a movie stored in an
     NSData object.
     
     + movieWithData:options:error:
     Creates a mutable movie object from a movie stored in an
     NSData object.
     
     - initWithSettingsFromMovie:options:error:
     Creates a mutable movie object without tracks.
     
     + movieWithSettingsFromMovie:options:error:
     Creates a mutable movie object without tracks.
     */
    
    
    /**
     Modifying Tracks
     
     - addMutableTrackWithMediaType:copySettingsFromTrack:options:
     Adds an empty track to the target movie.
     
     - addMutableTracksCopyingSettingsFromTracks:options:
     Adds one or more empty tracks to the target movie and copies
     the track settings from the source tracks.
     
     - removeTrack:
     Removes the specified track from the target movie.
     
     tracks
     An array of tracks in a mutable movie.
     
     - trackWithTrackID:
     A mutable movie track representing the track with the
     specified track identifier.
     
     - tracksWithMediaCharacteristic:
     An array of mutable movie tracks that match the specified
     media characteristic.
     
     - tracksWithMediaType:
     An array of mutable movie tracks that match the specified media type.
     
     - mutableTrackCompatibleWithTrack:
     Provides a reference to a track from a mutable movie into
     which any time range can be inserted.
     */
    
    
    /**
     Modifying Time Ranges

     - insertEmptyTimeRange:
     Adds an empty time range to a movie.
     
     - insertTimeRange:ofAsset:atTime:copySampleData:error:
     Inserts all of the tracks in a specified time range of
     an asset into a movie.
     
     - removeTimeRange:
     Removes the specified time range from a movie.
     
     - scaleTimeRange:toDuration:
     Changes the duration of a time range in a movie.
     */
    
    
    /**
     Configuring Movie Properties
     
     defaultMediaDataStorage
     The default storage container for the media data added to a movie.
     
     metadata
     An array of metadata stored by the movie.
     
     interleavingPeriod
     A time period indicating the duration for interleaving runs of
     samples for each track.
     
     modified
     A Boolean value that indicates whether the movie has been modified.
     
     preferredRate
     The natural rate the movie is to be played.
     
     preferredTransform
     The transform performed on the visual media data of the
     movie for display purposes.
     
     preferredVolume
     The preferred volume for the audible medata data of the movie.
     
     timescale
     The time scale for movies that contain the moov atom.
     */
    
    
    
    /*
     AVMutableMovieTrack
     
     A mutable track that conforms to a QuickTime- or
     ISO-based media file format.
     */

    /**
     Associating Tracks
     
     - addTrackAssociationToTrack:type:
     Creates a specific type of track association between two tracks.
     
     - removeTrackAssociationToTrack:type:
     Removes a specific type of track association between two tracks.
     */
    
    /**
     Accessing General Track Information
     
     alternateGroupID
     An number that identifies the track as a member of a
     particular alternate group.
     
     enabled
     A Boolean value that indicates whether the track is enabled
     by default for presentation.
     
     hasProtectedContent
     A Boolean value that indicates whether a track contains
     protected content.
     
     mediaDataStorage
     A storage container for the media data to be added to
     a track.
     
     modified
     A Boolean value that indicates whether a track has been
     modified.
     
     sampleReferenceBaseURL
     The base URL for sample references.
     
     timescale
     The time scale for tracks that contain the moov atom.
     
     metadata
     A array of metadata stored by the track.
     */
    
    /**
     Accessing Visual Information
     
     naturalSize
     The dimensions used to display the visual media data for the track.
     
     preferredTransform
     The transform performed on the visual media data of the
     track for display purposes.
     
     layer
     The layer level for the visual media of the track.
     
     cleanApertureDimensions
     The clean aperture dimension of the track.
     
     productionApertureDimensions
     The production aperture dimensions of the track.
     
     encodedPixelsDimensions
     The encoded pixels dimensions of the track.
     */
    
    /**
     Accessing Audio and Language Information

     preferredVolume
     The preferred volume for the audible medata data of the track.
     
     languageCode
     A ISO 639-2/T language code that indicates the language
     associated with the track.
     
     extendedLanguageTag
     An IETF BCP 47 language identifier that identifies the language
     tag associated with the track.
     */
    
    /**
     Modifying Time Ranges

     - insertTimeRange:ofTrack:atTime:copySampleData:error:
     Inserts a portion of an asset track into the target movie.
     
     - insertEmptyTimeRange:
     Adds an empty time range to a track.
     
     - removeTimeRange:
     Removes the specified time range from a track.
     
     - scaleTimeRange:toDuration:
     Changes the duration of a time range in a track.
     */
    
    /**
     Accessing Media Chunks

     Sample data in a movie file is stored in a series of "chunks".
     A chunk contains one or more samples, which may have different
     sizes from one another. The collection of samples into chunks
     is intended to allow optimized access to the sample data
     during operations such as movie playback. You can change the
     default chunk size in a movie file by adjusting the chunk
     properties of a movie track prior to writing the track's
     sample data to a media storage container.

     preferredMediaChunkAlignment
     The boundary for media chunk alignment for file types that
     support media chunk alignment.
     
     preferredMediaChunkDuration
     The maximum duration to be used for each chunk of sample data
     written to the file for file types that support media chunk duration.
     
     preferredMediaChunkSize
     The maximum size to be used for each chunk of sample data
     written to the file for file types that support media chunk duration.
     */
    
    /**
     Appending Sample Data
     
     - appendSampleBuffer:decodeTime:presentationTime:error:
     Appends sample data to a media file and adds sample references
     for the added data to a track's media sample tables.
     
     - insertMediaTimeRange:intoTimeRange:
     Inserts a reference to a media time range into a track.
     */
    
    /**
     Changing Format Descriptions
     
     - replaceFormatDescription:withFormatDescription:
     Replaces a receiver's format description with a new format description.
     */
    
    
    
    /*
     AVFragmentedMovie
     
     An object used to handle fragmented movie files.
     */
    
    /**
     Accessing Fragmented Track Information
     
     tracks
     An array of tracks in a movie.
     */
        
    /**
     Creating Fragmented Movie Tracks

     - trackWithTrackID:
     Provides a movie track associated with the specified track ID.
     
     - tracksWithMediaCharacteristic:
     Provides the movie tracks of the specified media characteristic
     associated with an asset.
     
     - tracksWithMediaType:
     Provides the movie tracks of the specified media type associated
     with an asset.
     */
    
    
    /*
     AVFragmentedMovieTrack
     
     An object used to handle the tracks of fragmented movie files.
     */
    
    
    /*
     AVFragmentedMovieMinder
     
     An object used to check whether additional movie fragments
     have been appended to a fragmented movie file.
     */
    
    /**
     Creating a Movie Minder

     - initWithMovie:mindingInterval:
     Creates a movie minder and adds a movie with a minding interval.
     
     + fragmentedMovieMinderWithMovie:mindingInterval:
     Creates a movie minder and adds a movie with a minding interval.
     */
    
    /**
     Adding and Removing Movies
     
     - addFragmentedMovie:
     Adds a fragmented movie to the array of movies being minded.
     
     - removeFragmentedMovie:
     Removes a fragmented movie from the array of movies being minded.
     */
    
    /**
     Accessing Minder Information

     mindingInterval
     The amount of time between checks for additional movie fragments.
     
     movies
     An array containing the fragmented movie objects being minded.
     */
    
    /*
     AVMediaDataStorage
     
     An object used to create a sample data file.
     */
    
    /**
     An object used to create a sample data file.

     - initWithURL:options:
     Creates a media data storage object associated with a file URL.
     */
    
    /**
     Accessing the URL

     - URL
     Returns the URL used to initialize the receiver.
     */
    
    
#pragma mark -- Built-in Video Compositing
    
    /*
     AVVideoComposition
     
     An object that represents an immutable video composition.
     
     The AVFoundation framework also provides a mutable subclass,
     AVMutableVideoComposition, that you can use to create new videos.

     A video composition describes, for any time in the aggregate
     time range of its instructions, the number and IDs of video
     tracks that are to be used in order to produce a composed
     video frame corresponding to that time. When AVFoundation’s
     built-in video compositor is used, the instructions an
     AVVideoComposition contain can specify a spatial transformation,
     an opacity value, and a cropping rectangle for each video
     source, and these can vary over time via simple linear ramping
     functions.

     You can implement your own custom video compositor by
     implementing the AVVideoCompositing protocol; a custom video
     compositor is provided with pixel buffers for each of its
     video sources during playback and other operations and can
     perform arbitrary graphical operations on them in order to
     produce visual output.
     */
    
    /**
     Creating a Video Composition Object

     + videoCompositionWithPropertiesOfAsset:
     Creates a video composition object configured to present the
     video tracks of the specified asset.
     
     + videoCompositionWithAsset:applyingCIFiltersWithHandler:
     Creates a video composition configured to apply Core Image
     filters to each video frame of the specified asset.
     
     AVAsynchronousCIImageFilteringRequest
     An object that supprts using Core Image filters to process an
     individual video frame in a video composition.
     */
    
//    AVVideoComposition *videoComposition = [AVVideoComposition videoCompositionWithPropertiesOfAsset:composition];
    
    AVVideoComposition *videoComposition = [AVVideoComposition videoCompositionWithAsset:asset applyingCIFiltersWithHandler:^(AVAsynchronousCIImageFilteringRequest * _Nonnull request) {
        
    }];
    
    /**
     Configuring Video Composition Properties

     frameDuration
     A time interval for which the video composition should
     render composed video frames.
     
     renderSize
     The size at which the video composition should render.
     
     renderScale
     The scale at which the video composition should render.
     
     instructions
     The video composition instructions.
     
     AVVideoCompositionInstruction
     Methods you can implement to represent operations to be
     performed by a compositor.
     
     animationTool
     A video composition tool to use with Core Animation in
     offline rendering.
     
     customVideoCompositorClass
     A custom compositor class to use.
     
     sourceTrackIDForFrameTiming
     A value that indicates whether frame timing for the video
     composition is derived from the source's asset track.
     
     colorPrimaries
     The color primaries used for video composition.
     
     colorTransferFunction
     The transfer function used for video composition.
     
     colorYCbCrMatrix
     The YCbCr matrix used for video composition.
     */
//    NSLog(@"frameDuration %lld",videoComposition.frameDuration.value);
//    NSLog(@"renderSize %@",NSStringFromCGSize(videoComposition.renderSize));
//    NSLog(@"renderScale %f",videoComposition.renderScale);
//    NSLog(@"instructions %@",videoComposition.instructions);
//    NSLog(@"animationTool %@",videoComposition.animationTool);
//    NSLog(@"customVideoCompositorClass %@",videoComposition.customVideoCompositorClass);
//    if (@available(iOS 11.0, *)) {
//        NSLog(@"sourceTrackIDForFrameTiming %d",videoComposition.sourceTrackIDForFrameTiming);
//    } else {
//        // Fallback on earlier versions
//    }
//    if (@available(iOS 10.0, *)) {
//        NSLog(@"colorPrimaries %@",videoComposition.colorPrimaries);
//    } else {
//        // Fallback on earlier versions
//    }
//    if (@available(iOS 10.0, *)) {
//        NSLog(@"colorTransferFunction %@",videoComposition.colorTransferFunction);
//    } else {
//        // Fallback on earlier versions
//    }
//    if (@available(iOS 10.0, *)) {
//        NSLog(@"colorYCbCrMatrix %@",videoComposition.colorYCbCrMatrix);
//    } else {
//        // Fallback on earlier versions
//    }
    
    
    /**
     Validating the Time Range

     - isValidForAsset:timeRange:validationDelegate:
     Indicates whether the time ranges of the composition’s instructions
     conform to validation requirements.
     
     AVVideoCompositionValidationHandling
     Methods you can implement to indicate whether validation of a video
     composition should continue after specific errors are found.
     */
//    BOOL validResult = [videoComposition isValidForAsset:asset timeRange:CMTimeRangeMake(kCMTimeZero, asset.duration) validationDelegate:self];
//    NSLog(@"validAsset %d",validResult);
    
    
    /*
     AVMutableVideoComposition

     An object that represents a mutable video composition.

     A video composition describes, for any time in the aggregate
     time range of its instructions, the number and IDs of video
     tracks that are to be used in order to produce a composed video
     frame corresponding to that time. When AVFoundation’s built-in
     video compositor is used, the instructions an AVVideoComposition
     comprises can specify a spatial transformation, an opacity value,
     and a cropping rectangle for each video source, and these can
     vary over time via simple linear ramping functions.

     You can also implement your own custom video compositor by
     implementing the AVVideoCompositing protocol; a custom video
     compositor is provided with pixel buffers for each of its
     video sources during playback and other operations and can
     perform arbitrary graphical operations on them in order to
     produce visual output.
     */
    
    /**
     Creating a Video Composition

     + videoComposition
     Creates a new mutable video composition.
     
     + videoCompositionWithPropertiesOfAsset:
     Creates a new mutable video composition with the specified
     asset properties.
     
     + videoCompositionWithAsset:applyingCIFiltersWithHandler:
     Creates a mutable video composition configured to apply Core Image
     filters to each video frame of the specified asset.
     
     + videoCompositionWithPropertiesOfAsset:prototypeInstruction:
     */
//    AVMutableVideoComposition *mutableVideoComposition = [AVMutableVideoComposition videoCompositionWithAsset:composition applyingCIFiltersWithHandler:^(AVAsynchronousCIImageFilteringRequest * _Nonnull request) {
//
//    }];
    
    
    /**
     Configuring Video Composition Properties
     
     frameDuration
     A time interval for which the video composition should render
     composed video frames.
     
     renderSize
     The size at which the video composition should render.
     
     renderScale
     The scale at which the video composition should render.
     
     instructions
     The video composition instructions.
     
     AVVideoCompositionInstruction
     Methods you can implement to represent operations to be
     performed by a compositor.
     
     animationTool
     A video composition tool to use with Core Animation in
     offline rendering.
     
     customVideoCompositorClass
     The custom compositor class to use.
     
     sourceTrackIDForFrameTiming
     A value that indicates whether frame timing for the video
     composition is derived from the source's asset track.
     
     colorPrimaries
     The color primaries used for video composition.
     
     colorTransferFunction
     The transfer function used for video composition.
     
     colorYCbCrMatrix
     The YCbCr matrix used for video composition.
     */
    
    
    /*
     AVVideoCompositionInstruction
     
     An operation performed by a compositor.

     An AVVideoComposition object maintains an array of instructions
     to perform its composition.
     */
    
    
    /**
     Getting Composition Instruction Properties
     
     backgroundColor
     The background color of the composition.
     
     layerInstructions
     An array of video composition layer instruction instances of
     that specify how video frames from source tracks should be
     layered and composed.
     
     timeRange
     The time range during which the instruction is effective.
     
     enablePostProcessing
     A Boolean value that indicates whether post processing is
     required for the video composition instruction.
     
     passthroughTrackID
     The track identifier from an instruction source frame.
     
     requiredSourceTrackIDs
     An array of track identifiers required to compose frames for
     the instruction.
     */
    
    
    /*
     AVVideoCompositionLayerInstruction
     
     An object used to modify the transform, cropping, and opacity
     ramps applied to a given track in a composition.
     */
    
    /**
     Getting the Track ID
     
     trackID
     The track identifier of the source track to which the
     compositor will apply the instruction.
     */
    
    /**
     Getting Opacity, Transform, and Cropping Ramps

     - getOpacityRampForTime:startOpacity:endOpacity:timeRange:
     Obtains the opacity ramp that includes a specified time.
     
     - getTransformRampForTime:startTransform:endTransform:timeRange:
     Obtains the transform ramp that includes a specified time.
     
     - getCropRectangleRampForTime:startCropRectangle:endCropRectangle:timeRange:
     Obtains the crop rectangle ramp that includes the specified time.
     */
    
    
    /*
     AVMutableVideoCompositionInstruction
     
     An operation performed by a compositor.

     An AVVideoComposition object maintains an array of instructions
     to perform its composition.
     */
    
    /**
     Creating an Instruction

     + videoCompositionInstruction
     Returns a new mutable video composition instruction.
     */
    
    /**
     Configuring the Instructions

     backgroundColor
     The background color of the composition.
     
     layerInstructions
     An array of instances of AVVideoCompositionLayerInstruction that
     specify how video frames from source tracks should be layered and composed.
     
     timeRange
     The time range during which the instruction is effective.
     
     enablePostProcessing
     A Boolean value that indicates whether post processing is
     required for the video composition instruction.
     */
    
    
    /*
     AVMutableVideoCompositionLayerInstruction
     
     An object used to modify the transform, cropping, and opacity
     ramps applied to a given track in a mutable composition.
     */

    /**
     Creating an Instruction

     + videoCompositionLayerInstruction
     Returns a new mutable video composition layer instruction.
     
     + videoCompositionLayerInstructionWithAssetTrack:
     Creates a new mutable video composition layer instruction for
     the given track.
     */
    
    /**
     Configuring a Track ID

     trackID
     The track identifier of the source track to which the compositor
     applies the instruction.
     */
    
    /**
     Managing Properties

     - setOpacity:atTime:
     Sets the opacity value at a specific time within the time range
     of the instruction.
     
     - setOpacityRampFromStartOpacity:toEndOpacity:timeRange:
     Sets an opacity ramp to apply during a specified time range.
     
     - setTransform:atTime:
     Sets the transform value at a time within the time range of the instruction.
     
     - setTransformRampFromStartTransform:toEndTransform:timeRange:
     Sets a transform ramp to apply during a given time range.
     */
 
    /**
     Setting Crop Rectangle Values

     - setCropRectangle:atTime:
     Sets the crop rectangle value at a time within the time range
     of the instruction.

     - setCropRectangleRampFromStartCropRectangle:toEndCropRectangle:timeRange:
     Sets a crop rectangle ramp to apply during the specified time range.
     */
    
    
    /*
     AVVideoCompositionCoreAnimationTool
     
     An object used to incorporate Core Animation into a video composition.

     Any animations will be interpreted on the video's timeline,
     not real-time, so you should:
     1. Set animations’ beginTime property to AVCoreAnimationBeginTimeAtZero
        rather than 0 (which CoreAnimation replaces with CACurrentMediaTime);
     2. Set removedOnCompletion to NO on animations so they are
        not automatically removed;
     3. Avoid using layers that are associated with UIView objects.
     */
    
    /**
     Creating a Composition Tool
     
     + videoCompositionCoreAnimationToolWithAdditionalLayer:asTrackID:
     Adds a Core Animation layer to the video composition.
     
     + videoCompositionCoreAnimationToolWithPostProcessingAsVideoLayer:inLayer:
     Composes the composited video frame with a Core Animation layer.
     
     + videoCompositionCoreAnimationToolWithPostProcessingAsVideoLayers:inLayer:
     Composes the composited video frames with the Core Animation layer.
     */
    
    
    
#pragma mark -- Custom Video Compositing
    
    /*
     AVVideoCompositing
     
     A protocol that defines the methods custom video compositors
     must implement.

     For each AVFoundation object of class AVPlayerItem, AVAssetExportSession,
     AVAssetImageGenerator, or AVAssetReaderVideoCompositionOutput that has
     a non-nil value for its videoComposition property, and the value of the
     customVideoCompositorClass property of the AVVideoComposition is not
     nil, AVFoundation creates and uses an instance of that custom video
     compositor class to process the instructions contained in the
     AVVideoComposition.

     The system creates a custom video compositor instance when you
     assign videoComposition an instance of AVVideoComposition that's
     associated with a different custom video compositor class than
     the object was previously using.

     When creating instances of custom video compositors, AVFoundation
     initializes them by calling init and then makes them available as
     the value of the customVideoCompositor property of the object. You
     then can do any additional setup or configuration to the custom
     compositor.

     The AVFoundation object retains the custom video compositor
     instances for as long as the value of the videoComposition property
     indicates that there is an instance of the same custom video
     compositor class. This is true even when the value changes from
     one instance of AVVideoComposition to another associated instance
     with the same custom video compositor class.
     */
    
    /**
     Rendering the Composition

     - startVideoCompositionRequest:
     Directs a custom video compositor object to create a new pixel
     buffer composed asynchronously from a collection of sources.
     Required.
     
     AVAsynchronousVideoCompositionRequest
     An object that contains the information necessary for a video
     compositor to render an output pixel buffer.
     
     - cancelAllPendingVideoCompositionRequests
     Directs a custom video compositor object to cancel or finish all
     pending video composition requests.
     */
    
    /**
     Render Context Settings

     - renderContextChanged:
     Notifies the custom compositor that a composition will switch to
     a different render context.
     Required.
     
     AVVideoCompositionRenderContext
     An object that defines the context within which custom compositors
     render new output pixel buffers.
     
     supportsWideColorSourceFrames
     A Boolean value that indicates whether the client can handle
     frames that contain wide color properties.
     
     - anticipateRenderingUsingHint:
     Informs a custom video compositor about upcoming rendering requests.
     
     - prerollForRenderingUsingHint:
     Tells a custom video compositor to perform any work in the prerolling phase.
     
     AVVideoCompositionRenderHint
     Information about upcoming composition requests, such as composition
     start time and end time.
     */
    
    /**
     Pixel Buffer Attributes

     ==requiredPixelBufferAttributesForRenderContext
     The pixel buffer attributes required by the video compositor
     for new buffers created for processing.
     Required.
     
     ==sourcePixelBufferAttributes
     The types of source frame pixel buffer attributes a video compositor
     can accept as input.
     Required.
     */

    /**
     Determining HDR Support

     supportsHDRSourceFrames
     */
    
    
    
#pragma mark -- Audio Mixing
    
    /*
     AVAudioMix
     
     An object that manages the input parameters for mixing audio tracks.
     */
    
    /**
     Retrieving Input Parameters

     inputParameters
     An array of input parameters for the mix.
     */
    
    
    /*
     AVAudioMixInputParameters
     
     An object that represents the parameters that you apply when
     adding an audio track to a mix.

     You use an instance AVAudioMixInputParameters to apply audio
     volume ramps for an input to an audio mix. Mix parameters are
     associated with audio tracks via the trackID property.

     Audio volume is currently supported as a time-varying parameter.
     AVAudioMixInputParameters has a mutable subclass,
     AVMutableAudioMixInputParameters.

     Before the first time at which a volume is set, a volume of 1.0
     used; after the last time for which a volume has been set, the
     last volume is used. Within the time range of a volume ramp,
     the volume is interpolated between the start volume and end volume
     of the ramp. For example, setting the volume to 1.0 at time 0
     and also setting a volume ramp from a volume of 0.5 to 0.2 with
     a timeRange of [4.0, 5.0] results in an audio volume parameters
     that hold the volume constant at 1.0 from 0.0 sec to 4.0 sec,
     then cause it to jump to 0.5 and descend to 0.2 from 4.0 sec to
     9.0 sec, holding constant at 0.2 thereafter.

     Given that this is an immutable variant of the object, you should
     not allocate and initialize a version of this class yourself.
     Other classes may return instances of this class.
     */
    
    /**
     Getting the Track ID

     trackID
     The identifier of the audio track to which the parameters
     should be applied.
     */
    
    /**
     Getting Volume Ramps

     - getVolumeRampForTime:startVolume:endVolume:timeRange:
     Retrieves the volume ramp that includes the specified time.
     */
    
    /**
     Getting an Audio Tap

     audioTapProcessor
     The audio processing tap associated with the track.
     */
    
    /**
     Getting the Time Pitch Algorithm Setting

     audioTimePitchAlgorithm
     The processing algorithm used to manage audio pitch for scaled audio edits.
     
     AVAudioTimePitchAlgorithm
     An algorithm used to set the audio pitch as the rate changes.
     */
    
    
    /*
     AVMutableAudioMix
     
     An object that manages the input parameters for mixing audio tracks.
     */
    
    /**
     Creating a Mix

     + audioMix
     Returns a new mutable audio mix.
     */
    AVMutableAudioMix *audioMix = [AVMutableAudioMix audioMix];
    
    /**
     Input Parameters

     inputParameters
     An array of input parameters for the mix.
     */
//    audioMix.inputParameters = @[];
    
    
    
    /*
     AVMutableAudioMixInputParameters

     The parameters you use when adding an audio track to a mix.
     */
    
    /**
     Creating Input Parameters

     + audioMixInputParameters
     Creates a mutable input parameters object.
     
     + audioMixInputParametersWithTrack:
     Creates a mutable input parameters object for a given track.
     */
    AVMutableAudioMixInputParameters *mixInputParameters = [AVMutableAudioMixInputParameters audioMixInputParametersWithTrack:asset.tracks.lastObject];
    AVMutableAudioMixInputParameters *mixInputParameters_2 = [AVMutableAudioMixInputParameters audioMixInputParametersWithTrack:asset_2.tracks.lastObject];
    
    /**
     Managing the Track ID

     trackID
     The identifier of the audio track to which the parameters should be applied.
     */
    
    /**
     Setting the Volume

     - setVolume:atTime:
     Sets the value of the audio volume starting at the specified time.
     
     - setVolumeRampFromStartVolume:toEndVolume:timeRange:
     Sets a volume ramp to apply during a specified time range.
     */
    
    /**
     Getting an Audio Tap
     
     audioTapProcessor
     The audio processing tap associated with the track.
     */
    
    
    /**
     Time Pitch Settings

     audioTimePitchAlgorithm
     The processing algorithm used to manage audio pitch for scaled audio edits.
     
     AVAudioTimePitchAlgorithm
     An algorithm used to set the audio pitch as the rate changes.
     */
    mixInputParameters.audioTimePitchAlgorithm = AVAudioTimePitchAlgorithmVarispeed;
    mixInputParameters_2.audioTimePitchAlgorithm = AVAudioTimePitchAlgorithmVarispeed;

    audioMix.inputParameters = @[mixInputParameters,mixInputParameters_2];
    
    
    
    
    
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
