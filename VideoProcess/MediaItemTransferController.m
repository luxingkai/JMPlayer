//
//  MediaItemTransferController.m
//  VideoProcess
//
//  Created by tigerfly on 2020/6/1.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "MediaItemTransferController.h"
#import <AVFoundation/AVFoundation.h>

@interface MediaItemTransferController ()

@end

@implementation MediaItemTransferController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     定义了将样本从资源移动到播放器的公共接口的抽象类。
     */
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"sofa" withExtension:@"mp4"];
    AVAsset *asset = [AVAsset assetWithURL:url];
    AVPlayerItemOutput *itemOutput = [[AVPlayerItemOutput alloc] init];

    
    
    
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
