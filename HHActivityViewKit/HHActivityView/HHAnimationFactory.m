//
//  HHAnimationFactory.m
//  HHActivityViewKit
//
//  Created by lingaohe on 12/19/13.
//  Copyright (c) 2013 ilingaohe. All rights reserved.
//

#import "HHAnimationFactory.h"

@implementation HHAnimationFactory

+ (instancetype)sharedInstance
{
  static HHAnimationFactory *instance;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [[HHAnimationFactory alloc] init];
  });
  return instance;
}

- (CAAnimation *)slideIn:(UIView *)view direction:(HHAnimationDirection)direction duration:(NSTimeInterval)duration
{
  CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"position"];
	
	animation.fromValue = [NSValue valueWithCGPoint:[self animationStartPoint:view direction:direction animationType:HHAnimationTypeSlide]];
	animation.toValue = [NSValue valueWithCGPoint:view.center];
	animation.duration = duration;
	animation.removedOnCompletion = NO;
	animation.fillMode = kCAFillModeBoth;
	animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
	animation.delegate = self;
	
	return animation;
}
- (CAAnimation *)slideIn:(UIView *)view direction:(HHAnimationDirection)direction duration:(NSTimeInterval)duration delegate:(id)delegate startSelector:(SEL)startSelector stopSelector:(SEL)stopSelector
{
  CAAnimation *animation = [self slideIn:view direction:direction duration:duration];
  //
  [animation setValue:delegate forKey:HHANIMATIONKEY_DELEGATE];
  [animation setValue:NSStringFromSelector(startSelector) forKey:HHANIMATIONKEY_STARTSELECTOR];
  [animation setValue:NSStringFromSelector(stopSelector) forKey:HHANIMATIONKEY_STOPSELECTOR];
  //
  return animation;
}
- (CAAnimation *)slideOut:(UIView *)view direction:(HHAnimationDirection)direction duration:(NSTimeInterval)duration
{
  CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"position"];
	
	animation.fromValue = [NSValue valueWithCGPoint:view.center];
	animation.toValue = [NSValue valueWithCGPoint:[self animationStartPoint:view direction:direction animationType:HHAnimationTypeSlide]];
	animation.duration = duration;
	animation.removedOnCompletion = NO;
	animation.fillMode = kCAFillModeBoth;
	animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
	animation.delegate = self;
	
	return animation;
}
- (CAAnimation *)slideOut:(UIView *)view direction:(HHAnimationDirection)direction duration:(NSTimeInterval)duration delegate:(id)delegate startSelector:(SEL)startSelector stopSelector:(SEL)stopSelector
{
  CAAnimation *animation = [self slideOut:view direction:direction duration:duration];
  //
  [animation setValue:delegate forKey:HHANIMATIONKEY_DELEGATE];
  [animation setValue:NSStringFromSelector(startSelector) forKey:HHANIMATIONKEY_STARTSELECTOR];
  [animation setValue:NSStringFromSelector(stopSelector) forKey:HHANIMATIONKEY_STOPSELECTOR];
  //
  return animation;
}
#pragma mark -- Utilities
- (CGPoint)animationStartPoint:(UIView *)view direction:(HHAnimationDirection)direction animationType:(HHAnimationType)animationType
{
  CGPoint animationStartPoint = CGPointZero;
  if (HHAnimationTypeSlide == animationType) {
    if (HHAnimationDirectionTop == direction) {
      animationStartPoint = CGPointMake(view.center.x, [view superview].frame.origin.y - view.frame.size.height/2.0f);
    }else if (HHAnimationDirectionBottom == direction){
      animationStartPoint = CGPointMake(view.center.x, [view superview].frame.origin.y + [view superview].frame.size.height + view.frame.size.height/2.0f);
    }
  }
  return animationStartPoint;
}
#pragma mark -- CAAnimationDelegate
- (void)animationDidStart:(CAAnimation *)anim
{
  NSLog(@"%s",__FUNCTION__);
  id animationDelegate = [anim valueForKey:HHANIMATIONKEY_DELEGATE];
  NSString *animationStartSelector = [anim valueForKey:HHANIMATIONKEY_STARTSELECTOR];
  if (animationDelegate && animationStartSelector) {
    SEL startSelector = NSSelectorFromString(animationStartSelector);
    if ([animationDelegate respondsToSelector:startSelector]) {
      //
//      [animationDelegate performSelector:startSelector withObject:nil];
      //使用以下方式替换警告
      IMP imp = [animationDelegate methodForSelector:startSelector];
      void (*func)(id, SEL) = (void *)imp;
      func(animationDelegate, startSelector);
    }
  }
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
  NSLog(@"%s",__FUNCTION__);
  id animationDelegate = [anim valueForKey:HHANIMATIONKEY_DELEGATE];
  NSString *animationStopSelector = [anim valueForKey:HHANIMATIONKEY_STOPSELECTOR];
  if (animationDelegate && animationStopSelector) {
    SEL stopSelector = NSSelectorFromString(animationStopSelector);
    if ([animationDelegate respondsToSelector:stopSelector]) {
        //使用以下方式替换警告
//      [animationDelegate performSelector:stopSelector withObject:nil];
      IMP imp = [animationDelegate methodForSelector:stopSelector];
      void (*func)(id, SEL) = (void *)imp;
      func(animationDelegate, stopSelector);
    }
  }
}
@end
