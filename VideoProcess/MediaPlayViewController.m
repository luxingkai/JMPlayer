//
//  MediaPlayViewController.m
//  VideoProcess
//
//  Created by tigerfly on 2020/5/20.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "MediaPlayViewController.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>
#import <VideoToolbox/VideoToolbox.h>
#import <CoreMIDI/CoreMIDI.h>
#import <CoreVideo/CoreVideo.h>

//AVPlayer是一次播放一个媒体资产。可以使用player实例的replaceCurrentItemWithPlayerItem:方法重用player实例来播放其他媒体资产，但它一次只管理单个媒体资产的播放。该框架还提供了AVPlayer的一个子类，称为AVQueuePlayer，用于创建和管理按顺序播放的媒体资产的队列。使用AVPlayer播放媒体资产，AVFoundation使用AVAsset类对媒体资产进行建模。
//AVAsset只对媒体的静态方面进行建模，例如它的持续时间或创建日期，并且它本身不适合用AVPlayer播放。要运行一个asset，您需要创建一个在AVPlayerItem中找到的动态副本的实例。这个对象对AVPlayer实例播放的资产的时间和表示状态进行建模。查看AVPlayerItem参考以了解更多细节。
@interface MediaPlayViewController ()<AVPlayerItemMetadataCollectorPushDelegate,AVQueuedSampleBufferRendering>

@end

@implementation MediaPlayViewController  {
    
    NSURL *_assetUrl;
    AVAsset *_asset;
    AVPlayer *_player;
    AVPlayerItem *_playerItem;
    id _timeObserverToken;
    UIProgressView *_progressView;
}

