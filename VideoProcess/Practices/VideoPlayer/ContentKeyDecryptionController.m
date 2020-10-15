//
//  ContentKeyDecryptionController.m
//  VideoProcess
//
//  Created by tigerfly on 2020/6/9.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "ContentKeyDecryptionController.h"
#import <AVFoundation/AVFoundation.h>

@interface ContentKeyDecryptionController ()<AVContentKeySessionDelegate,AVContentKeyRecipient>

@end

@implementation ContentKeyDecryptionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"sofa" withExtension:@"mp4"];
    AVURLAsset *urlAsset = [AVURLAsset assetWithURL:url];
    
    
#pragma mark -- Creating New Content Key Sessions
    
    AVContentKeySession *keySession = [AVContentKeySession contentKeySessionWithKeySystem:AVContentKeySystemAuthorizationToken];
    
#pragma mark -- initializing the Content key Request Process
    
    [keySession setDelegate:self queue:dispatch_get_main_queue()];
//    [keySession addContentKeyRecipient:self];
//    NSLog(@"mayRequireContentKeysForMediaDataProcessing %d",self.mayRequireContentKeysForMediaDataProcessing);
    [keySession processContentKeyRequestWithIdentifier:[@"com.fxw.VideoProcess" dataUsingEncoding:NSUTF8StringEncoding] initializationData:[@"com.fxw.VideoProcess" dataUsingEncoding:NSUTF8StringEncoding] options:@{AVContentKeyRequestProtocolVersionsKey:@[@1]}];
    
    
#pragma mark -- Updating Content Key Requests
//    keySession renewExpiringResponseDataForContentKeyRequest:<#(nonnull AVContentKeyRequest *)#>
//    keySession makeSecureTokenForExpirationDateOfPersistableContentKey:<#(nonnull NSData *)#> completionHandler:<#^(NSData * _Nullable secureTokenData, NSError * _Nullable error)handler#>
//    keySession contentProtectionSessionIdentifier
    
    
#pragma mark -- Ending a Content Key Request Process
//    [keySession expire];
//    [keySession removeContentKeyRecipient:self];
    
    
#pragma mark -- Handling Expired Session Reports
//    AVContentKeySession pendingExpiredSessionReportsWithAppIdentifier:<#(nonnull NSData *)#> storageDirectoryAtURL:<#(nonnull NSURL *)#>
//    AVContentKeySession removePendingExpiredSessionReports:<#(nonnull NSArray<NSData *> *)#> withAppIdentifier:<#(nonnull NSData *)#> storageDirectoryAtURL:<#(nonnull NSURL *)#>
    
    
    
#pragma mark -- Getting Content Key Request Data
//    [keyRequest makeStreamingContentKeyRequestDataForApp:[@"com.fxw.VideoProcess" dataUsingEncoding:NSUTF8StringEncoding] contentIdentifier:[@"com.fxw.VideoProcess" dataUsingEncoding:NSUTF8StringEncoding] options:@{AVContentKeyRequestProtocolVersionsKey:@[@1]} completionHandler:^(NSData * _Nullable contentKeyRequestData, NSError * _Nullable error) {
//        NSLog(@"%@",contentKeyRequestData);
//    }];
    
#pragma mark -- Responding to the Content Key Request
//    NSError *error = nil;
//    [keyRequest respondByRequestingPersistableContentKeyRequestAndReturnError:&error];
//    keyRequest processContentKeyResponse:
//    keyRequest processContentKeyResponseError:<#(nonnull NSError *)#>
    
    
#pragma mark -- Getting Content Key Request Properties
    
    
    
    
    
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
