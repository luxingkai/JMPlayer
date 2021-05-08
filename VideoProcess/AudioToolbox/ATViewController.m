//
//  ATViewController.m
//  VideoProcess
//
//  Created by tigerfly on 2020/10/15.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "ATViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface ATViewController ()

@end

@implementation ATViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    /**
     Audio Toolbox
     
     Record or play audio, convert formats, parse audio streams, and
     configure your audio session.
     
     The AudioToolbox framework provides interfaces for recording,
     playback and stream parsing. In iOS, the framework provides
     addtional interfaces for managing audio sessions.
     */
    
     
    
#pragma mark -- Inter-Device Audio and MIDI
    
    
    /*
     Set up your system to record digital audio from an iOS device and
     exchange MIDI data with it by enabling Inter-Device Audio and MIDI.
     
     Inter-Device and MIDI (IDAM) enables you to record digital audio
     from an iOS device without using special cables or an audio interface.
     It also lets you transmit MIDI messages between an iOS device and
     your Mac, which simplifies the configuration of an iOS sampler or
     synthesizer app as an external MIDI instrument. You enable these
     features by connecting an iOS device to your Mac using a standard
     Lightning cable and enabling IDAM in Audio MIDI Setup.
     
     ⚠️ You can enable IDAM on multiple iOS devices and use Audio MIDI
     Setup to aggregate them into a single logical input device.
     */
    
    /**
     Open Audio MIDI Setup
     
     Open the audio MIDI Setup app to configure your environment. You
     can find this app in the /Applications/Utilities directory.
     
     If the Audio Devices window doesn't automatically appear, open it
     by choosing Show Audio Devices from the Window menu.
     */
    
    /**
     Connect and Enable the Device
     
     Using a Lightning cable, connect an iOS device running iOS 11
     or later to your Mac. If this is the first time you've connected
     this device, the system displays a dialog asking if you should trust
     this computer to access your data. Click Trust in the dialog.
     
     Enable IDAM by clicking the Enable button next to the connected device.
     
     ⚠️ While an iOS device is configured to use IDAM, photo import and
     QuickTime capture are disabled. To restore these capabilities, disable
     IDAM by either clicking the Disable button next to the device in the
     Audio Devices window, or disconnecting the device from the Lightning
     cable.
     */
    
    /**
     View the audio Input
     
     After you're enabled your device, you'll see a new audio input in your
     device list. While the iOS device is this mode, application audio is output
     to the Mac's USB input. However, system audio, such as alarms and keyboard
     clicks, are not routed through this input.
     */
    
    /**
     Configure the MIDI Device
     
     Open the MIDI Studio window by choosing Show MIDI studio from the window
     menu. You'll see your newly enabled device, available for MIDI input and
     output.
     
     Double-click the MIDI device to show its properties. In the panel that
     opens, rename the device and configure its MIDI behavior as desired.
     */
    
    
    
