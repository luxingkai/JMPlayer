//
//  MediaItemTransferController.m
//  VideoProcess
//
//  Created by tigerfly on 2020/6/1.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "MediaItemTransferController.h"
#import <AVFoundation/AVFoundation.h>

@interface MediaItemTransferController ()<AVPlayerItemLegibleOutputPushDelegate,AVPlayerItemMetadataOutputPushDelegate>

@end

@implementation MediaItemTransferController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     定义了将样本从资源移动到播放器的公共接口的抽象类。
     AVPlayerItemOutput /abstract class
     AVPlayerItemLegibleOutput
     AVPlayerItemItemMetadataOutput
     AVPlayerItemVideoOutput
     AVPlayerItemMediaDataCollector
     */
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"sofa" withExtension:@"mp4"];
    AVAsset *asset = [AVAsset assetWithURL:url];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:asset];
    
    
#pragma mark -- AVPlayerItemLegibleOutput
    AVPlayerItemLegibleOutput *legibleOutput = [[AVPlayerItemLegibleOutput alloc] init];
    legibleOutput.suppressesPlayerRendering = true;
    
    //Configuring the Delegate
    [legibleOutput setDelegate:self queue:dispatch_get_main_queue()];
    [playerItem addOutput:legibleOutput];
    legibleOutput.advanceIntervalForDelegateInvocation = 1.0f;
    
    //Configuring Attributed-String Text Styling Settings
    legibleOutput.textStylingResolution = AVPlayerItemLegibleOutputTextStylingResolutionDefault;
        
    
#pragma mark -- AVPlayerItemMetadataOutput/ setting the value of suppressesPlayerRendering on an instance of AVPlayerItemMetadataOutput has no effect.
    AVPlayerItemMetadataOutput *metadataOutput = [[AVPlayerItemMetadataOutput alloc] initWithIdentifiers:nil];
    metadataOutput.advanceIntervalForDelegateInvocation = 1.0;
    [metadataOutput setDelegate:self queue:dispatch_get_main_queue()];
    
    
#pragma mark -- AVPlayerItemVideoOutput
    if (@available(iOS 10.0, *)) {
//        AVPlayerItemVideoOutput *videoOutput = [[AVPlayerItemVideoOutput alloc] initWithOutputSettings:@{AVVideoCodecKey:AVVideoCodecTypeH264}];
    } else {
        // Fallback on earlier versions
    }
    

    
    
    // Do any additional setup after loading the view.
}

- (void)legibleOutput:(AVPlayerItemLegibleOutput *)output didOutputAttributedStrings:(NSArray<NSAttributedString *> *)strings nativeSampleBuffers:(NSArray *)nativeSamples forItemTime:(CMTime)itemTime {
    
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
