

//
//  AudioFileLoader.m
//  VideoProcess
//
//  Created by tigerfly on 2020/5/15.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "AudioFileLoader.h"
#import <AVFoundation/AVFoundation.h>

@implementation AudioFileLoader

+ (instancetype)fileLoaderWithFilePath:(NSString *)path {
    
    AudioFileLoader *fileLoader = [[AudioFileLoader alloc] initWithPath:path];
    return fileLoader;
}

- (instancetype)initWithPath:(NSString *)path {
    if (self = [super init]) {
        
        NSError *fileError = nil;
        NSURL *fileURL = [[NSBundle mainBundle] URLForResource:path withExtension:@"mp3"];
        AVAudioFile *audioFile = [[AVAudioFile alloc] initForReading:fileURL error:&fileError];
        
        //文件读取到缓冲文件中
        AVAudioFormat *audioFormat = [[AVAudioFormat alloc] initStandardFormatWithSampleRate:1.0 channels:2];
        AVAudioPCMBuffer *audioBuffer = [[AVAudioPCMBuffer alloc] initWithPCMFormat:audioFormat frameCapacity:1];
        NSError *readError = nil;
        BOOL read = [audioFile readIntoBuffer:audioBuffer error:&readError];
        if (read) {
            NSLog(@"文件读取成功！");
        }
        
        //获取音频文件属性
        AVAudioFormat *fileFormart = audioFile.fileFormat;
        AVAudioFormat *processingFormat = audioFile.processingFormat;
        int64_t framePosition = audioFile.framePosition;
        int64_t length = audioFile.length;
        
    }
    return self;
}


@end