- (void)dealloc {
    [self removePeriodicTimeObserver];
    [self removeBoundaryTimeObserver];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    /*
     Responding to Playback State Changes
     */
    NSArray *requiredAssetKey = @[@"playable",
                                  @"hasProtectedContent"];
    _assetUrl = [[NSBundle mainBundle] URLForResource:@"sofa" withExtension:@"mp4"];
    _asset = [AVAsset assetWithURL:_assetUrl];
    
#pragma mark -- playerItem
    
    _playerItem = [[AVPlayerItem alloc] initWithAsset:_asset automaticallyLoadedAssetKeys:requiredAssetKey];
    [_playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    /*
     检测播放器Item
     NSLog(@"asset %@",_playerItem.asset);
     NSLog(@"automaticallyLoadedAssetKeys %@",_playerItem.automaticallyLoadedAssetKeys);
     NSLog(@"tracks %@",_playerItem.tracks);
     NSLog(@"status %@",_playerItem.status);
     CMTimeShow(_playerItem.duration);
     NSLog(@"timebase %@",_playerItem.timebase);
     NSLog(@"presentationSize %@",NSStringFromCGSize(_playerItem.presentationSize));
     NSLog(@"error %@",_playerItem.error);
     */
    NSLog(@"loadedTimeRanges %@",_playerItem.loadedTimeRanges);

    /*
     移动播放头
     [_playerItem stepByCount:5];
     CMTime seekTime = CMTimeMakeWithSeconds(1.0, NSEC_PER_SEC);
     [_playerItem seekToTime:seekTime completionHandler:^(BOOL finished) {
     }];
     [_playerItem seekToTime:seekTime toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero completionHandler:nil];
     [_playerItem cancelPendingSeeks];
     */
    NSLog(@"seekableTimeRanges %@",[_playerItem seekableTimeRanges]);

    /*
     获取播放信息
     NSLog(@"playbackLikelyToKeepUp %d",_playerItem.playbackLikelyToKeepUp);
     NSLog(@"playbackBufferFull %d",_playerItem.playbackBufferFull);
     NSLog(@"playbackBufferEmpty %d",_playerItem.playbackBufferEmpty);
     NSLog(@"canPlayReverse %d",[_playerItem canPlayReverse]);
     NSLog(@"canPlayFastForward %d",[_playerItem canPlayFastForward]);
     NSLog(@"canPlayReverse %d",[_playerItem canPlayFastReverse]);
     NSLog(@"canPlayReverse %d",[_playerItem canPlaySlowForward]);
     NSLog(@"canPlayReverse %d",[_playerItem canPlaySlowReverse]);
     NSLog(@"canPlayReverse %d",[_playerItem canStepBackward]);
     NSLog(@"canPlayReverse %d",[_playerItem canStepForward]);
     */
    /*
     获取时间信息
     CMTimeShow(_player.currentTime);
     NSLog(@"%@",_playerItem.currentDate);
     CMTimeShow(_playerItem.forwardPlaybackEndTime);
     CMTimeShow(_playerItem.reversePlaybackEndTime);
     */
    /*
     构建网络行为
     _playerItem.preferredPeakBitRate = 60.0;
     _playerItem.preferredForwardBufferDuration = 1.0;
     _playerItem.canUseNetworkResourcesForLiveStreamingWhilePaused = true;
     _playerItem.preferredMaximumResolution = CGSizeZero;
     */
    /*
     构建Item设置
     AVAudioMixInputParameters *inputParameters = [AVAudioMixInputParameters new];
     AVMutableAudioMix *audioMix = [AVMutableAudioMix audioMix];
     audioMix.inputParameters = @[inputParameters];
     _playerItem.audioMix = audioMix;
     要在播放期间应用的视频合成设置。
     AVVideoComposition *videoComposition = [AVVideoComposition videoCompositionWithPropertiesOfAsset:_asset];
     CMTimeShow(videoComposition.frameDuration);
     NSLog(@"sourceTrackIDForFrameTiming %d",videoComposition.sourceTrackIDForFrameTiming);
     NSLog(@"renderSize %@",NSStringFromCGSize(videoComposition.renderSize));
     NSLog(@"renderScale %f",videoComposition.renderScale);
     NSLog(@"instructions %@",videoComposition.instructions);
     NSLog(@"animationTool %@",videoComposition.animationTool);
     NSLog(@"colorPrimaries %@",videoComposition.colorPrimaries);
     NSLog(@"colorYCbCrMatrix %@",videoComposition.colorYCbCrMatrix);
     NSLog(@"colorTransferFunction %@",videoComposition.colorTransferFunction);
     _playerItem.seekingWaitsForVideoCompositionRendering = true;
     _playerItem.audioTimePitchAlgorithm = AVAudioTimePitchAlgorithmVarispeed;
     _playerItem.videoApertureMode = AVVideoApertureModeCleanAperture;
     */
    /*
     访问日志
     AVPlayerItemAccessLog *accessLog = _playerItem.accessLog;
     NSLog(@"extendedLogData %@",accessLog.extendedLogData);
     AVPlayerItemErrorLog *errorLog = _playerItem.errorLog;
     NSLog(@"extendedLogData %@",errorLog.extendedLogData);
     */
    /*
     授权管理
     */
    /*
     选择多媒体选项
     NSLog(@"%@",_playerItem.currentMediaSelection);
     */
    /*
     访问文本样式规则
     NSLog(@"textStyleRules %@",_playerItem.textStyleRules);
     */
    /*
     管理item输出
     NSLog(@"outputs %@",_playerItem.outputs);
     AVPlayerItemVideoOutput *videoOutput = [[AVPlayerItemVideoOutput alloc] initWithOutputSettings:@{}];
     [_playerItem addOutput:videoOutput];
     [_playerItem removeOutput:videoOutput];
     */
    /*
     管理item数据收集
     NSLog(@"mediaDataCollectors %@",_playerItem.mediaDataCollectors);
     [_playerItem removeMediaDataCollector:dataCollector];
     */
    AVPlayerItemMetadataCollector *dataCollector = [[AVPlayerItemMetadataCollector alloc] init];
    [dataCollector setDelegate:self queue:dispatch_get_main_queue()];
    [_playerItem addMediaDataCollector:dataCollector];

    /*
     观察者通知
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemDidPlayToEndTimeNotification:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemFailedToPlayToEndTimeNotification:) name:AVPlayerItemFailedToPlayToEndTimeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemTimeJumpedNotification:) name:AVPlayerItemTimeJumpedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemPlaybackStalledNotification:) name:AVPlayerItemPlaybackStalledNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemNewAccessLogEntryNotification:) name:AVPlayerItemNewAccessLogEntryNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemNewErrorLogEntryNotification:) name:AVPlayerItemNewErrorLogEntryNotification object:nil];
    /*
      实例属性
     _playerItem.automaticallyPreservesTimeOffsetFromLive = true;
     CMTimeShow(_playerItem.configuredTimeOffsetFromLive);
     NSLog(@"audioSpatializationAllowed %d",_playerItem.audioSpatializationAllowed);
     CMTimeShow(_playerItem.recommendedTimeOffsetFromLive);
     */
 
#pragma mark -- playerItemTracks
    
    NSArray *playerItemTracks = _playerItem.tracks;
    for (AVPlayerItemTrack *itemTrack in playerItemTracks) {
        NSLog(@"assetTrack %@",itemTrack.assetTrack);
        NSLog(@"currentVideoFrameRate %f",itemTrack.currentVideoFrameRate);
        NSLog(@"enabled %d",itemTrack.enabled);
    }
    
#pragma mark -- player
    
    _player = [AVPlayer playerWithPlayerItem:_playerItem];
    /*
     管理播放
     [_player play];
     [_player pause];
     _player.rate = 1.0;
     _player.actionAtItemEnd = AVPlayerActionAtItemEndNone;
     [_player replaceCurrentItemWithPlayerItem:_playerItem];
     _player.preventsDisplaySleepDuringVideoPlayback = true;
     */
    /*
     管理自动等待行为
     _player.automaticallyWaitsToMinimizeStalling = true;
     NSLog(@"%d",_player.reasonForWaitingToPlay);
     NSLog(@"%d",_player.timeControlStatus);
     [_player playImmediatelyAtRate:1.0];
     */
    /*
     管理时间
     CMTimeShow(_player.currentTime);
     //Jump to Specific Time Quickly
     //    CMTime time = CMTimeMake(1200, 600);
     //    [_player seekToTime:time];
     //Jump to a Specific Time Accurately
     CMTime seekTime = CMTimeMakeWithSeconds(0.0, NSEC_PER_SEC);
     [_player seekToTime:seekTime toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
     */
    
    /*
     观察时间
     //Observe Periodic Timing
     
     //Observe Boundary Timing
     //    [self addBoundaryTimeObserver];
     */
    [self addPeriodicTimeObserver];
    
    /*
     配置媒体选择条件设置
     _player.appliesMediaSelectionCriteriaAutomatically = true;
     AVPlayerMediaSelectionCriteria *selectionCriteria = [_player mediaSelectionCriteriaForMediaCharacteristic:AVMediaCharacteristicVisual];
     [_player setMediaSelectionCriteria:selectionCriteria forMediaCharacteristic:AVMediaCharacteristicVisual];
     */
    
    /*
     管理扩展播放
     NSLog(@"%d",_player.externalPlaybackActive);
     _player.allowsExternalPlayback = true;
     _player.usesExternalPlaybackWhileExternalScreenIsActive = true;
     _player.externalPlaybackVideoGravity = AVLayerVideoGravityResizeAspect;
     */
    
    /*
     同步播放到外部源
     [_player setRate:1.0 time:kCMTimeZero atHostTime:kCMTimeZero];
     [_player prerollAtRate:1.0 completionHandler:^(BOOL finished) {
     }];
     [_player cancelPendingPrerolls];
     _player.masterClock = CMClockGetHostTimeClock();
     */
    /*
     管理音频输出
     _player.muted = false;
     _player.volume = 1.0;
     */
    /*
     获取播放器属性
     [_player addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
     NSLog(@"error %@",_player.error);
     NSLog(@"%@",_player.currentItem);
     NSLog(@"%d",_player.outputObscuredDueToInsufficientExternalProtection);
     */
    /*
     确定HDR播放
     NSLog(@"eligibleForHDRPlayback %d",AVPlayer.eligibleForHDRPlayback);
     NSLog(@"availableHDRModes %d",[AVPlayer availableHDRModes]);
     */
    /*
     设置GPU
     */

#pragma mark -- playerLayer
    
    AVPlayerLayer *playerLayer = [[AVPlayerLayer alloc] init];
    playerLayer.frame = [UIScreen mainScreen].bounds;
    playerLayer.player = _player;
    [self.view.layer addSublayer:playerLayer];
    /*
     构建播放展示层
     NSLog(@"%d",playerLayer.readyForDisplay);
     NSLog(@"%@",playerLayer.videoGravity);
     NSLog(@"%@",NSStringFromCGRect(playerLayer.videoRect));
     playerLayer.pixelBufferAttributes = @{CFBridgingRelease(kCVPixelFormatType_8Indexed):@8};
     */
    
#pragma mark -- AVSynchronizedLayer
//    AVSynchronizedLayer *syncLayer = [AVSynchronizedLayer synchronizedLayerWithPlayerItem:_playerItem];
//    [syncLayer addSublayer:playerLayer];
//    [self.view.layer addSublayer:syncLayer];
    
#pragma mark -- AVSampleBufferAudioRenderer /用来解压音频和播放压缩或未压缩的音频。
//    AVSampleBufferAudioRenderer
    
#pragma mark -- AVSampleBufferDisplayLayer /显示压缩或未压缩视频帧的对象。
//    AVSampleBufferDisplayLayer *displayLayer = [AVSampleBufferDisplayLayer layer];
        
#pragma mark -- AVSampleBufferRenderSynchronizer /用于将多个排队的示例缓冲区同步到单个时间线的对象。

#pragma mark -- AVRouteDetector /检测媒体播放路径存在的对象。

    _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    _progressView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 83.0, [UIScreen mainScreen].bounds.size.width, 2.0);
    _progressView.progressTintColor = [UIColor redColor];
    _progressView.trackTintColor = [UIColor grayColor];
    [self.view addSubview:_progressView];
    
    
    // Do any additional setup after loading the view.
}

