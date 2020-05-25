//
//  MetadataManipulationController.m
//  VideoProcess
//
//  Created by tigerfly on 2020/5/25.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "MetadataManipulationController.h"
#import <AVFoundation/AVFoundation.h>

@interface MetadataManipulationController ()

@end
 
@implementation MetadataManipulationController {
    
}
 
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"sofa" withExtension:@"mp4"];
    AVAsset *asset = [AVAsset assetWithURL:url];
    NSString *formatsKey = @"availableMetadataFormats";
    
    [asset loadValuesAsynchronouslyForKeys:@[formatsKey] completionHandler:^{
        NSError *error = nil;
        AVKeyValueStatus status = [asset statusOfValueForKey:formatsKey error:&error];
        if (status == AVKeyValueStatusLoaded) {
            for (AVMetadataFormat format in asset.availableMetadataFormats) {
                NSArray *metadata = [asset metadataForFormat:format];
                //process format-specific metadata collection
                NSLog(@"%@",metadata);
            }
        }
    }];
    
    NSArray *metadata = [asset commonMetadata];
    NSArray *titleItems = [AVMetadataItem metadataItemsFromArray:metadata filteredByIdentifier:AVMetadataCommonIdentifierTitle];
    for (AVMetadataItem *item in titleItems) {
        //process title Item
        NSLog(@"%@",item.identifier);
        NSLog(@"%@",item.dataType);
        NSLog(@"%@",item.extendedLanguageTag);
        NSLog(@"%@",item.locale);
        CMTimeShow(item.time);
        CMTimeShow(item.duration);
        NSLog(@"%@",item.value);
        NSLog(@"%@",item.extraAttributes);
    }
    
//    Find Specific Values
    NSArray *metadatas = asset.commonMetadata;
    NSArray *artworkItems = [AVMetadataItem metadataItemsFromArray:metadatas filteredByIdentifier:AVMetadataCommonIdentifierArtwork];
    AVMetadataItem *artworkItem = [artworkItems firstObject];
    NSData *imageData = artworkItem.dataValue;
    UIImage *image = [UIImage imageWithData:imageData];
    
    
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
