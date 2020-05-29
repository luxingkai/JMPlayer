//
//  VPCameraManager.h
//  VideoProcess
//
//  Created by tigerfly on 2020/5/26.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/*
 相机和多媒体捕获
 媒体捕获的基本架构的主要部分是: captureSession\captureInput\captureOutput
 */

/// Manager主要处理（设备授权访问、Session、设备相关设置（曝光、焦距、闪光灯、电筒等设置）以及设备输出相关设置）
@interface VPCameraManager : NSObject

+ (instancetype)cameraManager;
/// 获取任务
@property (nonatomic, nonnull, strong) AVCaptureSession *captureSession;
/// 捕获输入
@property (nonatomic, nonnull, strong) AVCaptureDeviceInput *captureInput;
/// 捕获输出
@property (nonatomic, nonnull, strong) AVCaptureOutput *captureOutput;
/// 设备连接
@property (nonatomic, nullable, strong) AVCaptureConnection *connection;

- (void)startRunning;
- (void)stopRunning;

@end

NS_ASSUME_NONNULL_END
