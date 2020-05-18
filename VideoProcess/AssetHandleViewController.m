//
//  AssetHandleViewController.m
//  VideoProcess
//
//  Created by tigerfly on 2020/5/18.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "AssetHandleViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>
#import <VideoToolbox/VideoToolbox.h>

@interface AssetHandleViewController ()

@end

@implementation AssetHandleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"beauty" withExtension:@"mp4"];
    AVAsset *asset = [AVAsset assetWithURL:url];
    
    // Inspect asset
    CMTimeShow(asset.duration);
    NSLog(@"providesPreciseDurationAndTiming %d",asset.providesPreciseDurationAndTiming);
    NSLog(@"creationDate %@",asset.creationDate);
    NSLog(@"preferredRate %f",asset.preferredRate);
    NSLog(@"preferredTransform %@",NSStringFromCGAffineTransform(asset.preferredTransform));
    NSLog(@"preferredVolume %f",asset.preferredVolume);
    
    //Determine Usablility
    NSLog(@"playable %d",asset.playable);
    NSLog(@"exportable %d",asset.exportable);
    NSLog(@"readable %d",asset.readable);
    NSLog(@"composable %d",asset.composable);
    NSLog(@"hasProtectedContent %d",asset.hasProtectedContent);
    NSLog(@"compatibleWithAirPlayVideo %d",asset.compatibleWithAirPlayVideo);
    NSLog(@"compatibleWithSavedPhotosAlbum %d",asset.compatibleWithSavedPhotosAlbum);
    
    //Accessing Tracks
    for (AVAssetTrack *assetTrack in asset.tracks) {
        NSLog(@"asset %@",assetTrack.asset);
        NSLog(@"trackID %d",assetTrack.trackID);
    }
    for (AVAssetTrackGroup *trackGroup in asset.trackGroups) {
        NSLog(@"trackIDs %@",trackGroup.trackIDs);
    }
//    NSArray *assetTracks = [asset tracksWithMediaType:AVMediaTypeVideo];
//    for (AVAssetTrack *assetTrack in assetTracks) {
//        NSLog(@"assetTrack %@",assetTrack);
//    }
//    NSLog(@"unusedTrackID %d",asset.unusedTrackID);
    
    //Accessing Metadata
    NSLog(@"%@",asset.lyrics);
    for (AVMetadataItem *metadata in asset.metadata) {
        NSLog(@"identifier %@",metadata.identifier);
        NSLog(@"extendedLanguageTag %@",metadata.extendedLanguageTag);
        NSLog(@"locale %@",metadata.locale);
        CMTimeShow(metadata.time);
        CMTimeShow(metadata.duration);
        NSLog(@"dataType %@",metadata.dataType);
        NSLog(@"value %@",metadata.value);
        NSLog(@"extraAttributes %@",metadata.extraAttributes);
        NSLog(@"startDate %@",metadata.startDate);
        NSLog(@"stringValue %@",metadata.stringValue);
        NSLog(@"numberValue %@",metadata.numberValue);
        NSLog(@"dateValue %@",metadata.dateValue);
        NSLog(@"dataValue %@",metadata.dataValue);
        NSLog(@"startDate %@",metadata.startDate);
        NSLog(@"startDate %@",metadata.startDate);
    }
    NSLog(@"availableMetadataFormats %@",asset.availableMetadataFormats);
    
    // Using Chapter Metadata
    NSString *chapterLocalesKey = @"availableChapterLocales";
    [asset loadValuesAsynchronouslyForKeys:@[chapterLocalesKey] completionHandler:^{
        NSError *error = nil;
        AVKeyValueStatus status = [asset statusOfValueForKey:chapterLocalesKey error:&error];
        if (status == AVKeyValueStatusLoaded) {
            NSArray *languages = [NSLocale preferredLanguages];
            NSArray *metadataGroups = [asset chapterMetadataGroupsBestMatchingPreferredLanguages:languages];
            //Process chapter metadata
        }else {
            //handle other status cases
        }
    }];
    NSArray *locales = [asset availableChapterLocales];
    for (NSLocale *locale in locales) {
        NSLog(@"%@",locale.localeIdentifier);
        NSLog(@"%@",locale.languageCode);
        NSLog(@"%@",locale.countryCode);
        NSLog(@"%@",locale.scriptCode);
        NSLog(@"%@",locale.variantCode);
        NSLog(@"%@",locale.exemplarCharacterSet);
        NSLog(@"%@",locale.calendarIdentifier);
        NSLog(@"%@",locale.collationIdentifier);
        NSLog(@"%d0",locale.usesMetricSystem);
        NSLog(@"%@",locale.decimalSeparator);
        NSLog(@"%@",locale.groupingSeparator);
        NSLog(@"%@",locale.currencySymbol);
        NSLog(@"%@",locale.currencyCode);
        NSLog(@"%@",locale.collatorIdentifier);
        NSLog(@"%@",locale.quotationBeginDelimiter);
        NSLog(@"%@",locale.quotationEndDelimiter);
        NSLog(@"%@",locale.alternateQuotationBeginDelimiter);
        NSLog(@"%@",locale.alternateQuotationEndDelimiter);
    }
    if (locales.count != 0) {
        NSArray *metadataGroup = [asset chapterMetadataGroupsWithTitleLocale:locales.firstObject containingItemsWithCommonKeys:@[AVMetadataCommonKeyTitle,AVMetadataCommonKeyCreator,AVMetadataCommonKeySubject,AVMetadataCommonKeyDescription,AVMetadataCommonKeyPublisher]];
        for (AVTimedMetadataGroup *group in metadataGroup) {
            NSLog(@"%@",group.classifyingLabel);
            NSLog(@"%@",group.uniqueID);
        }
    }
    
    // Finding Media Seletions
    AVMediaSelection *mediaSelection = asset.preferredMediaSelection;
    NSArray *mediaCharacteristics = [asset availableMediaCharacteristicsWithMediaSelectionOptions];
    for (AVMediaCharacteristic mediaCharacteristic in mediaCharacteristics) {
        NSLog(@"mediaCharacteristic %@",mediaCharacteristic);
        AVMediaSelectionGroup *selectionGroup = [asset mediaSelectionGroupForMediaCharacteristic:mediaCharacteristic];
        NSLog(@"selectionGroup %d",selectionGroup.options);
        NSLog(@"selectionGroup %d",selectionGroup.defaultOption);
        NSLog(@"selectionGroup %d",selectionGroup.allowsEmptySelection);
    }
    NSArray *allMediaSelections = [asset allMediaSelections];
    for (AVMediaSelection *selection in allMediaSelections) {
        NSLog(@"%@",selection.asset);
    }
    
    //Working with Fragmented Movies
    BOOL containFragments = [asset canContainFragments];
    BOOL containsFragments = [asset containsFragments];
    CMTimeShow(asset.overallDurationHint);
    
    //Specified Media Characteristics

