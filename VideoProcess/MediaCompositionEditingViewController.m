//
//  MediaCompositionEditingViewController.m
//  VideoProcess
//
//  Created by tigerfly on 2020/6/2.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "MediaCompositionEditingViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreImage/CoreImage.h>

@interface MediaCompositionEditingViewController ()<AVVideoCompositionValidationHandling>

@end

@implementation MediaCompositionEditingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /*
     合并，编辑，并重新混合音频和视频轨道从多个来源在一个单一的组成。
     */
    
#pragma mark -- AVComposition
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"sofia" withExtension:@"mp4"];
    AVAsset *asset = [AVAsset assetWithURL:url];
    AVComposition *compostion = [AVComposition assetWithURL:url];
    
    //Accessing Tracks
    NSLog(@"tracks %@",compostion.tracks);
    for (AVCompositionTrack *compositionTrack in compostion.tracks) {
        NSLog(@"compositionTrack %@",compositionTrack);
    }
    
    //Getting the Natural Size of a Composition
    NSLog(@"naturalSize %@",NSStringFromCGSize(compostion.naturalSize));
    
    //Setting URL initialization Options
    NSLog(@"URLAssetInitializationOptions %@",compostion.URLAssetInitializationOptions);
    
    
#pragma mark -- AVCompositionTrack
    
    AVCompositionTrack *compositionTrack = compostion.tracks.firstObject;
    NSLog(@"mediaType %@",compositionTrack.mediaType);
    NSLog(@"trackID %d",compositionTrack.trackID);
    
    // Accessing Track Segments
    NSLog(@"segments %@",compositionTrack.segments);
    
    //Instance Properties
    NSLog(@"formatDescriptionReplacements %@",compositionTrack.formatDescriptionReplacements);
    
#pragma mark -- AVCompositionTrackSegment
    
    AVCompositionTrackSegment *trackSegment = compositionTrack.segments.firstObject;
    
    //Getting Segment Properties
    NSLog(@"sourceURL %@",trackSegment.sourceURL);
    NSLog(@"sourceTrackID %@",trackSegment.sourceTrackID);
    NSLog(@"empty %@",trackSegment.empty);
    
#pragma mark -- AVMutableComposition
    
    //Creating a Mutable Composition
    AVMutableComposition *mutableComposition = [AVMutableComposition composition];
    
    //Managing Time Ranges
    [mutableComposition insertEmptyTimeRange:kCMTimeRangeZero];
    CMTime time = CMTimeMake(1.0, 60);
    NSError *error = nil;
    [mutableComposition insertTimeRange:kCMTimeRangeZero ofAsset:asset atTime:time error:&error];
    [mutableComposition removeTimeRange:kCMTimeRangeZero];
    [mutableComposition scaleTimeRange:kCMTimeRangeZero toDuration:time];
    
    //Managing Tracks
    NSLog(@"mutableCompositionTrack %@",mutableComposition.tracks);
    [mutableComposition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:compositionTrack.trackID];
    [mutableComposition removeTrack:compositionTrack];
    AVMutableCompositionTrack *mutableCompositionTrack = [mutableComposition mutableTrackCompatibleWithTrack:compositionTrack];
    AVMutableCompositionTrack *specifiedTrack = [mutableComposition trackWithTrackID:compostion.tracks.firstObject];
    
    //Configuring Video Size
    NSLog(@"naturalSize %@",mutableComposition.naturalSize);
    
#pragma mark -- AVMutableCompositionTrack
    
    // Configuring Track Properties
    NSLog(@"languageCode%@",mutableCompositionTrack.languageCode);
    NSLog(@"extendedLanguageTag %@",mutableCompositionTrack.extendedLanguageTag);
    NSLog(@"naturalTimeScale %@",mutableCompositionTrack.naturalTimeScale);
    NSLog(@"preferredTransform %@",NSStringFromCGAffineTransform(mutableCompositionTrack.preferredTransform));
    NSLog(@"preferredVolume %f",mutableCompositionTrack.preferredVolume);
    
    //Associating Tracks
    [mutableCompositionTrack addTrackAssociationToTrack:compositionTrack type:AVTrackAssociationTypeChapterList];
    [mutableCompositionTrack removeTrackAssociationToTrack:compositionTrack type:AVTrackAssociationTypeChapterList];
    
    //Managing Time Ranges
    [mutableCompositionTrack insertEmptyTimeRange:kCMTimeRangeZero];
    [mutableCompositionTrack insertTimeRange:kCMTimeRangeZero ofTrack:asset atTime:time error:&error];
    [mutableCompositionTrack removeTimeRange:kCMTimeRangeZero];
    [mutableCompositionTrack scaleTimeRange:kCMTimeRangeZero toDuration:time];
    NSLog(@"segments %@",mutableCompositionTrack.segments);
    
    //Validating Segments
    [mutableCompositionTrack validateTrackSegments:compositionTrack.segments error:&error];
    
    
    
#pragma mark -- AVVideoComposition
    AVVideoComposition *videoComposition = [AVVideoComposition videoCompositionWithPropertiesOfAsset:asset];
    
    //Configuring Video Composition Properties
    CMTimeShow(videoComposition.frameDuration);
    NSLog(@"renderSize %@",NSStringFromCGSize(videoComposition.renderSize));
    NSLog(@"renderSize %f",videoComposition.renderScale);
    NSLog(@"instructions %@",videoComposition.instructions.firstObject);
    NSLog(@"animationTool %@",videoComposition.animationTool);
    NSLog(@"customVideoCompositorClass %@",videoComposition.customVideoCompositorClass);
    NSLog(@"sourceTrackIDForFrameTiming %d",videoComposition.sourceTrackIDForFrameTiming);
    NSLog(@"colorPrimaries %@",videoComposition.colorPrimaries);
    NSLog(@"colorTransferFunction %@",videoComposition.colorTransferFunction);
    NSLog(@"colorYCbCrMatrix %@",videoComposition.colorYCbCrMatrix);
    
    //Validating the Time Range
    BOOL result = [videoComposition isValidForAsset:asset timeRange:kCMTimeRangeZero validationDelegate:self];
    NSLog(@"validate result %d",result);
    
