//
//  AssetsViewController.m
//  VideoProcess
//
//  Created by tigerfly on 2020/10/15.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "AssetsViewController.h"
#import <AVFoundation/AVFoundation.h>

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
    
    NSURL *sourceURL = [[NSBundle mainBundle] URLForResource:@"tiger fly 2020-10-10 15.58.59" withExtension:@"mp4"];
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
    [asset cancelLoading];
    
    /**
     Inspecting an Asset
     
     duration
     providesPreciseDurationAndTiming
     creationDate
     preferredRate
     preferredTransform
     preferredVolume
     */
    CMTime time = asset.duration;
    CMTimeShow(time);
    BOOL provides = asset.providesPreciseDurationAndTiming;
    NSLog(@"%d",provides);
    AVMetadataItem *creationDate = asset.creationDate;
    NSLog(@"%@",creationDate.dataValue);
    float preferredRate = asset.preferredRate;
    NSLog(@"%f",preferredRate);
    CGAffineTransform affineTransform = asset.preferredTransform;
    NSLog(@"%@",NSStringFromCGAffineTransform(affineTransform));
    float preferredVolume = asset.preferredVolume;
    NSLog(@"%f",preferredVolume);
    
    
    /**
     Determining Usability
     
     The usability properties have a value of YES when the indicated
     operation can be performed, even if only true under a specific
     set of conditions. These properties only return NO when there is
     no condition under which the associated operation can be performed.
     */
    NSLog(@"playable %d",asset.playable);
    NSLog(@"exportable %d",asset.exportable);
    NSLog(@"readable %d",asset.readable);
    NSLog(@"composable %d",asset.composable);
    NSLog(@"hasProtectedContent %d",asset.hasProtectedContent);
    NSLog(@"compatibleWithAirPlayVideo %d",asset.compatibleWithAirPlayVideo);
    NSLog(@"compatibleWithSavedPhotosAlbum %d",asset.compatibleWithSavedPhotosAlbum);
    
    
    /**
     Accessing Tracks
     */
    NSLog(@"tracks %@",asset.tracks);
    NSLog(@"trackGroups %@",asset.trackGroups);
    //    asset trackWithTrackID:<#(CMPersistentTrackID)#>
    //    asset tracksWithMediaType:<#(nonnull AVMediaType)#>
    //    asset tracksWithMediaCharacteristic:<#(nonnull AVMediaCharacteristic)#>
    CMPersistentTrackID trackID = [asset unusedTrackID];
    NSLog(@"unusedTrackID %d",trackID);
    
    
    /**
     Accessing Metadata
     */
    NSLog(@"lyrics %@",asset.lyrics);
    NSLog(@"metadata %@",asset.metadata);
    NSLog(@"commonMetadata %@",asset.commonMetadata);
    NSLog(@"availableMetadataFormats %@",asset.availableMetadataFormats);
    //    asset metadataForFormat:<#(nonnull AVMetadataFormat)#>
    
    
    /**
     Using Chapter Metadata
     
     Add chapter markers to enable users to quilkly navigate
     your content.
     */
    NSLog(@"availableChapterLocales %@",asset.availableChapterLocales);
    NSArray *metadataGroups = [asset chapterMetadataGroupsWithTitleLocale:[NSLocale systemLocale] containingItemsWithCommonKeys:@[AVMetadataCommonKeyTitle]];
    NSLog(@"%@",metadataGroups);
    NSArray *timeMetadataGroup = [asset chapterMetadataGroupsBestMatchingPreferredLanguages:[NSLocale availableLocaleIdentifiers]];
    NSLog(@"%@",timeMetadataGroup);
    
    
    /**
     Finding Media Selections
     */
    NSLog(@"preferredMediaSelection %@",asset.preferredMediaSelection);
    NSLog(@"asset.availableMediaCharacteristicsWithMediaSelectionOptions %@",asset.availableMediaCharacteristicsWithMediaSelectionOptions);
    NSLog(@"allMediaSelections %@",asset.allMediaSelections);
    //    asset mediaSelectionGroupForMediaCharacteristic:<#(nonnull AVMediaCharacteristic)#>
    
    /**
     Managing Reference Restrictions
     */
    NSLog(@"referenceRestrictions %d", asset.referenceRestrictions);
    
    
    /**
     Working with Fragmented Moives
     */
    NSLog(@"canContainFragments %d", asset.canContainFragments);
    NSLog(@"containsFragments %d", asset.containsFragments);
    NSLog(@"overallDurationHint %d", asset.overallDurationHint);
    
    /**
     Specifying Media Characteristics
     */
    //    AVMediaCharacteristic
    
    
    
#pragma mark -- AVAsynchronousKeyValueLoading
    
    /*
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
    
    
#pragma mark -- Asset Tracks
    
    /**
     AVAssetTrack
     An object that provides the track-level inspection interface for an asset’s media tracks.
     */
    
    /**
     AVAssetTrackGroup
     A group of related tracks in an asset.
     */
    
    /**
     AVAssetTrackSegment
     A segment of an asset track, consisting of a time mapping from the
     source to the asset track timeline.
     */
    
    
#pragma mark -- Metadata
    
    /**
     
     
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
