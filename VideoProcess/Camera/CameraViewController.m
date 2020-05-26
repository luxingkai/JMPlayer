//
//  CameraViewController.m
//  VideoProcess
//
//  Created by tigerfly on 2020/5/25.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "CameraViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "PreviewView.h"
#import "VPCameraManager.h"

@interface CameraViewController ()

@property (nonatomic, strong) AVCaptureSession *captureSession;

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    VPCameraManager *cameraManager = [VPCameraManager cameraManager];
    PreviewView *previewView = [[PreviewView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    previewView.previewLayer.session = cameraManager.captureSession;
    [self.view addSubview:previewView];
    [cameraManager startRunning];
    
    // Do any additional setup after loading the view.
}



//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [super touchesBegan:touches withEvent:event];
//    if (![self.captureSession isRunning]) {
//    }
//}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
