//
//  AVAssetTrack+CoreMediaExtensions.h
//  VideoProcess
//
//  Created by tigerfly on 2020/5/18.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AVAssetTrack (CoreMediaExtensions)

- (NSString *)mediaFormat;

@end

NS_ASSUME_NONNULL_END