#pragma mark -- AssetTrack
    
    //Retrieving Track Information
    NSArray *assetTracks = [asset tracks];
    for (AVAssetTrack *assetTrack in assetTracks) {
        NSLog(@"assetTrack %@",assetTrack);
        NSLog(@"trackID %d",assetTrack.trackID);
        NSLog(@"mediaType %@",assetTrack.mediaType);
        NSArray * trackUserDataItems = [assetTrack metadataForFormat:AVMetadataFormatQuickTimeUserData ];
        NSArray * trackTaggedMediaCharacteristics = [AVMetadataItem metadataItemsFromArray:trackUserDataItems withKey:AVMetadataQuickTimeUserDataKeyTaggedCharacteristic keySpace:AVMetadataKeySpaceQuickTimeUserData];
        for (AVMetadataItem *metadataItem in trackTaggedMediaCharacteristics) {
            NSString *thisTrackMediaCharacteristic = [metadataItem stringValue];
            NSLog(@"thisTrackMediaCharacteristic %@",thisTrackMediaCharacteristic);
        }
        BOOL audible = [assetTrack hasMediaCharacteristic:AVMediaCharacteristicAudible];
        NSLog(@"audiable %d",audible);
        BOOL visible = [assetTrack hasMediaCharacteristic:AVMediaCharacteristicVisual];
        NSLog(@"visiable %d",visible);
        
        NSLog(@"enabled %d", assetTrack.enabled);
        NSLog(@"playable %d", assetTrack.playable);
        NSLog(@"selfContained %d",assetTrack.selfContained);
        NSLog(@"estimatedDataRate %f",assetTrack.estimatedDataRate);
        NSLog(@"totalSampleDataLength %lld",assetTrack.totalSampleDataLength);
        if (@available(iOS 11.0, *)) {
            NSLog(@"decodable %d",assetTrack.decodable);
        } else {
            // Fallback on earlier versions
        }
        
        // Retrieving Temporal Properties
        CMTimeRangeShow(assetTrack.timeRange);
        NSLog(@"naturalTimeScale%d",assetTrack.naturalTimeScale);
        //Retrieving Language Properties
        NSLog(@"languageCode %@",assetTrack.languageCode);
        NSLog(@"extendedLanguageTag %@",assetTrack.extendedLanguageTag);
        //Retrieving Visual Characteristics
        NSLog(@"naturalSize %@",NSStringFromCGSize(assetTrack.naturalSize));
        NSLog(@"preferredTransform %@",NSStringFromCGAffineTransform(assetTrack.preferredTransform));
        //Retrieving Audible Characteristics
        NSLog(@"preferredVolume %f",assetTrack.preferredVolume);
        //Retrieving Frame-Based Characteristics
        NSLog(@"nominalFrameRate %f",assetTrack.nominalFrameRate);
//        NSLog(@"%f",assetTrack.minFrameDuration);
        CMTimeShow(assetTrack.minFrameDuration);
        NSLog(@"requiresFrameReordering %d",assetTrack.requiresFrameReordering);
        //Finding Track Segments
        NSLog(@"segments %@",assetTrack.segments);
        //Managing Metadata
        NSLog(@"metadata %@",assetTrack.metadata);
        NSLog(@"commonMetadata %@",assetTrack.commonMetadata);
        NSLog(@"availableMetadataFormats %@",assetTrack.availableMetadataFormats);
        //Working with Associated Tracks
        NSLog(@"availableTrackAssociationTypes %@",assetTrack.availableTrackAssociationTypes);
    }
//    AVMutableMetadataItem *myTaggedMediaCharacteristic = [[AVMutableMetadataItem alloc] init];
//    [myTaggedMediaCharacteristic setKey:AVMetadataQuickTimeUserDataKeyTaggedCharacteristic];
//    [myTaggedMediaCharacteristic setKeySpace:AVMetadataKeySpaceQuickTimeUserData];
//    [myTaggedMediaCharacteristic setValue:aMeaningfulCharacteristicAsNSString];
//    [myMutableArrayOfMetadata addObject:myTaggedMediaCharacteristic];
//    [myAssetWriterInput setMetadata:myMutableArrayOfMetadata];
    
    
    
    
    
    
    
    // Do any additional setup after loading the view.
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
