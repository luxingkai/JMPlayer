//
//  LibswscaleViewController.m
//  VideoProcess
//
//  Created by tigerfly on 2021/5/10.
//  Copyright © 2021 tiger fly. All rights reserved.
//

#import "LibswscaleViewController.h"
#include <libswscale/swscale.h>

@interface LibswscaleViewController ()

@end

@implementation LibswscaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /*
     The libswscale library performs highly optimized image scaling and
     colorspace and pixel format conversion operations.
     
     Specifically, this library performs the following conversions:

     • Rescaling: is the process of changing the video size. Several rescaling
     options and algorithms are available. This is usually a lossy process.
     
     • Pixel format conversion: is the process of converting the image format and
     colorspace of the image, for example from planar YUV420P to RGB24 packed. It
     also handles packing conversion, that is converts from packed layout (all pixels
     belonging to distinct planes interleaved in the same buffer), to planar layout
     (all samples belonging to the same plane stored in a dedicated buffer or "plane").
     
     This is usually a lossy process in case the source and destination colorspaces differ.
     */
    
    
    unsigned int version = swscale_version();
    const char *configration = swscale_configuration();
    const char *license = swscale_license();
    const int *coefficients = sws_getCoefficients(SWS_CS_DEFAULT);
    int supportInput = sws_isSupportedInput(AV_PIX_FMT_RGB24);
    int supportOutput = sws_isSupportedOutput(AV_PIX_FMT_RGB24);
    int supportEndianness = sws_isSupportedEndiannessConversion(AV_PIX_FMT_RGB24);
    struct SwsContext *context = sws_alloc_context();
    
    SwsFilter *srcFilter = sws_getDefaultFilter(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1);
    int init_context = sws_init_context(context, srcFilter, srcFilter);
    const double param;
    sws_getContext(10, 10, AV_PIX_FMT_RGB24, 10, 10, AV_PIX_FMT_RGB24, 1, srcFilter, srcFilter, &param);
        
    

    const AVClass *class = sws_get_class();
    printf("%s\n",class->class_name);
    printf("%d\n",*coefficients);

    
    struct SwsContext *ctx;
    
    
    
    
    
    
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
