//
//  AudioController.m
//  VideoProcess
//
//  Created by tigerfly on 2020/10/15.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "AudioController.h"

@interface AudioController ()<AVAudioRecorderDelegate>

@end

@implementation AudioController {
    
    AVAudioSession *_audioSession;
    AVAudioRecorder *_audioRecorder;
    AVAudioPlayer *_audioPlayer;
    NSURL *_recordURL;
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVAudioSessionRouteChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVAudioSessionInterruptionNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVAudioSessionMediaServicesWereLostNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVAudioSessionMediaServicesWereResetNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVAudioSessionSilenceSecondaryAudioHintNotification object:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"开始录音" style:UIBarButtonItemStyleDone target:self action:@selector(start)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"结束录音" style:UIBarButtonItemStyleDone target:self action:@selector(end)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(20, 100, 40, 20);
    [button setTitle:@"play" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(player) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    /*
     Play, record, and process audio; configure your app's
     system audio behavior.
     */
    
    
    
#pragma mark -- System Audio
    
    /*
     AVAudioSession
     
     An object that communicates to the system how you
     intend to use audio in your app.
     
     An audio session acts as an intermediary between your app
     and the operating system -- and, in turn, the underlying audio
     hardware. You use an audio session to communicate to the
     operating system the general nature of your app's audio
     without detailing the specific behavior or required interactions
     with the audio hardware. You delegate the management of those
     details to the audio session, which ensures that the operating
     system can best manage the user's audio experience.
     
     All iOS, tvOS, and watchOS apps have a default audio session
     that comes preconfigured with the following behavior:
     •  In iOS, setting the Ring/Silent switch to silent mode
     silences any audio the app is playing.
     •  In iOS, locking a device silences the app’s audio.
     •  When the app plays audio, it silences any other background audio.
     
     Although the default audio session provides useful behavior, it
     generally doesn't provide the audio behavior a media app needs.
     To change the default behavior, you configure your app's
     audio session category.
     
     There are seven possible categories you can use, but
     AVAudioSessionCategoryPlayback is the one that playback
     apps most commonly use. This category indicates that audio
     playback is a central feature of your app. When the Ring/Silent
     switch set to silent mode(iOS only). Using this category,
     you can also play background audio if you're using the audio,
     AirPlay, and Picture in Picture background mode.
     
     You use an AVAudioSession object to configure your app’s audio
     session. This class is a singleton object used to set the audio
     session’s category, mode, and other configurations. You can
     interact with the audio session throughout your app’s life
     cycle, but it’s often useful to perform this configuration
     at app launch, as shown in the following example.
     ====================================================================
     func application(_ application: UIApplication,
     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
     
     // Get the singleton instance.
     let audioSession = AVAudioSession.sharedInstance()
     do {
     // Set the audio session category, mode, and options.
     try audioSession.setCategory(.playback, mode: .moviePlayback, options: [])
     } catch {
     print("Failed to set audio session category.")
     }
     
     // Other post-launch configuration.
     return true
     }
     ====================================================================
     
     The audio session uses this configuration when you activate the
     session using the setActive:error: or setActive:withOptions:error: method.
     
     ⚠️ You can activate the audio session at any time after setting
     its category, but it’s generally preferable to defer this call
     until your app begins audio playback. Deferring the call ensures
     that you won’t prematurely interrupt any other background audio
     that may be in progress.
     */
    
    /**
     Getting the Audio Session
     
     + sharedInstance
     Returns the shared audio session instance.
     */
    _audioSession = [AVAudioSession sharedInstance];
    
    
    /**
     Configuring the Audio Session
     
     category
     The current audio session category.
     
     - setCategory:error:
     Sets the audio session’s category.
     
     availableCategories
     The audio session categories available on the current device.
     
     AVAudioSessionCategory
     Audio session category identifiers.
     
     categoryOptions
     The set of options associated with the current audio session
     category.
     
     - setCategory:withOptions:error:
     Sets the audio session’s category with the specified options.
     
     AVAudioSessionCategoryOptions
     Constants that specify optional audio behaviors.
     
     mode
     The current audio session’s mode.
     
     - setMode:error:
     Sets the audio session’s mode.
     
     - setCategory:mode:options:error:
     Sets the audio session’s category, mode, and options.
     
     availableModes
     The audio session modes available on the device.
     
     AVAudioSessionMode
     Audio session mode identifiers.
     
     routeSharingPolicy
     The current route-sharing policy.
     
     - setCategory:mode:routeSharingPolicy:options:error:
     Sets the session category, mode, route-sharing policy, and options.
     
     AVAudioSessionRouteSharingPolicy
     Cases that indicate the possible route-sharing policies for an audio session.
     */
    NSError *error = nil;
    //    [_audioSession setCategory:AVAudioSessionCategoryRecord error:&error];
    //
    
    /**
     Activating the Audio Session
     
     - setActive:error:
     Activates or deactivates your app’s audio session.
     
     - setActive:withOptions:error:
     Activates or deactivates your app’s audio session using the specified options.
     
     - activateWithOptions:completionHandler:
     Activates an audio session asynchronously on watchOS.
     
     AVAudioSessionActivationOptions
     Constants that describe the options to pass when activating
     the audio session.
     */
    [_audioSession setActive:YES error:NULL];
    
    
    /**
     Requesting Permission to Record
     
     recordPermission
     The current recording permission status.
     
     - requestRecordPermission:
     Requests the user’s permission to record audio.
     */
    if (_audioSession.recordPermission != AVAudioSessionRecordPermissionGranted) {
        [_audioSession requestRecordPermission:^(BOOL granted) {
            if (granted == true) {
                NSLog(@"授权成功");
            }
        }];
    }
    
    
    /**
     Mixing with Other Audio
     
     otherAudioPlaying
     A Boolean value that indicates whether another app is playing audio.
     
     secondaryAudioShouldBeSilencedHint
     A Boolean value that indicates whether another app, with a nonmixable
     audio session, is playing audio.
     
     allowHapticsAndSystemSoundsDuringRecording
     A Boolean value that indicates whether system sounds and haptics
     play while recording from audio input.
     
     - setAllowHapticsAndSystemSoundsDuringRecording:error:
     Sets a Boolean value that indicates whether system sounds and
     haptics play while recording from audio input.
     
     promptStyle
     A hint to audio sessions that use voice prompt mode to alter the
     type of prompts they issue in response to other system audio,
     such as Siri and phone calls.
     
     AVAudioSessionPromptStyle
     Constants that indicate the prompt style to use.
     */
    NSLog(@"otherAudioPlaying %d",_audioSession.otherAudioPlaying);
    NSLog(@"secondaryAudioShouldBeSilencedHint %d",_audioSession.secondaryAudioShouldBeSilencedHint);
    if (@available(iOS 13.0, *)) {
        NSLog(@"allowHapticsAndSystemSoundsDuringRecording %d",_audioSession.allowHapticsAndSystemSoundsDuringRecording);
    } else {
        // Fallback on earlier versions
    }
    if (@available(iOS 13.0, *)) {
        NSLog(@"promptStyle %lu",(unsigned long)_audioSession.promptStyle);
    } else {
        // Fallback on earlier versions
    }
    
    
    
    /**
     Responding to Audio Session Interruptions
     
     Observe audio session notifications to ensure that your
     app responds appropriately to interruptions.
     
     Interruptions are a common part of the iOS and watchOS user
     experiences. For example, consider the case of receiving a
     phone call while you’re watching a movie in the TV app on
     your iPhone. In this scenario, the movie’s audio fades out,
     playback pauses, and the sound of the call’s ringtone fades
     in. If you decline the call, control returns to the TV app,
     and playback begins again as the movie’s audio fades in.
     
     At the center of this behavior is your app’s audio session.
     As interruptions begin and end, the audio session notifies
     any registered observers so they can take appropriate action.
     For example, AVPlayer monitors your app’s audio session and
     automatically pauses and resumes playback in response to
     interruption events. You can observe these changes by
     key-value observing the player’s rate property and updating
     your user interface as needed when the player pauses and
     resumes playback.
     
     ===Observe Interruptions
     You can directly observe interruption notifications posted
     by AVAudioSession. This might be useful if you’d like to
     know if the system paused playback due to an interruption
     or another reason, such as a route change. To observe audio
     interruptions, begin by registering to observe notifications
     of type AVAudioSessionInterruptionNotification.
     ===========================================================
     func setupNotifications() {
     // Get the default notification center instance.
     let nc = NotificationCenter.default
     nc.addObserver(self,
     selector: #selector(handleInterruption),
     name: AVAudioSession.interruptionNotification,
     object: nil)
     }
     
     @objc func handleInterruption(notification: Notification) {
     // To be implemented.
     }
     ===========================================================
     
     ===Respond to Interruptions
     The posted Notification object contains a populated
     user-information dictionary providing the details of
     the interruption. You determine the type of interruption
     by retrieving the AVAudioSessionInterruptionType value
     from the userInfo dictionary. The interruption type indicates
     whether the interruption has begun or ended.
     ===========================================================
     @objc func handleInterruption(notification: Notification) {
     guard let userInfo = notification.userInfo,
     let typeValue = userInfo[AVAudioSessionInterruptionTypeKey] as? UInt,
     let type = AVAudioSession.InterruptionType(rawValue: typeValue) else {
     return
     }
     
     // Switch over the interruption type.
     switch type {
     
     case .began:
     // An interruption began. Update the UI as needed.
     
     case .ended:
     // An interruption ended. Resume playback, if appropriate.
     
     guard let optionsValue = userInfo[AVAudioSessionInterruptionOptionKey] as? UInt else { return }
     let options = AVAudioSession.InterruptionOptions(rawValue: optionsValue)
     if options.contains(.shouldResume) {
     // Interruption ended. Playback should resume.
     } else {
     // Interruption ended. Playback should not resume.
     }
     
     default: ()
     }
     }
     ===========================================================
     
     If the interruption type is AVAudioSessionInterruptionTypeEnded,
     the userInfo dictionary contains an AVAudioSessionInterruptionOptions
     value, which you use to determine if playback should automatically
     resume.
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleInterruption:) name:AVAudioSessionInterruptionNotification object:nil];
    
    
    /**
     Responding to Audio Session Route Changes
     
     Observe audio session notifications to ensure that your app
     responds appropriately to route changes.
     
     An important responsibility of AVAudioSession is managing audio
     route changes. A route change occurs when the system adds
     or removes an audio input or output. Route changes occur for
     several reasons, including a user plugging in a pair of headphones,
     connecting a bluetooth LE headset, or unplugging a USB audio
     interface. When these changes occur, the audio session reroutes
     audio signals accordingly and broadcasts a notification containing
     the details of the change to any registered observers.
     
     An important behavior related to route changes occurs when a
     user plugs in or removes a pair of headphones (see Audio in
     iOS Human Interface Guidelines). When users connect a pair of
     wired or wireless headphones, they’re implicitly indicating
     that audio playback should continue, but privately. They expect
     an app that’s currently playing media to continue playing
     without pause. However, when users disconnect their headphones,
     they don’t want to automatically share what they’re listening
     to with others. Applications should respect this implicit
     privacy request and automatically pause playback when users
     disconnect their headphones.
     
     ⚠️ AVPlayer monitors your app’s audio session and responds
     appropriately to route changes. When users connect headphones,
     playback continues as expected. When they disconnect their
     headphones, playback is automatically paused. To observe this
     player behavior, key-value observe the player’s rate property
     so that you can update your user interface as the player pauses
     playback.
     
     ===Observe Route Changes
     You can directly observe route change notifications posted by
     the audio session. This might be useful if you want the system
     to notify you when a user connects headphones so you can
     present an icon or message in the player interface.
     
     To observe audio route changes, begin by registering to observe
     notifications of type AVAudioSessionRouteChangeNotification.
     ============================================================
     func setupNotifications() {
     // Get the default notification center instance.
     let nc = NotificationCenter.default
     nc.addObserver(self,
     selector: #selector(handleRouteChange),
     name: AVAudioSession.routeChangeNotification,
     object: nil)
     }
     
     @objc func handleRouteChange(notification: Notification) {
     // To be implemented.
     }
     ============================================================
     
     ===Respond to Route Changes
     
     The posted Notification object contains a populated user-information
     dictionary providing the details of the route change. Determine
     the reason for this change by retrieving the
     AVAudioSessionRouteChangeReason value from the dictionary.
     When a user connects a new device, the reason is
     AVAudioSessionRouteChangeReasonNewDeviceAvailable, and when a
     user removes a device, the reason is
     AVAudioSessionRouteChangeReasonOldDeviceUnavailable.
     
     When a new device becomes available, you ask the audio session
     for its currentRoute to determine where the audio output is
     currently routed. This query returns an
     AVAudioSessionRouteDescription object that lists all of the
     audio session’s inputs and outputs. When the user removes a
     device, you retrieve the route description for the previous
     route from the user-information dictionary. In both cases,
     you query the route description for its outputs, which
     returns an array of port description objects providing
     the details of the audio output routes.
     
     ============================================================
     @objc func handleRouteChange(notification: Notification) {
     guard let userInfo = notification.userInfo,
     let reasonValue = userInfo[AVAudioSessionRouteChangeReasonKey] as? UInt,
     let reason = AVAudioSession.RouteChangeReason(rawValue: reasonValue) else {
     return
     }
     
     // Switch over the route change reason.
     switch reason {
     
     case .newDeviceAvailable: // New device found.
     let session = AVAudioSession.sharedInstance()
     headphonesConnected = hasHeadphones(in: session.currentRoute)
     
     case .oldDeviceUnavailable: // Old device removed.
     if let previousRoute =
     userInfo[AVAudioSessionRouteChangePreviousRouteKey] as? AVAudioSessionRouteDescription {
     headphonesConnected = hasHeadphones(in: previousRoute)
     }
     
     default: ()
     }
     }
     
     func hasHeadphones(in routeDescription: AVAudioSessionRouteDescription) -> Bool {
     // Filter the outputs to only those with a port type of headphones.
     return !routeDescription.outputs.filter({$0.portType == .headphones}).isEmpty
     }
     ============================================================
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleRouteChange:) name:AVAudioSessionRouteChangeNotification object:nil];
    
    
    
    /**
     Responding to Audio Session Notifications
     
     A notification that’s posted when an audio interruption occurs.
     
     The notification’s user-information dictionary contains the
     AVAudioSessionInterruptionTypeKey key. If the interruption
     type is AVAudioSessionInterruptionTypeBegan, the system
     interrupted your app’s audio session and it’s no longer
     active. If the interruption type is AVAudioSessionInterruptionTypeEnded,
     this dictionary also contains the AVAudioSessionInterruptionOptionKey key.
     
     See Responding to Audio Session Interruptions for more information
     on using this notification.
     
     The system posts this notification on the main thread.
     
     ⚠️ Starting in iOS 10, the system deactivates an app’s audio
     session when it suspends the app process. When the app starts
     running again, it receives an interruption notification that
     the system has deactivated its audio session. This notification
     is necessarily delayed in time because the system can only
     deliver it once the app is running again. If the system suspended
     your app’s audio session for this reason, the user-information
     dictionary contains the AVAudioSessionInterruptionWasSuspendedKey
     key with a value of YES.
     
     If you configured your audio session to be nonmixable (the default
     behavior for the AVAudioSessionCategoryPlayback,
     AVAudioSessionCategoryPlayAndRecord, AVAudioSessionCategorySoloAmbient,
     and AVAudioSessionCategoryMultiRoute categories), deactivate your
     audio session if you’re not actively using audio when you go into
     the background. Doing so avoids having your audio session
     deactivated by the system (and receiving this somewhat
     confusing notification).
     */
    
    
    /**
     AVAudioSessionRouteChangeNotification
     
     A notification that’s posted when the system’s audio route changes.
     
     The userInfo dictionary of this notification contains the
     AVAudioSessionRouteChangeReasonKey and AVAudioSessionRouteChangePreviousRouteKey
     keys, which provide information about the route change.
     
     See Responding to Audio Session Route Changes for more information
     on using this notification.
     
     The system posts this notification on a secondary thread.
     */
    
    
    /**
     AVAudioSessionSilenceSecondaryAudioHintNotification
     
     A notification that’s posted when the primary audio from
     other applications starts and stops.
     
     Subscribe to this notification to ensure that the system notifies
     your app when optional secondary audio muting should begin or
     end. The system sends this notification only to registered
     listeners who are currently in the foreground and have an
     active audio session.
     
     This notification’s userInfo dictionary contains a
     AVAudioSessionSilenceSecondaryAudioHintType value for the
     AVAudioSessionSilenceSecondaryAudioHintTypeKey. Use the audio
     hint type to determine if your secondary audio muting should begin
     or end.
     =======================================================
     func handleSecondaryAudio(notification: Notification) {
     // Determine hint type
     guard let userInfo = notification.userInfo,
     let typeValue = userInfo[AVAudioSessionSilenceSecondaryAudioHintTypeKey] as? UInt,
     let type = AVAudioSession.SilenceSecondaryAudioHintType(rawValue: typeValue) else {
     return
     }
     
     if type == .begin {
     // Other app audio started playing - mute secondary audio.
     } else {
     // Other app audio stopped playing - restart secondary audio.
     }
     }
     =======================================================
     
     The system posts this notification on the main thread.
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleSecondaryAudio:) name:AVAudioSessionSilenceSecondaryAudioHintNotification object:nil];
    
    
    /**
     AVAudioSessionMediaServicesWereLostNotification
     
     A notification that’s posted when the system terminates the media server.
     
     The system posts this notification when the media server
     first becomes unavailable. Most apps don’t need to subscribe
     to this notification and should instead subscribe to the
     AVAudioSessionMediaServicesWereResetNotification notification.
     However, you can use this notification as a cue to take any
     appropriate steps to handle requests that come in before the
     server restarts.
     
     This notification has no userInfo dictionary.
     
     The system posts this notification on the main thread.
     */
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleMediaServicesWereLost:) name:AVAudioSessionMediaServicesWereLostNotification object:nil];
    
    
    /**
     AVAudioSessionMediaServicesWereResetNotification
     
     A notification that’s posted when the media server restarts.
     
     Under rare circumstances, the system terminates and restarts
     its media services daemon. Respond to these events by
     reinitializing your app’s audio objects (such as players,
     recorders, converters, or audio queues) and resetting your
     audio session’s category, options, and mode configuration.
     Your app shouldn’t restart its media playback, recording,
     or processing until initiated by user action.
     
     ⚠️ You can trigger a media server reset by choosing
     the “Reset Media Services” selection under the Developer
     menu in the iOS Settings app. Using this utility helps to
     ensure that your app responds appropriately if media
     services were reset.
     
     This notification has no userInfo dictionary.
     
     The system posts this notification on the main thread.
     
     ⚠️ Apps don’t need to reregister for any audio session
     notifications and don’t need to reset key-value observers
     on audio session properties after a media services reset.
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mediaServiceWereReset:) name:AVAudioSessionMediaServicesWereResetNotification object:nil];
    
    
    /**
     Working with Audio Routes
     
     currentRoute
     A description of the current audio route’s input and output ports.
     
     AVAudioSessionRouteDescription
     An object that describes the input and output ports associated
     with a session’s audio route.
     
     inputAvailable
     A Boolean value that indicates whether an audio input path is available.
     
     availableInputs
     An array of input ports available for audio routing.
     
     preferredInput
     The preferred input port for audio routing.
     
     - setPreferredInput:error:
     Sets the preferred input port for audio routing.
     
     AVAudioSessionPortDescription
     Information about the capabilities of the port and the hardware
     channels it supports.
     
     inputDataSource
     The currently selected input data source.
     
     inputDataSources
     An array of available data sources for the audio session’s
     current input port.
     
     - setInputDataSource:error:
     Selects a data source for the audio session’s current input port.
     
     outputDataSources
     An array of available output data sources for the current audio route.
     
     outputDataSource
     The currently selected output data source.
     
     - setOutputDataSource:error:
     Sets the output data source for an audio session.
     
     AVAudioSessionDataSourceDescription
     An object that defines a data source for an audio input or
     output, giving information such as the source’s name, location,
     and orientation.
     
     - overrideOutputAudioPort:error:
     Temporarily changes the current audio route.
     */
    NSLog(@"currentRoute %@",_audioSession.currentRoute);
    NSLog(@"inputAvailable %d",_audioSession.inputAvailable);
    NSLog(@"availableInputs %@",_audioSession.availableInputs);
    NSLog(@"preferredInput %@",_audioSession.preferredInput);
    NSLog(@"inputDataSource %@",_audioSession.inputDataSource);
    NSLog(@"inputDataSources %@",_audioSession.inputDataSources);
    NSLog(@"outputDataSources %@",_audioSession.outputDataSources);
    NSLog(@"outputDataSource %@",_audioSession.outputDataSource);
    NSError *volumError = nil;
      [[AVAudioSession sharedInstance] overrideOutputAudioPort:AVAudioSessionPortOverrideSpeaker error:&volumError];
      if (volumError) {
          NSLog(@"音量控制失败 --- ");
          NSLog(@"%@", volumError);
      }
    
    /**
     Preparing the Playback Route
     
     - prepareRouteSelectionForPlaybackWithCompletionHandler:
     Prepares the route selection for long-form video playback.
     
     AVAudioSessionRouteSelection
     Constants used to define the active route selection.
     */
    
    
    /**
     Enabling Stereo Recording
     
     inputOrientation
     An orientation value that dictates which directions represent left
     and right when capturing audio from a built-in microphone configured
     for stereo recording.
     
     preferredInputOrientation
     The audio session’s preferred stereo input orientation.
     
     - setPreferredInputOrientation:error:
     Sets the audio session’s preferred stereo input orientation.
     
     AVAudioStereoOrientation
     Constants that define the supported stereo orientations.
     */
    
    
    /**
     Working with Audio Channels
     
     inputNumberOfChannels
     The number of audio input channels for the current route.
     
     maximumInputNumberOfChannels
     The maximum number of input channels available for the current audio route.
     
     preferredInputNumberOfChannels
     The preferred number of input channels for the current route.
     
     - setPreferredInputNumberOfChannels:error:
     Sets the preferred number of input channels for the current route.
     
     outputNumberOfChannels
     The number of audio output channels.
     
     maximumOutputNumberOfChannels
     The maximum number of output channels available for the current audio route.
     
     preferredOutputNumberOfChannels
     The preferred number of output channels for the current route.
     
     - setPreferredOutputNumberOfChannels:error:
     Sets the preferred number of output channels for the current route.
     */
    NSLog(@"inputNumberOfChannels %ld",(long)_audioSession.inputNumberOfChannels);
    NSLog(@"maximumInputNumberOfChannels %ld",(long)_audioSession.maximumInputNumberOfChannels);
    NSLog(@"preferredInputNumberOfChannels %ld",(long)_audioSession.preferredInputNumberOfChannels);
    NSLog(@"outputNumberOfChannels %ld",(long)_audioSession.outputNumberOfChannels);
    NSLog(@"maximumOutputNumberOfChannels %ld",(long)_audioSession.maximumOutputNumberOfChannels);
    NSLog(@"preferredOutputNumberOfChannels %ld",(long)_audioSession.preferredOutputNumberOfChannels);
    
    
    /**
     Working with Audio Device Settings
     
     inputGain
     The gain applied to inputs associated with the session.
     
     inputGainSettable
     A Boolean value that indicates whether you can set the input gain.
     
     - setInputGain:error:
     Changes the input gain to the specified value.
     
     outputVolume
     The systemwide output volume set by the user.
     
     sampleRate
     The current audio sample rate, in hertz.
     
     preferredSampleRate
     The preferred sample rate, in hertz.
     
     - setPreferredSampleRate:error:
     Sets the preferred sample rate for audio input and output.
     
     inputLatency
     The latency for audio input, in seconds.
     
     outputLatency
     The latency for audio output, in seconds.
     
     IOBufferDuration
     The current I/O buffer duration, in seconds.
     
     preferredIOBufferDuration
     The preferred I/O buffer duration, in seconds.
     
     - setPreferredIOBufferDuration:error:
     Sets the preferred audio I/O buffer duration.
     */
    NSLog(@"inputGain %f",_audioSession.inputGain);
    NSLog(@"inputGainSettable %d",_audioSession.inputGainSettable);
    NSLog(@"outputVolume %f",_audioSession.outputVolume);
    NSLog(@"sampleRate %f",_audioSession.sampleRate);
    NSLog(@"preferredSampleRate %f",_audioSession.preferredSampleRate);
    NSLog(@"inputLatency %f",_audioSession.inputLatency);
    NSLog(@"outputLatency %f",_audioSession.outputLatency);
    NSLog(@"IOBufferDuration %f",_audioSession.IOBufferDuration);
    NSLog(@"preferredIOBufferDuration %f",_audioSession.preferredIOBufferDuration);
    
    
    /**
     Setting the Aggregated I/O Preference
     
     - setAggregatedIOPreference:error:
     Sets the audio session’s aggregated I/O configuration preference.
     
     AVAudioSessionIOType
     Constant values used to specify the audio session’s aggregated I/O behavior.
     */
    
    
    /**
     Errors
     
     AVAudioSessionErrorCode
     Codes that describe error conditions that may occur when
     performing audio session operations.
     */
    
    
    
    
