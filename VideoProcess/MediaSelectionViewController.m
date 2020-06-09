//
//  MediaSelectionViewController.m
//  VideoProcess
//
//  Created by tigerfly on 2020/6/6.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "MediaSelectionViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface MediaSelectionViewController ()

@end

@implementation MediaSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /*
     */
    
#pragma mark -- Retrieve the Available Media Options
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"sofa" withExtension:@"mp4"];
    AVAsset *asset = [AVAsset assetWithURL:url];
    for (AVMediaCharacteristic mediaCharacteristic in asset.availableMediaCharacteristicsWithMediaSelectionOptions) {
        NSLog(@"%@",mediaCharacteristic);
        
        // Retrieve the AVMediaSelectionGroup for the speficied characteristic.
        AVMediaSelectionGroup *group = [asset mediaSelectionGroupForMediaCharacteristic:mediaCharacteristic];
        
        for (AVMediaSelectionOption *option in group.options) {
            NSLog(@"%@",option.displayName);
        }
    }
    
#pragma mark -- Select the Desired Media Option
    AVMediaSelectionGroup *group = [asset mediaSelectionGroupForMediaCharacteristic:AVMediaCharacteristicAudible];
    NSLocale *locale = [NSLocale localeWithLocaleIdentifier:@"es-ES"];
    NSArray *options = [AVMediaSelectionGroup mediaSelectionOptionsFromArray:group.options withLocale:locale];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:url];
    // Select Spanish-language subtitle option
    [playerItem selectMediaOption:options.firstObject inMediaSelectionGroup:group];
    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
    
    AVPlayerLayer *playerLayer = [[AVPlayerLayer alloc] init];
    playerLayer.frame = [UIScreen mainScreen].bounds;
    playerLayer.player = player;
    [self.view.layer addSublayer:playerLayer];
    
    //Note: Starting with iOS 7.0 and MacOS 10.9, AVPlayer provides automatic media selection based on the user's system
    //preferences as its default behavior.To take control over when media selections are presented, disable the default behavior by setting the player’s appliesMediaSelectionCriteriaAutomatically value to NO.
    player.appliesMediaSelectionCriteriaAutomatically = NO;
//    [player play];
    
    
#pragma mark -- AVMediaSelection
    
    NSArray *mediaSelections = asset.allMediaSelections;
    for (AVMediaSelection *mediaSelection in mediaSelections) {
        NSLog(@"%@",mediaSelection.asset);
        AVMediaSelectionGroup *group = [asset mediaSelectionGroupForMediaCharacteristic:AVMediaCharacteristicVisual];
        AVMediaSelectionOption *options = [mediaSelection selectedMediaOptionInMediaSelectionGroup:group];
        [mediaSelection mediaSelectionCriteriaCanBeAppliedAutomaticallyToMediaSelectionGroup:group];
    }
    
    
#pragma mark --AVMediaSelectionGroup
    
    //Accessing Option
    AVMediaSelection *mediaSelection = asset.allMediaSelections.firstObject;
    AVMediaSelectionGroup *selectionGroup = [asset mediaSelectionGroupForMediaCharacteristic:AVMediaCharacteristicVisual];
        
    //Configuring Empty Selection
    NSLog(@"allowsEmptySelection %d",selectionGroup.allowsEmptySelection);
    
    //Filtering Selection Optionsgroup
//    selectionGroup makeNowPlayingInfoLanguageOptionGroup
    AVMediaSelectionOption *selectionOption = [mediaSelection selectedMediaOptionInMediaSelectionGroup:selectionGroup];
    if (selectionOption) {
        [AVMediaSelectionGroup playableMediaSelectionOptionsFromArray:@[selectionOption]];
        
        NSLocale *locale = [NSLocale localeWithLocaleIdentifier:@"es-ES"];
        NSArray *options = [AVMediaSelectionGroup mediaSelectionOptionsFromArray:selectionGroup.options withLocale:locale];
        
        [AVMediaSelectionGroup mediaSelectionOptionsFromArray:@[selectionOption] withMediaCharacteristics:@[AVMediaCharacteristicVisual]];
    }
    
#pragma mark -- AVMediaSelectionOptions
    
    //Managing Media Types
    NSLog(@"mediaType %@",selectionOption.mediaType);
    NSLog(@"mediaSubTypes %@",selectionOption.mediaSubTypes);
    NSLog(@"hasMediaCharacteristic %d",[selectionOption hasMediaCharacteristic:AVMediaCharacteristicVisual]);
    
    //Managing Metadata
    NSLog(@"commonMetadata %@",[selectionOption commonMetadata]);
    NSLog(@"availableMetadataFormats %@",[selectionOption availableMetadataFormats]);

    //Getting the Selection Playable Status
    NSLog(@"playable %d",[selectionOption isPlayable]);
    
    //Getting the Language and Locale Settings
    NSLog(@"displayName %@",selectionOption.displayName);
    NSLog(@"displayNameWithLocale %@",[selectionOption displayNameWithLocale:locale]);
    NSLog(@"locale %@",[selectionOption locale]);
    NSLog(@"extendedLanguageTag %@",[selectionOption extendedLanguageTag]);

    //Getting the Properties List
    NSLog(@"propertyList %@",selectionOption.propertyList);
    
    //Getting the Associated Media Selection Option
    [selectionOption associatedMediaSelectionOptionInMediaSelectionGroup:selectionGroup];
    
    
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
