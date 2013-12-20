//
//  HHAnimationFactory.h
//  HHActivityViewKit
//
//  Created by lingaohe on 12/19/13.
//  Copyright (c) 2013 ilingaohe. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef NS_ENUM
#define NS_ENUM(_type, _name) enum _name : _type _name; enum _name : _type
#endif

#define HHANIMATIONKEY_DELEGATE @"HHANIMATIONKEY_DELEGATE"
#define HHANIMATIONKEY_STARTSELECTOR @"HHANIMATIONKEY_STARTSELECTOR"
#define HHANIMATIONKEY_STOPSELECTOR @"HHANIMATIONKEY_STOPSELECTOR"

typedef NS_ENUM (NSInteger, HHAnimationDirection){
  HHAnimationDirectionTop,
  HHAnimationDirectionBottom
};
typedef NS_ENUM(NSInteger, HHAnimationType) {
  HHAnimationTypeSlide
};


@interface HHAnimationFactory : NSObject

+ (instancetype)sharedInstance;

- (CAAnimation *)slideIn:(UIView *)view direction:(HHAnimationDirection)direction duration:(NSTimeInterval)duration;
- (CAAnimation *)slideIn:(UIView *)view direction:(HHAnimationDirection)direction duration:(NSTimeInterval)duration delegate:(id)delegate startSelector:(SEL)startSelector stopSelector:(SEL)stopSelector;
- (CAAnimation *)slideOut:(UIView *)view direction:(HHAnimationDirection)direction duration:(NSTimeInterval)duration;
- (CAAnimation *)slideOut:(UIView *)view direction:(HHAnimationDirection)direction duration:(NSTimeInterval)duration delegate:(id)delegate startSelector:(SEL)startSelector stopSelector:(SEL)stopSelector;

@end
