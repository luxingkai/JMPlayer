//
//  AssetsViewController.m
//  VideoProcess
//
//  Created by tigerfly on 2020/10/15.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "AssetsViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import <MobileCoreServices/UTType.h>
#import <CoreServices/CoreServices.h>
#import <CoreFoundation/CoreFoundation.h>
#import <CoreMedia/CoreMedia.h>
#include <stdlib.h>
#include <stdio.h>

typedef struct {
    int first;
    float second;
} CompleteType;

struct curel {
    CompleteType hint;
};

struct juice {
    int sdeee;
};

@interface AssetsViewController ()

@end

@implementation AssetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /*
     Load, inspect, and export media assets and metadata, and
     perform low-level reading and writing of media sample data.
     */
    
    
    
    
#pragma mark -- Assets
    
    /**
     Understand how assets are used as the building blocks for media
     players.
     
     Many of AVFoundation's key features and capabilities relate to
     playing and processing media assets. The framework models assets
     by using the AVAsset class, which is a abstract, immutable type
     representing a single media resource. It provides a composite
     view of a media asset, modeling the static aspects of the media
     as a whole. An instance of AVAsset can model local file-based
     media, such as a QuickTime moive or an MP3 audio file, but can
     also represent an asset progressively downloaded from a remote
     host or streamed using HTTP Live Streaming(HLS).
     
     AVAsset simplifies working with media in two important ways.
     First, it provides a level of independence from the media
     format. It gives you a consistent interface for managing and
     interacting with your media regardless of its underlying type.
     The details of working with container formats and codec types
     are left to the framework, leaving you to focus on how you
     want to use those assets in your app.
     
     Second, AVAsset provides a level of independence from the
     media's location. You create an asset instance by initializing
     it with the media's URL. This could be a local URL, such as
     one contained within your app bundle or elsewhere on the file
     system, or it could be a resource, such as an HLS stream hosted
     on a remote server. In either case, the framework performs the
     work necessary to efficiently retrieve and load the media in
     a timely mannar on your behalf. Removing the burdens of dealing
     with media formats and locations greatly simplifies working
     with audiovisual media.
     
     AVAsset is a container object composed of one or more instances
     of AVAssetTrack, which models the asset's uniformly typed media
     streams. The most commonly used track types are audio and video
     tracks, but AVAssetTrack also models other supplementary tracks,
     such as closed captions, subtitles, and timed metadata.
     
     You retrieve an asset's collection of tracks using its tracks
     property. In many cases, you'll want to perform operations on
     a subset of an asset's tracks rather than on its complete
     collection. In these cases, AVAsset also provides methods to
     retrieve subsets of tracks based on criteria such as identifier,
     media type, or characteristic.
     */
    
    
    /*
     Asset
     
     The abstract class used to model timed audiovisual media such
     as videos and sounds.
     */
    
    NSURL *sourceURL = [[NSBundle mainBundle] URLForResource:@"sofa" withExtension:@"mp4"];
    //    AVAsset *asset = [AVAsset assetWithURL:sourceURL];
    //    AVAsset *asset = [AVURLAsset URLAssetWithURL:<#(nonnull NSURL *)#> options:<#(nullable NSDictionary<NSString *,id> *)#>];
    
    /**
     Creating an Asset
     Returns an asset for inspection of a media resource.
     */
    AVAsset *asset = [AVAsset assetWithURL:sourceURL];
    
    /**
     Loading Data
     Cancels the loading of all values for all observers.
     */
    //    [asset cancelLoading];
    
    /**
     Inspecting an Asset
     
     duration
     providesPreciseDurationAndTiming
     creationDate
     preferredRate
     preferredTransform
     preferredVolume
     */
    //    CMTime time = asset.duration;
    //    CMTimeShow(time);
    //    BOOL provides = asset.providesPreciseDurationAndTiming;
    //    NSLog(@"%d",provides);
    //    AVMetadataItem *creationDate = asset.creationDate;
    //    NSLog(@"%@",creationDate.dataValue);
    //    float preferredRate = asset.preferredRate;
    //    NSLog(@"%f",preferredRate);
    //    CGAffineTransform affineTransform = asset.preferredTransform;
    //    NSLog(@"%@",NSStringFromCGAffineTransform(affineTransform));
    //    float preferredVolume = asset.preferredVolume;
    //    NSLog(@"%f",preferredVolume);
    //
    
    /**
     Determining Usability
     
     The usability properties have a value of YES when the indicated
     operation can be performed, even if only true under a specific
     set of conditions. These properties only return NO when there is
     no condition under which the associated operation can be performed.
     */
    //    NSLog(@"playable %d",asset.playable);
    //    NSLog(@"exportable %d",asset.exportable);
    //    NSLog(@"readable %d",asset.readable);
    //    NSLog(@"composable %d",asset.composable);
    //    NSLog(@"hasProtectedContent %d",asset.hasProtectedContent);
    //    NSLog(@"compatibleWithAirPlayVideo %d",asset.compatibleWithAirPlayVideo);
    //    NSLog(@"compatibleWithSavedPhotosAlbum %d",asset.compatibleWithSavedPhotosAlbum);
    
    
    /**
     Accessing Tracks
     */
    NSLog(@"tracks %@",asset.tracks);
    NSLog(@"trackGroups %@",asset.trackGroups);
    //    asset trackWithTrackID:<#(CMPersistentTrackID)#>
    //    asset tracksWithMediaType:<#(nonnull AVMediaType)#>
    //    asset tracksWithMediaCharacteristic:<#(nonnull AVMediaCharacteristic)#>
    //    CMPersistentTrackID trackID = [asset unusedTrackID];
    //    NSLog(@"unusedTrackID %d",trackID);
    
    
    /**
     Accessing Metadata
     */
    //    NSLog(@"lyrics %@",asset.lyrics);
    //    NSLog(@"metadata %@",asset.metadata);
    //    NSLog(@"commonMetadata %@",asset.commonMetadata);
    //    NSLog(@"availableMetadataFormats %@",asset.availableMetadataFormats);
    //    asset metadataForFormat:<#(nonnull AVMetadataFormat)#>
    
    
    /**
     Using Chapter Metadata
     
     Add chapter markers to enable users to quilkly navigate
     your content.
     */
    //    NSLog(@"availableChapterLocales %@",asset.availableChapterLocales);
    //    NSArray *metadataGroups = [asset chapterMetadataGroupsWithTitleLocale:[NSLocale systemLocale] containingItemsWithCommonKeys:@[AVMetadataCommonKeyTitle]];
    //    NSLog(@"%@",metadataGroups);
    //    NSArray *timeMetadataGroup = [asset chapterMetadataGroupsBestMatchingPreferredLanguages:[NSLocale availableLocaleIdentifiers]];
    //    NSLog(@"%@",timeMetadataGroup);
    
    
    /**
     Finding Media Selections
     */
    //    NSLog(@"preferredMediaSelection %@",asset.preferredMediaSelection);
    //    NSLog(@"asset.availableMediaCharacteristicsWithMediaSelectionOptions %@",asset.availableMediaCharacteristicsWithMediaSelectionOptions);
    //    NSLog(@"allMediaSelections %@",asset.allMediaSelections);
    //    asset mediaSelectionGroupForMediaCharacteristic:<#(nonnull AVMediaCharacteristic)#>
    
    
    /**
     Managing Reference Restrictions
     */
    //    NSLog(@"referenceRestrictions %lu", (unsigned long)asset.referenceRestrictions);
    
    
    /**
     Working with Fragmented Moives
     */
    //    NSLog(@"canContainFragments %d", asset.canContainFragments);
    //    NSLog(@"containsFragments %d", asset.containsFragments);
    //    NSLog(@"overallDurationHint %d", asset.overallDurationHint);
    
    /**
     Specifying Media Characteristics
     */
    //    AVMediaCharacteristic
    
    
    /*
     AVAsynchronousKeyValueLoading
     
     Methods you can implement to use an asset or asset track
     without blocking the calling thread.
     
     This protocol includes methods you can use to find out the
     status of a key -- any property of a class that uses asynchronous
     key value loading. For example, you can find out whether the
     value of a key has beed loaded. You can also ask the object to
     load its values asynchronously and inform you when the operation
     has completed.
     */
    [asset loadValuesAsynchronouslyForKeys:@[@"playable"] completionHandler:^{
        NSError *error = nil;
        AVKeyValueStatus status = [asset statusOfValueForKey:@"playable" error:&error];
        switch (status) {
            case AVKeyValueStatusLoaded:{
                // Sucessfully loaded. Continue processing.
            }
                break;
            case AVKeyValueStatusFailed:{
                // Handle error
            }
                break;
            case AVKeyValueStatusCancelled:{
                // Terminate processing
            }
                break;
            default:
                // Handle all other cases
                break;
        }
    }];
    
    
    /*
     AVAssetTrack
     An object that provides the track-level inspection interface for
     an asset’s media tracks.
     
     AVAssetTrack adopts the AVAsynchronousKeyValueLoading protocol.
     You can use the protocol’s statusOfValueForKey:error: method to
     determine if a track property can be accessed without blocking the
     calling thread. If a property’s status is a value other than
     AVKeyValueStatusLoaded, you should use the protocol’s
     loadValuesAsynchronouslyForKeys:completionHandler: method to
     asynchronously load the key prior to use. To cancel pending load
     requests for all keys of AVAssetTrack you must message its owning
     AVAsset object (for example, [track.asset cancelLoading]).
     */
    
    /**
     Retrieving Track Information
     */
    AVAssetTrack *assetTrack = asset.tracks.firstObject;
    //    assetTrack.asset
    //    assetTrack.trackID
    //    assetTrack.mediaType
    //    assetTrack hasMediaCharacteristic:<#(nonnull AVMediaCharacteristic)#>
    //    assetTrack.formatDescriptions
    //    assetTrack.enabled
    //    assetTrack.playable
    //        assetTrack.selfContained
    //    assetTrack.estimatedDataRate
    //        assetTrack.totalSampleDataLength
    //    assetTrack.decodable
    
    
    /**
     Retrieving Temporal Properties
     */
    //    assetTrack.timeRange
    //    assetTrack.naturalTimeScale
    
    /**
     Retrieving Language Properties
     */
    //    assetTrack.languageCode
    //    assetTrack.extendedLanguageTag
    
    /**
     Retrieving Visual Characteristics
     */
    //    assetTrack.naturalSize
    //    assetTrack.preferredTransform
    
    /**
     Retrieving Audible Characteristics
     */
    //    assetTrack.preferredVolume
    
    /**
     Retrieving Frame-Based Characteristics
     */
    //    assetTrack.nominalFrameRate
    //    assetTrack.minFrameDuration
    //    assetTrack.requiresFrameReordering
    
    /**
     Finding Track Segments
     */
    //        assetTrack.segments
    //        assetTrack segmentForTrackTime:<#(CMTime)#>
    //        assetTrack samplePresentationTimeForTrackTime:<#(CMTime)#>
    
    /**
     Managing Metadata
     */
    //    assetTrack.metadata
    //    assetTrack.commonMetadata
    //    assetTrack.availableMetadataFormats
    //    assetTrack metadataForFormat:<#(nonnull AVMetadataFormat)#>
    
    /**
     Working With Associated Tracks
     */
    //    assetTrack.availableTrackAssociationTypes
    //    assetTrack associatedTracksOfType:<#(nonnull AVTrackAssociationType)#>
    
    
    /*
     AVAssetTrackGroup
     A group of related tracks in an asset.
     */
    
    /*
     AVAssetTrackSegment
     A segment of an asset track, consisting of a time mapping from the
     source to the asset track timeline.
     */
    
    
