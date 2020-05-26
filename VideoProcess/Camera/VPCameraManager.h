//
//  VPCameraManager.h
//  VideoProcess
//
//  Created by tigerfly on 2020/5/26.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

/*
 相机和多媒体捕获
 媒体捕获的基本架构的主要部分是: captureSession\captureInput\captureOutput
 */

@interface VPCameraManager : NSObject

+ (instancetype)cameraManager;
/// 获取任务
@property (nonatomic, nonnull, strong) AVCaptureSession *captureSession;
/// 捕获输入
@property (nonatomic, nonnull, strong) AVCaptureDeviceInput *captureInput;
/// 捕获输出
@property (nonatomic, nonnull, strong) AVCaptureOutput *captureOutput;

- (void)startRunning;
- (void)stopRunning;

@end

NS_ASSUME_NONNULL_END
