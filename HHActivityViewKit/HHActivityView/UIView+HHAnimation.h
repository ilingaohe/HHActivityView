//
//  UIView+HHAnimation.h
//  HHActivityViewKit
//
//  Created by lingaohe on 12/19/13.
//  Copyright (c) 2013 ilingaohe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHAnimationFactory.h"

@interface UIView (HHAnimation)

- (void)animationSlideInWithDirection:(HHAnimationDirection)direction duration:(NSTimeInterval)duration;
- (void)animationSlideInWithDirection:(HHAnimationDirection)direction duration:(NSTimeInterval)duration delegate:(id)delegate startSelector:(SEL)startSelector stopSelector:(SEL)stopSelector;
- (void)animationSlideOutWithDirection:(HHAnimationDirection)direction duration:(NSTimeInterval)duration;
- (void)animationSlideOutWithDirection:(HHAnimationDirection)direction duration:(NSTimeInterval)duration delegate:(id)delegate startSelector:(SEL)startSelector stopSelector:(SEL)stopSelector;
@end
