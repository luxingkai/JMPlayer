//
//  RSILAViewController.m
//  VideoProcess
//
//  Created by tigerfly on 2020/6/29.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "RSILAViewController.h"
#import <Speech/Speech.h>
#import <AVFoundation/AVFoundation.h>

@interface RSILAViewController ()<SFSpeechRecognizerDelegate>

@end

@implementation RSILAViewController {
    
    UITextView *_textView;
    UIButton *_button;
    __block SFSpeechRecognitionTask *_recognitionTask;
    __block SFSpeechAudioBufferRecognitionRequest *_recognitionRequest;
    AVAudioEngine *_audioEngine;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 60, 200, 300)];
    [self.view addSubview:_textView];
    
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = CGRectMake(30, screenH - 60, 100, 30);
    [_button setTitle:@"start recording" forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_button.titleLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:14]];
    [_button addTarget:self action:@selector(record:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
    
    if ([SFSpeechRecognizer authorizationStatus] != SFSpeechRecognizerAuthorizationStatusAuthorized) {
        [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
            switch (status) {
                case SFSpeechRecognizerAuthorizationStatusAuthorized: {
                    dispatch_async(dispatch_get_main_queue(), ^{
                    });
                }
                    break;
                case SFSpeechRecognizerAuthorizationStatusNotDetermined: {
                    
                }
                    break;
                case SFSpeechRecognizerAuthorizationStatusDenied: {
                    
                }
                    break;
                case SFSpeechRecognizerAuthorizationStatusRestricted: {
                    
                }
                    break;
            }
        }];
    }
    
}

- (void)record:(id)sender {
    
    if (_audioEngine.isRunning) {
        [_audioEngine stop];
        [_recognitionRequest endAudio];
        _button.enabled = false;
        [_button setTitle:@"Stopping" forState:UIControlStateDisabled];
    }else {
        @try {
            [self handleRecordAudio];
            [_button setTitle:@"Stop Recording" forState:UIControlStateNormal];
        } @catch (NSException *exception) {
            [_button setTitle:@"recording Not available" forState:UIControlStateNormal];
        } @finally {
    
        }
    }
}

- (void)handleRecordAudio {
    
    //Cancel teh previous task if it's running
    if (_recognitionTask) {
        [_recognitionTask cancel];
        _recognitionTask = nil;
    }
    
    /* Configure the Microphone Using AVFoundation */
    
    AVAudioEngine *audioEngine = [[AVAudioEngine alloc] init];
    
    //Configure the audio session for the app
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    NSError *error = nil;
    [audioSession setCategory:AVAudioSessionCategoryRecord error:&error];
    [audioSession setActive:true error:&error];
    AVAudioInputNode *inputNode = audioEngine.inputNode;
    
    /* Create the Speech Recognition Request */
    
    //Create and Configure the Speech Recognition request
    SFSpeechRecognizer *recognizer = [SFSpeechRecognizer new];
    if (!recognizer.available) {
        return;
    }
    recognizer.delegate = self;
    
    _recognitionRequest = [SFSpeechAudioBufferRecognitionRequest new];
    if (_recognitionRequest == nil) {
        NSLog(@"unable to create a SFSpeechAudioBufferRecognitionRequest object");
        return;
    }
    _recognitionRequest.shouldReportPartialResults = true;
    
    //Create a Recognition task for the speech recognition session
    //Keep a reference to the task so that it can be canceled.
    _recognitionTask = [recognizer recognitionTaskWithRequest:_recognitionRequest resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
        BOOL isFinal = false;
        
        if (result) {
            //Update the text view with the results.
            self->_textView.text = result.bestTranscription.formattedString;
            isFinal = result.isFinal;
            NSLog(@"text %@",result.bestTranscription.formattedString);
        }
        if (error != nil || isFinal) {
            [audioEngine stop];
            [inputNode removeTapOnBus:0];
            
            self->_recognitionRequest = nil;
            self->_recognitionTask = nil;
            
            self->_button.enabled = YES;
            [self->_button setTitle:@"start recording" forState:UIControlStateNormal];
        }
    }];
    
    // Configure the microphone input.
    AVAudioFormat *audioFormat = [inputNode outputFormatForBus:0];
    [inputNode installTapOnBus:0 bufferSize:1024 format:audioFormat block:^(AVAudioPCMBuffer * _Nonnull buffer, AVAudioTime * _Nonnull when) {
        [_recognitionRequest appendAudioPCMBuffer:buffer];
    }];
    [audioEngine prepare];
    [audioEngine startAndReturnError:nil];

}


#pragma mark -- SFSpeechRecognizerDelegate

- (void)speechRecognizer:(SFSpeechRecognizer *)speechRecognizer availabilityDidChange:(BOOL)available {
    if (available) {
        _button.enabled = true;
        [_button setTitle:@"start recording" forState:UIControlStateNormal];
    }else {
        _button.enabled = false;
        [_button setTitle:@"Recognition not available" forState:UIControlStateNormal];
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
