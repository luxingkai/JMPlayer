//
//  PlaybackViewController.m
//  VideoProcess
//
//  Created by tigerfly on 2020/10/15.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "PlaybackViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <VideoToolbox/VideoToolbox.h>
#import <CoreMedia/CoreMedia.h>

@interface PlaybackViewController ()<AVAssetResourceLoaderDelegate>

@end

@implementation PlaybackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    /*
     Media Playback and Selection
     
     Get and inspect media assets; queue media for playback and
     customize playback behavior; edit and combine assets;
     import and export raw media streams.
     
     The AVFoundation framework provides classes for the inspection,
     playback, editing, and exporting of audiovisual media assets.
     Use these classes if you want to:
     •  Retrieve media assets for playback, or gather information
        about an asset.
     •  Play audio and video media assets.
     •  Combine, edit, and remix audio and video assets from multiple
        sources.
     •  Obtain the media data of an asset, or write media data to
        a new file of a specified type.
     •  Transcode the contents of an asset to create a new representation.
     
     Assets are the building blocks for media players, and they provide
     a representation of a media resource. Assets come from many different
     media resources, such as local or remote media files, or from media
     streamed using HTTP Live Streaming. Use assets to efficiently retrieve
     and load audiovisual media in a timely manner. Inspect assets to learn
     about their properties, such as their duration and playback rate.
     
     You use a player to manage the playback and timing of an asset, for
     example starting and stopping playback, and seeking to a particular
     time. A player manages the playback of a single media asset at a time.
     A queue player manages the queuing of media assets played sequentially.
     To play an asset, you need its counterpart in the player item. A player
     item manages the timing and presentation state of an asset played by
     the player. A player item also contains player item tracks that
     correspond to the tracks in the asset. You direct the output of a
     player to a specified Core Animation layer, a player layer, or a
     synchronized layer.
     
     With AVFoundation you can create new representations of an asset
     in several ways. Use a composition to combine multiple audio and
     video assets into a new, composite asest. Use an export session
     to re-encode an existing asset into a format defined by one of
     many commonly used presets. If you need more control over the
     transformation, use an asset reader and asset writer in tandem
     to convert an asset to a new representation. You use an asset
     writer to create assets from media such as sample buffers or
     still images.
     
     ⚠️ You must call the VTRegisterProfessionalVideoWorkflowVideoDecoders
     function if your app requires Afterburner accelerated playback
     and decoding of ProRes and ProRes RAW video files.
     */
    
    
#pragma mark -- Essentials
    
    /*
     Configuring iOS Audio Playback Behavior
     
     Customize your app's audio playback capabilities by configuring
     its audio session and background modes.
     
     Most media playback apps for iOS require additional configuration
     to enable the desired playback behavior. Performing this
     configuration ensures your app's audio behavior works as
     expected, and enables advanced features like airplay streaming
     and background audio playback.
     
     An audio session acts as an intermediary between your app and
     the operating system - and in turn, the underlying audio hardware.
     You use an audio session to communicate to the operating system
     the nature of your app's audio without detailing the specific
     behavior or required interactions with the audio hardware.
     Instead, you delegate the management of those details to
     the audio session, ensuring that the operating system can
     best manage the use's audio experience.
     
     All iOS apps have a default audio session that's preconfigured
     as follows:
     •  When your app plays audio, it silences any other background
     audio.
     •  It supports audio playback, but disallows audio recording
     (audio recording isn't supported in TVOS).
     •  In iOS, setting teh Ring/Silent switch to silent mode
     silences your app's audio.
     •  In iOS, locking the device silences the app's audio.
     
     The default audio session provides useful behavior. but not
     always the hehavior needed when building a media playback
     app. To add the needed behavior, you configure your app's
     audio session category.
     
     An audio session category defines the general audio behavior
     your app requires. AVFoundation defines several audio session
     categories that you can use, but most media playback apps
     requires the AVAudioSessionCategoryPlayback category. This
     category indicates that audio playback is a central feature
     of your app. When you specify this category, your app's
     audio continues with the Ring/Silent switch set to silent
     mode(iOS only). Enabling this category also allows your app
     to play background audio if you're using the "Audio, AirPlay,
     and Picture in Picture" background mode.
     
     Use an AVAudioSession object to configure your app's audio
     session. AVVAudioSession is a singleton object you use to
     set the audio session category and other settings. You can
     interact with the audio session throughout your app's life
     cycle, but it's often useful to configure its category at app
     launch, as shown in the following example:
     
     let audioSession = AVAudioSession.sharedInstance()
     do {
     try audioSession.setCategory(.playback)
     } catch {
     print("Setting category to AVAudioSessionCategoryPlayback failed.")
     }
     
     To enable this category, activate the audio session using the
     setActive:withOptions:error: method.
     
     ⚠️ You can activate the audio session at any time after
     setting its category, but it's generally preferable to
     defer this call until your app begins audio playback.
     Deferring the call ensures that you don't prematurely
     interrupt any other background audio that may be in progess.
     
     Setting the category is the minimal interaction you have
     with an audio session, but other configuration options
     and features are available.
     */
    
    /**
     Enable Background Audio
     
     iOS and tvOS apps require you to enable certain capabilities
     for some background operations. A common capability playback
     apps require is to play background audio. With this capability
     enabled, your app’s audio continues when users switch to
     another app or when they lock their iOS device. This capability
     is also required for enabling advanced playback features like
     AirPlay streaming and Picture in Picture playback in iOS.
     
     The simplest way to configure these capabilities is by using
     Xcode. Select your app’s target in Xcode and select the Signing
     & Capabilities tab. Under the Capabilities tab, add the Background
     Modes capability and select the “Audio, AirPlay, and Picture
     in Picture” option under its list of background modes.
     */
    
    