#pragma mark -- Metadata
    
    /*
     Finding Metadata values
     
     Retrieve and filter all of the metadata associated with an asset.
     
     Media container formats store descriptive metadata about their
     media. As a developer, it's often challenging to work with metadata,
     because each container format has its own unique metadata format.
     You typically need a low-level understanding of the format to read
     and write a container's metadata, but AVFoundation simplifies working
     with metadata through the use of its AVMetadataItem class.
     
     In its most basic form, an instance of AVMetadataItem is a key-value
     pair representing a single metadata value such as a moive's title
     or an album's artwork. In the same way that AVAsset provides a
     normalized view of your media, AVMetadataItem provides a normalized
     view of its associated metadata.
     */
    
    /**
     Load the Asset's Metadata
     
     You determine what metadata formats an asset contains by calling
     its availableMetadataFormats property. This property returns an
     array of string identifiers for each metadata format it contains.
     You then use its metadataForFormat: method to retrieve format-
     specific metadata values by passing it an appropriate format
     identifier, as shown below:
     */
    
    NSString *formatKey = @"availableMetadataFormats";
    [asset loadValuesAsynchronouslyForKeys:@[formatKey] completionHandler:^{
        NSError *error = nil;
        AVKeyValueStatus status = [asset statusOfValueForKey:formatKey error:&error];
        if (status == AVKeyValueStatusLoaded) {
            for (AVMetadataFormat format in asset.availableMetadataFormats) {
                NSArray *metaItems = [asset metadataForFormat:format];
                //process format-specific metadata collection
            }
        }
    }];
    
    /**
     Filter the Metadata Collection
     
     After you've retrieved a collection of metadata, the next step is
     to find the specific values of interest within it. You use the various
     class methods of AVMetadataItem to filter metadata collections down to
     a discrete set of values.
     
     The easiest way to find specific metadata items is to filter by identifier,
     which groups a key space and key into a single unit. The following example
     shows how to retrieve the title item from the common key space:
     
     ⚠️ The filtering methods of AVMetadataItem return collections of items
     instead of a single instance. In many cases, the returned collection
     contains a single element, but if the media contains localized metadata
     or if you're retrieving data from the common key space and the same value
     exists in multiple key spaces, a distinct value matching each locale or
     key space is returned.
     */
    
    NSArray *commonMetadata = asset.commonMetadata;
    NSArray *titleItems = [AVMetadataItem metadataItemsFromArray:commonMetadata filteredByIdentifier:AVMetadataCommonIdentifierLanguage];
    AVMetadataItem *item = titleItems.firstObject;
    //process title item
    
    
    /**
     Find Specific Values
     
     After you're retrieved a specific metadata item, the next step is
     to call its value property. The value returned is an object type adopting
     the NSObject and NSCopying protocols. You can manually cast the value
     to the appropriate type, but it's safer and easier to use the metadata
     item's type coercion properties. You can use its stringValue, numberValue,
     dataValue, and dataValue properties to easily coerce the value to the
     appropriate type. For instance, the following example shows how you
     retrieve the artwork associated with an iTunes music track:
     */
    NSArray *artworkItems = [AVMetadataItem metadataItemsFromArray:commonMetadata filteredByIdentifier:AVMetadataCommonIdentifierArtwork];
    AVMetadataItem *artworkItem = artworkItems.firstObject;
    NSData *imageData = artworkItem.dataValue;
    UIImage *image = [UIImage imageWithData:imageData];
    //process image
    
    
    /*
     AVMetadataItem
     
     A metadata item associated with an audiovisual asset or one of its tracks.
     
     To effectively use AVMetadataItem, you need to understand how AVFoundation
     organizes metadata. To simplify finding and filtering metadata items, the
     framework groups related metadata into key spaces:
     •  Format-specific key spaces. The framework defines a number of
     format-specific key space. They roughly correlate to a particular
     container or file format, such as QuickTime or MP3(ID3). However, a
     single asset may contain metadata values across multipe key spaces.
     To retrieve an asset's complete collection of format-specific metadata,
     you use its metadata property.
     •  Common Key space. There are a number of common metadata values, such
     as a movie's creation data or description, that can exist across multiple
     key spaces. To help normalize access to this common metadata, the
     framework provides a common key space that gives access to a limited
     set of metadata values common to several key spaces. This makes it
     easy to retrieve commonly used metadata without concern for the specific
     format. To retrieve an asset's collection of common metadata, you use
     its commonMetadata property.
     
     Metadata items have keys that accord with the specification of the container
     format from which they're drawn. Full details of the metadata formats, metadata
     keys, and metadata key spaces supported by AVFoundation are available in
     AVMetadataKeySpace and AVMetadataKey.
     
     To load values of a metadata item "lazily", you use the methods from the
     AVAsynchronousKeyValueLoading protocol. The AVAsset class and other classes
     in turn provide their metadata lazily so that you can obtain objects from
     those arrays without incurring overhead for items you don't ultimately
     inspect.
     
     To filter arrays of metadata items, you use the methods of this class.
     For example, you can filter by key and key space, by locale, and by
     preferred language.
     */
    
    /**
     Creating Metadata Items
     */
    //    AVMetadataItem metadataItemWithPropertiesOfMetadataItem:<#(nonnull AVMetadataItem *)#> valueLoadingHandler:<#^(AVMetadataItemValueRequest * _Nonnull valueRequest)handler#>
    
    /**
     Getting Keys and Key Spaces
     */
    //    item.key
    //    item.keySpace
    //    item.commonKey
    
    /**
     Asynchronous Loading
     */
    //    asset loadValuesAsynchronouslyForKeys:<#(nonnull NSArray<NSString *> *)#> completionHandler:<#^(void)handler#>
    //    asset statusOfValueForKey:<#(nonnull NSString *)#> error:<#(NSError * _Nullable __autoreleasing * _Nullable)#>
    
    /**
     Accessing Metadata Values
     */
    //    item.value
    //    item.time
    //    item.duration
    //    item.locale
    //    item.dataValue
    //    item.extraAttributes
    //    item.dataType
    //    item.extendedLanguageTag
    //    item.startDate
    //    item.identifier
    AVMetadataItem *videoMetadataItem = asset.metadata.firstObject;
    id value = videoMetadataItem.value;
    NSData *dataValue = videoMetadataItem.dataValue;
    NSString *dataType = videoMetadataItem.dataType;
    NSString *identifier = videoMetadataItem.identifier;
    
    /**
     Retrieving Formatted Metadata
     */
    //    item.stringValue
    //    item.numberValue
    //    item.dateValue
    
    /**
     Filtering Arrays of Metadata Items
     */
    //    AVMetadataItem metadataItemsFromArray:<#(nonnull NSArray<AVMetadataItem *> *)#> withKey:<#(nullable id)#> keySpace:<#(nullable AVMetadataKeySpace)#>
    //    AVMetadataItem metadataItemsFromArray:<#(nonnull NSArray<AVMetadataItem *> *)#> withLocale:<#(nonnull NSLocale *)#>
    //    AVMetadataItem metadataItemsFromArray:<#(nonnull NSArray<AVMetadataItem *> *)#> filteredByMetadataItemFilter:<#(nonnull AVMetadataItemFilter *)#>
    //    AVMetadataItem metadataItemsFromArray:<#(nonnull NSArray<AVMetadataItem *> *)#> filteredByIdentifier:<#(nonnull AVMetadataIdentifier)#>
    //    AVMetadataItem metadataItemsFromArray:<#(nonnull NSArray<AVMetadataItem *> *)#> filteredAndSortedAccordingToPreferredLanguages:<#(nonnull NSArray<NSString *> *)#>
    
    
    /*
     AVMetadataItemFilter
     
     An object that filters selected information from a metadata item.
     
     AVMetadataItemFilter instances are opaque, unmodifiable objects,
     created via the class metadataItemFilterForSharing method.
     */
    
    /**
     Creating a Metadata item Filter
     */
    AVMetadataItemFilter *itemFilter = [AVMetadataItemFilter metadataItemFilterForSharing];
    
    
    /*
     AVMetadataItemValueRequest
     
     An object used to respond to a request to load the value of
     a metadata item.
     */
    //    [AVMetadataItemValueRequest alloc] respondWithValue:<#(nonnull id<NSObject,NSCopying>)#>
    //    [AVMetadataItemValueRequest alloc] respondWithError:<#(nonnull NSError *)#>
    
    
    /*
     AVMutableMetadataItem
     
     A mutable metadata item associated with an audiovisual asset or 
     with one of its tracks.
     */
    
    /**
     Creating a Mutable metadata item
     */
    AVMutableMetadataItem *mutableMetadataItem = [AVMutableMetadataItem metadataItem];
    
    /**
     Configuring Keys and Key Spaces
     */
    //    mutableMetadataItem.key
    //    mutableMetadataItem.keySpace
    
    /**
     Configuring Metadata Values
     */
    //    mutableMetadataItem.value
    //    mutableMetadataItem.locale
    //    mutableMetadataItem.time
    //    mutableMetadataItem.duration
    //    mutableMetadataItem.extraAttributes
    //    mutableMetadataItem.dataType
    //    mutableMetadataItem.extendedLanguageTag
    //    mutableMetadataItem.identifier
    //    mutableMetadataItem.startDate
    
    
    /*
     AVMetadataFormat
     
     A value that defines a metadata format.
     
     AVMetadataFormatHLSMetadata
     AVMetadataFormatiTunesMetadata
     AVMetadataFormatID3Metadata
     AVMetadataFormatISOUserData
     AVMetadataFormatQuickTimeMetadata
     AVMetadataFormatQuickTimeUserData
     AVMetadataFormatUnknown
     */
    
    