#pragma mark -- Basic Playback and Recording
    
    /*
     AVAudioPlayer
     
     An audio player that provides playback of audio data
     from a file or memory.
     
     Use this class for audio playback unless you’re playing audio
     captured from a network stream or require very low I/O latency.
     
     Using an audio player you can:
     •  Play sounds of any duration
     •  Play sounds from files or memory buffers
     •  Loop sounds
     •  Play multiple sounds simultaneously, one sound per audio
        player, with precise synchronization
     •  Control relative playback level, stereo positioning,
        and playback rate for each sound you’re playing
     •  Seek to a particular point in a sound file, which supports
        such application features as fast forward and rewind
     •  Obtain data you can use for playback-level metering
     
     This class lets you play sound in any audio format available in
     iOS and macOS. You implement a delegate to handle interruptions
     (such as an incoming phone call on iOS) and to update the user
     interface when a sound has finished playing. The delegate
     methods are described in AVAudioPlayerDelegate.
     
     To play, pause, or stop an audio player, call one of its
     playback control methods, described in Controlling Playback.
     
     This class uses the Objective-C declared properties feature
     for managing information about a sound, such as the playback
     point within the sound’s timeline, and for accessing playback
     options, such as volume and looping.
     
     To configure an appropriate audio session for playback on
     iOS, see AVAudioSession and AVAudioSessionDelegate.
     */
    
    
    /**
     Creating an Audio Player
     
     - initWithContentsOfURL:error:
     Creates an audio player for playing a designated sound file.
     
     - initWithContentsOfURL:fileTypeHint:error:
     Creates an audio player using the specified URL and file type hint.
     
     - initWithData:error:
     Creates an audio player for playing a designated memory buffer.
     
     - initWithData:fileTypeHint:error:
     Creates an audio player using the specified data and file type hint.
     */
    
    
    /**
     Controlling Playback
     
     currentTime
     The playback point, in seconds, within the timeline of the sound
     associated with the audio player.
     
     duration
     The total duration, in seconds, of the sound associated with the audio player.
     
     - prepareToPlay
     Prepares the audio player for playback by preloading its buffers.
     
     - play
     Plays a sound asynchronously.
     
     - playAtTime:
     Plays a sound asynchronously, starting at a specified point in the audio
     output device’s timeline.
     
     - pause
     Pauses playback; sound remains ready to resume playback from where it left off.
     
     - stop
     Stops playback and undoes the setup needed for playback.
     
     playing
     A Boolean value that indicates whether the audio player is playing (YES) or not (NO).
     
     numberOfLoops
     The number of times a sound will return to the beginning, upon reaching
     the end, to repeat playback.
     */
    
    
    /**
     Configuring Audio Settings
     
     - setVolume:fadeDuration:
     Fades to a new volume over a specific duration.
     
     volume
     The playback volume for the audio player, ranging from 0.0 through
     1.0 on a linear scale.
     
     pan
     The audio player’s stereo pan position.
     
     rate
     The audio player’s playback rate.
     
     enableRate
     A Boolean value that specifies whether playback rate adjustment
     is enabled for an audio player.
     */
    
    
    /**
     Using Audio Level Metering
     
     meteringEnabled
     A Boolean value that specifies the audio-level metering on/off state
     for the audio player.
     
     - updateMeters
     Refreshes the average and peak power values for all channels of
     an audio player.
     
     - averagePowerForChannel:
     Returns the average power for a given channel, in decibels, for the
     sound being played.
     
     - peakPowerForChannel:
     Returns the peak power for a given channel, in decibels, for the
     sound being played.
     */
    
    
    /**
     Responding to Player Events
     
     delegate
     The delegate object for the audio player.
     
     AVAudioPlayerDelegate
     A protocol that allows a delegate to respond to audio interruptions
     and audio decoding errors, and to the completion of a sound’s playback.
     */
    
    
    /**
     Managing Audio Channels
     
     numberOfChannels
     The number of audio channels in the sound associated with the audio player.
     
     channelAssignments
     An array of AVAudioSessionChannelDescription objects associated with
     the audio player
     */
    
    
    /**
     Accessing Device Information
     
     currentDevice
     The UID of the current audio player.
     
     deviceCurrentTime
     The time value, in seconds, of the audio output device.
     */
    
    
    /**
     Inspecting the Audio Data
     
     settings
     The audio player’s settings dictionary, containing information about
     the sound associated with the player.
     
     format
     The format of the audio in the buffer.
     
     url
     The URL for the sound associated with the audio player.
     
     data
     The data object containing the sound associated with the audio player.
     
     General Audio Format Settings
     Audio settings that apply to all audio formats handled by the
     AVAudioPlayer and AVAudioRecorder classes.
     */
    
    
    
    /*
     AVAudioRecorder
     
     An object that provides audio recording capabilities in your app.
     
     Using an audio recorder, you can:
     •  Record until the user stops the recording
     •  Record for a specified duration
     •  Pause and resume a recording
     •  Obtain input audio-level data that you can use to provide
        level metering
     
     In iOS, the audio being recorded comes from the device connected
     by the user—built-in microphone or headset microphone, for example.
     In macOS, the audio comes from the system’s default audio input
     device as set by a user in System Preferences.
     
     You can implement a delegate object for an audio recorder to
     respond to audio interruptions and audio decoding errors, and
     to the completion of a recording.
     
     To configure a recording, including options such as bit depth,
     bit rate, and sample rate conversion quality, configure the
     audio recorder’s settings dictionary. Use the settings keys
     described in Settings.
     
     To configure an appropriate audio session for recording,
     refer to AVAudioSession and AVAudioSessionDelegate.
     
     The AVAudioRecorder class is intended to allow you to make
     audio recordings with very little programming overhead.
     Other classes that can be used for recording audio in iOS
     and macOS include AVCaptureAudioDataOutput and the Audio
     Queue services described in the Audio Queue Services
     Programming Guide.
     
     In macOS, you can also use the AVCaptureAudioFileOutput
     class to record audio.
     */
    
    /**
     Creating an Audio Recorder
     
     - initWithURL:settings:error:
     Initializes and returns an audio recorder.
     
     - initWithURL:format:error:
     Initializes and returns an audio recorder.
     */
    NSString *writePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSURL *url = [NSURL fileURLWithPath:[writePath stringByAppendingFormat:@"/a"]];
    if (@available(iOS 11.0, *)) {
        _audioRecorder = [[AVAudioRecorder alloc] initWithURL:url settings:@{
        AVFormatIDKey: @(kAudioFormatMPEG4AAC),
        AVNumberOfChannelsKey: @2,
        AVLinearPCMBitDepthKey: @16,
        AVEncoderAudioQualityKey: @(AVAudioQualityHigh)
        } error:&error];
    } else {
        // Fallback on earlier versions
    }
    NSLog(@"audioRecordError === %@",error);
    
    
    /**
     Controlling Recording
     
     currentTime
     The time, in seconds, since the beginning of the recording.
     
     - prepareToRecord
     Creates an audio file and prepares the system for recording.
     
     - record
     Starts or resumes recording.
     
     - recordAtTime:
     Starts recording at a specific time.
     
     - recordForDuration:
     Records for a specified duration of time.
     
     - recordAtTime:forDuration:
     Starts recording at a specified time for a specified duration of time.
     
     - pause
     Pauses a recording.
     
     - stop
     Stops recording and closes the audio file.
     
     - deleteRecording
     Deletes a recorded audio file.
     
     recording
     A Boolean value that indicates whether the audio recorder is recording.
     */
    BOOL prepareResult = [_audioRecorder prepareToRecord];
    NSLog(@"prepareToRecord %d",prepareResult);
    
    
    /**
     Using Audio Level Metering
     
     meteringEnabled
     A Boolean value that indicates whether audio-level metering is enabled.
     
     - updateMeters
     Refreshes the average and peak power values for all channels of an
     audio recorder.
     
     - peakPowerForChannel:
     Returns the peak power for a given channel, in decibels, for the
     sound being recorded.
     
     - averagePowerForChannel:
     Returns the average power for a given channel, in decibels, for
     the sound being recorded.
     */
    //    NSLog(@"meteringEnabled %d",_audioRecorder.meteringEnabled);
    [_audioRecorder updateMeters];
    
    
    /**
     Responding to Recorder Events
     
     delegate
     The delegate object for the audio recorder.
     
     AVAudioRecorderDelegate
     The delegate of an audio recorder object.
     */
    _audioRecorder.delegate = self;
    
    
    /**
     Accessing Device Information
     
     deviceCurrentTime
     The time, in seconds, of the host device where the audio recorder
     is located.
     
     channelAssignments
     An array of AVAudioSessionChannelDescription objects associated
     with the recorder.
     */
    NSLog(@"deviceCurrentTime %f",_audioRecorder.deviceCurrentTime);
    NSLog(@"channelAssignments %@",_audioRecorder.channelAssignments);
    
    
    /**
     Inspecting the Audio Data
     
     url
     The URL for the audio file associated with the audio recorder.
     
     format
     The format of the audio in the buffer.
     
     settings
     The audio settings for the audio recorder.
     */
    
    
    
    /**
     Settings
     
     ==General Audio Format Settings==
     AVFormatIDKey
     A format identifier.
     
     AVSampleRateKey
     A sample rate, in hertz, expressed as an NSNumber floating point value.
     
     AVNumberOfChannelsKey
     The number of channels expressed as an NSNumber integer value.
     
     
     ==Encoder Settings==
     AVEncoderAudioQualityKey
     A constant from AVAudioQuality.
     
     AVEncoderBitRateKey
     An integer that identifies the audio bit rate.
     
     AVEncoderBitRatePerChannelKey
     An integer that identifies the audio bit rate per channel.
     
     AVEncoderBitRateStrategyKey
     An AVAudioBitRateStrategy constant.
     
     AVEncoderBitDepthHintKey
     An integer ranging from 8 through 32.
     
     
     ==AVEncoderBitRateStrategyKey Values ==
     AVAudioBitRateStrategy_Constant
     A constant rate strategy.
     
     AVAudioBitRateStrategy_LongTermAverage
     A long term average rate strategy.
     
     AVAudioBitRateStrategy_VariableConstrained
     A constrained variable rate strategy.
     
     AVAudioBitRateStrategy_Variable
     A variable rate strategy.
     
     
     ==AVSampleRateConverterAlgorithmKey Values==
     AVSampleRateConverterAlgorithm_Normal
     The normal encoder bit rate strategy.
     
     AVSampleRateConverterAlgorithm_Mastering
     The mastering encoder bit rate strategy.
     
     AVSampleRateConverterAlgorithm_MinimumPhase
     The minimum phase encoder bit rate strategy.
     */
    
    
    
    /*
     AVMIDIPlayer
     
     A player for music file formats like MIDI and iMelody.
     */
    
    /**
     Creating a MIDI Player
     
     - initWithContentsOfURL:soundBankURL:error:
     Initializes a newly allocated MIDI player with the contents of the
     file specified by the URL, using the specified sound bank.
     
     - initWithData:soundBankURL:error:
     Initializes a newly allocated MIDI player with the contents of
     the data object.
     */
    
    
    /**
     Controlling Playback
     
     - prepareToPlay
     Prepares to play the sequence by prerolling all events.
     
     - play:
     Plays the sequence.
     
     playing
     A Boolean value that indicates whether the sequence is playing.
     
     - stop
     Stops playing the sequence.
     
     rate
     The playback rate of the player.
     */
    
    /**
     Managing Timing
     
     duration
     The length of the currently loaded file, in seconds.
     
     currentPosition
     The current playback position, in seconds.
     */
    
    
    
