//
//  HHActivityView.m
//  HHActivityViewKit
//
//  Created by lingaohe on 12/19/13.
//  Copyright (c) 2013 ilingaohe. All rights reserved.
//

#import "HHActivityView.h"
#import "UIView+HHAnimation.h"  

//Define
//Duration
#define DURATION_OF_ANIMATION 0.3

@interface HHActivityView ()
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) NSTimer *dismissTimer;
@property (nonatomic, assign) BOOL tapDismiss;
@property (nonatomic, assign) HHAnimationType animationType;
@property (nonatomic, assign) HHAnimationDirection animationDirection;
@property (nonatomic, assign) HHAnimationMaskType maskType;
@property (nonatomic, strong) UIView *animationView;
@end

@implementation HHActivityView

#pragma mark -- Init
- (id)initWithContentView:(UIView *)contentView
{
  CGRect frame = contentView.frame;
  if (self = [super initWithFrame:frame]) {
    _contentView = contentView;
    [self addSubview:contentView];
    [self setupData];
    [self setupNotification];
  }
  return self;
}
- (void)dealloc
{
  [self removeNotification];
}
#pragma mark -- Private
- (void)show
{
  [self setupView];
  [self setupAnimationIn];
}
- (void)show:(NSTimeInterval)duration
{
  [self show];
  if (duration > 0) {
    self.dismissTimer = [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(handleDismissTimer:) userInfo:nil repeats:NO];
  }
}
- (void)dismiss
{
  [self setupAnimationOut];
}
- (void)dismissCompletion
{
  [self removeFromSuperview];
}
#pragma mark -- UIAction
- (void)handleTapDismissBtnAction:(id)sender
{
  [self dismiss];
}
#pragma mark -- NSTimer
- (void)handleDismissTimer:(NSTimer *)timer
{
  if (self.dismissTimer) {
    [self.dismissTimer invalidate];
  }
  [self dismiss];
}
#pragma mark -- SetupData
//初始化设置
- (void)setupData
{
  //默认设置
  self.animationType = HHAnimationTypeSlide; //使用Slide动画
  self.animationDirection = HHAnimationDirectionBottom; //默认从下方滑上来
  self.maskType = HHAnimationMaskSuperView; //默认覆盖住SuperView
  self.tapDismiss = NO; //点击不消失
}
#pragma mark -- UIView
- (void)setupView
{
  //调整位置
  self.backgroundColor = [UIColor clearColor];
  self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
  if (self.maskType == HHAnimationMaskSuperView) {
    //需要覆盖SuperView,只对contentView进行动画
    self.frame = self.superview.bounds;
    self.animationView = self.contentView;
  }else if (self.maskType == HHAnimationMaskNone){
    //不需要覆盖住SuperView，需要对整个View进行动画
    self.frame = self.contentView.frame;
    self.contentView.frame = self.bounds;
    self.animationView = self;
  }
  //设置TapDismiss背景
  if (self.tapDismiss) {
    UIButton *tapBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tapBtn.backgroundColor = [UIColor grayColor];
    tapBtn.alpha = 0.5f;
    [tapBtn addTarget:self action:@selector(handleTapDismissBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [tapBtn setFrame:self.bounds];
    [self addSubview:tapBtn];
    [self sendSubviewToBack:tapBtn];
  }
}
- (void)setupAnimationIn
{
  //开始动画
  [self.animationView animationSlideInWithDirection:self.animationDirection duration:DURATION_OF_ANIMATION];
}
- (void)setupAnimationOut
{
  //开始动画
  [self.animationView animationSlideOutWithDirection:self.animationDirection duration:DURATION_OF_ANIMATION delegate:self startSelector:nil stopSelector:@selector(dismissCompletion)];
}
- (void)layoutSubviews
{
  [super layoutSubviews];
  NSLog(@"%s",__FUNCTION__);
}
#pragma mark -- Public
- (void)setupAnimationType:(HHAnimationType)animationType direction:(HHAnimationDirection)direction
{
  self.animationType = animationType;
  self.animationDirection = direction;
}
- (void)showInView:(UIView *)view
{
  [self showInView:view duration:0];
}
- (void)showInView:(UIView *)view duration:(CGFloat)duration
{
  [self showInView:view duration:duration tapDismiss:NO];
}
- (void)showInView:(UIView *)view tapDismiss:(BOOL)tapDismiss
{
  [self showInView:view duration:0 tapDismiss:tapDismiss];
}
- (void)showInView:(UIView *)view duration:(CGFloat)duration tapDismiss:(BOOL)tapDismiss
{
  self.tapDismiss = tapDismiss;
  [view addSubview:self];
  [view bringSubviewToFront:self];
  [self show:duration];
}
- (void)dismissViewAnimated:(BOOL)animated
{
  if (animated) {
    [self dismiss];
  }else{
    if (self.dismissTimer) {
      [self.dismissTimer invalidate];
    }
    [self dismissCompletion];
  }
}
#pragma mark -- Notification
- (void)setupNotification
{
  [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleDeviceOrientationChangeNotification:) name:UIDeviceOrientationDidChangeNotification object:nil];
}
- (void)removeNotification
{
  [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)handleDeviceOrientationChangeNotification:(NSNotification *)notification
{
  NSLog(@"%s",__FUNCTION__);
  UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
  //  UIDeviceOrientation deveiceOrientation = [[UIDevice currentDevice] orientation];
  if (UIInterfaceOrientationIsPortrait(orientation)) {
    NSLog(@"Portrait");
  }else if (UIInterfaceOrientationIsLandscape(orientation)){
    NSLog(@"Landscape");
  }else{
    //默认也走竖屏
    NSLog(@"Portrait");
  }
  //
  [self dismissViewAnimated:NO];
}
@end
