//
//  HHActivityView.h
//  HHActivityViewKit
//
//  Created by lingaohe on 12/19/13.
//  Copyright (c) 2013 ilingaohe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHAnimationFactory.h"

//Define
#define NOTIFICATION_OF_AVTIVITY_VIEW_DISMISS @"NOTIFICATION_OF_AVTIVITY_VIEW_DISMISS"
//
typedef NS_ENUM(NSInteger, HHAnimationMaskType) {
  HHAnimationMaskSuperView,
  HHAnimationMaskNone
};

@interface HHActivityView : UIView

//设置ContentView，ContentView包含要显示的内容
- (id)initWithContentView:(UIView *)contentView;
- (void)setupAnimationType:(HHAnimationType)animationType direction:(HHAnimationDirection)direction;
//不同的展示方式
- (void)showInView:(UIView *)view;
- (void)showInView:(UIView *)view duration:(CGFloat)duration;
- (void)showInView:(UIView *)view tapDismiss:(BOOL)tapDismiss;
//消失
- (void)dismissViewAnimated:(BOOL)animated;
@end
