//
//  JMPlayerView.m
//  VideoProcess
//
//  Created by tiger fly on 2020/3/13.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "JMPlayerView.h"
#import "JMPlayerControlLayer.h"
#import "JMPlayer.h"
#import <SVProgressHUD/SVProgressHUD.h>

@implementation JMPlayerView {
    
    NSURL *_sourceURL;
    
    AVPlayerItem *_playerItem;
    AVPlayer *_player;
    AVPlayerLayer *_playerLayer;
    
    UIButton *_playButton;
    UIProgressView *_progressView;
    JMPlayerControlLayer *_controlLayer;
    
    CGFloat _screenWidth;
    AVPlayerItemTrack *_itemTrack;
    //视频总时长
    NSTimeInterval _totalTime;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

+ (instancetype)playerViewWithFrame:(CGRect)frame sourceURL:(NSURL *)source {
    
    JMPlayerView *playerView = [[JMPlayerView alloc] initWithFrame:frame sourceURL:source];
    return playerView;
}

- (instancetype)initWithFrame:(CGRect)frame sourceURL:(NSURL *)source {
    
    if (self = [super initWithFrame:frame]) {
        _sourceURL = source;
        _screenWidth = [UIScreen mainScreen].bounds.size.width;
        [self addUserGestureRecognizer];
        [self setupPlayer];
        
    }
    return self;
}

- (void)setupPlayer {
    
    //资源相关设置层
    _playerItem = [[AVPlayerItem alloc] initWithURL:_sourceURL];
    _playerItem.preferredForwardBufferDuration = 0;
    NSArray *itemTracks = [_playerItem tracks];
    _itemTrack = (AVPlayerItemTrack *)itemTracks.firstObject;
    
    //播放器实例
    _player = [AVPlayer playerWithPlayerItem:_playerItem];

    //展示层
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    _playerLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    //_playerLayer.pixelBufferAttributes = @{};
    _playerLayer.backgroundColor = [UIColor colorWithRGB:0x333333].CGColor;
    [self.layer addSublayer:_playerLayer];
    
    //播放按钮
    _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_playButton setBackgroundImage:[UIImage imageNamed:@"player"] forState:UIControlStateNormal];
    [_playButton addTarget:self action:@selector(playAction) forControlEvents:UIControlEventTouchUpInside];
    _playButton.frame = CGRectMake(0, 0, 50, 50);
    _playButton.center = CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0);
    _playButton.hidden = YES;
    [self addSubview:_playButton];
    
    //缓冲进度条
    _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 200.0 - 1.5, _screenWidth, 1.0)];
    _progressView.progress = 0.0f;
    _progressView.backgroundColor = [UIColor colorWithRGB:0x333333];
    _progressView.progressTintColor = [UIColor whiteColor];
