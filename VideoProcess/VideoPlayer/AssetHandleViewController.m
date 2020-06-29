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

@interface AssetHandleViewController ()<AVAssetResourceLoaderDelegate>

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
        NSArray * trackUserDataItems = [assetTrack metadataForFormat:AVMetadataFormatQuickTimeUserData];
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
        for (AVAssetTrackSegment *trackSegment in assetTrack.segments) {
            CMTimeMapping timeMapping = trackSegment.timeMapping;
            CMTimeRangeShow(timeMapping.source);
            CMTimeRangeShow(timeMapping.target);
        }
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
    
#pragma make -- Asset Manipulation
    
    //Asset Information
    AVFragmentedAsset *fragmentedAsset = [[AVFragmentedAsset alloc] initWithURL:url options:nil];
    NSArray *tracks = fragmentedAsset.tracks;
    NSLog(@"canContainFragments %d",[fragmentedAsset canContainFragments]);
    NSLog(@"containsFragments %d",[fragmentedAsset containsFragments]);
    NSLog(@"overallDurationHint %d",[fragmentedAsset overallDurationHint]);
    
//    AVFragmentedAssetMinder *assetMinder = [[AVFragmentedAssetMinder alloc] initWithAsset:asset mindingInterval:2.0];
    
    //Track Information
    AVAssetTrackGroup *trackGroup = [asset trackGroups];
    AVAssetTrack *assetTrack = assetTracks.firstObject;
    
    //Asset Retrieval
    AVURLAsset *urlAsset = [AVURLAsset assetWithURL:url];
    AVAssetDownloadURLSession *downloadURLSession = [[AVAssetDownloadURLSession alloc] assetDownloadTaskWithURLAsset:urlAsset destinationURL:nil options:nil];
    
    AVAssetResourceLoader *resourceLoadser = urlAsset.resourceLoader;
    [resourceLoadser setDelegate:self queue:dispatch_get_main_queue()];
    
#pragma mark -- Asset File Import and Export
    
    //File Import
    
    //AVAssetReader
    NSError *readerError = nil;
    AVAssetReader *assetReader = [AVAssetReader assetReaderWithAsset:asset error:&readerError];
    NSLog(@"readStatus %ld",(long)assetReader.status);
    NSArray *outputs = assetReader.outputs;
    NSLog(@"outputs %lu",(unsigned long)outputs.count);
    NSLog(@"error %@",assetReader.error.description);
    CMTimeRangeShow(assetReader.timeRange);
    
//    NSMutableArray *audioTracks = [NSMutableArray array];
//    for (AVAssetTrack *assetTrack in asset.tracks) {
//        NSLog(@"mediaType %@",assetTrack.mediaType);
//        if (assetTrack.mediaType == AVMediaTypeVideo) {
//            [audioTracks addObject:assetTrack];
//        }
//    }
    
    /*
     Video Setting
     AVVideoCodecKey
     AVVideoWidthKey
     AVVideoheightKey
     AVVideoCompressionPropertiesKey
     AVVideoAverageBitRateKey
     AVVideoQualityKey
     AVVideoMaxKeyFrameIntervalKey
     AVVideoProfileLevelKey
     AVVideoProfileLevelH264Baseline30
     AVVideoProfileLevelH264Baseline31
     AVVideoProfileLevelH264Baseline41
     AVVideoProfileLevelH264Main30
     AVVideoProfileLevelH264Main31
     AVVideoProfileLevelH264Main32
     AVVideoProfileLevelH264Main41
     AVVideoProfileLevelH264High40
     AVVideoPixelAspectRatioKey
     AVVideoPixelAspectRatioHorizontalSpacingKey
     AVVideoPixelAspectRatioVerticalSpacingKey
     AVVideoCleanApertureKey
     AVVideoCleanApertureWidthKey
     AVVideoCleanApertureHeightKey
     AVVideoCleanApertureHorizontalOffsetKey
     AVVideoCleanApertureVerticalOffsetKey
     */
    
    //AVAssetReaderAudioMixOutput
