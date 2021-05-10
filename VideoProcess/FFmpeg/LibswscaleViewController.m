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
    
    
    unsigned int version = swscale_version();
    const char *configration = swscale_configuration();
    const char *license = swscale_license();
    
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
