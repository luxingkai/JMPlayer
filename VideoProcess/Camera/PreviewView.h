//
//  PreviewView.h
//  VideoProcess
//
//  Created by tigerfly on 2020/5/26.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PreviewView : UIView

@property (nonatomic, nonnull, getter=previewLayer) AVCaptureVideoPreviewLayer *previewLayer;

@end

NS_ASSUME_NONNULL_END
