//
//  LibavcodecViewController.m
//  VideoProcess
//
//  Created by tigerfly on 2021/3/23.
//  Copyright © 2021 tiger fly. All rights reserved.
//

#import "LibavcodecViewController.h"
#include <libavcodec/avcodec.h>
#include <libavcodec/version.h>

// Decoding



@interface LibavcodecViewController ()

@end

@implementation LibavcodecViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
#pragma mark --
//    avcodec_find_decoder(<#enum AVCodecID id#>)
//    avcodec_find_decoder_by_name(<#const char *name#>)
//    avcodec_default_get_buffer2(<#AVCodecContext *s#>, <#AVFrame *frame#>, <#int flags#>)
//    avcodec_align_dimensions(<#AVCodecContext *s#>, <#int *width#>, <#int *height#>)
//    avcodec_align_dimensions2(<#AVCodecContext *s#>, <#int *width#>, <#int *height#>, <#int *linesize_align#>)
//    avcodec_enum_to_chroma_pos(<#int *xpos#>, <#int *ypos#>, <#enum AVChromaLocation pos#>)
//    avcodec_chroma_pos_to_enum(<#int xpos#>, <#int ypos#>)
//    avcodec_decode_audio4(<#AVCodecContext *avctx#>, <#AVFrame *frame#>, <#int *got_frame_ptr#>, <#const AVPacket *avpkt#>)
//    avcodec_decode_video2(<#AVCodecContext *avctx#>, <#AVFrame *picture#>, <#int *got_picture_ptr#>, <#const AVPacket *avpkt#>)
//    avcodec_decode_subtitle2(<#AVCodecContext *avctx#>, <#AVSubtitle *sub#>, <#int *got_sub_ptr#>, <#AVPacket *avpkt#>)
    
    
#pragma mark -- Encoding
    
//    avcodec_find_encoder(<#enum AVCodecID id#>)
//    avcodec_encode_audio2(<#AVCodecContext *avctx#>, <#AVPacket *avpkt#>, <#const AVFrame *frame#>, <#int *got_packet_ptr#>)
//    avcodec_encode_video2(<#AVCodecContext *avctx#>, <#AVPacket *avpkt#>, <#const AVFrame *frame#>, <#int *got_packet_ptr#>)
//    avcodec_encode_subtitle(<#AVCodecContext *avctx#>, <#uint8_t *buf#>, <#int buf_size#>, <#const AVSubtitle *sub#>)
    
    
#pragma mark -- Codecs
    
    
#pragma mark -- Internal
    
    
#pragma mark -- send/receive encoding and decoding API overview
    
    
#pragma mark -- Core functions/structures
    
    
#pragma mark -- Utility functions
    
//    av_get_codec_tag_string(<#char *buf#>, <#size_t buf_size#>, <#unsigned int codec_tag#>)
//    avcodec_string(<#char *buf#>, <#int buf_size#>, <#AVCodecContext *enc#>, <#int encode#>)
//    av_get_profile_name(<#const AVCodec *codec#>, <#int profile#>)
//    avcodec_default_execute(<#AVCodecContext *c#>, <#int (*func)(AVCodecContext *, void *)#>, <#void *arg#>, <#int *ret#>, <#int count#>, <#int size#>)
//    avcodec_default_execute2(<#AVCodecContext *c#>, <#int (*func)(AVCodecContext *, void *, int, int)#>, <#void *arg#>, <#int *ret#>, <#int count#>)
    
    
    
    
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