//    _progressView.trackTintColor = [UIColor redColor];
    _progressView.hidden = YES;
    [self addSubview:_progressView];
    
    //控制层
    _controlLayer = [[JMPlayerControlLayer alloc] initWithFrame:CGRectMake(0, 0, JMPlayerDisplayWidth, JMPlayerDisplayHeight)];
    _controlLayer.hidden = YES;
    [self addSubview:_controlLayer];
    
    //监听视频流的播放状态
    [_playerLayer addObserver:self forKeyPath:@"readyForDisplay" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [_playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [_playerItem addObserver:self forKeyPath:@"seekableTimeRanges" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [_playerItem addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [_player addObserver:self forKeyPath:@"timeControlStatus" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    
    //播放结束通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playToEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
}

#pragma mark -- Layout SubViews

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

#pragma mark -- 添加手势操作（控制屏幕亮度、播放音量和控制播放进度）

- (void)addUserGestureRecognizer {
    
    //处理控制层显示
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playerTap:)];
    [self addGestureRecognizer:tapGesture];
    //控制音量、控制屏幕亮度
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(playerPan:)];
    [self addGestureRecognizer:panGesture];
    //
}

#pragma mark -- Getter

- (JMPlayerPlayStatus)status {
    JMPlayerPlayStatus playStatus = JMPlayerPlayStatusUnknown;
    switch (_player.status) {
        case AVPlayerStatusUnknown:
            playStatus = JMPlayerPlayStatusUnknown;
            break;
        case AVPlayerStatusReadyToPlay:
            playStatus = JMPlayerPlayStatusReady;
            break;
        case AVPlayerStatusFailed:
            playStatus = JMPlayerPlayStatusFailed;
            break;
    }
    return playStatus;
}

- (NSURL *)sourceURL {
    return _sourceURL;
}

#pragma mark -- Setter

- (void)setRate:(float)rate {
    if (!_player) {return;}
    [_player playImmediatelyAtRate:rate];
}

#pragma mark -- PlayerControl

- (void)play {
    if (!_player) {return;}
    [_player play];
}

- (void)pause {
    if (!_player) {return;}
    [_player pause];
}


#pragma mark -- Observer

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([object isKindOfClass:[AVPlayerItem class]]) {
        //在成功获取资源后用户请求播放视频(开始缓冲视频资源并准备播放)
        if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
            //获取缓冲进度
            NSArray *loadedTimeRanges = [_playerItem loadedTimeRanges];
            // 获取缓冲区域
            CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];
            //开始的时间
            NSTimeInterval startSeconds = CMTimeGetSeconds(timeRange.start);
            //表示已经缓冲的时间
            NSTimeInterval durationSeconds = CMTimeGetSeconds(timeRange.duration);
            //计算缓冲总时间
            NSTimeInterval result = startSeconds + durationSeconds;
            //当前的播放进度
            float progress = result / _totalTime;
            //
            [_progressView setProgress:progress animated:YES];
            
        }else if([keyPath isEqualToString:@"playbackBufferFull"]){
            
        }else {
        }
    
    }else if([object isKindOfClass:[AVPlayerLayer class]]){
        //观察播放状态（即在有网络状态下获取到视频资源并且可以准备播放或者无网络状态下的处理）
        if ([change[@"old"] isEqualToNumber:@(0)] && [change[@"new"] isEqualToNumber:@(1)]) {
            _playButton.hidden = NO;
            _progressView.hidden = NO;
            
            //视频播放准备成功之后，获取视频播放时长
            CMTime time = _playerItem.duration;
            _totalTime = time.value / time.timescale;
        }
    }else {
        if ([keyPath isEqualToString:@"timeControlStatus"]) {
            //缓冲后的播放状态检测
            if (_player.timeControlStatus == AVPlayerTimeControlStatusPlaying) {
                [SVProgressHUD dismiss];
            }
        }
    }
}

#pragma mark -- 播放

- (void)playAction {
    
    _playButton.hidden = YES;
    [_player play];
    [SVProgressHUD show];
}

#pragma mark -- 通知

- (void)playToEnd:(NSNotification *)notif {
    
    if ([notif.name isEqualToString:AVPlayerItemDidPlayToEndTimeNotification]) {
        _playButton.hidden = NO;
        [_player seekToTime:kCMTimeZero];
//        [_progressView setProgress:0.0 animated:YES];
    }
}

#pragma mark -- 手势处理

- (void)playerTap:(UIGestureRecognizer *)gesture {
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
//        if (_controlLayer && _controlLayer.hidden) {
//            _controlLayer.hidden = NO;
//        }
    }
    
}

- (void)playerPan:(UIGestureRecognizer *)gesture {
    
}

#pragma mark -- dealloc

- (void)dealloc {
    
    [_playerLayer removeObserver:self forKeyPath:@"readyForDisplay" context:nil];
    [_playerItem removeObserver:self forKeyPath:@"loadedTimeRanges" context:nil];
    [_playerItem removeObserver:self forKeyPath:@"seekableTimeRanges" context:nil];
    [_playerItem removeObserver:self forKeyPath:@"playbackLikelyToKeepUp" context:nil];
    [_player removeObserver:self forKeyPath:@"timeControlStatus" context:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self forKeyPath:AVPlayerItemDidPlayToEndTimeNotification];
}



@end