#pragma mark -- Media Playback
    
    /*
     Responding to playback state Changes
     
     AVPlayer and AVPlayerItem are dynamic objects whose states
     change frequently. A simple way to observe and respond to
     these state changes is to use key-value observing(KVO).
     With KVO, an object can register to observe another object's
     state. When the observed object's state changes, the observer
     is notified with details of the state change.
     */
    
    /**
     Observer the Player's State
     
     One of the most important AVPlayerItem properties to observe
     is status. This property indicates whether the player item is
     ready for playback and generally available for use. When you
     first create a player item, its status value is
     AVPlayerItemStatusUnknown, meaning its media hasn't been loaded
     or been enqueued for playback. When you associate a player item
     with AVPlayer, it immediately begins enqueuing the item's media
     and preparing it for playback. The player item becomes ready for
     use when the status value changes to AVPlayerItemStatusReadyToPlay.
     The following example shows how you can observe this state change:
     */
    
    AVAsset *asset = nil;
    AVPlayer *player = nil;
    AVPlayerItem *playerItem = nil;
    NSArray *requiredAssetKeys = @[@"playable",@"hasProtectedContent"];
    
    NSURL *sourceURL = [[NSBundle mainBundle] URLForResource:@"tiger fly 2020-10-10 15.58.59" withExtension:@"mp4"];
    asset = [AVAsset assetWithURL:sourceURL];
    playerItem = [AVPlayerItem playerItemWithAsset:asset automaticallyLoadedAssetKeys:requiredAssetKeys];
    [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    player = [AVPlayer playerWithPlayerItem:playerItem];
    
    
    /*
     Observing the Playback Time
     
     Observe the playback time for an asset in order to update the
     player's state.
     
     You'll commonly want to observe an asset's playback time as
     it progresses so you can update the playback position or
     otherwise synchronize the state of your uesr interface.
     Although key-value observing(KVO) works well for general
     state observations, it's not the right choice for observing
     player timing because it's not well suited for observing
     continuous state changes. Instead, AVPlayer provides two
     different ways for you to observe player time changes:
     periodic observations and boundary observations.
     */
    
    /**
     Observe Periodic Timing
     
     You can observe time ticking by at some regular, periodic
     interval. If you're building a custom player, the most
     common use case for periodic observation is to update the
     time display in your user interface.
     
     To observe periodic timing, use the player's
     AddPeriodicTimeObserverForInterval:queue:usingBlock:method.
     This method takes a CMTime value representing the time
     interval, a serial dispatch queue, and a callback block to be
     invoked at the specified time interval. The following example
     shows how to set up a block to be called every half-second
     during normal playback:
     
     */
    CMTime time = CMTimeMake(0.5, NSEC_PER_SEC);
    [player addPeriodicTimeObserverForInterval:time queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        //Update player transport UI
    }];
    
    //    [player removeTimeObserver:self];
    
    /**
     Observe Boundary Timing
     
     The other way you can observe time is by boundary. You define
     various points of interest within the media's timeline, and
     the framework calls you back as those times are traversed during
     normal playback. Boundary observations are used less frequently
     than periodic observations, but can still prove useful in certain
     situations. For instance, you might use boundary observations if
     you're presenting a video with no playback controls and want to
     synchronize elements of the display or present supplemental
     content as those times are traversed.
     
     To observe boundary times, use the player's
     addBoundaryTimeObserverForTimes:queue:usingBlock:method.
     This method takes an array of NSValue objects wrapping the
     CMTime values that define your boundary times, a serial
     dispatch queue, and a callback block. The following
     example shows how to define boundary times for each
     quarter of playback:
     
     */
    CMTime interval = CMTimeMultiplyByFloat64(asset.duration, 0.25);
    CMTime currentTime = kCMTimeZero;
    NSMutableArray *times = [NSMutableArray array];
    
    while (CMTimeCompare(currentTime, asset.duration) == -1) {
        currentTime = CMTimeAdd(currentTime, interval);
        [times addObject:[NSValue valueWithCMTime:currentTime]];
    }
    [player addBoundaryTimeObserverForTimes:times queue:dispatch_get_main_queue() usingBlock:^{
        // Update UI
        
    }];
    
    
    /*
     Seeking Through Media
     
     Seek or scrub across a media item to quickly access a
     specific time point.
     
     In addtion to normal, linear playback, users also want the
     ability to seek or scrub in a nonlinear manner to quickly
     get to various points of interest within the media, AVKit
     automatically provides a scurbbing control for you (if
     supported by the media), but if you're building a custom
     player, you'll need to build this feature yourself. Even in
     cases where you're using AVKit, you still may want to provide
     a supplemental user interface, such as a table view or a
     collection view, that lets users quickly skip to various
     locations in the media.
     */
    
    /**
     Jump to a Specific Time Quickly
     
     You can seek in a number of ways using the methods of AVPlayer
     and AVPlayerItem. The most common way is to use the player's
     seekToTime: method, passing it a destination CMTime value
     as follows:
     
     The seekToTime: method is a convenient way to quickly seek
     through your presentation, but its turned more for speed
     rather than precision. This means the actual time to which
     the player moves may differ from the time you requested.
     */
    [player seekToTime:CMTimeMake(120, 1)];
    
    /**
     Jump to a Specific Time Accurately
     
     If you need to implement precise seeking behavior, use
     the seekToTime:toleranceBefore:toleranceAfter: method,
     which lets you indicate the tolerated amount of
     deviation from your target time(before and after).
     If you need to provide sample-accurate seeking
     behavior, you can indicate that zero tolerance is allowed:
     
     ⚠️ Calling the seek(to:toleranceBefore:toleranceAfter:)
     method with small or zero-valued tolerances may incur
     additional decoding delay, which can impact your app's
     seeking behavior.
     */
    [player seekToTime:CMTimeMakeWithSeconds(205, NSEC_PER_SEC) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    
    
    
    /*
     Play audio and Video assets modeled by a player item.
     */
    
    /*
     AVPlayer
     
     An object that provides the interface to control the player's
     transport behavior.
     
     An AVPlayer is a controller object used to manage the playback
     and timing of a media asset. You can use an AVPlayer to play
     local and remote file-based media, such as QuickTime movies
     and MP3 audio files, as well as audiovisual media served using
     HTTP Live Streaming.
     
     AVPlayer is for playing a single media asset at a time. You
     can reuse the player instance to play additional media assets
     using its replaceCurrentItemWithPlayerItem:method, but it
     manages the playback of only a single media asset at a time.
     The framework also provides a subclass of AVPlayer, called
     AVQueuePlayer, you use to create and manage the queuing of
     media assets played sequentially.
     
     You use an AVPlayer to play media assets, which AVFoundation
     models using the AVAsset class. AVAsset only models the static
     aspects of the media, such as its duration or creation date,
     and on its own, is unsuitable for playback with an AVPlayer.
     To play as asset, you need to create an instance of its
     dynamic counterpart found in AVPlayerItem. This object models
     the timing and presentation state of an asset played by an
     instance of AVPlayer.
     
     AVPlayer is a dynamic object whose state continuously changes.
     There are two approaches you can use to observe a player's
     state:
     •  General State Observations: You can use Key-Value observing
     (KVO) to observe state changes to many of the player's
     dynamic properties, such as its currentItem or its playback
     rate. You should register and unregister for KVO change
     notifications on the main thread. This avoid s the possibility
     of receiving a partial notification when making a change
     on another thread. AVFoundation invokes
     observeValueForKeyPath:ofObject:change:context: on the main
     thread, even when making the change operation on another
     thread.
     
     •  Timed State Observation: KVO works well for general state
     observations, but isn't intented for observing continuously
     changing state like the player's time. AVPlayer provides
     two methods to observe time changes:
     addPeriodicTimeObserverForInterval:queue:usingBlock:
     addBoundaryTimeObserverForTimes:queue:usingBlock:
     
     these methods let you observe time changes either periodically
     or by boundary, respectively. As changes occur, invoke the
     callback block or closure you supply to these methods to
     give you the opportunity to take some action such as updating
     the state of your player's user interface.
     
     AVPlayer and AVPlayerItem are nonvisual objects, meaning that
     on their own they are unable to present an asset's video
     onscreen. You have two primary approaches you can use to
     present your video content onscreen:
     
     •  AVKit: The best way to present your video content is with
     the AVKit framework's AVPlayerViewController class in iOS,
     or the AVPlayerView class in macOS. These classes present
     the video content, along with playback controls and other
     media features giving you a full-featured playback experience.
     •  AVPlayerLayer: When building a custom interface for your
     player, use AVPlayerLayer. The player layer can be set as
     a view's backing layer or can be added directly to the layer
     hierarchy. Unlike AVPlayerView and AVPlayerViewController,
     a player layer doesn't present any playback controls - it
     presents the visual content onscreen. It's up to you to
     build the playback transport controls to play, pause, and
     seek through the media.
     
     Alongside the visual content presented with AVKit or AVPlayerLayer,
     you can also present animated content synchronized with the player's
     timing using AVSynchronizedLayer. Use the synchronizedLayer to
     build custom effects in Core Animation, such as animated lower
     thirds or video transitions, and have them play in sync with
     the timing of the player's current AVPlayerItem.
     */
    
    /**
     Creating a Player
     */
    //    [AVPlayer alloc] initWithURL:<#(nonnull NSURL *)#>
    //    AVPlayer playerWithURL:<#(nonnull NSURL *)#>
    //    [AVPlayer alloc] initWithPlayerItem:<#(nullable AVPlayerItem *)#>
    //    AVPlayer playerWithPlayerItem:<#(nullable AVPlayerItem *)#>
    
    /**
     Managing Playback
     */
    //    [player play];
    //    [player pause];
    //    player.rate
    //    player actionAtItemEnd
    //    player replaceCurrentItemWithPlayerItem:<#(nullable AVPlayerItem *)#>
    //    player preventsDisplaySleepDuringVideoPlayback
    
    /**
     Managing Automatic Waiting Behavior
     */
    //    player.automaticallyWaitsToMinimizeStalling
    //    player.reasonForWaitingToPlay
    //    player.timeControlStatus
    //    player playImmediatelyAtRate:<#(float)#>
    
    /**
     Managing Time
     */
    //    player.currentTime
    //    player seekToTime:<#(CMTime)#>
    //    player seekToDate:<#(nonnull NSDate *)#>
    //    player seekToDate:<#(nonnull NSDate *)#> completionHandler:<#^(BOOL finished)completionHandler#>
    //    player seekToTime:<#(CMTime)#> completionHandler:<#^(BOOL finished)completionHandler#>
    //    player seekToTime:<#(CMTime)#> toleranceBefore:<#(CMTime)#> toleranceAfter:<#(CMTime)#>
    //    player seekToTime:<#(CMTime)#> toleranceBefore:<#(CMTime)#> toleranceAfter:<#(CMTime)#> completionHandler:<#^(BOOL finished)completionHandler#>
    
    /**
     Observing Time
     */
    //    player addPeriodicTimeObserverForInterval:<#(CMTime)#> queue:<#(nullable dispatch_queue_t)#> usingBlock:<#^(CMTime time)block#>
    //    player addBoundaryTimeObserverForTimes:<#(nonnull NSArray<NSValue *> *)#> queue:<#(nullable dispatch_queue_t)#> usingBlock:<#^(void)block#>
    //    player removeTimeObserver:<#(nonnull id)#>
    
    /**
     Configuring Media Selection Criteria Settings
     */
    //    player appliesMediaSelectionCriteriaAutomatically
    //    player mediaSelectionCriteriaForMediaCharacteristic:<#(nonnull AVMediaCharacteristic)#>
    //    player setMediaSelectionCriteria:<#(nullable AVPlayerMediaSelectionCriteria *)#> forMediaCharacteristic:<#(nonnull AVMediaCharacteristic)#>
    
    /**
     Managing External Playback
     */
    //    player.allowsExternalPlayback
    //    player.externalPlaybackActive
    //    player.usesExternalPlaybackWhileExternalScreenIsActive
    //    player.externalPlaybackVideoGravity
    
    /**
     Synchronizing Playback to an External Source
     */
    //    player setRate:<#(float)#> time:<#(CMTime)#> atHostTime:<#(CMTime)#>
    //    player prerollAtRate:<#(float)#> completionHandler:<#^(BOOL finished)completionHandler#>
    //    player cancelPendingPrerolls
    //    player masterClock
    
    /**
     Managing Audio Output
     */
    //    player.muted
    //    player.volume
    
    /**
     Getting Player Properties
     */
    //    player.status
    //    player.error
    //    player.currentItem
    //    player.outputObscuredDueToInsufficientExternalProtection
    
    /**
     Determining HDR Playback
     */
    //    player.availableHDRModes
    //    AVPlayerEligibleForHDRPlaybackDidChangeNotification
    
    
    /*
     AVQueuePlayer
     
     A player used to play a number of items in sequence.
     
     Use this class to create and manage a queue of player items
     composed of local or progressively downloaded file-based media,
     such as QuickTime movies or MP3 audio files, as well as media
     served using HTTP Live Streaming.
     */
    
    /**
     Creating a Queue Player
     */
    AVQueuePlayer *queuePlayer = [[AVQueuePlayer alloc] initWithItems:@[playerItem]];
    //    [AVQueuePlayer queuePlayerWithItems:@[playerItem]];
    
    /**
     Managing the Player Queue
     */
    //    queuePlayer.items
    //    queuePlayer advanceToNextItem
    //    queuePlayer canInsertItem:<#(nonnull AVPlayerItem *)#> afterItem:<#(nullable AVPlayerItem *)#>
    //    queuePlayer insertItem:<#(nonnull AVPlayerItem *)#> afterItem:<#(nullable AVPlayerItem *)#>
    //    queuePlayer removeItem:<#(nonnull AVPlayerItem *)#>
    //    queuePlayer removeAllItems
    
    /**
     Automatically Looping an Item
     */
    //    AVPlayerLooper
    
    
    /*
     AVPlayerLayer
     
     An object that manages a player's visual output.
     
     A convenient way of using AVPlayerLayer in iOS is as the
     backing layer for a UIView as illustrated in the following
     code example:
     */
    
    /**
     Creating a Player Layer
     */
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    
    /**
     Configuring Player Layer Values
     */
    //    playerLayer.player
    //    playerLayer isReadyForDisplay
    //    playerLayer.videoRect
    //    playerLayer.videoGravity
    //    playerLayer.pixelBufferAttributes
    
    
    /*
     AVPlayerItem
     
     An object used to model the timing and presentation state of an
     asset played by the player.
     */
    
    /**
     Creating a Player Item
     */
    //    [AVPlayerItem alloc] initWithURL:<#(nonnull NSURL *)#>
    //    AVPlayerItem playerItemWithURL:<#(nonnull NSURL *)#>
    //    [AVPlayerItem alloc] initWithAsset:<#(nonnull AVAsset *)#>
    //    AVPlayerItem  playerItemWithAsset:<#(nonnull AVAsset *)#>
    //    [AVPlayerItem alloc] initWithAsset:<#(nonnull AVAsset *)#> automaticallyLoadedAssetKeys:<#(nullable NSArray<NSString *> *)#>
    //    AVPlayerItem playerItemWithAsset:<#(nonnull AVAsset *)#> automaticallyLoadedAssetKeys:<#(nullable NSArray<NSString *> *)#>
    
    /**
     Inspecting a Player Item
     */
    //    playerItem.asset
    //    playerItem.automaticallyLoadedAssetKeys
    //    playerItem.tracks
    //    playerItem.status
    //    playerItem.duration
    //    playerItem.timebase
    //    playerItem.loadedTimeRanges
    //    playerItem.presentationSize
    //    playerItem.error
    
    /**
     Moving the Playhead
     */
    //    playerItem stepByCount:<#(NSInteger)#>
    //    playerItem seekableTimeRanges
    //    playerItem seekToDate:<#(nonnull NSDate *)#> completionHandler:<#^(BOOL finished)completionHandler#>
    //    playerItem seekToTime:<#(CMTime)#> completionHandler:<#^(BOOL finished)completionHandler#>
    //    playerItem seekToTime:<#(CMTime)#> toleranceBefore:<#(CMTime)#> toleranceAfter:<#(CMTime)#>
    //    playerItem cancelPendingSeeks
    
    /**
     Getting Information About Playback
     */
    //    playerItem.playbackLikelyToKeepUp
    //    playerItem.playbackBufferEmpty
    //    playerItem.playbackBufferFull
    //    playerItem.canPlayReverse
    //    playerItem.canPlayFastForward
    //    playerItem.canPlayFastReverse
    //    playerItem.canPlaySlowForward
    //    playerItem.canPlaySlowReverse
    //    playerItem.canStepForward
    //    playerItem.canStepBackward
    
    /**
     Getting Timing Information
     */
    //    playerItem.currentTime
    //    playerItem.currentDate
    //    playerItem.forwardPlaybackEndTime
    //    playerItem.reversePlaybackEndTime
    
    /**
     Configuring Network Behavior
     */
    //    playerItem.preferredPeakBitRate
    //    playerItem.preferredMaximumResolution
    //    playerItem.preferredForwardBufferDuration
    //    playerItem canUseNetworkResourcesForLiveStreamingWhilePaused
    
    /**
     Configuring an Item's Settings
     */
    //    playerItem.audioMix
    //    playerItem.videoComposition
    //    playerItem.customVideoCompositor
    //    playerItem.seekingWaitsForVideoCompositionRendering
    //    playerItem.audioTimePitchAlgorithm
    //    playerItem.videoApertureMode
    
    
    /**
     Accessing Logs
     */
    //    playerItem.accessLog
    //    playerItem.errorLog
    
    /**
     Selections Media Options
     */
    //    playerItem.currentMediaSelection
    //    playerItem selectMediaOption:<#(nullable AVMediaSelectionOption *)#> inMediaSelectionGroup:<#(nonnull AVMediaSelectionGroup *)#>
    //    playerItem selectedMediaOptionInMediaSelectionGroup:<#(nonnull AVMediaSelectionGroup *)#>
    
    /**
     Accessing the Text Style Rules
     */
    //    playerItem.textStyleRules
    
    /**
     Managing the Item's Outputs
     */
    //    playerItem.outputs
    //    playerItem addOutput:<#(nonnull AVPlayerItemOutput *)#>
    //    playerItem removeOutput:<#(nonnull AVPlayerItemOutput *)#>
    
    /**
     Managing the Item's Data Collectors
     */
    //    playerItem.mediaDataCollectors
    //    playerItem addMediaDataCollector:<#(nonnull AVPlayerItemMediaDataCollector *)#>
    //    playerItem removeMediaDataCollector:<#(nonnull AVPlayerItemMediaDataCollector *)#>
    
    /**
     Observing Notifications
     */
    //    AVPlayerItemDidPlayToEndTimeNotification
    //    AVPlayerItemFailedToPlayToEndTimeNotification
    //    AVPlayerItemTimeJumpedNotification
    //    AVPlayerItemPlaybackStalledNotification
    //    AVPlayerItemNewAccessLogEntryNotification
    //    AVPlayerItemNewErrorLogEntryNotification
    
    
    
    /*
     AVPlayerItemMetadataCollector
     
     An object used to capture the date range metadata defined
     for an HTTP Live Streaming asset.
     
     You can use the HLS #EXT-X-DATERANGE tag to define date range
     metadata in a media playlist. This tag is useful for defining
     timed metadata for interstitial regions such as advertisements,
     but can be used to define any timed metadata needed by your
     stream. To access this metadata when the stream is played using an
     AVPlayer, you create an instance of AVPlayerItemMetadataCollector,
     configure its delegate object (see AVPlayerItemMetadataCollectorPushDelegate),
     and add it as a media data collector to the AVPlayerItem (see example).
     */
    
    /**
     Creating a Metadata Collector
     */
    //    [AVPlayerItemMetadataCollector alloc] initWithIdentifiers:<#(nullable NSArray<NSString *> *)#> classifyingLabels:<#(nullable NSArray<NSString *> *)#>
    
    /**
     Accessing the Delegate and Callback Queue
     */
    AVPlayerItemMetadataCollector *metadataCollector = nil;
    //    metadataCollector.delegate
    //    metadataCollector.delegateQueue
    
    
    /*
     AVPlayerItemTrack
     
     An object used to modify the presentation state of an
     asset track being presented by a player.
     
     This class is intended to represent the presentation state for
     a track of an asset that's played by an AVPlayer and AVPlayerItem.
     To ensure safe access to nonatomic properties while dynamic
     changes in playback state may be reported, clients must serialize
     their access with the associated AVPlayer notification queue.
     Serialization is naturally achieved by invoking the AVPlayerItemTrack
     methods on the main thread or queue.
     */
    
    /**
     Configuring Track Properties
     */
    AVPlayerItemTrack *itemTrack = nil;
    //    itemTrack.assetTrack
    //    itemTrack.enabled
    //    itemTrack.currentVideoFrameRate
    
    
    /*
     AVSynchronizedLayer
     
     An object used to synchronize with a specific player item.
     
     You can create an arbitrary number of synchronized layers
     from the same AVPlayerItem object.
     
     A synchronized layer is similar to a CATransformLayer object in
     that it doesn't display anything itself, it just confers state
     upon its layer subtree. AVSynchronizedLayer confers its timing
     state, synchronizing the timing of layers in its subtree with
     that of a player item.
     
     Any CoreAnimation layer with animation property set that is
     added as a sublayer of AVSynchronizedLayer should set the
     animation's beginTime property to a non-zero positive value
     so animations will be interpreted on the player item's timeline.
     CoreAnimation replaces the default beginTime of 0.0 with
     CACurrentMediaTime. To start the animation from time 0, use
     a small positive value like AVCoreAnimationBeginTimeAtZero.
     
     You might use a layer as shown in the following example:
     */
    
    /**
     Creating a Synchronized Layer
     */
    //    AVSynchronizedLayer synchronizedLayerWithPlayerItem:<#(nonnull AVPlayerItem *)#>
    
    /**
     Managing the Player Item
     */
    AVSynchronizedLayer *synchronizedLayer = nil;
    //    synchronizedLayer.playerItem
    
    /**
     Supporting Types
     */
    //    AVCoreAnimationBeginTimeAtZero
    
    
    /*
     AVPlayerMediaSelectionCriteria
     
     An object that specifies the preferred languages
     and media characteristics for a player.
     
     The languages and media characteristics of assets containing
     media selection options that an AVPlayer instance should
     attempt to select automatically when preparing and playing
     items. The languages and media characteristics are specified
     in the preferred order.
     */
    
    /**
     Creating Media Selection Criteria
     */
    //    [AVPlayerMediaSelectionCriteria alloc] initWithPreferredLanguages:<#(nullable NSArray<NSString *> *)#> preferredMediaCharacteristics:<#(nullable NSArray<AVMediaCharacteristic> *)#>
    AVPlayerMediaSelectionCriteria *selectionCriteria = nil;
    
    /**
     Media Selection Criteria Settings
     */
    //    selectionCriteria.preferredLanguages
    //    selectionCriteria.preferredMediaCharacteristics
    
    
    /*
     AVSampleBufferAudioRenderer
     
     An object used to decompress audio and play compressed or
     uncompressed audio.
     
     You must add an instance of this class to an
     AVSampleBufferRenderSynchronizer before queuing the first sample buffer.
     */
    
    /**
     Inspecting Sample Buffers
     */
    AVSampleBufferAudioRenderer *audioRenderer = nil;
    //    audioRenderer.audioTimePitchAlgorithm
    //    audioRenderer.volume
    //    audioRenderer.muted
    //    audioRenderer.status
    
    /**
     Removing Queued Buffers
     */
    //    audioRenderer flushFromSourceTime:<#(CMTime)#> completionHandler:<#^(BOOL flushSucceeded)completionHandler#>
    
    /**
     Responding to Errors
     */
    //    audioRenderer.error
    
    
    /*
     AVSampleBufferDisplayLayer
     
     An object that displays compressed or uncompressed video frames.
     */
    
    /**
     Initiating Media Data Requests
     */
    AVSampleBufferDisplayLayer * bufferDisplayLayer = nil;
    //    [AVSampleBufferDisplayLayer alloc] requestMediaDataWhenReadyOnQueue:<#(nonnull dispatch_queue_t)#> usingBlock:<#^(void)block#>
    //    bufferDisplayLayer.readyForMoreMediaData
    //    bufferDisplayLayer stopRequestingMediaData
    
    /**
     Flushing Sample Buffers
     */
    //    bufferDisplayLayer flush
    //    bufferDisplayLayer flushAndRemoveImage
    
    /**
     Configuring the Timebase
     */
    //    bufferDisplayLayer.controlTimebase
    
    /**
     Enqueuing the sample buffer
     */
    //    bufferDisplayLayer enqueueSampleBuffer:<#(nonnull CMSampleBufferRef)#>
    
    /**
     Setting the Video Gravity
     */
    //    bufferDisplayLayer.videoGravity
    
    /**
     Getting Display Layer Settings
     */
    //    bufferDisplayLayer.status
    
    /**
     Handling Errors
     */
    //    bufferDisplayLayer.error
    //    AVSampleBufferDisplayLayerFailedToDecodeNotificationErrorKey
    //    AVSampleBufferDisplayLayerFailedToDecodeNotification
    
    
    /*
     AVSampleBufferRenderSynchronizer
     
     An object used to synchronize multiple queued sample buffers
     to a single timeline.
     
     This class synchronizes multiple objects that conform to
     AVQueuedSampleBufferRendering to a single timeline.
     */
    
    /**
     Working with Time Observers
     */
    //    [AVSampleBufferRenderSynchronizer alloc] addPeriodicTimeObserverForInterval:<#(CMTime)#> queue:<#(nullable dispatch_queue_t)#> usingBlock:<#^(CMTime time)block#>
    //    [AVSampleBufferRenderSynchronizer alloc] addBoundaryTimeObserverForTimes:<#(nonnull NSArray<NSValue *> *)#> queue:<#(nullable dispatch_queue_t)#> usingBlock:<#^(void)block#>
    //    [AVSampleBufferRenderSynchronizer alloc] removeTimeObserver:<#(nonnull id)#>
    
    /**
     Working with Renderers
     */
    AVSampleBufferRenderSynchronizer *renderSynchronizer = nil;
    //    renderSynchronizer.renderers
    //    renderSynchronizer addRenderer:<#(nonnull id<AVQueuedSampleBufferRendering>)#>
    //    renderSynchronizer removeRenderer:<#(nonnull id<AVQueuedSampleBufferRendering>)#> atTime:<#(CMTime)#> completionHandler:<#^(BOOL didRemoveRenderer)completionHandler#>
    
    /**
     Accessing Time Information
     */
    //    renderSynchronizer.timebase
    //    renderSynchronizer.rate
    //    renderSynchronizer setRate:<#(float)#> time:<#(CMTime)#>
    //    renderSynchronizer.currentTime
    
    
    /*
     AVRouteDetector
     
     An object that detects the presences of media playback routes.
     
     When route detection is enabled, AVRouteDetector reports whether
     multiple playback routes have been detected. If this is the case,
     AVKit's AVRoutePickerView can be used to allow users to pick
     from the set of available routes. By default, route detection
     is disabled.
     */
    
    /**
     Detecting Routes
     */
    AVRouteDetector *routeDetector = nil;
    //    routeDetector.routeDetectionEnabled
    //    routeDetector.multipleRoutesDetected
    //    AVRouteDetectorMultipleRoutesDetectedDidChangeNotification
    
    
    /*
     Sample Buffer Playback
     
     Play audio and video sample buffers using a custom player.
     */
    
    /**
     AVSampleBufferAudioRenderer
     
     An object used to decompress audio and play compressed
     or uncompressed audio.
     
     You must add an instance of this class to an
     AVSampleBufferRenderSynchronizer before queuing the
     first sample buffer.
     */
    AVSampleBufferAudioRenderer *sampleBufferAudioRenderer = nil;
    //    sampleBufferAudioRenderer.volume
    //    sampleBufferAudioRenderer.muted
    //    sampleBufferAudioRenderer.audioTimePitchAlgorithm
    //    sampleBufferAudioRenderer.status
    //    sampleBufferAudioRenderer.error
    //    sampleBufferAudioRenderer flushFromSourceTime:<#(CMTime)#> completionHandler:<#^(BOOL flushSucceeded)completionHandler#>
    
    
    /**
     AVSampleBufferDisplayLayer
     
     An object that displays compressed or uncompressed video frames.
     */
    
    AVSampleBufferDisplayLayer *displayLayer = nil;
    //    displayLayer requestMediaDataWhenReadyOnQueue:<#(nonnull dispatch_queue_t)#> usingBlock:<#^(void)block#>
    //    displayLayer isReadyForMoreMediaData
    //    displayLayer stopRequestingMediaData
    
    //    displayLayer flush
    //    displayLayer flushAndRemoveImage
    
    //    displayLayer controlTimebase
    
    //    displayLayer enqueueSampleBuffer:<#(nonnull CMSampleBufferRef)#>
    
    //    displayLayer videoGravity
    //    displayLayer.status
    //    displayLayer.error
    //    AVSampleBufferDisplayLayerFailedToDecodeNotificationErrorKey
    //    AVSampleBufferDisplayLayerFailedToDecodeNotification
    
    
    /**
     AVSampleBufferRenderSynchronizer
     
     An object used to synchronizer multiple queued sample buffers
     to a single timeline.
     This class synchronizes multiple objects that conform to
     AVQueuedSampleBufferRendering to a single timeline.
     */
    //    AVSampleBufferRenderSynchronizer *renderSynchronizer = nil;
    //    renderSynchronizer addBoundaryTimeObserverForTimes:<#(nonnull NSArray<NSValue *> *)#> queue:<#(nullable dispatch_queue_t)#> usingBlock:<#^(void)block#>
    //    renderSynchronizer addPeriodicTimeObserverForInterval:<#(CMTime)#> queue:<#(nullable dispatch_queue_t)#> usingBlock:<#^(CMTime time)block#>
    
    
    
#pragma mark -- Metadata Manipulation
    
    /*
     AVMetadataGroup
     
     A collection of metadata items associated with a timeline segment.
     */
    
    /**
     Inspecting the Metadata Group
     */
    AVMetadataGroup *metadataGroup = nil;
    //    metadataGroup.items
    //    metadataGroup.uniqueID
    //    metadataGroup.classifyingLabel
    
    
    /*
     AVDateRangeMetadataGroup
     
     A collection of metadata items that are valid for use within
     a specific date range.
     */
    
    /**
     Creating a Date Range Group
     */
    AVDateRangeMetadataGroup *rangeMetadataGroup = nil;
    //    AVDateRangeMetadataGroup *rangeMetadataGroup = [AVDateRangeMetadataGroup alloc] initWithItems:<#(nonnull NSArray<AVMetadataItem *> *)#> startDate:<#(nonnull NSDate *)#> endDate:<#(nullable NSDate *)#>;
    
    /**
     Inspecting the Date Range Group
     */
    //    rangeMetadataGroup.items
    //    rangeMetadataGroup.startDate
    //    rangeMetadataGroup.endDate
    
    
    /*
     AVMutableDateRangeMetadataGroup
     
     A mutable collection of metadata items that are valid for use
     within a specific range of dates.
     */
    
    /**
     Inspecting and Configuring the Metadata Group
     */
    AVMutableDateRangeMetadataGroup *mutableRangeMetadataGroup = nil;
    //    mutableRangeMetadataGroup.items
    //    mutableRangeMetadataGroup.startDate
    //    mutableRangeMetadataGroup.endDate
    
    
    /*
     AVTimedMetadataGroup
     
     A collection of metadata items that are valid for use during
     a specific time range.
     
     For example, AVTimeMetadataGroups are used to represent chapters,
     optionally containing metadata items for chapter titles and
     chapter images.
     */
    
    /**
     Initializing Timed Metadata Group Objects
     */
    AVTimedMetadataGroup *timedMetadataGroup = nil;
    //    [AVTimedMetadataGroup alloc] initWithSampleBuffer:<#(nonnull CMSampleBufferRef)#>
    //    [[AVTimedMetadataGroup alloc] initWithItems:<#(nonnull NSArray<AVMetadataItem *> *)#> timeRange:<#(CMTimeRange)#>]
    
    /**
     Configuring Timed Metadata Group Attributes
     */
    //    timedMetadataGroup copyFormatDescription
    //    timedMetadataGroup.items
    //    timedMetadataGroup.timeRange
    
    
    /*
     AVMutableTimedMetadataGroup
     
     A mutable collection of metadata items that are valid for
     use during a specific time range.
     */
    
    /**
     Modifying the Group
     */
    AVMutableTimedMetadataGroup *mutableTimedMetadataGroup = nil;
    //    mutableTimedMetadataGroup.timeRange
    //    mutableTimedMetadataGroup.items
    
    
    
    
#pragma mark -- Asset Downloading
    
    /*
     AVURLAsset
     
     A concrete subclass of AVAsset that's used to initilize an
     asset from a local or remote URL.
     */
    
    /**
     Creating a URL Asset
     */
    AVURLAsset *urlAsset = [[AVURLAsset alloc] initWithURL:sourceURL options:nil];
    //    AVURLAsset URLAssetWithURL:<#(nonnull NSURL *)#> options:<#(nullable NSDictionary<NSString *,id> *)#>
    
    /**
     Accessing the URL
     */
    //    urlAsset.URL
    
    /**
     Assisting with Resource Loading
     */
    //    urlAsset.resourceLoader
    
    /**
     Finding Compatible Tracks
     */
    //    urlAsset compatibleTrackForCompositionTrack:<#(nonnull AVCompositionTrack *)#>
    
    /**
     Getting Supported Media Types
     */
    //    AVURLAsset audiovisualTypes
    //    AVURLAsset audiovisualMIMETypes
    //    AVURLAsset isPlayableExtendedMIMEType:<#(nonnull NSString *)#>
    
    /**
     Working with Offline Assets
     */
    //    urlAsset.assetCache
    
    /**
     Working with Encrypted Content
     */
    //    urlAsset.mayRequireContentKeysForMediaDataProcessing
    
    
    /*
     AVAssetDownloadURLSession
     
     A URL session used to support the creation and execution
     of asset download tasks.
     */
    
    /**
     Creating an Instance
     */
    //    AVAssetDownloadURLSession sessionWithConfiguration:<#(nonnull NSURLSessionConfiguration *)#> assetDownloadDelegate:<#(nullable id<AVAssetDownloadDelegate>)#> delegateQueue:<#(nullable NSOperationQueue *)#>
    
    /**
     Creating a Download Task
     */
    //    [AVAssetDownloadURLSession alloc] assetDownloadTaskWithURLAsset:<#(nonnull AVURLAsset *)#> assetTitle:<#(nonnull NSString *)#> assetArtworkData:<#(nullable NSData *)#> options:<#(nullable NSDictionary<NSString *,id> *)#>
    //    [AVAssetDownloadURLSession alloc] aggregateAssetDownloadTaskWithURLAsset:<#(nonnull AVURLAsset *)#> mediaSelections:<#(nonnull NSArray<AVMediaSelection *> *)#> assetTitle:<#(nonnull NSString *)#> assetArtworkData:<#(nullable NSData *)#> options:<#(nullable NSDictionary<NSString *,id> *)#>
    
    
    /*
     AVAssetResourceLoader
     
     An object that mediates resource requests from a URL asset.
     
     You do not create resource loader objects yourself. Instead, you
     retrieve a resource loader from the resourceLoader property of an
     AVURLAsset object and use it to assign your custom delegate object.
     
     The delegate you associate with this object must adopt the
     AVAssetResourceLoaderDelegate protocol. For more information,
     see AVAssetResourceLoaderDelegate.
     
     The AVARLDelegateDemo demonstrates using this class in a streaming environment.
     */
    
    /**
     Accessing the Delegate
     */
    AVAssetResourceLoader *assetResourceLoader = nil;
    [assetResourceLoader setDelegate:self queue:dispatch_get_main_queue()];
    
    /**
     Getting the Dispatch Queue
     */
    //    assetResourceLoader.delegateQueue
    
    /**
     Loading Content Keys
     */
    //    assetResourceLoader.preloadsEligibleContentKeys
    
    
    /*
     AVAssetResourceLoadingRequest
     
     An object that encapsulates information about a resource
     request issued by a resource loader object.
     
     When an AVURLAsset object needs help loading a resource,
     it asks its AVAssetResourceLoader object to assist. The resource
     loader encapsulates the request information by creating an instance
     of this object, which it then hands to its delegate object for
     processing. The delegate uses the information in this object
     to perform the request and report on the success or failure of
     the operation.
     */
    
    /**
     Accessing the Request Data
     */
    AVAssetResourceLoadingRequest *resourceLoadingRequest = nil;
    //    resourceLoadingRequest.request
    //    resourceLoadingRequest.requestor
    //    resourceLoadingRequest streamingContentKeyRequestDataForApp:<#(nonnull NSData *)#> contentIdentifier:<#(nonnull NSData *)#> options:<#(nullable NSDictionary<NSString *,id> *)#> error:<#(NSError * _Nullable __autoreleasing * _Nullable)#>
    //    resourceLoadingRequest persistentContentKeyFromKeyVendorResponse:<#(nonnull NSData *)#> options:<#(nullable NSDictionary<NSString *,id> *)#> error:<#(NSError *__autoreleasing  _Nullable * _Nullable)#>
    //    resourceLoadingRequest contentInformationRequest
    //    resourceLoadingRequest dataRequest
    //    resourceLoadingRequest redirect
    
    /**
     Reporting the Result of the Request
     */
    //    resourceLoadingRequest.response
    //    resourceLoadingRequest finishLoading
    //    resourceLoadingRequest isCancelled
    //    resourceLoadingRequest finishLoadingWithError:<#(nullable NSError *)#>
    
    
    /*
     AVAssetCache
     
     An object used to inspect the state of an asset’s locally
     cached media data.
     
     You can download HTTP Live Streaming assets to an iOS device
     using the AVAssetDownloadURLSession and AVAssetDownloadTask
     classes. You can use the downloaded asset’s associated AVAssetCache
     to inspect its locally cached media data.
     */
    
    AVAssetCache *assetCache = nil;
    //    assetCache.playableOffline
    //    assetCache mediaSelectionOptionsInMediaSelectionGroup:<#(nonnull AVMediaSelectionGroup *)#>
    
    
    /*
     AVAssetResourceRenewalRequest
     
     An object that encapsulates information about a resource
     request issued by a resource loader to renew a previously
     issued request.
     
     When an AVURLAsset needs to renew a resource, because the
     renewalDate has been set on a previous loading request,
     it asks its AVAssetResourceLoader object to assist. The resource
     loader encapsulates the request information by creating an
     instance of this object, which it then hands to its delegate
     for processing. The delegate uses the information in this object
     to perform the request and report on the success or failure of
     the operation.
     
     The AVAssetResourceRenewalRequest class is a subclass of
     AVAssetResourceLoadingRequest.
     */
    //    AVAssetResourceRenewalRequest
    
    
    /*
     AVAssetResourceLoadingContentInformationRequest
     
     A query used to get essential information about a resource
     referenced by an asset resource loading request.
     
     When a resource loading delegate, which must implement
     the AVAssetResourceLoaderDelegate protocol, receives an
     instance of AVAssetResourceLoadingRequest when the
     resourceLoader:shouldWaitForLoadingOfRequestedResource:
     is invoked and accepts responsibility for loading the resource,
     it must check whether the contentInformationRequest property
     of the AVAssetResourceLoadingRequest is not nil. Whenever the
     value is not nil, the request includes a query for the
     information that AVAssetResourceLoadingContentInformationRequest
     encapsulates. In response to such queries, the resource
     loading delegate should set the values of the content
     information request's properties appropriately before
     invoking the AVAssetResourceLoadingRequest method finishLoading.
     
     When finishLoading is invoked, the values of the properties of
     its contentInformationRequest property will, in part, determine
     how the requested resource is processed. For example, if the
     requested resource’s URL is the URL of an AVURLAsset and
     contentType is set by the resource loading delegate to a
     value that the underlying media system doesn’t recognize
     as a supported media file type, operations on the AVURLAsset,
     such as playback, are likely to fail.
     */
    AVAssetResourceLoadingContentInformationRequest *informationRequest = nil;
    
    /**
     Configuring Content Information
     */
    //    informationRequest.allowedContentTypes
    //    informationRequest.contentType
    //    informationRequest.contentLength
    //    informationRequest.byteRangeAccessSupported
    //    informationRequest.renewalDate
    
    
    /*
     AVAssetResourceLoadingDateRequest
     
     An object used to request data from a resource referenced by
     an asset resource loading request.
     
     The AVAssetResourceLoaderDelegate uses the AVAssetResourceLoadingDataRequest
     class to do the actual data reading, and its methods will be invoked,
     as necessary, to acquire data for the AVAssetResourceLoadingRequest
     instance.
     
     When the resource loading delegate, which implements the
     AVAssetResourceLoaderDelegate protocol, receives an instance
     of AVAssetResourceLoadingRequest as the second parameter of
     the delegate’s resourceLoader:shouldWaitForLoadingOfRequestedResource:
     method, it has the option of accepting responsibility for
     loading the referenced resource. If it accepts that responsibility,
     by returning YES, it must check whether the dataRequest property
     of the AVAssetResourceLoadingRequest instance is not nil. If it
     is not nil, the resource loading delegate is informed of the
     range of bytes within the resource that are required by the
     underlying media system. In response, the data is provided by
     one or more invocations of respondWithData: as required to
     provide the requested data. The data can be provided in increments
     determined by the resource loading delegate according to
     convenience or efficiency.
     
     When the AVAssetResourceLoadingRequest method finishLoading
     is invoked, the data request is considered fully satisfied.
     If the entire range of bytes requested has not yet been
     provided, the underlying media system assumes that the
     resource's length is limited to the provided content.
     */
    
    AVAssetResourceLoadingDataRequest *loadingDataRequest = nil;
    //    loadingDataRequest respondWithData:<#(nonnull NSData *)#>
    //    loadingDataRequest requestedLength
    //    loadingDataRequest requestedOffset
    //    loadingDataRequest currentOffset
    //    loadingDataRequest requestsAllDataToEndOfResource
    
    
    /*
     AVAssetDownloadStorageManager
     
     A manager of policies used to automatically purge
     downloaded assets.
     
     Fetch the shared singleton when setting a storage
     management policy. Set new policy using
     setStorageManagementPolicy:forURL: and the location
     of the downloaded asset.
     */
    
    /**
     Setting the Storage Policy
     */
    AVAssetDownloadStorageManager *downloadStorageManager = nil;
    //    downloadStorageManager setStorageManagementPolicy:<#(nonnull AVAssetDownloadStorageManagementPolicy *)#> forURL:<#(nonnull NSURL *)#>
    //    downloadStorageManager storageManagementPolicyForURL:<#(nonnull NSURL *)#>
    
    /**
     Retrieving the Singleton
     */
    //    AVAssetDownloadStorageManager sharedDownloadStorageManager
    
    
    /*
     AVAssetDownloadStorageManagementPolicy
     
     A set of properties that defines a policy to automatically
     purge downloaded assets.
     */
    
    /**
     Managing Storage
     */
    AVAssetDownloadStorageManagementPolicy *storageManagementPolicy = nil;
    //    storageManagementPolicy.expirationDate
    //    storageManagementPolicy.priority
    
    
    
#pragma mark -- Media Item Transfer
    
    /*
     AVPlayerItemOutput
     
     The abstract class that defines the common interface for moving
     samples from an asset to a player.
     
     This class provides basic methods for converting time values to
     the timebase of the item. It also provides an option to suppress
     rendering of the output associated with the specific instance of
     this class.
     
     ⚠️ Do not create instances of this class directly but instead use
     one of the concrete subclasses that manage specific types of assets.
     */
    
    /**
     Converting Time information
     
     itemTimeForHostTime:
     itemTimeForMachAbsoluteTime:
     itemTimeForCVTimeStamp:
     */
    
    /**
     Configuring the Playback Options
     
     suppressesPlayerRendering
     */
    
    
    /*
     AVPlayerItemOutputPushDelegate
     
     Methods you can implement to respond to changes in the media
     data sequence.
     */
    
    /**
     Flushing Sequence State
     
     outputSequenceWasFlushed:
     */
    
    
    /*
     AVPlayerItemLegibleOutput
     
     An object that can vend media with a legible characteristic
     as an attributed string.
     */
    AVPlayerItemLegibleOutput *legibleOutput = nil;
    
    /**
     Creating a Legible-Output Instance
     */
    //    [AVPlayerItemLegibleOutput alloc] initWithMediaSubtypesForNativeRepresentation:<#(nonnull NSArray<NSNumber *> *)#>
    //    [[AVPlayerItemLegibleOutput alloc] init];
    
    /**
     Configuring Attribtued-String Text Styling Settings
     */
//        legibleOutput.textStylingResolution
    
    /**
     Configuring the Delegate
     */
    //    legibleOutput.delegate
    //    legibleOutput setDelegate:<#(nullable id<AVPlayerItemLegibleOutputPushDelegate>)#> queue:<#(nullable dispatch_queue_t)#>
    //    legibleOutput.delegateQueue
    //    legibleOutput.advanceIntervalForDelegateInvocation
    
    
    /*
     AVPlayerItemMetadataOutput
     
     An object used to vend collections of metadata items carried
     in metadata tracks.
     
     ⚠️Setting the value of suppressesPlayerRendering on an instance of
     AVPlayerItemMetadataOutput has no effect.
     */
    
    /**
     Initializing a Metadata Output Object
     */
    //    AVPlayerItemMetadataOutput *metadataOutput = [AVPlayerItemMetadataOutput alloc] initWithIdentifiers:<#(nullable NSArray<NSString *> *)#>;
    AVPlayerItemMetadataOutput *metadataOutput = nil;
    
    /**
     Configuring the Delegate
     */
    //    metadataOutput advanceIntervalForDelegateInvocation
    //    metadataOutput.delegate
    //    metadataOutput.delegateQueue
    //    metadataOutput setDelegate:<#(nullable id<AVPlayerItemMetadataOutputPushDelegate>)#> queue:<#(nullable dispatch_queue_t)#>
    
    
    /*
     AVPlayerItemVideoOutput
     
     An object that coordinates the output of content associated
     with a Core Video pixel buffer.
     */
    
    /**
     Initializing the Player item Video Output
     */
    AVPlayerItemVideoOutput *videoOutput = nil;
    //    [AVPlayerItemVideoOutput alloc] initWithOutputSettings:<#(nullable NSDictionary<NSString *,id> *)#>
    //    [AVPlayerItemVideoOutput alloc] initWithPixelBufferAttributes:<#(nullable NSDictionary<NSString *,id> *)#>
    
    /**
     Accessing the Delegate
     */
    //    videoOutput setDelegate:<#(nullable id<AVPlayerItemOutputPullDelegate>)#> queue:<#(nullable dispatch_queue_t)#>
    //    videoOutput.delegate
    //    videoOutput.delegateQueue
    
    /**
     Notifying the Delegate of Changes
     */
    //    videoOutput requestNotificationOfMediaDataChangeWithAdvanceInterval:<#(NSTimeInterval)#>
    
    /**
     Getting Pixel Buffer Data
     */
    //    videoOutput hasNewPixelBufferForItemTime:<#(CMTime)#>
    //    videoOutput copyPixelBufferForItemTime:<#(CMTime)#> itemTimeForDisplay:<#(nullable CMTime *)#>
    
    
#pragma mark -- HTTP Live Streaming
    
    
#pragma mark -- Sample Buffer Manipulation
    
    /*
     AVQueuedSampleBufferRendering
     
     Methods you can implement to enqueue sample buffers for presentation.
     
     AVSampleBufferDisplayLayer and AVSampleBufferAudioRenderer conform to
     this protocol. When used in conjunction with an
     AVSampleBufferRenderSynchronizer, an object conforming to
     AVQueuedSampleBufferRendering can only be attached to a single synchronizer.
     
     */

    
    /**
     Requesting Media
     
     readyForMoreMediaData
     enqueueSampleBuffer:
     requestMediaDataWhenReadyOnQueue:UsingBlock:
     stopRequestingMediaData
     */
    
    /**
     Clearing Queued Sample buffers
     
     flush
     */
    
    /**
     indentifying the Timebase
     
     timebase
     */
    
    
#pragma mark -- Text Formatting
    
    /*
     AVTextStyleRule
     
     An object that represents text styling rules applied to text in a
     media item.
     
     You use text style objects to format subtitles, closed captions,
     and other text-related content of the item. The system applies
     these rules to all or part of the text of the media item.
     */

    
    /**
     Creating and Initailizing Style Rules
     */
    //    AVTextStyleRule textStyleRulesFromPropertyList:<#(nonnull id)#>
    //    AVTextStyleRule textStyleRuleWithTextMarkupAttributes:<#(nonnull NSDictionary<NSString *,id> *)#>
    //    AVTextStyleRule textStyleRuleWithTextMarkupAttributes:<#(nonnull NSDictionary<NSString *,id> *)#> textSelector:<#(nullable NSString *)#>
    //    [AVTextStyleRule alloc] initWithTextMarkupAttributes:<#(nonnull NSDictionary<NSString *,id> *)#>
    //    [AVTextStyleRule alloc] initWithTextMarkupAttributes:<#(nonnull NSDictionary<NSString *,id> *)#> textSelector:<#(nullable NSString *)#>
    
    /**
     Accessing the Style Attributes
     */
    AVTextStyleRule *styleRule = nil;
    //    styleRule.textMarkupAttributes
    //    styleRule.textSelector
    
    /**
     Exporting the Style Rules
     */
    //    AVTextStyleRule propertyListForTextStyleRules:<#(nonnull NSArray<AVTextStyleRule *> *)#>
    
    
    
#pragma mark -- Media Selection
    
    /*
     Adding Subtitles and Alternative Audio Tracks
     
     Extend your app's appeal to users by adding subtitles and
     alternative audio tracks in their native language.
     
     As a developer, you want to make your apps accessible to as
     broad an audience as possible. One way for you to extend
     your app's reach is to make it available to users in their
     native language as well as to provide support for users who
     have hearing impairments or other accessibility needs. AVKit
     and AVFoundation simplify handling these concerns by providing
     built-in support for presenting subtitles and closed captions,
     and for selecting alternative audio and video tracks. If you're
     building your own custom player or would like to present your
     own media-selection interface, use the features provides by
     AVFoundation's AVMediaSelectGroup and AVMediaSelectionOption
     classes.
     */
    
    /**
     Retrieve the Available Media Options
     
     AVMediaSelectionOption models an alternative audio, video, or
     text track contained within the source media. Media options
     are uesd to select alternative camera angles, present audio
     dubbed in a user's native language, or display subtitles and
     closed captions. You determine which alternative media
     presentations are available by asynchronously loading and
     calling the asset's availbleMediaCharateristicsWithMediaSelectionOptions
     property, which returns are AVMediaCharacteristicAudible (alternative
     audio tracks), AVMediaCharacteristicVisual (alternative video tracks),
     and AVMediaCharacteristicLegible(subtitles and closed captions).
     
     After you've retrieved the array of available options, you call
     the asset's mediaSelectionGroupForMediaChracteristic:method, passing
     it the desired characteristic. This method returns the associated
     AVMediaSelectionGroup object, or nil if no groups exist for the
     the specified characteristic.
     
     AVMediaSelectionGroup acts as a container for a collection of
     mutually exclusive AVMediaSelectionOption objects. The following
     example shows how you retrieve an asset's media-selection groups
     and display their available options:
     */
    
    for (AVMediaCharacteristic characteristic in asset.availableMediaCharacteristicsWithMediaSelectionOptions) {
        
        //retrieve the AVMediaSelectionGroup for the specified characteristic.
        AVMediaSelectionGroup *group = [asset mediaSelectionGroupForMediaCharacteristic:characteristic];
        for (AVMediaSelectionOption *option in group.options) {
            printf("%s",[option.displayName cStringUsingEncoding:NSUTF8StringEncoding]);
        }
    }
    
    /**
     Select the Desired Media Option
     
     After you're retrieved an AVMediaSelectionGroup object for a particular
     media characteristic and identified the desired AVMediaSelectionOption
     object, the next step is to select it. You select a media option by
     calling selectMediaOption:inMediaSelectionGroup: on the active AVPlayerItem.
     For instance, to present the asset's Spanish subtitle option, you could
     select it as follows:
     
     Selecting a media option makes it immediately available for presentation.
     Selecting a subtitle or closed-caption option displays the associated
     text within the video display provided by AVPlayerViewController,
     AVPlayerView, and AVPlayerLayer. Selecting an alternative audio
     or video option replaces the currently presented media with the new
     selection's media.
     */
    
    AVMediaSelectionGroup *group = [asset mediaSelectionGroupForMediaCharacteristic:AVMediaCharacteristicLegible];
    NSLocale *locale = [NSLocale localeWithLocaleIdentifier:@"en-ES"];
    NSArray *options = [AVMediaSelectionGroup mediaSelectionOptionsFromArray:group.options withLocale:locale];
    [playerItem selectMediaOption:options.firstObject inMediaSelectionGroup:group];
    
    
    /*
     AVMediaSelection
     
     An object that represents a complete rendition of media selection options
     on an asset.
     */
    
    /**
     Inspecting the Media Selection
     */
    AVMediaSelection *mediaSelection = nil;
//    mediaSelection.asset
//    mediaSelection selectedMediaOptionInMediaSelectionGroup:<#(nonnull AVMediaSelectionGroup *)#>
//    mediaSelection mediaSelectionCriteriaCanBeAppliedAutomaticallyToMediaSelectionGroup:<#(nonnull AVMediaSelectionGroup *)#>
    
    
    /*
     AVMediaSelectionGroup
     
     An object that represents a collection of mutually exclusive options
     for the presentation of media within an asset.
     */
    
    /**
     Accessing Options
     */
    AVMediaSelectionGroup *selectionGroup = nil;
//    selectionGroup.options
//    selectionGroup mediaSelectionOptionWithPropertyList:<#(nonnull id)#>
//    selectionGroup defaultOption
    
    /**
     Configuring Empty Selection
     */
//    selectionGroup.allowsEmptySelection
    
    /**
     Filtering Selection Options
     */
//    AVMediaSelectionGroup playableMediaSelectionOptionsFromArray:<#(nonnull NSArray<AVMediaSelectionOption *> *)#>
    
    
    /*
     AVMediaSelectionOption
     
     An object that represents a specific option for the presentation of
     media within a group of options.
     */
    
    /**
     Managing Media Types
     */
    AVMediaSelectionOption *selectionOption = nil;
//    selectionOption.mediaType
//    selectionOption.mediaSubTypes
//    selectionOption hasMediaCharacteristic:<#(nonnull AVMediaCharacteristic)#>
    
    /**
     Managing Metadata
     */
//    selectionOption.commonMetadata
//    selectionOption.availableMetadataFormats
//    selectionOption metadataForFormat:<#(nonnull NSString *)#>
    
    /**
     Getting the Selection Playable Status
     */
//    selectionOption.playable
    
    /**
     Getting the Language and Locale Settings
     */
//    selectionOption.displayName
//    selectionOption displayNameWithLocale:<#(nonnull NSLocale *)#>
//    selectionOption.locale
//    selectionOption.extendedLanguageTag
    
    /**
     Getting the Property List
     */
//    selectionOption.propertyList
    
    /**
     Getting the Associated Media Selection Option
     */
//    selectionOption associatedMediaSelectionOptionInMediaSelectionGroup:<#(nonnull AVMediaSelectionGroup *)#>
    
    
    /*
     AVMutableMediaSelection
     
     A mutable object that represents a complete rendition of media selection
     options on an asset.
     */
    
    /**
     Selecting Media Options
     */
    AVMutableMediaSelection *mutableMediaSelection = nil;
//    mediaSelection selectedMediaOptionInMediaSelectionGroup:<#(nonnull AVMediaSelectionGroup *)#>
    
    
#pragma mark -- Content Key Decryption
    
    /*
     AVContentKeyRequest
     
     An object that encapsulates information about a content decryption
     key request issued from a content key session object.
     */
    
    /**
     Getting Content Key Request Data
     */
    AVContentKeyRequest *keyRequest = nil;
//    keyRequest makeStreamingContentKeyRequestDataForApp:<#(nonnull NSData *)#> contentIdentifier:<#(nullable NSData *)#> options:<#(nullable NSDictionary<NSString *,id> *)#> completionHandler:<#^(NSData * _Nullable contentKeyRequestData, NSError * _Nullable error)handler#>
//    AVContentKeyRequestProtocolVersionsKey
    
    /**
     Responding to the Content Key Request
     */
//    keyRequest respondByRequestingPersistableContentKeyRequestAndReturnError:<#(NSError *__autoreleasing  _Nullable * _Nullable)#>
//    keyRequest processContentKeyResponse:<#(nonnull AVContentKeyResponse *)#>
//    keyRequest processContentKeyResponseError:<#(nonnull NSError *)#>
    
    /**
     Getting Content Key Request Properties
     */
//    keyRequest.identifier
//    keyRequest canProvidePersistableContentKey
//    keyRequest.error
//    keyRequest.initializationData
//    keyRequest.renewsExpiringResponseData
//    keyRequest.status
    
    
    /*
     AVContentKeyResponse
     
     An object that encapsulates information about a response
     to a content decryption key request.
     */
    
    /**
     Creating New Content Key Responses
     */
//    AVContentKeyResponse contentKeyResponseWithAuthorizationTokenData:<#(nonnull NSData *)#>
//    AVContentKeyResponse contentKeyResponseWithFairPlayStreamingKeyResponseData:<#(nonnull NSData *)#>
//    AVContentKeyResponse contentKeyResponseWithClearKeyData:<#(nonnull NSData *)#> initializationVector:<#(nullable NSData *)#>
    
    
    /*
     AVContentKeySession
     
     An object used to create and track decryption keys for media data.
     */
    
    /**
     Creating New Content Key Sessions
     */
//    AVContentKeySession contentKeySessionWithKeySystem:<#(nonnull AVContentKeySystem)#>
//    AVContentKeySession contentKeySessionWithKeySystem:<#(nonnull AVContentKeySystem)#> storageDirectoryAtURL:<#(nonnull NSURL *)#>
    
    /**
     Initializing the Content Key Request Process
     */
    AVContentKeySession *keySession = nil;
//    keySession setDelegate:<#(nullable id<AVContentKeySessionDelegate>)#> queue:<#(nullable dispatch_queue_t)#>
//    keySession.delegate
//    keySession.delegateQueue
//    keySession addContentKeyRecipient:<#(nonnull id<AVContentKeyRecipient>)#>
//    keySession.contentKeyRecipients
//    keySession processContentKeyRequestWithIdentifier:<#(nullable id)#> initializationData:<#(nullable NSData *)#> options:<#(nullable NSDictionary<NSString *,id> *)#>
    
    /**
     Updating Content Key Requests
     */
//    keySession renewExpiringResponseDataForContentKeyRequest:<#(nonnull AVContentKeyRequest *)#>
//    keySession makeSecureTokenForExpirationDateOfPersistableContentKey:<#(nonnull NSData *)#> completionHandler:<#^(NSData * _Nullable secureTokenData, NSError * _Nullable error)handler#>
//    keySession.contentProtectionSessionIdentifier
    
    /**
     Ending a Content Key Request Process
     */
//    keySession.expire
//    keySession removeContentKeyRecipient:<#(nonnull id<AVContentKeyRecipient>)#>
     
    /**
     Handling Expired Session Reports
     */
//    AVContentKeySession pendingExpiredSessionReportsWithAppIdentifier:<#(nonnull NSData *)#> storageDirectoryAtURL:<#(nonnull NSURL *)#>
//    AVContentKeySession removePendingExpiredSessionReports:<#(nonnull NSArray<NSData *> *)#> withAppIdentifier:<#(nonnull NSData *)#> storageDirectoryAtURL:<#(nonnull NSURL *)#>
//    keySession.storageURL
    
    
    /*
     AVPersistableContentKeyRequest
     
     An object that encapsulate information about a persistable content
     decryption key request issued from a content key session.
     
     This class allows clients to create and use persistable content keys.
     */
    
    /**
     Requesting Persistable Content Key Data
     */
    AVPersistableContentKeyRequest *persistableKeyRequset = nil;
//    persistableKeyRequset persistableContentKeyFromKeyVendorResponse:<#(nonnull NSData *)#> options:<#(nullable NSDictionary<NSString *,id> *)#> error:<#(NSError * _Nullable __autoreleasing * _Nullable)#>
    
    
    
#pragma mark -- Error
    
    /*
     AVErrorDeviceKey
     AVErrorDiscontinuityFlagsKey
     AVErrorFileSizeKey
     AVErrorFileTypeKey
     AVErrorMediaSubTypeKey
     AVErrorMediaTypeKey
     AVErrorPIDKey
     AVErrorPersistentTrackIDKey
     AVErrorPresentationTimeStampKey
     AVErrorRecordingSuccessfullyFinishedKey
     AVErrorTimeKey
     AVFoundationErrorDomain
     AVError
     */
    
    
}



#pragma mark --

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"status"]) {
        int statusNumber = [change[@"new"] numberValue].intValue;
        
        switch (statusNumber) {
            case 1:
            {
                //Player Item is ready to play.
            }
                break;
                
            case 2:
            {
                // Player item failed. See error.
            }
                break;
            case 0:
            {
                // Player Item is not yet ready.
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
