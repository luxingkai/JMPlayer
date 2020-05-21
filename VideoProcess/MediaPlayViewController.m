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

@interface MediaPlayViewController ()

@end

@implementation MediaPlayViewController  {
    
    AVPlayer *_player;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    NSArray *requiredAssetKey = @[@"playable",
                                  @"hasProtectedContent"];
    NSURL *assetUrl = [[NSBundle mainBundle] URLForResource:@"beauty" withExtension:@"mp4"];
    AVAsset *asset = [AVAsset assetWithURL:assetUrl];
    AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithAsset:asset];
    _player = [AVPlayer playerWithPlayerItem:playerItem];
     
    AVPlayerLayer *playerLayer = [[AVPlayerLayer alloc] init];
    playerLayer.frame = [UIScreen mainScreen].bounds;
    playerLayer.player = _player;
    [self.view.layer addSublayer:playerLayer];
    
    
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    if (_player.status == AVPlayerStatusReadyToPlay) {
        [_player play];
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