#pragma mark -- Fragmented Assets
    
    /*
     AVFragmentedAsset
     
     An asset you can extend the total duration of without
     modifying the previously existing data structure.
     
     AVFragmentedAsset is a subclass of AVURLAsset.
     
     Media resources that include QuickTime movie files and MPEG-4
     files that indicate, via an 'mvex' box in their 'moov' box,
     that they accommodate additional fragments. AVFragmentedAsset
     can also support other media resource types. To determine whether
     a given instance of AVFragmentedAsset can monitor the addition
     of fragments, check the value of the canContainFragments property
     
     Fragmented assets associated with an instance of AVFragmentedAssetMinder
     and an operation that appends fragments to the underlying media resource
     is in progress, AVFragmentedAsset is capable of changing certain values
     of its properties and those of its tracks.
     
     While associated with an AVFragmentedAssetMinder, AVFragmentedAssetTrack
     posts AVAssetDurationDidChangeNotification and whenever it detects
     new fragments, as appropriate. It may also post
     AVAssetContainsFragmentsDidChangeNotification
     and AVAssetWasDefragmentedNotification, as discussed in documentation of
     those notifications.
     */
    
    AVFragmentedAsset *fragmentedAsset = [AVFragmentedAsset assetWithURL:sourceURL];
    /**
     Accesing tracks
     */
    //    fragmentedAsset.tracks
    //    fragmentedAsset trackWithTrackID:<#(CMPersistentTrackID)#>
    //    fragmentedAsset tracksWithMediaType:<#(nonnull AVMediaType)#>
    //    fragmentedAsset tracksWithMediaCharacteristic:<#(nonnull AVMediaCharacteristic)#>
    //    [AVFragmentedAsset fragmentedAssetWithURL:sourceURL options:NULL];
    
    
    /*
     AVFragmentedAssetMinder
     
     An object that periodically checks whether fragmented assets had
     additional fragments appended to them.
     */
    
    /**
     Creating Fragment Assets
     */
    AVFragmentedAssetMinder *assetMinder = [[AVFragmentedAssetMinder alloc] initWithAsset:fragmentedAsset mindingInterval:1.0];
    //    AVFragmentedAssetMinder fragmentedAssetMinderWithAsset:<#(nonnull AVAsset<AVFragmentMinding> *)#> mindingInterval:<#(NSTimeInterval)#>
    //    assetMinder.mindingInterval
    
    /**
     Inspecting a Fragment asset
     */
    //    assetMinder.assets
    
    /**
     Adding and Removing Asset Fragments
     */
    //    assetMinder addFragmentedAsset:<#(nonnull AVAsset<AVFragmentMinding> *)#>
    //    assetMinder removeFragmentedAsset:<#(nonnull AVAsset<AVFragmentMinding> *)#>
    
    /**
     Determining Fragment Support
     
     AVFragmentMinding
     Properties you can query to determine if an asset supports
     fragment minding.
     */
    
    
    /*
     AVFragmentedAssetTrack
     
     An object used for handling tracks of fragmented assets.
     
     AVFragmentedAssetTrack is a subclass of AVAssetTrack. It has no
     methods or properties of its own.
     */
    
    
    
