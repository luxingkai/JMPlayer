//
//  AudioFileLoader.h
//  VideoProcess
//
//  Created by tigerfly on 2020/5/15.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AudioFileLoader : NSObject
+ (instancetype)fileLoaderWithFilePath:(NSString *)path;
@end

NS_ASSUME_NONNULL_END