//    NSArray *audioTracks = [asset tracksWithMediaType:AVMediaTypeAudio];
//    AVMutableAudioMix *audioMix = [AVMutableAudioMix audioMix];
//    AVAssetReaderAudioMixOutput *audioMixOutput = [[AVAssetReaderAudioMixOutput alloc] initWithAudioTracks:audioTracks audioSettings:nil];
//    audioMixOutput.audioMix = audioMix;
//    audioMixOutput.audioTimePitchAlgorithm = AVAudioTimePitchAlgorithmSpectral;
//    if ([assetReader canAddOutput:audioMixOutput]) {
//        [assetReader addOutput:audioMixOutput];
//    }
//    [assetReader startReading];
//
//    CMSampleBufferRef *sampleBufferRef = [audioMixOutput copyNextSampleBuffer];
//    NSLog(@"sampleBuffer %@",sampleBufferRef);
    
    //AVAssetReaderTrackOutput
//    AVAssetReaderTrackOutput *trackOutput = [[AVAssetReaderTrackOutput alloc] initWithTrack:asset.tracks.firstObject outputSettings:nil];
//    trackOutput.audioTimePitchAlgorithm = AVAudioTimePitchAlgorithmSpectral;
//    if ([assetReader canAddOutput:trackOutput]) {
//        [assetReader addOutput:trackOutput];
//    }
//    [assetReader startReading];
//    [trackOutput copyNextSampleBuffer];
    
    //AVAssetReaderSampleReferenceOutput
//    AVAssetReaderSampleReferenceOutput *referenceOutput = [[AVAssetReaderSampleReferenceOutput alloc] initWithTrack:asset.tracks.firstObject];
//    if ([assetReader canAddOutput:referenceOutput]) {
//        [assetReader addOutput:referenceOutput];
//    }
//    [assetReader startReading];
    
    //AVAssetReaderVideoCompositionOutput
//    AVAssetReaderVideoCompositionOutput *compositionOutput = [[AVAssetReaderVideoCompositionOutput alloc] initWithVideoTracks:assetTracks videoSettings:nil];
//    if ([assetReader canAddOutput:compositionOutput]) {
//        [assetReader addOutput:compositionOutput];
//    }
//    [assetReader startReading];
    
    //AVAssetReaderOutputMetadataAdaptor
//    NSArray *metadataTracks = [asset tracksWithMediaType:AVMediaTypeMetadata];
//    AVAssetReaderTrackOutput *trackOutput = [[AVAssetReaderTrackOutput alloc] initWithTrack:metadataTracks.firstObject outputSettings:nil];
//    trackOutput.audioTimePitchAlgorithm = AVAudioTimePitchAlgorithmVarispeed;
//    if ([assetReader canAddOutput:trackOutput]) {
//        [assetReader addOutput:trackOutput];
//    }
//    AVAssetReaderOutputMetadataAdaptor *metadataAdaptor = [[AVAssetReaderOutputMetadataAdaptor alloc] initWithAssetReaderTrackOutput:trackOutput];
//    if (assetReader.outputs.count >= 1) {
//        [assetReader startReading];
//        AVTimedMetadataGroup *metadataGroup = [metadataAdaptor nextTimedMetadataGroup];
//        NSLog(@"metadataGroup %@",metadataGroup);
//    }
     
    //AVAssetImageGenerator