#pragma mark -- Media Export
    
    /*
     Exporting Video to Alternative Formats
     
     Convert an existing movie file to a different format.
     
     To convert existing movie files to a format that makes them
     compatible with other devices, you must generate a new
     movie file based on the contents of the existing file.
     You can't change the format of the saved video in place;
     you must create a second file of the the desired format.
     
     This article assumes that you're already saved the movie
     file in a different format. If your app is saving a movie
     directly from video capture, it's more efficient to change
     the default format during capture by following the steps
     in Capturing Video in Alternative Formats.
     */
    
    /**
     Export the New Video into the Desired Format
     
     Convert the movie file by exporting the asset into the desired
     file type. Pick the type you want for the final video from the
     list of AVFileType presets that AVFoundation provides. You'll use
     that type to configure an AVAssetExportSession object, which
     then manages the export process from your existing type.
     
     For example, to convert a movie file to H.264/MPEG-4 AVC, use
     an existing preset that encodes to H.264, such as
     AVAssetExportPresetHighestQuality, and set the output file
     type to AVFileTypeQuickTimeMoive.
     */
    
    [AVAssetExportSession determineCompatibilityOfExportPreset:AVAssetExportPresetHighestQuality withAsset:asset outputFileType:AVFileTypeAppleM4V completionHandler:^(BOOL compatible) {
        if (!compatible) {
            return;
        }
        //Compatibility check successed, continue with export.
        
    }];
    
    
    /*
     AVAssetExportSession
     
     An object that transcodes the contents of an asset source object
     to create an output of the form describle by a specified export
     preset.
     
     Prior to initializing an instance of AVAssetExportSession, you can
     use allExportPresets to get the complete list of presets available.
     Use exportPresetsCompatibleWithAsset: to get a list of presets that
     are compatible with a specific asset.
     
     After you have initialized an export session with the asset that
     contains the source media, the export preset name(presetName),
     and the output file type(outputFileType), you can start the
     export running by invoking exportAsynchronouslyWithCompletionHandler:.
     Because the export is performed asynchronously, this method returns
     immediately -- you can use progress to check on the progress.
     Depending on the capabilities of the device, some exports may be
     queued when multiple exports are attempted. When this happens,
     the status of a queued export will indicate that it's waiting
     (AVAssetExportSessionStatusWaiting).
     
     The completion handler you supply to exportAsynchronouslyWithCompletionHandler:
     is called whether the export fails, completes, or is cancelled.
     Upon completion, the status property indicates whether the export
     has completed successfully. If it has failed, the value of the
     error property supplies additional information about the reason
     for the failure.
     */
    
    /**
     Initializing a Session
     */
    AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:asset presetName:AVAssetExportPreset1920x1080];
    //    [AVAssetExportSession exportSessionWithAsset:asset presetName:AVAssetExportPreset1920x1080];
    
    /**
     Configuring Output
     
     Indicates the URL of the export session's output. You may use UTTypeCopyPreferredTagWithClass(outputFileType, kUTTagClassFilenameExtension) to obtain an appropriate path extension for the outputFileType you have specified. For more information about UTTypeCopyPreferredTagWithClass and kUTTagClassFilenameExtension, on iOS see <MobileCoreServices/UTType.h> and on Mac OS X see <LaunchServices/UTType.h>.
     */
    id extension = CFBridgingRelease(UTTypeCopyPreferredTagWithClass((CFStringRef)AVFileTypeAppleM4V, kUTTagClassFilenameExtension));
    NSString *outputPath = [NSHomeDirectory() stringByAppendingFormat:@"/test.%@",extension];
    exportSession.outputURL = [NSURL fileURLWithPath:outputPath];
    exportSession.outputFileType = AVFileTypeAppleM4V;
    //    exportSession.supportedFileTypes
    //    exportSession.fileLengthLimit
    //    exportSession.timeRange
    //    exportSession.metadata
    //    exportSession.metadataItemFilter
    exportSession.audioMix = [AVMutableAudioMix audioMix];
    exportSession.audioTimePitchAlgorithm = AVAudioTimePitchAlgorithmTimeDomain;
    exportSession.shouldOptimizeForNetworkUse = YES;
    //    exportSession.videoComposition
    //    exportSession.customVideoCompositor
    //    exportSession.canPerformMultiplePassesOverSourceMediaData
    //    exportSession.directoryForTemporaryFiles
    
    /**
     Configuring Export Presets
     */
    //    exportSession.presetName
    //    [AVAssetExportSession allExportPresets];
    //    [AVAssetExportSession exportPresetsCompatibleWithAsset:asset];
    //    AVAssetExportSession determineCompatibilityOfExportPreset:<#(nonnull NSString *)#> withAsset:<#(nonnull AVAsset *)#> outputFileType:<#(nullable AVFileType)#> completionHandler:<#^(BOOL compatible)handler#>
    //    exportSession determineCompatibleFileTypesWithCompletionHandler:<#^(NSArray<AVFileType> * _Nonnull compatibleFileTypes)handler#>
    
    
    /**
     Exporting Media
     */
    [exportSession exportAsynchronouslyWithCompletionHandler:^{
        switch (exportSession.status) {
            case AVAssetExportSessionStatusUnknown:
            {
            }
                break;
            case AVAssetExportSessionStatusWaiting:
            {
            }
                break;
            case AVAssetExportSessionStatusExporting:
            {
                NSLog(@"%f",exportSession.progress);
            }
                break;
            case AVAssetExportSessionStatusCompleted:
            {
                NSLog(@"export completed");
            }
                break;
            case AVAssetExportSessionStatusFailed:
            {
                NSLog(@"export error %@",exportSession.error);
            }
                break;
            case AVAssetExportSessionStatusCancelled:
            {
            }
                break;
        }
    }];
    //    [exportSession cancelExport];
    //    exportSession.error
    
    /**
     Getting Export Status
     */
    //    exportSession.progress
    //    exportSession.status
    
    /**
     Accessing the Asset
     */
    //    exportSession.asset
    
    /**
     Instance methods
     */
    //    exportSession estimateMaximumDurationWithCompletionHandler:<#^(CMTime estimatedMaximumDuration, NSError * _Nullable error)handler#>
    //    exportSession estimateOutputFileLengthWithCompletionHandler:<#^(int64_t estimatedOutputFileLength, NSError * _Nullable error)handler#>
    
    
    
    
#pragma mark -- Reading and Writing
    
    /*
     AVAssetReader
     
     A reader object used to obtain the media data of an asset, either
     file-based or consisting of an assemblage of media data from
     multiple sources.
     
     AVAssetReader lets you:
     •  Read raw un-decoded media samples directly from storage,
     obtain samples decoded into renderable forms.
     •  Mix multiple audio tracks of the asset and compose multiple
     video tracks by using AVAssetReaderAudioMixOutput and
     AVAssetReaderVideoCompositionOutput.
     
     The AVAssetReader pipelines are multithreaded internally.
     After you initiate reading with initWithAsset:error:,
     a reader loads and processes a reasonable amount of sample
     data ahead of use so that retrieval operations such as
     copyNextSampleBuffer(AVAssetReaderOutput) can have very
     low latency. AVAssetReader is not intended for use with
     real-time sources, and its performance is not guaranteed
     for real-time operations.
     */
    
    
    /**
     Creating a Reader
     */
    //    NSError *assetReaderError = nil;
    //    AVAssetReader *assetReader = [[AVAssetReader alloc] initWithAsset:asset error:&assetReaderError];
    //    [AVAssetReader assetReaderWithAsset:asset error:&assetReaderError];
    
    /**
     Managing Outputs
     */
    //    assetReader.outputs
    //    assetReader addOutput:<#(nonnull AVAssetReaderOutput *)#>
    //    assetReader canAddOutput:(nonnull AVAssetReaderOutput *)
    
    /**
     Controlling Reading
     */
    //    assetReader.status
    //    assetReader startReading
    //    assetReader cancelReading
    //    assetReader.error
    //    assetReader.timeRange
    
    /**
     Getting the Asset
     */
    //    assetReader.asset
    
    
    
    /*
     AVAssetReaderAudioMixOutput
     
     An object that defines an interface for reading audio samples
     that result from mixing the audio from one or more tracks.
     
     AVAssetReaderAudioMixOutput is a concrete subclass of
     AVAssetReaderOutput. You can read the audio data mixed from
     one or more asset tracks by adding an instance of
     AVAssetReaderAudioMixOutput to an asset reader using
     addOutput:. You can read the samples in a default format
     or you can convert them to a different format.
     */
    
    /**
     Creating an Audio Mix Output
     */
    AVAssetTrack *audioTrack = asset.tracks.lastObject;
    AVAssetReaderAudioMixOutput *audioMixOutput =
    [[AVAssetReaderAudioMixOutput alloc] initWithAudioTracks:@[audioTrack] audioSettings:nil];
    //    AVAssetReaderAudioMixOutput assetReaderAudioMixOutputWithAudioTracks:<#(nonnull NSArray<AVAssetTrack *> *)#> audioSettings:
    
    
    /**
     Configuring Audio Properties
     */
    //    audioMixOutput.audioMix = [AVMutableAudioMix audioMix];
    //    audioMixOutput.audioSettings
    //    audioMixOutput.audioTracks
    audioMixOutput.audioTimePitchAlgorithm = AVAudioTimePitchAlgorithmTimeDomain;
    //    audioMixOutput.mediaType
    audioMixOutput.alwaysCopiesSampleData = NO;
    audioMixOutput.supportsRandomAccess = NO;
    //    [audioMixOutput markConfigurationAsFinal];
    //    audioMixOutput resetForReadingTimeRanges:<#(nonnull NSArray<NSValue *> *)#>
    
