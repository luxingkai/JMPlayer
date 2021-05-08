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

@interface LibavdeviceViewController ()

@end

@implementation LibavdeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   const AVOption *option = av_device_capabilities;
    avdevice_configuration();
    avdevice_license();
    avdevice_register_all();
//    av_input_audio_device_next(<#AVInputFormat *d#>)
    
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