#pragma mark -- Advanced Audio Processing
    
    /*
     Perform advanced realtime and offline audio processing.
     */
    
    
    
}

- (void)handleInterruption:(NSNotification *)notif {
    
    NSDictionary *userInfo = notif.userInfo;
    int value = [userInfo[@"AVAudioSessionInterruptionTypeKey"] intValue];
    switch (value) {
        case 0:
        {
            //the interruption has ended
            
        }
            break;
            
        case 1:
        {
            //the system has interrupted your audio session
        }
            break;
    }
}

- (void)handleRouteChange:(NSNotification *)notif {
    
    NSDictionary *userInfo = notif.userInfo;
    int value = [userInfo[@"AVAudioSessionRouteChangeReasonKey"] intValue];
    //    AVAudioSessionRouteChangeReasonUnknown = 0,
    //    AVAudioSessionRouteChangeReasonNewDeviceAvailable = 1,
    //    AVAudioSessionRouteChangeReasonOldDeviceUnavailable = 2,
    //    AVAudioSessionRouteChangeReasonCategoryChange = 3,
    //    AVAudioSessionRouteChangeReasonOverride = 4,
    //    AVAudioSessionRouteChangeReasonWakeFromSleep = 6,
    //    AVAudioSessionRouteChangeReasonNoSuitableRouteForCategory = 7,
    //    AVAudioSessionRouteChangeReasonRouteConfigurationChange = 8
    switch (value) {
        case 0:
        {
            //            AVAudioSessionRouteChangeReasonUnknown
        }
            break;
            
        case 1:
        {
            //            AVAudioSessionRouteChangeReasonNewDeviceAvailable
        }
            break;
            
        case 2:
        {
            //            AVAudioSessionRouteChangeReasonOldDeviceUnavailable
        }
            break;
        case 3:
        {
            //            AVAudioSessionRouteChangeReasonCategoryChange
        }
            break;
        case 4:
        {
            //            AVAudioSessionRouteChangeReasonOverride
        }
            break;
        case 6:
        {
            //            AVAudioSessionRouteChangeReasonWakeFromSleep
        }
            break;
        case 7:
        {
            //            AVAudioSessionRouteChangeReasonNoSuitableRouteForCategory
        }
            break;
        case 8:
        {
            //            AVAudioSessionRouteChangeReasonRouteConfigurationChange
        }
            break;
            
        default:
            break;
    }
}