#pragma mark -- AVAsynchronousCIImageFilteringRequest
    
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    AVVideoComposition *composition = [AVVideoComposition videoCompositionWithAsset:asset applyingCIFiltersWithHandler:^(AVAsynchronousCIImageFilteringRequest * _Nonnull request) {
        // Clamp to avoid blurring transparent pixels at the image edges
        CIImage *source = [request.sourceImage imageByClampingToExtent];
        [filter setValue:source forKey:kCIInputImageKey];
        
        // Vary filter parameters based on video timing
        Float64 seconds = CMTimeGetSeconds(request.compositionTime);
        [filter setValue:@(seconds * 10.0) forKey:kCIInputRadiusKey];
        
        // Crop the blurred output to the bounds of the original image
        CIImage *output = [filter.outputImage imageByCroppingToRect:request.sourceImage.extent];
        
        // Provide the filter output to the composition
        [request finishWithImage:output context:nil];
    }];
    
    AVPlayerItem *item = [AVPlayerItem playerItemWithAsset:asset];
    item.videoComposition = videoComposition;
    
#pragma mark -- AVAsynchronousVideoCompositionRequest
    NSLog(@"customVideoCompositor %@",item.customVideoCompositor);
    
#pragma mark -- AVMutableVideoCompositionInstruction
    AVMutableVideoCompositionInstruction *compositionInstruction = [AVMutableVideoCompositionInstruction videoCompositionInstruction];
    compositionInstruction.backgroundColor = UIColor.whiteColor.CGColor;
    compositionInstruction.enablePostProcessing = true;
    
#pragma mark -- AVMutableVideoCompositionLayerInstruction
    AVMutableVideoCompositionLayerInstruction *compositionLayerInstruction = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstruction];
    //Configuring a Track ID
    compositionLayerInstruction.trackID = compositionTrack.trackID;
    //Managing Properties
    [compositionLayerInstruction setOpacity:1.0 atTime:time];
    [compositionLayerInstruction setOpacityRampFromStartOpacity:1 toEndOpacity:1 timeRange:kCMTimeRangeZero];
    [compositionLayerInstruction setTransform:CGAffineTransformIdentity atTime:time];
    [compositionLayerInstruction setTransformRampFromStartTransform:CGAffineTransformIdentity toEndTransform:CGAffineTransformIdentity timeRange:kCMTimeRangeZero];
    //Setting Crop Rectangle Values
    [compositionLayerInstruction setCropRectangle:CGRectZero atTime:time];
    [compositionLayerInstruction setCropRectangleRampFromStartCropRectangle:CGRectZero toEndCropRectangle:CGRectZero timeRange:kCMTimeRangeZero];
    
#pragma mark -- AVVideoCompositionCoreAnimationTool
    //Creating a Composition Tool
    AVPlayer *player = [AVPlayer playerWithURL:url];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    playerLayer.frame = self.view.frame;
    AVVideoCompositionCoreAnimationTool *animationTool = [AVVideoCompositionCoreAnimationTool videoCompositionCoreAnimationToolWithAdditionalLayer:playerLayer asTrackID:compositionTrack.trackID];
    [self.view.layer addSublayer:playerLayer];
    
#pragma mark -- AVVideoCompositionInstruction
    AVVideoCompositionInstruction *videoCompositionInstruction = videoComposition.instructions.firstObject;
    NSLog(@"backgroundColor %@",videoCompositionInstruction.backgroundColor);
    NSLog(@"layerInstructions %@",videoCompositionInstruction.layerInstructions);
    CMTimeRangeShow(videoCompositionInstruction.timeRange);
    NSLog(@"enablePostProcessing %d",videoCompositionInstruction.enablePostProcessing);
    NSLog(@"passthroughTrackID %d",videoCompositionInstruction.passthroughTrackID);
    NSLog(@"requiredSourceTrackIDs %@",videoCompositionInstruction.requiredSourceTrackIDs);
    
#pragma mark -- AVVideoCompositionLayerInstruction
    AVVideoCompositionLayerInstruction *videoCompositionLayerInstruction = [AVVideoCompositionLayerInstruction new];
    NSLog(@"trackID %d",videoCompositionLayerInstruction.trackID);
    CMTimeRange timeRange;
    float startOpacity;
    float endOpacity;
    [videoCompositionLayerInstruction getOpacityRampForTime:kCMTimeZero startOpacity:&startOpacity endOpacity:&endOpacity timeRange:&timeRange];
    
#pragma mark -- AVVideoCompositionRenderContext
    AVVideoCompositionRenderContext *renderContext = [AVVideoCompositionRenderContext new];
    
    
#pragma mark -- AVMutableMoive
    
    AVMutableMovie *mutableMovie = [AVMutableMovie movieWithURL:url options:nil error:nil];
    AVMutableMovieTrack *mutableMovieTrack = mutableMovie.tracks.firstObject;
    
#pragma mark -- AVAudioMix
    
    AVMutableAudioMix *mutableAudioMix = [AVMutableAudioMix audioMix];
    
    
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