//    if ([assetReader canAddOutput:audioMixOutput]) {
//        [assetReader addOutput:audioMixOutput];
//    }
    //    assetReader.timeRange = assetTrack.timeRange;
    //    assetReader.status
    //    assetReader.error
    //    assetReader.outputs
    //    [assetReader addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
    //    [assetReader startReading];
    //    if (assetReader.status == AVAssetReaderStatusFailed) {
    //        NSLog(@"readerStatusFailed %@",assetReader.error.description);
    //    }
    
    //    CMSampleBufferRef audioMixOutputBuffer = [audioMixOutput copyNextSampleBuffer];
    //    CMBlockBufferRef blockBufferRef = CMSampleBufferGetDataBuffer(audioMixOutputBuffer);
    //    CMTimeShow(CMSampleBufferGetDecodeTimeStamp(audioMixOutputBuffer));
    //    CMTimeShow(CMSampleBufferGetDuration(audioMixOutputBuffer));
    //    CMFormatDescriptionRef descriptionRef = CMSampleBufferGetFormatDescription(audioMixOutputBuffer);
    //    CVImageBufferRef imagebufferRef = CMSampleBufferGetImageBuffer(audioMixOutputBuffer);
    //    CMItemCount itemCount = CMSampleBufferGetNumSamples(audioMixOutputBuffer);
    //    CMTimeShow(CMSampleBufferGetOutputDecodeTimeStamp(audioMixOutputBuffer));
    //    CMTimeShow(CMSampleBufferGetOutputDuration(audioMixOutputBuffer));
    //    CMTimeShow(CMSampleBufferGetOutputPresentationTimeStamp(audioMixOutputBuffer));
    //    //    //    CMSampleBufferGetOutputSampleTimingInfoArray
    //    CMTimeShow(CMSampleBufferGetPresentationTimeStamp(audioMixOutputBuffer));
    //    CFArrayRef arrayRef = CMSampleBufferGetSampleAttachmentsArray(audioMixOutputBuffer, YES);
    //    size_t sampleSize = CMSampleBufferGetSampleSize(audioMixOutputBuffer, 0);
    //    size_t *sizeArrayOut = nil;
    //    CMItemCount *sizeArrayEntriesNeededOut = nil;
    //    OSStatus status = CMSampleBufferGetSampleSizeArray(audioMixOutputBuffer, 1, sizeArrayOut, sizeArrayEntriesNeededOut);
    //    CMSampleTimingInfo timingInfoOut;
    //    CMSampleBufferGetSampleTimingInfo(audioMixOutputBuffer, 1, &timingInfoOut);
    //    CMSampleBufferGetSampleTimingInfoArray(audioMixOutputBuffer, 1, &timingInfoOut, sizeArrayEntriesNeededOut);
    //    size_t totalSampleSize = CMSampleBufferGetTotalSampleSize(audioMixOutputBuffer);
    //    OSStatus statusOut;
    //    CMSampleBufferHasDataFailed(audioMixOutputBuffer, &statusOut);
    //    Boolean isReady = CMSampleBufferDataIsReady(audioMixOutputBuffer);
    //    CMSampleBufferIsValid(audioMixOutputBuffer);
    //
    //    size_t bufferListSizeNeededOut;
    //    AudioBufferList bufferListOut;
    //    CMBlockBufferRef blockBufferOut;
    //    OSStatus getAudioBufferList = CMSampleBufferGetAudioBufferListWithRetainedBlockBuffer(audioMixOutputBuffer, &bufferListSizeNeededOut, &bufferListOut, 4, kCFAllocatorDefault, kCFAllocatorDefault, 10, &blockBufferOut);
    //
    //        BOOL isEmpty = CMBlockBufferIsEmpty(blockBufferRef);
    //        size_t dataLength = CMBlockBufferGetDataLength(blockBufferRef);
    //        size_t lengthAtOffsetOut;
    //        size_t totalLengthOut;
    //        char *dataPointerOut;
    //        CMBlockBufferGetDataPointer(blockBufferRef, 0, &lengthAtOffsetOut, &totalLengthOut, &dataPointerOut);
    //        BOOL contiguous = CMBlockBufferIsRangeContiguous(blockBufferRef, 0, dataLength);
    
    
    
    /*
     AVAssetReaderTrackOutput
     
     An object that defines an interface for reading media data
     from a single track of an asset reader's asset.
     
     You can read the media data of an asset track by adding an instance
     of AVAssetReaderTrackOutput to an asset reader using the AVAssetReader
     method addOutput:. You can read the samples in the track in their
     stored format, or you can convert them to a different format.
     
     The AVAssetReaderTrackOutput class can only produce uncompressed
     output.  For audio output settings, this means that AVFormatIDKey
     must be kAudioFormatLinearPCM.  For video output settings, this
     means that the dictionary must contain values for uncompressed
     video output, as defined in Video Settings.  AVAssetReaderTrackOutput
     does not support the AVSampleRateConverterAudioQualityKey key or the
     following Video_Settings keys: AVVideoCleanApertureKey,
     AVVideoPixelAspectRatioKey, AVVideoScalingModeKey, or the
     AVVideoColorPropertiesKey key.
     */
    
    /**
     Creating a Track Output
     */
    //    AVAssetTrack *videoTrack = asset.tracks.firstObject;
    //    AVAssetReaderTrackOutput *trackOutput = [AVAssetReaderTrackOutput assetReaderTrackOutputWithTrack:videoTrack outputSettings:nil];
    //    [AVAssetReaderTrackOutput alloc] initWithTrack:<#(nonnull AVAssetTrack *)#> outputSettings:<#(nullable NSDictionary<NSString *,id> *)#>
    
    /**
     Retrieving Output Properties
     */
    //        trackOutput.outputSettings
    //        trackOutput.track
    //    trackOutput.audioTimePitchAlgorithm = AVAudioTimePitchAlgorithmTimeDomain;
    //
    //    if ([assetReader canAddOutput:trackOutput]) {
    //        [assetReader addOutput:trackOutput];
    //    }
    //    assetReader.timeRange = videoTrack.timeRange;
    //    [assetReader startReading];
    //
    //    CMSampleBufferRef trackOutputBuffer = [trackOutput copyNextSampleBuffer];
    //    CMBlockBufferRef trackOutputBlockBuffer = CMSampleBufferGetDataBuffer(trackOutputBuffer);
    
    
    
    /*
     AVAssetReaderSampleReferenceOutput
     
     An object that defines an interface for reading sample references
     from a single asset track.
     
     AVAssetReaderSampleReferenceOutput is a concrete subclass
     AVAssetReaderOutput. The sample reference is from a single
     AVAssetTrack of an AVAsset instance contained in an AVAssetReader object.
     
     Clients can extract information about the location of samples in
     a track—the file URL and offset—by adding an instance of this
     class to an AVAssetReader object using the addOutput:. The
     kCMSampleBufferAttachmentKey_SampleReferenceURL and
     kCMSampleBufferAttachmentKey_SampleReferenceByteOffset
     attachments on the extracted sample buffers describe the
     location of the sample data. Find more information about sample
     buffers describing sample references in the CMSampleBuffer.
     
     You can also append sample buffers extracted using this class
     to an AVAssetWriterInput instance to create movie tracks that
     are not self-contained and reference data in the original file
     instead. To write tracks that are not self-contained, use instances
     of AVAssetWriter configured to write files of type AVFileTypeQuickTimeMovie.
     
     Since you can't extract sample data and return it by instances of
     AVAssetReaderSampleReferenceOutput, ignore the value of the
     alwaysCopiesSampleData property.
     */
    
    /**
     Creating Sample Reference Output instances
     */
    //    AVAssetReaderSampleReferenceOutput *sampleReferenceOutput = [AVAssetReaderSampleReferenceOutput assetReaderSampleReferenceOutputWithTrack:assetTrack];
    //        [AVAssetReaderSampleReferenceOutput alloc] initWithTrack:<#(nonnull AVAssetTrack *)#>
    
    /**
     Getting the Track
     
     track
     The track from which the sample references are extracted.
     */
    
    //    if ([assetReader canAddOutput:sampleReferenceOutput]) {
    //        [assetReader addOutput:sampleReferenceOutput];
    //    }
    
    //    assetReader.asset
    //    assetReader.error
    //    assetReader.status
    //    assetReader.outputs
    //    assetReader.timeRange = assetTrack.timeRange;
    
    //    [assetReader startReading];
    //    CMSampleBufferRef nextSampleBuffer = [sampleReferenceOutput copyNextSampleBuffer];
    //    CMBlockBufferRef blockBufferRef = CMSampleBufferGetDataBuffer(nextSampleBuffer);
    
    
    
    
    /*
     AVAssetReaderVideoCompositionOutput
     
     An object that reads video frames composited from the frames
     in one or more tracks of a reader's assets.
     
     AVAssetReaderVideoCompositionOutput is a subclass of AVAssetReaderOutput.
     Composit the video frames together from the frames in one or more
     tracks of an AVAssetReader object's asset.
     
     You can read the composited video frames from one or more asset tracks
     by adding an instance of AVAssetReaderVideoCompositionOutput to an
     AVAssetReader object with the addOutput: method.
     
     AVAssetReaderVideoCompositionOutput can only produce uncompressed
     output.  This means that the videoSettings dictionary must follow
     the rules for uncompressed video output.  In addition, the following
     keys are not supported: AVVideoCleanApertureKey,
     AVVideoPixelAspectRatioKey, AVVideoScalingModeKey, and
     AVVideoColorPropertiesKey.
     */
    
    /**
     Creating a Video Composition Output
     */
    //    AVAssetTrack *videoTrack = asset.tracks.firstObject;
    //    AVAssetReaderVideoCompositionOutput *videoCompositionOutput = [AVAssetReaderVideoCompositionOutput assetReaderVideoCompositionOutputWithVideoTracks:@[videoTrack] videoSettings:nil];
    //    //    [AVAssetReaderVideoCompositionOutput alloc] initWithVideoTracks:<#(nonnull NSArray<AVAssetTrack *> *)#> videoSettings:<#(nullable NSDictionary<NSString *,id> *)#>
    
    /**
     Setting Video Properties
     */
    //    AVMutableVideoComposition *videoComposition = [AVMutableVideoComposition videoComposition];
    //    videoComposition.renderSize = CGSizeMake(100, 100);
    //    videoComposition.frameDuration = CMTimeMake(100, 1);
    //    videoCompositionOutput.videoComposition = videoComposition;
    ////    videoCompositionOutput.customVideoCompositor
    ////    videoCompositionOutput.videoSettings
    ////    videoCompositionOutput.videoTracks
    //    videoCompositionOutput.alwaysCopiesSampleData = YES;
    //
    //    if ([assetReader canAddOutput:videoCompositionOutput]) {
    //        [assetReader addOutput:videoCompositionOutput];
    //    }
    //    assetReader.timeRange = videoTrack.timeRange;
    ////    assetReader.asset
    ////    assetReader.error
    ////    assetReader.status
    ////    assetReader.outputs
    //    [assetReader startReading];
    //    CMSampleBufferRef sampleBufferRef = [videoCompositionOutput copyNextSampleBuffer];
    //    CMBlockBufferRef blockBufferRef = CMSampleBufferGetDataBuffer(sampleBufferRef);
    
    
    
    /*
     AVAssetReaderOutput
     
     An abstract class that defines an interface for reading a single
     collection of samples of a common media type from an
     asset reader object.
     
     There are several subclasses of AVAssetReaderOutput for
     specific tasks, such as AVAssetReaderTrackOutput or
     AVAssetReaderVideoCompositionOutput.
     
     You can read the media data of an asset by adding one or more
     concrete instances of AVAssetReaderOutput to an AVAssetReader
     object using addOutput:.
     */
    
    /**
     Copying a Buffer
     */
    //        AVAssetReaderOutput *output = nil;
    //    output copyNextSampleBuffer
    //    output alwaysCopiesSampleData
    
    /**
     Inspecting the Media type
     */
    //    output.mediaType
    
    /**
     Configuring Reading Settings
     */
    //        [output markConfigurationAsFinal];
    //        output resetForReadingTimeRanges:<#(nonnull NSArray<NSValue *> *)#>
    //        output supportsRandomAccess
    
    
    /*
     AVAssetReaderOutputMetadataAdaptor
     
     An object that defines an interface for reading metadata.
     
     You can package the read metadata as instances of AVTimedMetadataGroup
     or from a single AVAssetReaderTrackOutput object.
     */
    
    /**
     Creating an Output Metadata Adaptor
     */
    //    AVAssetReaderOutputMetadataAdaptor assetReaderOutputMetadataAdaptorWithAssetReaderTrackOutput:<#(nonnull AVAssetReaderTrackOutput *)#>
    //    [AVAssetReaderOutputMetadataAdaptor alloc] initWithAssetReaderTrackOutput:<#(nonnull AVAssetReaderTrackOutput *)#>
    
    /**
     Getting the Track Output Object
     */
    //    AVAssetReaderOutputMetadataAdaptor *outputMetadataAdaptor = nil;
    //    outputMetadataAdaptor.assetReaderTrackOutput
    
    /**
     Getting the Next Timed Metadata Group
     */
    //    outputMetadataAdaptor.nextTimedMetadataGroup
    
    
    
    
    
    
    /*
     AVAssetWriter
     
     An object used to write media data to a new file of a specified
     audiovisual container type.
     
     You can get the media data for one or more assets from instances of
     AVAssetReader or even from outside the AVFoundation API set. Send
     Media data to AVAssetWriter for writing in the form of CMSampleBuffer.
     Sequences of sample data appended to the asset writer inputs fall
     within "sample-writing sessions." You must call startSessionAtSourceTime:
     to begin one of these sessions.
     
     Using AVAssetWriter, you can optionally re-encode media samples
     while writing. You can also optionally write metadata collections
     to the output file. AVAssetWriter automatically supports interleaving
     of media data for multiple concurrent tracks.
     
     You can only use a given instance of AVAssetWriter once to write to a
     single file. You must use a new instance of AVAssetWriter every time
     you write to a file.
     */
    
    /**
     Creating an Asset Writer
     */
    //    AVAssetWriter assetWriterWithURL:<#(nonnull NSURL *)#> fileType:<#(nonnull AVFileType)#> error:<#(NSError * _Nullable __autoreleasing * _Nullable)#>
    //    [AVAssetWriter alloc] initWithURL:<#(nonnull NSURL *)#> fileType:<#(nonnull AVFileType)#> error:<#(NSError * _Nullable __autoreleasing * _Nullable)#>
    //    AVAssetWriter *assetWriter = nil;
    //    assetWriter.availableMediaTypes
    
    
    /**
     Writing Data
     */
    //    [assetWriter startWriting];
    //    assetWriter finishWritingWithCompletionHandler:<#^(void)handler#>
    //    assetWriter cancelWriting
    //    assetWriter.outputURL
    //    assetWriter.outputFileType
    //    assetWriter.error
    //    assetWriter.status
    
    /**
     Managing Inputs
     */
    //    assetWriter.inputs
    //    assetWriter canAddInput:<#(nonnull AVAssetWriterInput *)#>
    //    assetWriter addInput:<#(nonnull AVAssetWriterInput *)#>
    
    
    /**
     Managing Session Time
     */
    //    assetWriter startSessionAtSourceTime:<#(CMTime)#>
    //    assetWriter endSessionAtSourceTime:<#(CMTime)#>
    
    /**
     Configuring Output
     */
    //    assetWriter canApplyOutputSettings:<#(nullable NSDictionary<NSString *,id> *)#> forMediaType:<#(nonnull AVMediaType)#>
    //    assetWriter.metadata
    //    assetWriter.movieFragmentInterval
    //    assetWriter.overallDurationHint
    //    assetWriter.movieTimeScale
    //    assetWriter.shouldOptimizeForNetworkUse
    
    /**
     Managing Asset Writer Input Groups
     */
    //    assetWriter canAddInputGroup:<#(nonnull AVAssetWriterInputGroup *)#>
    //    assetWriter addInputGroup:<#(nonnull AVAssetWriterInputGroup *)#>
    //    assetWriter.inputGroups
    
    
    
    /*
     AVAssetWriterInput
     
     A writer used to append media samples tp a single track of
     an asset writer's output file.
     
     An AVAssetWriterInput object can append media samples packaged
     as CMSampleBufferRef objects, or collections of metadata,
     to a single track of the output file of an AVAssetWriter object.
     
     When there are multiple inputs, AVAssetWriter tries to write
     media data in an ideal interleaving pattern for efficiency in
     storage and playback. Each of its inputs signals its readiness
     to receive media data for writing according to that pattern
     via the value of readyForMoreMedia. If readyForMoreMediaData
     is YES, an input can accept additional media data while
     maintaining appropriate interleaving. You can only append
     media data to an input while its readyForMoreMediaData property
     is YES.
     •  If you're writing media data from a non-real-time source,
     such as an instance of AVAssetReader, you should hold off
     on generating or obtaining more media data to append to an
     input when the value of readyForMoreMediaData is No. To
     help with control of the supply of non-real-time media data,
     you can use requestMediaDataWhenReadyOnQueue:usingBlock:
     to specify a block that the input should invoke whenever
     it's ready to append input.
     •  If you're writing media data from a real-time source such
     as an AVCaptureOutput object, you should set the input's
     expectsMediaDataInRealTime property to YES to ensure to
     calculate the value fo readyForMoreMediaData appropriately.
     When expectsMediaDataInRealTime is YES, readyForMoreMediaData
     will become NO only when the input cannot process media samples
     as quickly as they are provided by the client. If
     readyForMoreMediaData becomes NO for a real-time source,
     the client may need to drop samples or consider reducing the
     data rate of appended samples.
     
     The value of readyForMoreMediaData will often change from NO
     to YES asynchronously while processing and writing
     previously-supplied media data to the output. It is possible
     for all fo an asset writer's inputs temporarily to return
     NO for readForMoreMediaData.
     */
    
    
    /**
     Creating an Asset Writer Input Instance
     */
    //    AVAssetWriterInput assetWriterInputWithMediaType:<#(nonnull AVMediaType)#> outputSettings:<#(nullable NSDictionary<NSString *,id> *)#>
    //    AVAssetWriterInput assetWriterInputWithMediaType:<#(nonnull AVMediaType)#> outputSettings:<#(nullable NSDictionary<NSString *,id> *)#> sourceFormatHint:<#(nullable CMFormatDescriptionRef)#>
    //    [AVAssetWriterInput alloc] initWithMediaType:<#(nonnull AVMediaType)#> outputSettings:<#(nullable NSDictionary<NSString *,id> *)#>
    //    [AVAssetWriterInput alloc] initWithMediaType:<#(nonnull AVMediaType)#> outputSettings:<#(nullable NSDictionary<NSString *,id> *)#> sourceFormatHint:<#(nullable CMFormatDescriptionRef)#>
    
    /**
     Adding Media Samples
     */
    //    AVAssetWriterInput *writerInput = nil;
    //    writerInput appendSampleBuffer:<#(nonnull CMSampleBufferRef)#>
    //    writerInput.readyForMoreMediaData
    //    writerInput markAsFinished
    //    writerInput requestMediaDataWhenReadyOnQueue:<#(nonnull dispatch_queue_t)#> usingBlock:<#^(void)block#>
    
    /**
     Configuring a Writer Input
     */
    //    writerInput.metadata
    //    writerInput.transform
    //    writerInput.mediaTimeScale
    //    writerInput.expectsMediaDataInRealTime
    //    writerInput.marksOutputTrackAsEnabled
    //    writerInput.naturalSize
    //    writerInput.preferredVolume
    
    /**
     Managing Track Associations
     */
    //    writerInput addTrackAssociationWithTrackOfInput:<#(nonnull AVAssetWriterInput *)#> type:<#(nonnull NSString *)#>
    //    writerInput canAddTrackAssociationWithTrackOfInput:<#(nonnull AVAssetWriterInput *)#> type:<#(nonnull NSString *)#>
    
    /**
     Inspecting a Writer input
     */
    //    writerInput.mediaType
    //    writerInput.outputSettings
    //    writerInput.sourceFormatHint
    //    writerInput.sampleReferenceBaseURL
    
    /**
     Managing Language Settings
     */
    //    writerInput.extendedLanguageTag
    //    writerInput.languageCode
    
    /**
     Performing Multiple-Pass Encoding
     */
    //    writerInput canPerformMultiplePasses
    //    writerInput currentPassDescription
    //    writerInput markCurrentPassAsFinished
    //    writerInput.preferredMediaChunkDuration
    //    writerInput.preferredMediaChunkAlignment
    //    writerInput.performsMultiPassEncodingIfSupported
    //    writerInput respondToEachPassDescriptionOnQueue:<#(nonnull dispatch_queue_t)#> usingBlock:<#^(void)block#>
    
    /**
     Specifying Media Data Layout
     */
    //    writerInput.mediaDataLocation
    
    
    
    /*
     AVOutputSettingsAssistant
     
     An object that specifies a set of parameters for configuring
     objects that use output settings dictionaries.
     
     Often you create Instances of AVOutputSettingAssistant using
     a string constant representing a specific preset configuration,
     such as AVOutputSettingsPreset1280*720. After configuring the
     instance, its properties can be a guide for creating and configuring
     an AVAssetWriter object and one or more AVAssetWriterInput objects
     so that the resulting media file conforms to a specific criteria.
     The preset configuration properties can be a "base" configuration,
     which you can custimize to suit your individual needs.
     
     The suggested output settings improve as more information
     is provided about the format of the source data. For example,
     by setting the sourceVideoFormat property, the VideoSettings
     property value ensures that video frames don't scale up
     from a smaller size.
     */
    
    /**
     Creating an Output Settings Assistant
     */
    //    AVOutputSettingsAssistant outputSettingsAssistantWithPreset:<#(nonnull AVOutputSettingsPreset)#>
    //    AVOutputSettingsAssistant availableOutputSettingsPresets
    
    /**
     Configuring Output Settings
     */
    //    AVOutputSettingsAssistant *settingsAssistant = nil;
    //    settingsAssistant.outputFileType
    //    settingsAssistant.audioSettings
    //    settingsAssistant.sourceAudioFormat
    //    settingsAssistant.sourceVideoFormat
    //    settingsAssistant.sourceVideoAverageFrameDuration
    //    settingsAssistant.videoSettings
    //    settingsAssistant.sourceVideoMinFrameDuration
    
    
    /*
     AVAssetWriterInputGroup
     
     A group of tracks in a mutually exclusive relationship.
     
     Use this class to associate tracks corresponding to multiple
     AVAssetWriterInput instances as mutually exclusive to each
     other for playback or other processing.
     
     For example, if you are creating an asset with multiple audio
     tracks using different spoken languages -- an only one track
     should be played at a time -- group the inputs corresponding
     to those tracks into a single instance of
     AVAssetWriterInputGroup and add the group to the AVAssetWriter
     instance using the AVAssetWriter method addInputGroup:. If the
     output format supports mutually exclusive relationships among
     tracks, the AVAssetWriter marks the tracks as mutually exclusive
     to each other.
     
     Because AVAssetWriterInputGroup is a subclass of AVMediaSelectionGroup,
     clients can examine the media selection options that are available
     on the output asset before writing the asset. Obtain the best
     results by examining the options of the AVAssetWriterInputGroup
     after associating the AVAssetWriterInput instances of the
     AVAssetTrack objects as appropriate using the AVAssetWriterInput
     method addTrackAssociatedWithTrackOfInput:type: and by initializing
     each AVAssetWriterInput with a source format hint, where appropriate.
     */
    
    /**
     Creating an Asset Writer input Group
     */
    //    AVAssetWriterInputGroup assetWriterInputGroupWithInputs:<#(nonnull NSArray<AVAssetWriterInput *> *)#> defaultInput:<#(nullable AVAssetWriterInput *)#>
    //    [AVAssetWriterInputGroup alloc] initWithInputs:<#(nonnull NSArray<AVAssetWriterInput *> *)#> defaultInput:<#(nullable AVAssetWriterInput *)#>
    
    /**
     Getting the Asset Writer Input Group Settings
     */
    AVAssetWriterInputGroup *writerInputGroup = nil;
    //    writerInputGroup.defaultInput
    //    writerInputGroup.inputs
    
    
    /*
     AVAssetWriterInputMetadataAdaptor
     
     An object that defines an interface for writing metadata
     packaged as timed metadata groups into a single asset writer
     input.
     */
    
    /**
     Creating Input Metadata Adaptors
     */
    AVAssetWriterInputMetadataAdaptor *inputMetadataAdaptor = nil;
    //    [AVAssetWriterInputMetadataAdaptor alloc] initWithAssetWriterInput:<#(nonnull AVAssetWriterInput *)#>
    //    AVAssetWriterInputMetadataAdaptor assetWriterInputMetadataAdaptorWithAssetWriterInput:<#(nonnull AVAssetWriterInput *)#>
    
    /**
     Appending Timed Metadata Groups
     */
    //    inputMetadataAdaptor appendTimedMetadataGroup:<#(nonnull AVTimedMetadataGroup *)#>
    
    /**
     Getting the Input
     */
    //    inputMetadataAdaptor.assetWriterInput
    
    
    
    /*
     AVAssetWriterInputPixelBufferAdaptor
     
     A buffer used to append video samples packaged as pixel buffers
     to a single asset writer input.
     
     Instances of AVAssetWriterInputPixelBufferAdaptor provide a
     CVPixelBufferPoolRef that you can use to allocate pixel buffers
     for writing to the output file. Using the provided pixel buffer
     pool for buffer allocation is typically more efficient than
     appending pixel buffers allocated using a separate pool.
     */
    
    
    /**
     Creating an Adaptor
     */
    //    AVAssetWriterInputMetadataAdaptor assetWriterInputMetadataAdaptorWithAssetWriterInput:<#(nonnull AVAssetWriterInput *)#>
    //    [AVAssetWriterInputMetadataAdaptor alloc] initWithAssetWriterInput:<#(nonnull AVAssetWriterInput *)#>
    
    /**
     Adding a Pixel Buffer
     */
    AVAssetWriterInputPixelBufferAdaptor *inputPixelBufferAdaptor = nil;
    //    inputPixelBufferAdaptor appendPixelBuffer:<#(nonnull CVPixelBufferRef)#> withPresentationTime:<#(CMTime)#>
    
    /**
     Inspecting a Pixel Buffer Adaptor
     */
    //    inputPixelBufferAdaptor.assetWriterInput
    //    inputPixelBufferAdaptor.pixelBufferPool
    //    inputPixelBufferAdaptor.sourcePixelBufferAttributes
    
    
    
