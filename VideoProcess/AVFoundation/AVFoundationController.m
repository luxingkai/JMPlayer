//
//  AVFoundationController.m
//  VideoProcess
//
//  Created by tigerfly on 2020/10/15.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "AVFoundationController.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>
#import <CoreVideo/CoreVideo.h>

@interface AVFoundationController ()

@end

@implementation AVFoundationController {
    
    AVAssetReader *assetReader;
//    AVAssetReaderVideoCompositionOutput *videoCompositionOutput;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageView];
    
    /*
     AVFoundation
     
     Work with audiovisual assets, control device cameras, process audio,
     and configure system audio interactions.
     
     The AVFoundation framework combines six major technology areas that
     together encompass a wide range of tasks for capturing, processing,
     synthesizing, controlling, importing, and exporting audiovisual media
     on Apple platforms.
     */
    
    NSURL *sourceURL = [[NSBundle mainBundle] URLForResource:@"chou" withExtension:@"mp4"];
    AVAsset *asset = [AVAsset assetWithURL:sourceURL];
    NSError *error = nil;
    
//    assetReader = [AVAssetReader assetReaderWithAsset:asset error:&error];
//    assetReader.timeRange = CMTimeRangeMake(kCMTimeZero, asset.duration);
//
//    AVAssetReaderVideoCompositionOutput *videoCompositionOutput = [AVAssetReaderVideoCompositionOutput assetReaderVideoCompositionOutputWithVideoTracks:@[asset.tracks.firstObject] videoSettings:nil];
//    videoCompositionOutput.videoComposition = [AVVideoComposition videoCompositionWithPropertiesOfAsset:asset];
//    if ([assetReader canAddOutput:videoCompositionOutput]) {
//        [assetReader addOutput:videoCompositionOutput];
//    }
//
//    [assetReader addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
//    [assetReader startReading];
//
//    CMSampleBufferRef sampleBuffer = [videoCompositionOutput copyNextSampleBuffer];
    
    AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    imageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    imageGenerator.appliesPreferredTrackTransform = YES;
    
    CMTime actualTime;
    CGImageRef imageRef = [imageGenerator copyCGImageAtTime:CMTimeMake(4, 1) actualTime:&actualTime error:nil];
    imageView.image = [UIImage imageWithCGImage:imageRef];
    CFRelease(imageRef);
}

#pragma mark --

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
    
    if ([keyPath isEqualToString:@"status"]) {
        NSInteger statusValue = [change[@"new"] integerValue];
        //        AVAssetReaderStatusUnknown = 0,
        //        AVAssetReaderStatusReading = 1,
        //        AVAssetReaderStatusCompleted = 2,
        //        AVAssetReaderStatusFailed = 3,
        //        AVAssetReaderStatusCancelled = 4,
        switch (statusValue) {
            case 0: {
                NSLog(@"未知状态");
            }
                break;
            case 1: {
                NSLog(@"开始读取");
            }
                break;
            case 2: {
                NSLog(@"读取完成");
            }
                break;
            case 3: {
                NSLog(@"读取失败");
            }
                break;
            case 4: {
                NSLog(@"取消读取");
            }
                break;
            default:
                break;
        }
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
