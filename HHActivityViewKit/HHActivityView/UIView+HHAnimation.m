//
//  UIView+HHAnimation.m
//  HHActivityViewKit
//
//  Created by lingaohe on 12/19/13.
//  Copyright (c) 2013 ilingaohe. All rights reserved.
//

#import "UIView+HHAnimation.h"

@implementation UIView (HHAnimation)


- (void)animationSlideInWithDirection:(HHAnimationDirection)direction duration:(NSTimeInterval)duration
{
  CAAnimation *animation = [[HHAnimationFactory sharedInstance] slideIn:self direction:direction duration:duration];
  [self.layer addAnimation:animation forKey:[NSString stringWithFormat:@"%d",HHAnimationTypeSlide]];
}
- (void)animationSlideInWithDirection:(HHAnimationDirection)direction duration:(NSTimeInterval)duration delegate:(id)delegate startSelector:(SEL)startSelector stopSelector:(SEL)stopSelector
{
  CAAnimation *animation = [[HHAnimationFactory sharedInstance] slideIn:self direction:direction duration:duration delegate:delegate startSelector:startSelector stopSelector:stopSelector];
  [self.layer addAnimation:animation forKey:[NSString stringWithFormat:@"%d",HHAnimationTypeSlide]];
}
- (void)animationSlideOutWithDirection:(HHAnimationDirection)direction duration:(NSTimeInterval)duration
{
  CAAnimation *animation = [[HHAnimationFactory sharedInstance] slideOut:self direction:direction duration:duration];
  [self.layer addAnimation:animation forKey:[NSString stringWithFormat:@"%d",HHAnimationTypeSlide]];
}
- (void)animationSlideOutWithDirection:(HHAnimationDirection)direction duration:(NSTimeInterval)duration delegate:(id)delegate startSelector:(SEL)startSelector stopSelector:(SEL)stopSelector
{
  CAAnimation *animation = [[HHAnimationFactory sharedInstance] slideOut:self direction:direction duration:duration delegate:delegate startSelector:startSelector stopSelector:stopSelector];
  [self.layer addAnimation:animation forKey:[NSString stringWithFormat:@"%d",HHAnimationTypeSlide]];
}
@end
