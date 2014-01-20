//
//  HHActivityView.m
//  HHActivityViewKit
//
//  Created by lingaohe on 12/19/13.
//  Copyright (c) 2013 ilingaohe. All rights reserved.
//

#import "HHActivityView.h"
#import "UIView+HHAnimation.h"  
#import "UIImage+HHBlur.h"

//Define
//Duration
#define DURATION_OF_ANIMATION 0.3
#define TAG_OF_BG_BTN 2001

@interface HHActivityView ()
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) NSTimer *dismissTimer;
@property (nonatomic, assign) BOOL tapDismiss;
@property (nonatomic, assign) HHAnimationType animationType;
@property (nonatomic, assign) HHAnimationDirection animationDirection;
@property (nonatomic, assign) HHAnimationMaskType maskType;
@property (nonatomic, weak) UIView *animationView;
@property (nonatomic, assign) UIInterfaceOrientation interfaceOrientation;
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
- (void)showCompletion
{
}
#pragma mark -- UIAction
- (void)handleTapDismissBtnAction:(id)sender
{
  [self dismiss];
}
- (void)handleTapBtnTouchDownAction:(id)sender
{
  SEL shouldDismissViewSelector = sel_registerName("shouldDismissView");
  if ([self.contentView respondsToSelector:shouldDismissViewSelector]) {
//    [self.contentView performSelector:shouldDismissViewSelector withObject:nil];
    //使用以下方式替换警告
    IMP imp = [self.contentView methodForSelector:shouldDismissViewSelector];
    void (*func)(id, SEL) = (void *)imp;
    func(self.contentView, shouldDismissViewSelector);
  }
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
  //获取背景图
  UIImage *superViewBgImage = [self.superview captureScreenShot];
  UIImage *croppedImage = [superViewBgImage croppedImageAtFrame:self.contentView.frame];
  UIImage *blurImage = [croppedImage applyLightEffect];
  UIImageView *bgImageView = [[UIImageView alloc] initWithImage:blurImage];
  [self.contentView addSubview:bgImageView];
  [self.contentView sendSubviewToBack:bgImageView];
  //
//  self.contentView.layer.shadowColor = [UIColor colorWithRed:0.5f green:0.5f blue:0.5f alpha:0.5f].CGColor;
//  self.contentView.layer.shadowRadius = 2.0f;
//  self.contentView.layer.shadowOpacity = 0.8f;
//  self.contentView.layer.shadowOffset = CGSizeMake(0, -4.0f);
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
    tapBtn.backgroundColor = [UIColor blackColor];
    tapBtn.alpha = 0.0f;
    [tapBtn addTarget:self action:@selector(handleTapBtnTouchDownAction:) forControlEvents:UIControlEventTouchDown];
    [tapBtn addTarget:self action:@selector(handleTapDismissBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [tapBtn setFrame:self.bounds];
    tapBtn.tag = TAG_OF_BG_BTN;
    [self addSubview:tapBtn];
    [self sendSubviewToBack:tapBtn];
  }
  //记录当前转向
  self.interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
}
- (void)setupAnimationIn
{
  //开始动画
  [self.animationView animationSlideInWithDirection:self.animationDirection duration:DURATION_OF_ANIMATION delegate:self startSelector:nil stopSelector:@selector(showCompletion)];
  //背景透明度的动画
  UIButton *tapBtn = (UIButton *)[self viewWithTag:TAG_OF_BG_BTN];
  tapBtn.alpha = 0.0f;
  [UIView animateWithDuration:DURATION_OF_ANIMATION animations:^{
    tapBtn.alpha = 0.6f;
  }];
}
- (void)setupAnimationOut
{
  //开始动画
  [self.animationView animationSlideOutWithDirection:self.animationDirection duration:DURATION_OF_ANIMATION delegate:self startSelector:nil stopSelector:@selector(dismissCompletion)];
  //背景透明度的动画
  UIButton *tapBtn = (UIButton *)[self viewWithTag:TAG_OF_BG_BTN];
  tapBtn.alpha = 0.6f;
  [UIView animateWithDuration:DURATION_OF_ANIMATION animations:^{
    tapBtn.alpha = 0.0f;
  }];
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
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleActivityViewDismissNotification:) name:NOTIFICATION_OF_AVTIVITY_VIEW_DISMISS object:nil];
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
  NSLog(@"InterfaceOrientation,Previous:%d,Current:%d",self.interfaceOrientation, orientation);
  if (self.interfaceOrientation != orientation) {
    self.interfaceOrientation = orientation;
    //
    [self dismissViewAnimated:NO];
  }
}
- (void)handleActivityViewDismissNotification:(NSNotification *)notification
{
  [self dismissViewAnimated:NO];
}
@end