- (void)addPeriodicTimeObserver {
    
    //Notify every half second
    CMTime time = CMTimeMakeWithSeconds(1.5, NSEC_PER_SEC);
    _timeObserverToken = [_player addPeriodicTimeObserverForInterval:time queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        //update player transport UI
        CMTimeShow(time);
        CGFloat progress = CMTimeGetSeconds(time)/CMTimeGetSeconds(_player.currentItem.duration);
        _progressView.progress = progress;
    }];
}

- (void)removePeriodicTimeObserver {
    
    if (_timeObserverToken) {
        [_player removeTimeObserver:_timeObserverToken];
        _timeObserverToken = nil;
    }
}

- (void)addBoundaryTimeObserver {
    
    // Divide the asset's duration into quarters
    CMTime interval = CMTimeMultiplyByFloat64(_asset.duration, 0.25);
    CMTime currentTime = kCMTimeZero;
    NSMutableArray *times = [NSMutableArray array];
    
    // Calculate boundary times
    while (CMTimeCompare(currentTime, _asset.duration) == -1) {
        currentTime = CMTimeAdd(currentTime, interval);
        [times addObject:[NSValue valueWithCMTime:interval]];
    }
    _timeObserverToken = [_player addBoundaryTimeObserverForTimes:times queue:dispatch_get_main_queue() usingBlock:^{
        //Update UI
    }];
}
 
