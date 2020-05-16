//
//  JMPlayerControlLayer.m
//  VideoProcess
//
//  Created by tiger fly on 2020/3/14.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "JMPlayerControlLayer.h"
#import "UIColor+Add.h"

@implementation JMPlayerControlLayer

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
 
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithRGB:0x333333];
        self.alpha = 0.3f;
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    if (self && !self.hidden) {
        self.hidden = YES;
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
}



@end
