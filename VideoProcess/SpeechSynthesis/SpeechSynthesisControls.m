//
//  SpeechSynthesisControls.m
//  VideoProcess
//
//  Created by tigerfly on 2020/6/29.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "SpeechSynthesisControls.h"
#import <AVFoundation/AVFoundation.h>

@interface SpeechSynthesisControls ()<AVSpeechSynthesizerDelegate>

@end

@implementation SpeechSynthesisControls {
    
    
}
 
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
     /* AVSpeechSynthesizer */
    
    AVSpeechUtterance *speechUtterance = [AVSpeechUtterance speechUtteranceWithString:@"die away"];
    speechUtterance.volume = 1.0;
    speechUtterance.rate = AVSpeechUtteranceDefaultSpeechRate;
    
    // Synthesizing Speech
    AVSpeechSynthesizer *speechSynthesizer = [AVSpeechSynthesizer new];
    [speechSynthesizer speakUtterance:speechUtterance];
    
    // Controlling Speech Synthesis
//    [speechSynthesizer continueSpeaking];
//    speechSynthesizer pauseSpeakingAtBoundary:<#(AVSpeechBoundary)#>
//    speechSynthesizer.isPaused
//    speechSynthesizer.isSpeaking
//    speechSynthesizer stopSpeakingAtBoundary:<#(AVSpeechBoundary)#>
    
    // Managing the Delegate
    speechSynthesizer.delegate = self;
    
    //Directing Speech Output
    speechSynthesizer.mixToTelephonyUplink = true;
    speechSynthesizer.usesApplicationAudioSession = true;
//    speechSynthesizer.outputChannels
//    speechSynthesizer writeUtterance:<#(nonnull AVSpeechUtterance *)#> toBufferCallback:<#^(AVAudioBuffer * _Nonnull buffer)bufferCallback#>
        
}


#pragma mark -- AVSpeechSynthesizerDelegate

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance {
    
}
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance {
    
}
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didPauseSpeechUtterance:(AVSpeechUtterance *)utterance {
    
}
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didContinueSpeechUtterance:(AVSpeechUtterance *)utterance {
    
}
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didCancelSpeechUtterance:(AVSpeechUtterance *)utterance  {
    
}
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer willSpeakRangeOfSpeechString:(NSRange)characterRange utterance:(AVSpeechUtterance *)utterance {
    
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