- (void)removeBoundaryTimeObserver {
    
    if (_timeObserverToken) {
        [_player removeTimeObserver:_timeObserverToken];
        _timeObserverToken = nil;
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    if (_player.status == AVPlayerStatusReadyToPlay) {
        [_player play];
    }
}


#pragma mark --

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerItemStatus status;
        int statusNumber = [change[NSKeyValueChangeNewKey] intValue];
        status = statusNumber;
        
        //Switch over status value
        switch (status) {
            case AVPlayerItemStatusReadyToPlay:
            {
                //player Item is ready to play.
            }
                break;
            case AVPlayerItemStatusFailed:
            {
                //player Item failed. See error.
            }
                break;
            case AVPlayerItemStatusUnknown:
            {
                //player Item is not yet ready
            }
                break;
        }
    }
}

#pragma mark --

- (void)itemDidPlayToEndTimeNotification:(NSNotification *)notification {
    if (notification.name == AVPlayerItemDidPlayToEndTimeNotification) {
        [_player seekToTime:kCMTimeZero completionHandler:^(BOOL finished) {
            [_player play];
        }];
    }
}
- (void)itemFailedToPlayToEndTimeNotification:(NSNotification *)notification {
    if (notification.name == AVPlayerItemFailedToPlayToEndTimeNotification) {
        NSLog(@"播放失败");
    }
}
- (void)itemTimeJumpedNotification:(NSNotification *)notification {
    if (notification.name == AVPlayerItemTimeJumpedNotification) {
        NSLog(@"跳动播放");
    }
}
- (void)itemPlaybackStalledNotification:(NSNotification *)notification {
    if (notification.name == AVPlayerItemPlaybackStalledNotification) {
        NSLog(@"暂停播放");
    }
}
- (void)itemNewAccessLogEntryNotification:(NSNotification *)notification {
    
}
- (void)itemNewErrorLogEntryNotification:(NSNotification *)notification {
    
}

#pragma mark -- AVPlayerItemMetadataCollectorPushDelegate

- (void)metadataCollector:(AVPlayerItemMetadataCollector *)metadataCollector
didCollectDateRangeMetadataGroups:(NSArray<AVDateRangeMetadataGroup *> *)metadataGroups
       indexesOfNewGroups:(NSIndexSet *)indexesOfNewGroups
  indexesOfModifiedGroups:(NSIndexSet *)indexesOfModifiedGroups {
    // Process metadata
    NSLog(@"metadataGroups %@",metadataGroups);
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