//    AVVideoComposition *videoComposition = [AVVideoComposition videoCompositionWithPropertiesOfAsset:asset];
//    AVAssetImageGenerator *imageGenerator = [AVAssetImageGenerator assetImageGeneratorWithAsset:asset];
//    imageGenerator.apertureMode = AVAssetImageGeneratorApertureModeCleanAperture;
//    imageGenerator.appliesPreferredTrackTransform = YES;
//    imageGenerator.videoComposition = videoComposition;
//    Float64 durationSeconds = CMTimeGetSeconds(asset.duration);
//    CMTime firstThird = CMTimeMakeWithSeconds(durationSeconds/3.0, 600);
//    CMTime secondThird = CMTimeMakeWithSeconds(durationSeconds*2.0/3.0, 600);
//    CMTime end = CMTimeMakeWithSeconds(durationSeconds, 600);
//    NSArray *times = @[[NSValue valueWithCMTime:kCMTimeZero],[NSValue valueWithCMTime:firstThird],[NSValue valueWithCMTime:secondThird],[NSValue valueWithCMTime:end]];
//    [imageGenerator generateCGImagesAsynchronouslyForTimes:times completionHandler:^(CMTime requestedTime, CGImageRef  _Nullable image, CMTime actualTime, AVAssetImageGeneratorResult result, NSError * _Nullable error) {
//        NSString *requestTimeString = (NSString *)CFBridgingRelease(CMTimeCopyDescription(NULL, requestedTime));
//        NSString *actualTimeString = (NSString *)CFBridgingRelease(CMTimeCopyDescription(NULL, actualTime));
//        NSLog(@"requested: %@; actual %@",requestTimeString, actualTimeString);
//
//        if (result == AVAssetImageGeneratorSucceeded) {
//            // Do something interesting with the image.
//            NSLog(@"image %@",image);
//        }
//        if (result == AVAssetImageGeneratorFailed) {
//            NSLog(@"Failed with error: %@",[error localizedDescription]);
//        }
//        if (result == AVAssetImageGeneratorCancelled) {
//            NSLog(@"Canceled");
//        }
//    }];
//
//    NSError *generatorError = nil;
//    CMTime actualTime;
//    CGImageRef halfWayImage = [imageGenerator copyCGImageAtTime:firstThird actualTime:&actualTime error:&generatorError];
//    if (halfWayImage != NULL) {
//        NSString *actualTimeString = (NSString *)CFBridgingRelease(CMTimeCopyDescription(NULL, actualTime));
//        NSString *requestTimeString = (NSString *)CFBridgingRelease(CMTimeCopyDescription(NULL, firstThird));
//        NSLog(@"Got halfWayImage: Asked for %@, got %@",requestTimeString,actualTimeString);
//
//        //Do something interesting with the image.
//        CGImageRelease(halfWayImage);
//    }
    
    //File Export
    NSString *localpath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSLog(@"path %@",localpath);
    NSURL *outputURL = [[NSURL alloc] initFileURLWithPath:[localpath stringByAppendingFormat:@"/moive.mp4"]];
    
    //These setting will encode using H.264
    NSString *preset = AVAssetExportPresetHighestQuality;
    AVFileType outFileType = AVFileTypeQuickTimeMovie;
    //检测是否可以转换为指定格式
    [AVAssetExportSession determineCompatibilityOfExportPreset:preset withAsset:asset outputFileType:outFileType completionHandler:^(BOOL compatible) {
        if (!compatible) {
            return;
        }
    }];
    AVAssetExportSession *exportSession = [AVAssetExportSession exportSessionWithAsset:asset presetName:preset];
    if (exportSession) {
        exportSession.outputFileType = outFileType;
        exportSession.outputURL = outputURL;
        [exportSession exportAsynchronouslyWithCompletionHandler:^{
            //handle export results.
            if (exportSession.progress == 1.0) {
            }
        }];
        NSLog(@"progress %f",exportSession.progress);
    }
    
    NSError *writerError = nil;
    AVAssetWriterInput *writerInput = [[AVAssetWriterInput alloc] initWithMediaType:AVMediaTypeVideo outputSettings:nil];
    AVAssetWriter *assetWriter = [AVAssetWriter assetWriterWithURL:outputURL fileType:outFileType error:&writerError];
    NSLog(@"write status %ld",(long)assetWriter.status);
    if ([assetWriter canAddInput:writerInput]) {
        [assetWriter addInput:writerInput];
    }
    [assetWriter startWriting];
    [assetWriter finishWritingWithCompletionHandler:^{
        [assetWriter cancelWriting];
    }];
    
    
    // Do any additional setup after loading the view.
}

- (BOOL)resourceLoader:(AVAssetResourceLoader *)resourceLoader shouldWaitForLoadingOfRequestedResource:(AVAssetResourceLoadingRequest *)loadingRequest {
    
    return true;
}

- (void)resourceLoader:(AVAssetResourceLoader *)resourceLoader didCancelLoadingRequest:(AVAssetResourceLoadingRequest *)loadingRequest {
    
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
