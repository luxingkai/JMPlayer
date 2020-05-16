//
//  MainViewController.m
//  VideoProcess
//
//  Created by tigerfly on 2020/5/16.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "MainViewController.h"

#import <FMDB.h>
#import "JMPlayerView.h"

//处理多媒体文件框架
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import <CoreMedia/CoreMedia.h>
#import <CoreMIDI/CoreMIDI.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MediaToolbox/MediaToolbox.h>
#import <MobileCoreServices/UTType.h>

//视频处理框架
#import <CoreVideo/CoreVideo.h>

//音频处理框架
#import <CoreAudio/CoreAudioTypes.h>
#import <AudioUnit/AudioUnit.h>
#import <CoreAudioKit/CoreAudioKit.h>
#import <OpenAL/OpenAL.h>

//废弃框架
#import <AssetsLibrary/AssetsLibrary.h>
//访问用户资源采用框架
#import <Photos/Photos.h>
#import <PhotosUI/PhotosUI.h>

//视频解码框架
#import <VideoToolbox/VideoToolbox.h>

//音频解码框架
#import <AudioToolbox/AudioToolbox.h>

//滤镜框架
#import <GPUImage/GPUImage.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    ////    NSURL *bundleURL = [[NSBundle mainBundle] URLForResource:@"spring" withExtension:@"mp4"];
    ////    NSURL *workURL = [[NSBundle mainBundle] URLForResource:@"work" withExtension:@"mp4"];
    ////
    ////    AVAsset *firstAsset = [AVAsset assetWithURL:bundleURL];
    ////    AVAsset *secondAsset = [AVAsset assetWithURL:workURL];
    //
    //    //Combining Multiple Assets and Saving the Result to the Camera Roll
    //
    //    //Create an AVMutableComposition object and add multiple AVMutableCompositionTrack objects
    //    //Add time ranges of AVAssetTrack objects to compatible composition tracks
    //    //Check the preferredTransform property of a video asset track to determine the video’s orientation
    //    //Use AVMutableVideoCompositionLayerInstruction objects to apply transforms to the video tracks within a composition
    //    //Set appropriate values for the renderSize and frameDuration properties of a video composition
    //    //Use a composition in conjunction with a video composition when exporting to a video file
    //    //Save a video file to the Camera Roll
    //
    //
    //    /*
    //     访问元数据
    //     */
    ////    NSURL *url = [[NSBundle mainBundle] URLForResource:@"spring" withExtension:@"mp4"];
    ////    if (@available(iOS 10.0, *)) {
    ////        AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:url
    ////                                                   options:@{AVURLAssetAllowsCellularAccessKey: @NO}];
    ////        NSLog(@"lyrics %@",urlAsset.lyrics);
    ////        for (AVMetadataItem *dateItem in urlAsset.metadata) {
    ////            NSLog(@"identifier %@",dateItem.identifier);
    ////            NSLog(@"extendedLanguageTag %@",dateItem.extendedLanguageTag);
    ////            NSLog(@"locale %@",dateItem.locale);
    ////            CMTimeShow(dateItem.time);
    ////            CMTimeShow(dateItem.duration);
    ////            NSLog(@"dataType %@",dateItem.dataType);
    ////            NSLog(@"value %@",dateItem.value);
    ////            NSLog(@"extraAttributes%@",dateItem.extraAttributes);
    ////            NSLog(@"startDate %@",dateItem.startDate);
    ////            NSLog(@"stringValue %@",dateItem.stringValue);
    ////            NSLog(@"numberValue %@",dateItem.numberValue);
    ////            NSLog(@"dateValue %@",dateItem.dateValue);
    ////            NSLog(@"dataValue %@",dateItem.dataValue);
    ////            NSLog(@"key %@",dateItem.key);
    ////            NSLog(@"commonKey %@",dateItem.commonKey);
    ////            NSLog(@"keySpace %@",dateItem.keySpace);
    ////        }
    ////        for (AVMetadataFormat format in urlAsset.availableMetadataFormats) {
    ////            NSLog(@"%@",format);
    ////        }
    ////    } else {
    ////        // Fallback on earlier versions
    ////    }
    //
    //    /*
    //     展现章节标签
    //     */
    ////    NSURL *url = [[NSBundle mainBundle] URLForResource:@"spring" withExtension:@"mp4"];
    ////    AVAsset *asset = [AVAsset assetWithURL:url];
    ////    NSString *chapterLocalesKey = @"availableChapterLocales";
    ////
    ////    [asset loadValuesAsynchronouslyForKeys:@[chapterLocalesKey] completionHandler:^{
    ////
    ////        NSError *error = nil;
    ////        AVKeyValueStatus status = [asset statusOfValueForKey:chapterLocalesKey error:&error];
    ////        if (status == AVKeyValueStatusLoaded) {
    ////            NSArray *languages = [NSLocale preferredLanguages];
    ////            NSArray *chapterMetadata = [asset chapterMetadataGroupsBestMatchingPreferredLanguages:languages];
    ////            for (AVTimedMetadataGroup *metadataGroup in chapterMetadata) {
    ////                if (@available(iOS 9.3, *)) {
    ////                    NSLog(@"%@",metadataGroup.classifyingLabel);
    ////                } else {
    ////                    // Fallback on earlier versions
    ////                }
    ////                if (@available(iOS 9.3, *)) {
    ////                    NSLog(@"%@",metadataGroup.uniqueID);
    ////                } else {
    ////                    // Fallback on earlier versions
    ////                }
    ////                CMTimeRangeShow(metadataGroup.timeRange);
    ////            }
    ////            //Process chapter metadata
    ////        }else
    ////        {
    ////            //handle other status cases
    ////        }
    ////    }];
    //
    //    /*
    //     检测资源（asset）
    //     */
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"spring" withExtension:@"mp4"];
    AVURLAsset *asset = [AVURLAsset assetWithURL:url];
    CMTimeShow(asset.duration);
    NSLog(@"preferredVolume %f",asset.preferredVolume);
    NSLog(@"preferredRate %f",asset.preferredRate);
    NSLog(@"preferredTransform %@",NSStringFromCGAffineTransform(asset.preferredTransform));
    if (@available(iOS 13.0, *)) {
        CMTimeShow(asset.minimumTimeOffsetFromLive);
    } else {
        // Fallback on earlier versions
    }
    
    NSLog(@"canContainFragments %d",[asset canContainFragments]);

    
    
    
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
