//
//  Introduction.m
//  VideoProcess
//
//  Created by tigerfly on 2021/1/4.
//  Copyright © 2021 tiger fly. All rights reserved.
//

#import "Introduction.h"

@interface Introduction ()

@end

@implementation Introduction

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    https://developer.apple.com/library/archive/documentation/MusicAudio/Conceptual/AudioQueueProgrammingGuide/AboutAudioQueues/AboutAudioQueues.html#//apple_ref/doc/uid/TP40005343-CH5-SW1
    /*
     This document describes how to use Audio Queue Services,
     a C programming interface in Core Audio's Audio Toolbox
     framework.
     */
    
    
    /*
     Audio Queue Services provides a straightforward, low overhead
     way to record and play audio in iOS and Mac OS X. It is the
     recommended technology to use for adding basic recording or
     playback features to your iOS or Mac OS X application.

     Audio Queue Services lets you record and play audio in any
     of the following formats:
     •  Linear PCM.
     •  Any compressed format supported natively on the Apple platform
        you are developing for.
     •  Any other format for which a user has an installed codec.
     
     Audio Queue Services is high level. It lets your application
     use hardware recording and playback devices (such as microphones
     and loudspeakers) without knowledge of the hardware interface.
     It also lets you use sophisticated codecs without knowledge of
     how the codecs work.

     At the same time, Audio Queue Services supports some advanced
     features. It provides fine-grained timing control to support
     scheduled playback and synchronization. You can use it to
     synchronize playback of multiple audio queues and to synchronize
     audio with video.

     ⚠️ Audio Queue Services provides features similar to those
     previously provided by the Sound Manager in Mac OS X. It adds
     additional features such as synchronization. The Sound Manager
     is deprecated in Mac OS X v10.5 and does not work with 64-bit
     applications. Apple recommends Audio Queue Services for all
     new development and as a replacement for the Sound Manager in
     existing Mac OS X applications.
     
     Audio Queue Services provides features similar to those previously
     provided by the Sound Manager in Mac OS X. It adds additional
     features such as synchronization. The Sound Manager is deprecated
     in Mac OS X v10.5 and does not work with 64-bit applications.
     Apple recommends Audio Queue Services for all new development
     and as a replacement for the Sound Manager in existing Mac OS X
     applications.
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
