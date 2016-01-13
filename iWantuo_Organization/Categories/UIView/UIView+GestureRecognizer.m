//
//  UIView+GestureRecognizer.m
//  DoctorYL
//
//  Created by 月 吴 on 15/12/18.
//  Copyright © 2015年 yuntai. All rights reserved.
//

#import "UIView+GestureRecognizer.h"

@implementation UIView (GestureRecognizer)

- (BOOL)hasGestureRecognizer:(UIGestureRecognizer *)gesture {
    
    NSArray *gestures = [self gestureRecognizers];
    for (UIGestureRecognizer *hasGesture in gestures) {
        if ([hasGesture isKindOfClass:[gesture class]]) {
            return YES;//该view上有gesture类型的手势事件
        }
    }
    return NO;
    
}


@end
