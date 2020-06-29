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
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:imageView];
    
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
                NSLog(@"metadata %@",metadata);
            }
        }
    }];
    
#pragma mark -- AVMetadataItem
    NSArray *metadata = [asset metadata];
    for (AVMetadataItem *item in metadata) {
        //process title Item
        
        //Getting Keys and Key Spaces
        NSLog(@"key %@",item.key);
        NSLog(@"keySpace %@",item.keySpace);
        NSLog(@"commonKey %@",item.commonKey);

        //Asynchronous Loading
        [item loadValuesAsynchronouslyForKeys:@[] completionHandler:^{
            AVKeyValueStatus status = [item statusOfValueForKey:@"" error:nil];
        }];
        
        //Accessing Metadata Values
        NSLog(@"value %@",item.value);
        CMTimeShow(item.time);
        CMTimeShow(item.duration);
        NSLog(@"locale %@",item.locale);
        NSLog(@"dataValue %@",item.dataValue);
        NSLog(@"extraAttributes %@",item.extraAttributes);
        NSLog(@"dataType %@",item.dataType);
        NSLog(@"extendedLanguageTag %@",item.extendedLanguageTag);
        NSLog(@"startDate %@",item.startDate);
        NSLog(@"identifier %@",item.identifier);

        //Retrieving Formatted Metadata
        NSLog(@"stringValue %@",item.stringValue);
        NSLog(@"numberValue %@",item.numberValue);
        NSLog(@"dataValue %@",item.dataValue);

        //Filtering Arrays of Metadata Items
//        [AVMetadataItem metadataItemsFromArray:asset.metadata withLocale:nil];
        [AVMetadataItem metadataItemsFromArray:asset.commonMetadata withKey:self keySpace:AVMetadataKeySpaceCommon];
        NSArray *titleItems = [AVMetadataItem metadataItemsFromArray:metadata filteredByIdentifier:AVMetadataCommonIdentifierTitle];
        
    
    }
    
#pragma mark -- AVMetadataItemFilter
    AVMetadataItemFilter *itemFilter = [AVMetadataItemFilter metadataItemFilterForSharing];
    
    
#pragma mark -- AVMetadataItemValueRequest
    AVMetadataItem *item = asset.metadata.firstObject;
//    AVMetadataItemValueRequest *valueRequest = [AVMetadataItemValueRequest new];
//    [valueRequest respondWithValue:item.dataValue];

    
#pragma mark -- AVMutableMetadataItem
    AVMutableMetadataItem *mutableItem = [AVMutableMetadataItem metadataItem];
    
#pragma mark -- AVDateRangeMetadataGroup
//    AVDateRangeMetadataGroup *metadataGroup = [[AVDateRangeMetadataGroup alloc] initWithItems:asset.metadata startDate:nil endDate:nil];
#pragma mark -- AVMutableDateRangeMetadataGroup
#pragma mark -- AVTimedMetadataGroup
#pragma mark -- AVMutableTimedMetadataGroup
#pragma mark -- AVMutableFormat
    
    
    
//    Find Specific Values
    NSArray *metadatas = asset.commonMetadata;
    NSArray *artworkItems = [AVMetadataItem metadataItemsFromArray:metadatas filteredByIdentifier:AVMetadataCommonIdentifierArtwork];
    AVMetadataItem *artworkItem = [artworkItems firstObject];
    NSData *imageData = artworkItem.dataValue;
    UIImage *image = [UIImage imageWithData:imageData];
    imageView.image = image;
    
    
    
    
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