#pragma mark -- Image Extraction
    
    /*
     AVAssetImageGenerator
     
     An object that provides thumbnail or preview images of assets
     independently of playback.
     
     AVAssetImageGenerator uses the default enabled video track(s) to
     generate images. Generating a single image in isolation can require
     the decoding of a large number of video frames with complex interdependencies.
     If you require a series of images, you can achieve far greater
     efficiency using the asynchronous method,
     generateCGImagesAsynchronouslyForTimes:completionHandler:,
     which employs decoding efficiencies similar to those used
     during playback.
     
     You create an asset generator using initWithAsset: or
     assetImageGeneratorWithAsset:. These methods may succeed even
     if the asset possesses no visual tracks at the time of initialization.
     You can test whether an asset has any tracks with the visual
     characteristic using the AVAsset class’s method tracksWithMediaCharacteristic:.
     
     The actual time of a generated image is within the range
     [requestedTime-requestedTimeToleranceBefore,
     requestedTime+requestedTimeToleranceAfter] and may differ
     from the requested time for efficiency.
     
     Assets that represent mutable compositions or mutable
     movies may gain visual tracks after initialization of an
     associated image generator.
     */
    
    /**
     Creating an Image Generator
     */
    AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    //    AVAssetImageGenerator *imageGenerator = [AVAssetImageGenerator assetImageGeneratorWithAsset:asset];
    
    /**
     Generating Images
     */
    //    imageGenerator copyCGImageAtTime:<#(CMTime)#> actualTime:<#(nullable CMTime *)#> error:<#(NSError * _Nullable __autoreleasing * _Nullable)#>
    //        imageGenerator generateCGImagesAsynchronouslyForTimes:<#(nonnull NSArray<NSValue *> *)#> completionHandler:<#^(CMTime requestedTime, CGImageRef  _Nullable image, CMTime actualTime, AVAssetImageGeneratorResult result, NSError * _Nullable error)handler#>
    //    [imageGenerator cancelAllCGImageGeneration];
    
    /**
     Managing Image-Generation Time Tolerances
     */
    //    imageGenerator requestedTimeToleranceBefore
    //    imageGenerator requestedTimeToleranceAfter
    
    /**
     Configuring Image-Generation Behavior
     */
    //    imageGenerator.apertureMode
    //    imageGenerator.appliesPreferredTrackTransform
    //    imageGenerator.asset
    //    imageGenerator.maximumSize
    //    imageGenerator.videoComposition
    //    imageGenerator.customVideoCompositor
    
    
    
