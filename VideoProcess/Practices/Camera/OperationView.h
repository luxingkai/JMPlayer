//
//  OperationView.h
//  VideoProcess
//
//  Created by tigerfly on 2020/5/28.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol OperationDelegate <NSObject>

@optional
- (void)operation;

@end

@interface OperationCell : UICollectionViewCell

@property (nonatomic, strong) NSString *title;
@end

@interface OperationView : UIView

@property (nonatomic, nullable, weak) id<OperationDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
