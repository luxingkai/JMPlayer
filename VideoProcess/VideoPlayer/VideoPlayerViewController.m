//
//  VideoPlayerViewController.m
//  VideoProcess
//
//  Created by tigerfly on 2020/5/15.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "VideoPlayerViewController.h"
#import "JMPlayer.h"
#import "JMPlayerView.h"


@interface VideoPlayerViewController ()

@end

@implementation VideoPlayerViewController {
    
    JMPlayerView *_playerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat status_height = [UIApplication sharedApplication].statusBarFrame.size.height;
    NSString *url = @"https://stream7.iqilu.com/10339/upload_transcode/202002/18/20200218114723HDu3hhxqIT.mp4";
    _playerView = [JMPlayerView playerViewWithFrame:CGRectMake(0, status_height + 44.0, [UIScreen mainScreen].bounds.size.width, 200.0) sourceURL:[NSURL URLWithString:url]];
    [self.view addSubview:_playerView];
    
    // Do any additional setup after loading the view.
}

#pragma mark --

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}

- (void)deviceOrientation:(NSNotification *)notif {
    
    if ([notif.name isEqualToString:UIDeviceOrientationDidChangeNotification]) {
        if (([UIDevice currentDevice].orientation == UIInterfaceOrientationLandscapeLeft) | UIInterfaceOrientationMaskLandscape) {
            _playerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
        }
    }
}


#pragma mark --

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didPauseSpeechUtterance:(AVSpeechUtterance *)utterance {
    
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance {
    
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
