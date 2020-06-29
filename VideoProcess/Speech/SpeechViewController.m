//
//  SpeechViewController.m
//  VideoProcess
//
//  Created by tigerfly on 2020/6/29.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "SpeechViewController.h"
#import <Speech/Speech.h>

@interface SpeechViewController ()<SFSpeechRecognitionTaskDelegate,SFSpeechRecognizerDelegate>

@end

@implementation SpeechViewController {
    
    SFSpeechRecognitionTask *_task;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
#pragma mark -- Essentials
    
    if ([SFSpeechRecognizer authorizationStatus] != SFSpeechRecognizerAuthorizationStatusAuthorized) {
        [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
            dispatch_async(dispatch_get_main_queue(), ^{
                switch (status) {
                    case SFSpeechRecognizerAuthorizationStatusAuthorized: {
                        [self handleSpeechRecognizer];
                    }
                        break;
                    case SFSpeechRecognizerAuthorizationStatusDenied: {
                        
                    }
                        break;
                    case SFSpeechRecognizerAuthorizationStatusRestricted: {
                        
                    }
                        break;
                    case SFSpeechRecognizerAuthorizationStatusNotDetermined: {
                        
                    }
                        break;
                }
            });
        }];
    }else {
        [self handleSpeechRecognizer];
        [self handleAudioSources];
        [self MonitorSpeechRecognitionProgress];
    }
    
}

- (void)handleSpeechRecognizer {
    
    /* SFSpeechRecognizer */
    
    // Creating a Speech Recognizer
    SFSpeechRecognizer *speechRecognizer = [[SFSpeechRecognizer alloc] init];
    //    [SFSpeechRecognizer alloc] initWithLocale:<#(nonnull NSLocale *)#>
    
    // Monitoring the Availability of Speech Recognization
    speechRecognizer.delegate = self;
    NSLog(@"speechRecognizer.isAvailable %d",speechRecognizer.isAvailable);
    speechRecognizer.supportsOnDeviceRecognition = true;
    
    // Requesting Authorization From the User
    //    SFSpeechRecognizer requestAuthorization:<#^(SFSpeechRecognizerAuthorizationStatus status)handler#>
    //    SFSpeechRecognizer authorizationStatus
    
    // Configuring the Speech Recognizer
    speechRecognizer.defaultTaskHint = SFSpeechRecognitionTaskHintUnspecified;
    speechRecognizer.queue = [NSOperationQueue mainQueue];
    
    // Performing Speech Recognition on Audio
    SFSpeechRecognitionRequest *recognitionRequest = [SFSpeechRecognitionRequest new];
    [speechRecognizer recognitionTaskWithRequest:recognitionRequest delegate:self];
    
    // Getting the Current Language
    NSLog(@"locale %@",speechRecognizer.locale);
    for (NSLocale *locale in [SFSpeechRecognizer supportedLocales].allObjects) {
        NSLog(@"supportedLocales %@",locale.localeIdentifier);
    }
    
}

#pragma mark -- Audio Sources

- (void)handleAudioSources {
    
    /* SFSpeechURLRecognitionRequest */
    
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"Christophe Lebled - Alpha" withExtension:@"mp3"];
    SFSpeechRecognizer *recognizer = [SFSpeechRecognizer new];
    
    if (![recognizer isAvailable]) {
        // The recognizer is not available right now
        return;
    }
    
    SFSpeechURLRecognitionRequest *request = [[SFSpeechURLRecognitionRequest alloc] initWithURL:fileURL];
    _task = [recognizer recognitionTaskWithRequest:request resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
        if (!result) {
            // Recognition failed, so check error for details and handle it
            return;
        }
        //Print the speech that has been recognized so far
        if (result.final) {
            NSLog(@"Speech in the file is %@",result.bestTranscription.formattedString);
        }
    }];
    
    
    /* SFSpeechAudioBufferRecognitionRequest */
    
    SFSpeechAudioBufferRecognitionRequest *audioBufferRequest = [SFSpeechAudioBufferRecognitionRequest new];
    
    //Appending Audio Buffers
    //audioBufferRequest appendAudioPCMBuffer:<#(nonnull AVAudioPCMBuffer *)#>
    //audioBufferRequest appendAudioSampleBuffer:<#(nonnull CMSampleBufferRef)#>
    [audioBufferRequest endAudio];
 
    // Getting the Audio Format
    NSLog(@"channelCount %d",audioBufferRequest.nativeAudioFormat.channelCount);
    NSLog(@"standard %d",audioBufferRequest.nativeAudioFormat.standard);
    NSLog(@"commonFormat %d",audioBufferRequest.nativeAudioFormat.commonFormat);
    NSLog(@"sampleRate %f",audioBufferRequest.nativeAudioFormat.sampleRate);
    NSLog(@"interleaved %d",audioBufferRequest.nativeAudioFormat.interleaved);
    NSLog(@"streamDescription %f",audioBufferRequest.nativeAudioFormat.streamDescription->mSampleRate);
    NSLog(@"channelLayout %@",audioBufferRequest.nativeAudioFormat.channelLayout);
    NSLog(@"settings %@",audioBufferRequest.nativeAudioFormat.settings);

    /* SFSpeechRecognitionRequest */
    SFSpeechRecognitionRequest *recognitionRequest = [SFSpeechRecognitionRequest new];
    
    // Configuring the Recognition Request
    recognitionRequest.requiresOnDeviceRecognition = true;
    recognitionRequest.shouldReportPartialResults = true;
    recognitionRequest.contextualStrings = @[@"sd",@"dfa"];
    
    // Classifying the type of Speech
    recognitionRequest.taskHint = SFSpeechRecognitionTaskHintSearch;
    
    // Identifying the Request
    recognitionRequest.interactionIdentifier = @"interactionIdentifier";
    
}

#pragma mark -- In-Progress Requests

- (void)MonitorSpeechRecognitionProgress {
    
    NSAssert(_task != nil, @"task can't be nil");
    // Canceling a Speech Recognition Task
    if (![_task isCancelled]) {
        [_task cancel];
    }
    
    // Finishing a Speech Recognition Task
    if (![_task isFinishing]) {
        [_task finish];
    }
    
    // Monitoring Recognition Progress
    NSLog(@"state %ld",(long)_task.state);
    NSLog(@"error %@",_task.error.description);
    
}

#pragma mark -- Transcription Results

- (void)handleTranscriptionResult {
    
    
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