#pragma mark -- Supporting Types
    
    /*
     Video Settings Dictionaries
     
     Define output image and video formats by using the key
     and value constants.
     */
    
    /**
     Video and Photo Codecs
     
     AVVideoCodecKey
     A key to access the name of the codec for compressing video.
     
     AVVideoCodecType
     A set of constants used to describle codecs for video capture.
     */
    
    
    /**
     Compression
     
     AVVideoCompressionPropertiesKey
     A key to access the dictionary of compression properties for
     a video asset.
     
     AVVideoAverageBitRateKey
     A key to access the average bit rate -- as bits per second --
     used in compressing video.
     
     AVVideoQualityKey
     A key to set the JPEG compression quality of the video.
     
     AVVideoMaxKeyFrameIntervalKey
     A key to access the maximum interval between keyframes.
     
     AVVideoMaxKeyFrameIntervalDurationKey
     A key to access the maximum interval duration between keyframes.
     
     AVVideoAllowFrameReorderingKey
     A key to access permission to reorder frames.
     */
    
    
    /**
     Size and Aspect Ratio
     
     AVVideoWidthKey
     A key to access the width of the video in pixels.
     
     AVVideoHeightKey
     A key to access the height of the video in pixels.
     
     AVVideoPixelAspectRatioKey
     A key to access the video's pixel aspect ratio.
     
     AVVideoPixelAspectRatioVerticalSpacingKey
     A key to access the pixel aspect ratio vertical spacing.
     
     AVVideoPixelAspectRatioHorizontalSpacingKey
     A key to access the pixel aspect ratio horizontal spacing.
     */
    
    
    /**
     Scaling Mode
     
     AVVideoScalingModeFit
     The string identifier for scaling a video to fit the
     surrounding view's dimensions.
     
     AVVideoScalingModeKey
     A key to retrieve the video scaling mode from a dictionary.
     
     AVVideoScalingModeResize
     The string identifier for resizing a video to fit the surrounding
     view's dimensions.
     
     AVVideoScalingModeResizeAspect
     The string identifier for resizing a video to its surrounding
     view's shorter dimension while preserving its aspect ratio.
     
     AVVideoScalingModeResizeAspectFill
     The string identifier for resizing a video to fit the surrounding
     view's longer dimension while preserving aspect ratio.
     */
    
    
    /**
     Clean Aperture
     
     AVVideoCleanApertureKey
     A key that defines the region within the video dimension
     displayed during playback.
     
     AVVideoCleanApertureWidthKey
     A key to access the width of video that's free from transition
     artifacts caused by signal encoding.
     
     AVVideoCleanApertureHeightKey
     A key to access the height of video that's free from transition
     artifacts caused by signal encoding.
     
     AVVideoCleanApertureVerticalOffsetKey
     A key to access the vertical offset of video that's free
     from transition artifacts caused by signal encoding.
     
     AVVideoCleanApertureHorizontalOffsetKey
     A key to access the horizontal offset of video that's free
     from transition artifacts caused by signal encoding.
     */
    
    /**
     Color Properties
     
     AVVideoAllowWideColorKey
     The key for a dictionary that indicates whether the client
     can process wide color.
     
     AVVideoColorPropertiesKey
     The key for a dictionary that contains properties specifying video color.
     
     AVVideoColorPrimariesKey
     The key to identify color primaries in a color properties dictionary.
     
     AVVideoColorPrimaries_P3_D65
     The color primary uses the DCI-P3 D65 color space.
     
     AVVideoColorPrimaries_SMPTE_C
     The color primary uses the SMPTE C color space.
     
     AVVideoColorPrimaries_EBU_3213
     The color primary is in the EBU Tech. 3213 color space.
     
     AVVideoColorPrimaries_ITU_R_709_2
     The color primary is in the ITU_R BT.709 color space.
     
     AVVideoColorPrimaries_ITU_R_2020
     The color primary is in the ITU_R BT.2020 color space for ultra
     high definition television.
     
     AVVideoTransferFunctionKey
     The key to identify the transfer function in a color properties
     dictionary.
     
     AVVideoTransferFunction_ITU_R_709_2
     The transfer function for the ITU_R BT.709 color space.
     
     AVVideoTransferFunction_SMPTE_240M_1995
     The transfer function for the SMPTE 240M color space.
     
     AVVideoTransferFunction_SMPTE_ST_2084_PQ
     The transfer function for the SMPTE 2084 color space.
     
     AVVideoTransferFunction_ITU_R_2100_HLG
     The transfer function for the ITU_R BT.2100 color space.
     
     AVVideoYCbCrMatrixKey
     The key to identify the Y'CbCr matrix in a color properties dictionary.
     
     AVVideoYCbCrMatrix_ITU_R_601_4
     The Y'CbCr color matrix for ITU-R BT.601 conversion.
     
     AVVideoYCbCrMatrix_ITU_R_709_2
     The Y'CbCr color matrix for ITU-R BT.709 conversion.
     
     AVVideoYCbCrMatrix_SMPTE_240M_1995
     The Y'CbCr color matrix for SMPTE 240M conversion.
     
     AVVideoYCbCrMatrix_ITU_R_2020
     The Y'CbCr color matrix for ITU-R BT.2020 conversion.
     */
    
    
    /**
     Profile Level
     
     AVVideoProfileLevelKey
     A key to access the video profile.
     
     AVVideoProfileLevelH264High40
     A high-level 4.0 profile.
     
     AVVideoProfileLevelH264High41
     A high-level 4.1 profile.
     
     AVVideoProfileLevelH264Main30
     A main-level 3.0 profile.
     
     AVVideoProfileLevelH264Main31
     A main-level 3.1 profile.
     
     AVVideoProfileLevelH264Main32
     A main-level 3.2 profile.
     
     AVVideoProfileLevelH264Main41
     A main-level 4.1 profile.
     
     AVVideoProfileLevelH264Baseline30
     A baseline-level 3.0 profile.
     
     AVVideoProfileLevelH264Baseline31
     A baseline-level 3.1 profile.
     
     AVVideoProfileLevelH264Baseline41
     A baseline-level 4.1 profile.
     
     AVVideoProfileLevelH264HighAutoLevel
     A high profile auto level profile.
     
     AVVideoProfileLevelH264MainAutoLevel
     A main profile auto level profile.
     
     AVVideoProfileLevelH264BaselineAutoLevel
     A baseline auto level profile.
     */
    
    
    /**
     Entropy Mode
     
     AVVideoH264EntropyModeKey
     The entropy encoding mode for H.264 compression.
     
     AVVideoH264EntropyModeCABAC
     The encoder uses Context-based Adaptive Binary Arithmetic Coding.
     
     AVVideoH264EntropyModeCAVLC
     The encoder uses Context-based Adaptive Variable Length Coding.
     */
    
    
    /**
     Frame Rate
     
     AVVideoAverageNonDroppableFrameRateKey
     The desired average number of non-droppable frames to be
     encoded for each second of video.
     
     AVVideoExpectedSourceFrameRateKey
     The expected source frame rate.
     */
    
    
    /**
     Video Toolbox Options
     
     AVVideoEncoderSpecificationKey
     The video encoder specification includes options for choosing
     a specific video encoder.
     */
    
    
    /*
     AVFileType
     */
    
    /*
     AVMediaType
     */
    
    /*
     AVMediaCharacteristic
     */
    
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    int value = [change[@"new"] intValue];
    switch (value) {
        case 0:
        {
            NSLog(@"状态未知");
        }
            break;
            
        case 1:
        {
            NSLog(@"状态读取");
        }
            break;
        case 2:
        {
            NSLog(@"状态完成");
        }
            break;
        case 3:
        {
            NSLog(@"状态失败");
        }
            break;
        case 4:
        {
            NSLog(@"状态取消");
        }
            break;
    }
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


