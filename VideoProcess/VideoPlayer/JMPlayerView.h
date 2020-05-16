//
//  JMPlayerView.h
//  VideoProcess
//
//  Created by tiger fly on 2020/3/13.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreVideo/CVPixelBuffer.h>
#import "UIColor+Add.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger) {
    JMPlayerPlayStatusUnknown = 1,
    JMPlayerPlayStatusReady,
    JMPlayerPlayStatusFailed
}JMPlayerPlayStatus;

typedef JMPlayerPlayStatus JMPlayerPlayStatus;

/// 播放器视图
@interface JMPlayerView : UIView
 
+ (instancetype)playerViewWithFrame:(CGRect)frame sourceURL:(NSURL *)source;

@property (nonatomic, strong, readonly) NSURL *sourceURL;

@property (nonatomic, assign, readonly) JMPlayerPlayStatus status;

//播放速率 （0.5x\1.0x\2.0x）
@property (nonatomic) float rate;

- (void)play;
- (void)pause;


@end

NS_ASSUME_NONNULL_END
