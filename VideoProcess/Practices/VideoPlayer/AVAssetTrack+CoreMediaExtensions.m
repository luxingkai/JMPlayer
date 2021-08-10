//
//  AVAssetTrack+CoreMediaExtensions.m
//  VideoProcess
//
//  Created by tigerfly on 2020/5/18.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "AVAssetTrack+CoreMediaExtensions.h"
static NSString *FourCCString(FourCharCode code);

@implementation AVAssetTrack (CoreMediaExtensions)

- (NSString *)mediaFormat {
    
    NSMutableString *format = [[NSMutableString alloc] init];
    for (int i = 0; i < self.formatDescriptions.count; i ++) {
        CMFormatDescriptionRef desc = (__bridge CMFormatDescriptionRef)self.formatDescriptions[i];
        NSString *type = FourCCString(CMFormatDescriptionGetMediaType(desc));
        NSString *subType = FourCCString(CMFormatDescriptionGetMediaSubType(desc));
        [format appendFormat:@"%@/%@",type, subType];
        if (i < self.formatDescriptions.count - 1) {
            [format appendFormat:@","];
        }
    }
    return format;
}
static NSString *FourCCString(FourCharCode code) {
    
    NSString *result = [NSString stringWithFormat:@"%c%c%c%c",(code >> 24) & 0xff,(code >> 16) &0xff, (code >> 8) & 0xff,code &0xff];
    NSCharacterSet *characterSet = [NSCharacterSet whitespaceCharacterSet];
    return [result stringByTrimmingCharactersInSet:characterSet];
}



@end
