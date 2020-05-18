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

@implementation MainViewController {
    AVPlayer *_player;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"beauty" withExtension:@"mp4"];
    AVAsset *asset = [AVAsset assetWithURL:url];
    NSArray *assetKeys = @[@"playable",@"hasProtectedContent"];
    
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:asset automaticallyLoadedAssetKeys:assetKeys];
    [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    
    _player = [AVPlayer playerWithPlayerItem:playerItem];
    
    AVPlayerLayer *playerLayer = [[AVPlayerLayer alloc] init];
    playerLayer.frame = [UIScreen mainScreen].bounds;
    playerLayer.player = _player;
    [self.view.layer addSublayer:playerLayer];
    
    // Observe Periodic Timing
//    dispatch_queue_t queue = dispatch_queue_create("main", DISPATCH_QUEUE_SERIAL);
//    CMTimeScale timeScale = NSEC_PER_SEC;
//    CMTime time = CMTimeMakeWithSeconds(0.5, timeScale);
//    [_player addPeriodicTimeObserverForInterval:time queue:queue usingBlock:^(CMTime time) {
//        CMTimeShow(time);
//    }];
    
    //Observe Boundary Timing
    CMTime interval = CMTimeMultiplyByFloat64(asset.duration, 0.25);
    CMTime currentTime = kCMTimeZero;
    NSMutableArray *times = [NSMutableArray array];
    //Calculate boundary times
    while (CMTimeCompare(currentTime, asset.duration) == -1) {
        currentTime = CMTimeAdd(currentTime, interval);
        [times addObject:[NSValue valueWithCMTime:currentTime]];
    }
    dispatch_queue_t queue = dispatch_queue_create("label", DISPATCH_QUEUE_SERIAL);
    [_player addBoundaryTimeObserverForTimes:times queue:queue usingBlock:^{
       //Update UI
    }];
    
    //Jump to a Specific Time Quickly
//    CMTime time = CMTimeMake(5, 1);
//    [_player seekToTime:time completionHandler:^(BOOL finished) {
//    }];
    //Jump to a Specific Time Accurately
    CMTime seekTime = CMTimeMakeWithSeconds(10, NSEC_PER_SEC);
    [_player seekToTime:seekTime toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero completionHandler:^(BOOL finished) {
    }];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerItemStatus status = [change[@"new"] integerValue];
        switch (status) {
            case AVPlayerItemStatusReadyToPlay:
            {
                NSLog(@"准备播放");
            }
                break;
            case AVPlayerItemStatusFailed:
            {
                NSLog(@"加载失败");
            }
                break;
            case AVPlayerItemStatusUnknown:
            {
                NSLog(@"状态未知");
            }
                break;
        }
    }
}/*//*/

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    if (_player.status == AVPlayerStatusReadyToPlay) {
        [_player play];
    }
    else{
        [_player pause];
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
