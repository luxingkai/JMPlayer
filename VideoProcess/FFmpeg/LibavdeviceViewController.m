//
//  LibavdeviceViewController.m
//  VideoProcess
//
//  Created by tigerfly on 2021/3/17.
//  Copyright © 2021 tiger fly. All rights reserved.
//

#import "LibavdeviceViewController.h"
#import <libavdevice/avdevice.h>
#import <libavdevice/version.h>
#include <libavutil/opt.h>

@interface LibavdeviceViewController ()

@end

@implementation LibavdeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    /*
     The libavdevice library provides a generic framework for grabbing from
     and rendering to many common multimedia input/output devices, and supports
     several input and output devices, including Video4Linux2, VfW, DShow, and ALSA.
     */
    
    
    unsigned int version = avdevice_version();
    const AVOption *option = av_device_capabilities;
    const char *config = avdevice_configuration();
    const char *license = avdevice_license();
    avdevice_register_all();
    
    
    
    AVInputFormat *audio_format = av_input_audio_device_next(NULL);
    AVInputFormat *video_format = av_input_video_device_next(NULL);
    AVOutputFormat *audio_out_format = av_output_audio_device_next(NULL);
    AVOutputFormat *video_out_format = av_output_video_device_next(NULL);
    
    
    
    

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