#pragma mark -- Audio Units
    
    /*
     Audio Unit v3 Plug-Ins
     
     Deliver custom audio effects, instruments, and other audio hehaviors
     using an Audio Unit v3 app extension.
     */
    
    /**
     Update your Audio Unit(AU) host app to take advantage of the new feature
     and capabilities of AUv3.
     
     The latest Audio Unit standard, AUv3, provides a robust plug-in model
     built on app extensions. This model provides several benefits to host
     apps, including greater security and stability, multiple view configurations,
     and support for shared user presets.
     
     You can adopt the new API while still retaining your ability to host
     AUv2 audio units. The framework’s bridging layer enables this capability
     by automatically translating AUv3 calls into their AUv2 equivalents,
     which means you can use a single API and work with both new and legacy
     audio units.
     
     For a downloadable sample app that uses the core features of the AUv3
     API, see Incorporating Audio Effects and Instruments.

     The AVFoundation framework’s AVAudioUnitComponentManager class provides
     a convenient way to find audio components registered with the host
     system. You use it to search for audio units by description, predicate,
     or test case, and the component manager returns an array of
     AVAudioUnitComponent objects matching your search criteria. The
     following code example shows how to use each approach to find all
     audio effects available on the system.
     ==============================================
     // Access the singleton AVAudioUnitComponentManager instance.
     let manager = AVAudioUnitComponentManager.shared()

     // Retrieve audio unit components by description.
     let description = AudioComponentDescription(componentType: kAudioUnitType_Effect,
                                                 componentSubType: 0,
                                                 componentManufacturer: 0,
                                                 componentFlags: 0,
                                                 componentFlagsMask: 0)
     let componentsByDesc = manager.components(matching: description)


     // Retrieve audio unit components by predicate.
     let predicate = NSPredicate(format: "typeName CONTAINS 'Effect'")
     let componentsByPredicate = manager.components(matching: predicate)

     // Retrieve audio unit components by test.
     let componentsByTest = manager.components { component, _ in
         return component.typeName == AVAudioUnitTypeEffect
     }
     ==============================================

     Once you've found the list of available audio components, the
     next step is to instantiate the component you want to use. To
     instantiate the audio unit, use the AVAudioUnit class's instantiateWithComponentDescription:options:completionHandler:
     method as shown below.
     ==============================================
     func selectAudioUnit(at index: Int) {
         let description = components[index].audioComponentDescription
         
         // Instantiate using AVFoundation's AVAudioUnit class method.
         AVAudioUnit.instantiate(with: description, options: []) { avAudioUnit, error in
             guard error == nil else {
                 DispatchQueue.main.async {  Show error message to user.  }
                 return
             }
             
             // Audio unit successfully instantiated.
             // Connect it to AVAudioEngine to use.
         }
     }
     ==============================================
     ⚠️
     A key difference between the two audio unit API versions is that
     AUv2 audio units are loaded into the host's process, whereas AUv3
     audio units are loaded out-of-process by default. In macOS only,
     if supported by the AUv3 audio unit, you can request loading it
     in-process by passing the kAudioComponentInstantiation_LoadInProcess
     option in the options argument. To verify that the audio unit was
     successfully loaded in-process, query its isLoadedInProcess property.
     

     The way you interact with audio units using the AUv3 API differs
     from how you do so with the AUv2 API. With AUv2, you used C functions
     to operate on an audio unit. For example, the following code sets
     the maximum number of frames to render using the AUv2 API.
     ==============================================
     // Get the underlying AudioUnit instance.
     let audioUnit = avAudioUnit.audioUnit
     var maxFrames = UInt32(4096)

     // Set the maximum frames to render.
     AudioUnitSetProperty(audioUnit,
                          kAudioUnitProperty_MaximumFramesPerSlice,
                          kAudioUnitScope_Global,
                          0,
                          &maxFrames,
                          UInt32(MemoryLayout<UInt32>.size))
     ==============================================
     In comparison, the AUv3 API provides a more natural interface that
     enables you to interact directly with the audio unit instance by
     calling its properties and methods. Using the AUv3 API, you set the
     maximum number of frames to render as shown below.
     ==============================================
     // Get the underlying AUAudioUnit instance.
     let audioUnit = avAudioUnit.auAudioUnit
     audioUnit.maximumFramesToRender = 4096
     ==============================================

     To present the audio unit's user interface, call its
     requestViewControllerWithCompletionHandler: method. This method
     asynchronously retrieves the audio unit's view controller instance
     and returns it in a callback closure. The callback is invoked on
     a background thread, so you need to dispatch control back to the
     main queue before adding the audio unit’s user interface into your
     app’s view hierarchy.
     ==============================================
     audioUnit.requestViewController { viewController in
         DispatchQueue.main.async {
             // Install the view controller's view in your host's user interface.
         }
     }
     ==============================================
     */
    
    
    
    
    
#pragma mark -- Playback and Recording
    
    /*
     Audio Queue Services
     
     Connect to audio hardware and manage the recording or playback process.
     
     This document describes Audio Queue Services, a C programming interface in
     the Audio Toolbox framework, which is part of Core Audio.
     
     An audio queue is a software object you use for recording or playing audio.
     An audio queue does the work of:
     
     •  Connecting to audio hardware
     •  Managing memory
     •  Employing codecs, as needed, for compressed audioo formats
     •  Mediating playback or recording
     
     Audio Queue Services enables you to record and play audio in linear PCM,
     in compressed formats (such as Lossless and AAC), and in other formats
     for which users have installed codecs. Audio Queue Services also supports
     scheduled playback and synchronization of multiple audio queues and synchronization
     of audio with video.
     
     Audio Queue Services provides features similar to those previously offered
     by the Sound Manager and in macOS. It adds additional features such as
     synchronization. The Sound Manager is deprecated in OS X v10.5 and does not
     work with 64-bit applications. Audio Queue Services is recommended for all
     new development and as a replacement for the Sound Manager in existing
     Mac apps.
     */
    
    
    /*
     Play short sounds or trigger a vibration effect on iOS devices with the
     appropriate hardware.
     
     System Sound Services provides a C interface for playing short sounds
     and for invoking vibration on iOS devices that support vibration.
     
     You can use System Sound Services to play short (30 seconds or shorter)
     sounds. The interface does not provide level, positioning, looping, or
     timing control, and does not support simulaneous playback: you can play
     only one sound at a time. You can use System Sound Services to provide
     audible alerts. On some iOS devices, alerts can include vibration.
     */
    
    
    /*
     Create and Play a sequence of tracks, and manage aspects of playback
     in response to standard events.
     */
    
    
    
