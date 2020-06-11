//
//  SupportingTypesController.m
//  VideoProcess
//
//  Created by tigerfly on 2020/6/11.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "SupportingTypesController.h"
#import <AVFoundation/AVFoundation.h>

@interface SupportingTypesController ()

@end

@implementation SupportingTypesController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"sofa" withExtension:@"mp4"];
    AVAsset *asset = [AVAsset assetWithURL:url];
    AVPlayerItem *playItem = [AVPlayerItem playerItemWithAsset:asset];
    AVPlayer *player = [AVPlayer playerWithPlayerItem:playItem];
    
    
#pragma mark -- Video and Photo Codecs
//    AVVideoCodecKey
//    AVVideoCodecType
    
#pragma mark -- Compression
//    AVVideoCompressionPropertiesKey
//    AVVideoAverageBitRateKey
//    AVVideoQualityKey
//    AVVideoMaxKeyFrameIntervalKey
//    AVVideoMaxKeyFrameIntervalDurationKey
//    AVVideoAllowFrameReorderingKey
    
#pragma mark -- Size and Aspect Ratio
//    AVVideoWidthKey
//    AVVideoHeightKey
//    AVVideoPixelAspectRatioKey
//    AVVideoPixelAspectRatioVerticalSpacingKey
//    AVVideoPixelAspectRatioHorizontalSpacingKey
    
#pragma mark -- Scaling Mode
//    AVVideoScalingModeFit
//    AVVideoScalingModeKey
//    AVVideoScalingModeResize
//    AVVideoScalingModeResizeAspect
//    AVVideoScalingModeResizeAspectFill
    
#pragma mark -- Clean Aperture
//    AVVideoCleanApertureKey
//    AVVideoCleanApertureWidthKey
//    AVVideoCleanApertureHeightKey
//    AVVideoCleanApertureVerticalOffsetKey
//    AVVideoCleanApertureHorizontalOffsetKey
    
#pragma mark -- Color Properties
//    AVVideoAllowWideColorKey
//    AVVideoColorPropertiesKey
//    AVVideoColorPrimariesKey
//    AVVideoColorPrimaries_P3_D65
//    AVVideoColorPrimaries_SMPTE_C
//    AVVideoColorPrimaries_ITU_R_709_2
//    AVVideoColorPrimaries_ITU_R_2020
//    AVVideoTransferFunctionKey
//    AVVideoTransferFunction_ITU_R_709_2
//    AVVideoTransferFunction_SMPTE_ST_2084_PQ
//    AVVideoYCbCrMatrixKey
//    AVVideoYCbCrMatrix_ITU_R_601_4
//    AVVideoYCbCrMatrix_ITU_R_709_2
//    AVVideoYCbCrMatrix_ITU_R_2020
    
#pragma mark -- Profile Level
//    AVVideoProfileLevelKey
//    AVVideoProfileLevelH264High40
//    AVVideoProfileLevelH264High41
//    AVVideoProfileLevelH264Main30
//    AVVideoProfileLevelH264Main31
//    AVVideoProfileLevelH264Main32
//    AVVideoProfileLevelH264Main41
//    AVVideoProfileLevelH264Baseline30
//    AVVideoProfileLevelH264Baseline31
//    AVVideoProfileLevelH264Baseline41
//    AVVideoProfileLevelH264HighAutoLevel
//    AVVideoProfileLevelH264MainAutoLevel
//    AVVideoProfileLevelH264BaselineAutoLevel
    
#pragma mark --  Entropy Mode
//    AVVideoH264EntropyModeKey
//    AVVideoH264EntropyModeCABAC
//    AVVideoH264EntropyModeCAVLC
    
#pragma mark -- Frame Rate
//    AVVideoAverageNonDroppableFrameRateKey
//    AVVideoExpectedSourceFrameRateKey
    
    
#pragma mark -- Video Toolbox Options
//    AVVideoEncoderSpecificationKey
    
    
#pragma mark -- AVFileType
//    AVFileTypeAC3
//    AVFileTypeAMR
//    AVFileTypeDNG
//    AVFileType3GPP
//    AVFileTypeAIFC
//    AVFileTypeAIFF
//    AVFileTypeAVCI
//    AVFileTypeHEIC
//    AVFileTypeHEIF
//    AVFileTypeJPEG
//    AVFileTypeTIFF
//    AVFileTypeWAVE
//    AVFileType3GPP2
//    AVFileTypeMPEG4
//    AVFileTypeSunAU
//    AVFileTypeAppleM4A
//    AVFileTypeAppleM4V
//    AVFileTypeMPEGLayer3
//    AVFileTypeEnhancedAC3
//    AVFileTypeQuickTimeMovie
//    AVFileTypeCoreAudioFormat
    
#pragma mark -- AVMediaType
//    AVMediaTypeAudio
//    AVMediaTypeClosedCaption
//    AVMediaTypeDepthData
//    AVMediaTypeMetadata
//    AVMediaTypeMetadataObject
//    AVMediaTypeMuxed
//    AVMediaTypeSubtitle
//    AVMediaTypeText
//    AVMediaTypeTimecode
//    AVMediaTypeVideo
    
    
    // Do any additional setup after loading the view.
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
