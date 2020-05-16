//
//  AudioViewController.m
//  VideoProcess
//
//  Created by tigerfly on 2020/5/15.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "AudioViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "AudioFileLoader.h"

@interface AudioViewController ()

@end

@implementation AudioViewController {
    AVAudioPlayer *_audioPlayer;
}

/// 如何与系统交互使用音频功能
/// 激活音频功能
/// 请求用户许可
/// 订阅和响应重要的音频事件通知（音频中断和路由修改）
/// 执行音频设备配置，例如设置样本率、输入输出缓存周期和频道数

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    //开启音频任务
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    NSError *error = nil;
    BOOL result = [audioSession setActive:true withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:&error];
    if (result != true) {
        NSLog(@"激活失败！");
        return;
    }
    
    NSError *audioError = nil;
    NSURL *audioURL = [[NSBundle mainBundle] URLForResource:@"Mark Petrie - New Light No Synth" withExtension:@"mp3"];
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:audioURL error:&audioError];
    BOOL prepare = [_audioPlayer prepareToPlay];
    if (prepare) {
        NSLog(@"prepareToPlay %d",prepare);
    }
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"Mark Petrie - New Light No Synth" ofType:@"mp3"];
    [AudioFileLoader fileLoaderWithFilePath:@"Mark Petrie - New Light No Synth"];
    

    	
    // Do any additional setup after loading the view.
}

- (void)done:(id)sender {
    if (!_audioPlayer.isPlaying) {
        [_audioPlayer play];
    }else {
        [_audioPlayer pause];
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