#pragma mark -- Audio Files and Formats
    
    /*
     Audio Format Services

     Access information about audio formats and codecs.

     This document describes Audio Format Services, a C interface for
     obtaining information about audio formats and codecs.
     */
    
    
    /*
     Audio File Services

     Read or write a variety of audio data to or from disk or a
     memory buffer.

     This document describes Audio File Services, a C programming interface
     that enables you to read or write a wide variety of audio data to
     or from disk or a memory buffer.

     With Audio File Services you can:
     •  Create, initialize, open, and close audio files
     •  Read and write audio files
     •  Optimize audio files
     •  Work with user data and global information
     */
    
    /*
     Extended Audio File Services
     
     Read and write compressed files and linear PCM audio files
     using a simplified interface.
     
     Extended Audio File Services provides simplified audio file
     access, combining features of Audio File Services and Audio
     Converter Services. It provides a unified interface for reading
     and writing compressed as well as linear PCM audio files.
     */
    
    /*
     Audio File Stream Services

     Parse streamed audio files as the data arrives on the user’s computer.

     Audio File Stream Services provides the interface for parsing streamed
     audio files—in which only a limited window of data is available at a time.

     Audio file streams, by nature, are not random access. When you request
     data from a stream, earlier data might no longer be accessible and later
     data might not yet be available. In addition, the data you obtain
     (and then provide to a parser) might include partial packets. To parse
     streamed audio data, then, a parser must remember data from partially
     satisfied requests, and must be able to wait for the remainder of that
     data. In other words, a parser must be able to suspend parsing as needed
     and then resume where it left off.

     To use a parser, you pass data from a streamed audio file, as you acquire
     it, to the parser. When the parser has a complete packet of audio data
     or a complete property, it invokes a callback function. Your callbacks
     then process the parsed data—such as by playing it or writing it to disk.

     Here, in outline form, is a typical usage pattern for an audio file
     stream parser:
     1. Create a new audio file stream parser by calling the AudioFileStreamOpen
     function. Pass pointers to your callback functions for audio data and metadata (AudioFileStream_PacketsProc and AudioFileStream_PropertyListenerProc).
     The AudioFileStreamOpen function gives you a reference to the new parser.
     
     2. Create a new audio file stream parser by calling the AudioFileStreamOpen
     function. Pass pointers to your callback functions for audio data and metadata (AudioFileStream_PacketsProc and AudioFileStream_PropertyListenerProc).
     The AudioFileStreamOpen function gives you a reference to the new parser.
     
     3. When finished parsing a stream, call the AudioFileStreamClose function to
     close and deallocate the parser.
     
     Audio File Stream Services supports the following audio data types:
     •  AIFF
     •  AIFC
     •  WAVE
     •  CAF
     •  NeXT
     •  ADTS
     •  MPEG Audio Layer 3
     •  AAC
     */
    
    
    /*
     Audio File Components

     Get information about audio file formats, and about files containing
     audio data.
     */
    
    
    /*
     Core Audio File Format

     Parse the structure of Core Audio files.
     */
    
    
#pragma mark -- Utilities
    
    /*
     Audio Converter Services

     Convert between linear PCM audio formats, and between linear PCM and
     compressed formats.

     Audio converter objects convert between various linear PCM audio formats.
     They can also convert between linear PCM and compressed formats. Supported
     transformations include the following:
     
     •  PCM bit depth
     •  PCM sample rate
     •  PCM floating point to and from PCM integer
     •  PCM interleaved to and from PCM deinterleaved
     •  PCM to and from compressed formats

     A single audio converter may perform more than one of the listed
     transformations.
     */
    
    
    /*
     Audio Session Support

     Describe the properties that you associate with audio sessions and
     audio routes.

     ⚠️
     The AudioSession API has been completely deprecated in iOS 7.0. See
     AVAudioSession for the Objective-C implementation of these functions.
     
     Audio Session Services lets you specify the intended audio behavior for
     your iOS app. For example, you can specify whether you intend for your
     app’s audio to silence other apps or to mix with their audio. You also
     use this API to specify your app’s behavior when it is interrupted,
     such as by a phone call. When the system knows your intentions, it
     configures the audio hardware in the device to satisfy those intentions,
     as possible.

     These functions apply only to iOS. They do not apply to macOS.
     */
    
    
    /*
     Workground Management
     
     Coordinate the activity of custom real-time audio threads with those
     of the system and other processes.


     Real-time audio rendering often requires coordination between the threads
     of an app, the system, and the threads of any active Audio Unit plug-ins.
     Workgroups provide the mechanism to coordinate the efforts of these different
     processes, and ensure that they execute on the same schedule. In an Audio
     Unit, use a render context observer to retrieve the workgroup that the host
     app uses for real-time audio rendering. In an app, fetch the workgroup for
     a Core Audio device directly from the device or from your AUAudioUnit object.

     If your app has real-time rendering threads that operate on their own
     deadlines, create your own workgroup using the AudioWorkIntervalCreate
     function. Use your custom workgroup to set and update the rendering
     schedule for your threads.
     */
    

    /*
     Audio Codec
     
     Translate audio data from one format to another.
     */
    
    
    /*
     Clock Utilities (unavaliable to iOS)
    
     Manage time-related information associated with audio playback.
     */
    
        
    
    
    
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