- (void)handleSecondaryAudio:(NSNotification *)notif {
    
    NSDictionary *userInfo = notif.userInfo;
    int value = [userInfo[@"AVAudioSessionSilenceSecondaryAudioHintTypeKey"] intValue];
    switch (value) {
        case 0:
        {
            //            AVAudioSessionSilenceSecondaryAudioHintTypeBegin
            
        }
            break;
        case 1:
        {
            //            AVAudioSessionSilenceSecondaryAudioHintTypeEnd
            
        }
            break;
        default:
            break;
    }
}

- (void)handleMediaServicesWereLost:(NSNotification *)notif {
    
    
}

- (void)mediaServiceWereReset:(NSNotification *)notif {
    
    
}


#pragma mark --

/* audioRecorderDidFinishRecording:successfully: is called when a recording has been finished or stopped. This method is NOT called if the recorder is stopped due to an interruption. */
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag {
    NSLog(@"url %@",recorder.url);
    NSLog(@"format %@",recorder.format);
    NSLog(@"settings %@",recorder.settings);
    _recordURL = recorder.url;
}

/* if an error occurs while encoding it will be reported to the delegate. */
- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError * __nullable)error {
    
}


- (void)start {
    if (_audioRecorder.recording) {return;}
    BOOL recordResult = [_audioRecorder record];
    NSLog(@"开始录音%@",recordResult ? @"成功" : @"失败");
}

- (void)end {
    [_audioRecorder stop];
}


- (void) player {
    
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:_recordURL error:nil];
    _audioPlayer.volume = 1.0;
    _audioPlayer.rate = 1;
    _audioPlayer.enableRate = YES;
    BOOL prepareToPlay = [_audioPlayer prepareToPlay];
    NSLog(@"准备播放录音 %d",prepareToPlay);
    NSLog(@"录音时长 %f",_audioPlayer.duration);
    NSLog(@"格式 %@",_audioPlayer.format);

    [_audioPlayer play];
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
