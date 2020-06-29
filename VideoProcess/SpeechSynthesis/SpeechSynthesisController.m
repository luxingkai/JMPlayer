//
//  SpeechSynthesisController.m
//  VideoProcess
//
//  Created by tigerfly on 2020/6/29.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "SpeechSynthesisController.h"
#import <AVFoundation/AVFoundation.h>
#import <Speech/Speech.h>

@interface SpeechSynthesisController ()

@end

@implementation SpeechSynthesisController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
#pragma mark -- Spoken Text Attributes
    
    /* AVSpeechUtterance, the text used to synthesize speech, along with parameters that affect the speech. */
    
    // Creating an Utterance
    AVSpeechUtterance *speechUtterance = [[AVSpeechUtterance alloc] initWithString:@"this is a world that need be protected by us"];
    
    // Configuring an Utterance
    AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-US"];
    speechUtterance.pitchMultiplier = 1.0;
    speechUtterance.voice = voice;
    speechUtterance.volume = 1.0;
    
    //Configuring Utterance Timing
    speechUtterance.rate = 1.0;
    speechUtterance.postUtteranceDelay = 0.0;
    speechUtterance.preUtteranceDelay = 0.0;
    
    // Accessing Utterance Text
    NSLog(@"speechString %@",speechUtterance.speechString);
    NSLog(@"attributedSpeechString %@",speechUtterance.attributedSpeechString);
    
    
    /* AVSpeechSynthesisVoice */
    
    //Finding Voices
    //    AVSpeechSynthesisVoice *synthesisVoice = [AVSpeechSynthesisVoice voiceWithIdentifier:@"shit"];
    //    [AVSpeechSynthesisVoice voiceWithLanguage:@"en-US"];
    NSArray *voices = [AVSpeechSynthesisVoice speechVoices];
    AVSpeechSynthesisVoice *specifyVoice = voices.firstObject;

    // Identifying Voices
    NSLog(@"identifier %@",specifyVoice.identifier);
    NSLog(@"name %@",specifyVoice.name);
    NSLog(@"quality %ld",(long)specifyVoice.quality);

    //Working with Language Codes
    NSLog(@"currentLanguageCode %@",AVSpeechSynthesisVoice.currentLanguageCode);
    NSLog(@"language %@",specifyVoice.language);

    // Instance Properties
    NSLog(@"audioFileSettings %@",specifyVoice.audioFileSettings);
    NSLog(@"gender %d",specifyVoice.gender);
    
    
    
    
    
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
