//
//  LibavformatViewController.m
//  VideoProcess
//
//  Created by tigerfly on 2021/5/10.
//  Copyright © 2021 tiger fly. All rights reserved.
//

#import "LibavformatViewController.h"
#include <libavformat/avio.h>
#include <libavformat/avformat.h>

@interface LibavformatViewController ()

@end

@implementation LibavformatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    /*
     The libavformat library provides a generic framework for multiplexing and
     demultiplexing (muxing and demuxing) audio, video and subtitle streams. It
     encompasses multiple muxers and demuxers for multimedia container formats.
     
     It also supports several input and output protocols to access a media resource.
     
     • Demuxing
     Demuxers read a media file and split it into chunks of data (packets).
     
     • Muxing
     Muxers take encoded data in the form of AVPackets and write it into files or other
     output bytestreams in the specified container format.
     
     • I/O Read/Write
     
     • Demuxers
     
     • I/O Protocols
     
     • Internal
     
     • Public Metadata API
     The metadata API allows libavformat to export metadata tags to a client application
     when demuxing.
     
     • Core functions
     Functions for querying libavformat capabilities, allocating core structures, etc.
     
     • Utility functions
     Miscellaneous utility functions related to both muxing and demuxing (or neither).
     */
    
    
    //    AVIODirContext *ctx = NULL;
    //    if (avio_open_dir(&ctx, "smb://example.com/some_dir", NULL) < 0) {
    //        fprintf(stderr, "Cannot open directory.\n");
    //        abort();
    //    }
    
    
    NSString *filename = [[NSBundle mainBundle] pathForResource:@"tiger fly 2020-10-10 17.54.42" ofType:@"mp4"];
    const char *file = [filename cStringUsingEncoding:NSUTF8StringEncoding];
    unsigned char buf[AVPROBE_PADDING_SIZE];
    const char *mime_type = [@"mp4" cStringUsingEncoding:NSUTF8StringEncoding];
    AVProbeData *probeData = {file, buf, 1024, mime_type};
    
    
    AVInputFormat *inputFormat = av_find_input_format("");
    AVInputFormat *probe_input_format = av_probe_input_format(probeData, 1);
    
    
    
#if 0
    NSLog(@"error");
#endif
    
    
    
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
