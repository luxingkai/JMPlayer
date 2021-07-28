//
//  LibswresampleViewController.m
//  VideoProcess
//
//  Created by tigerfly on 2021/5/10.
//  Copyright © 2021 tiger fly. All rights reserved.
//

#import "LibswresampleViewController.h"

@interface LibswresampleViewController ()

@end

@implementation LibswresampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    /*
     The libswresample library performs highly optimized audio resampling, rematrixing
     and sample format conversion operations.
     
     Specifically, this library performs the following conversions:
     
     •  Resampling: is the process of changing the audio rate, for example from a high
        sample rate of 44100Hz to 8000Hz. Audio conversion from high to low samples rate
        is a lossy process. Several resampling options and algorithm are available.
     
     •  Format conversion: is the process of converting the type of samples, for
        example from 16-bit signed samples to unsigned 8-bit or float samples. It also
        handles packing conversion, when passing from packed layout (all samples belonging
        to distinct channels interleaved in the same buffer), to planar layout (all samples
        belonging to the same channel stored in a dedicated buffer or "plane").
     
     •  Format conversion: is the process of converting the type of samples, for example
        from 16-bit signed samples to unsigned 8-bit or float samples. It also handles packing
        conversion, when passing from packed layout (all samples belonging to distinct channels
        interleaved in the same buffer), to planar layout (all samples belonging to the same
        channel stored in a dedicated buffer or "plane").
    
     Various other audio conversions (e.g. stretching and padding) are enabled through
     dedicated options.
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
