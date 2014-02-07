//
//  ShareContentView.m
//  HHActivityViewKit
//
//  Created by lingaohe on 12/20/13.
//  Copyright (c) 2013 ilingaohe. All rights reserved.
//

#import "ShareContentView.h"

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define HEIGHT_OF_CANCELBTN 50.0f
#define TAG_OF_CANCEL_BTN 1001

@interface ShareContentView ()
@property (nonatomic, strong) NSArray *shareItemCells;
@property (nonatomic, assign) UIDeviceOrientation deviceOrientation;
@property (nonatomic, assign) UIInterfaceOrientation interfaceOrientation;
@end

@implementation ShareContentView

- (instancetype)initWithShareItemCells:(NSArray *)shareItemCells
{
  if (self = [super init]) {
    self.shareItemCells = shareItemCells;
    [self setupView];
    [self setupNotification];
  }
  return self;
}
- (void)dealloc
{
  [self removeNotification];
}
#pragma mark -- UIView
- (void)setupView
{
  self.backgroundColor = [UIColor clearColor];
  //
  UIScrollView *containerView = [self productContainerView];
  containerView.showsHorizontalScrollIndicator = NO;
  containerView.showsVerticalScrollIndicator = NO;
  //
  UIButton *cancelBtn = [self productCancelBtn];
  cancelBtn.tag = TAG_OF_CANCEL_BTN;
  cancelBtn.center = CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height - cancelBtn.frame.size.height/2.0f);
  //
  [self addSubview:containerView];
  [self addSubview:cancelBtn];
  //记录当前转向
  self.deviceOrientation = [[UIDevice currentDevice] orientation];
  self.interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
  
}
- (UIScrollView *)productContainerView
{
  if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
    //iOS7.0及以上系统，使用单行布局
    return [self productContainerViewWithFlowLayout];
  }else{
    //iOS7.0之前的系统，使用九宫格布局
    return [self productContainerViewWithGridLayout];
  }
//  return [self productContainerViewWithGridLayout];
}
- (UIScrollView *)productContainerViewWithFlowLayout
{
  //单行方式的布局
  CGFloat margin = 10.0f;
  CGFloat itemCellWidth = SHAREITEMCELL_WIDTH;
  CGFloat itemCellHeight = SHAREITEMCELL_HEIGHT;
  CGFloat height = itemCellHeight + HEIGHT_OF_CANCELBTN + margin * 1;
  self.frame = CGRectMake(0, 0, [self currentScreenViewWidth], height);
  //
  UIScrollView *containerView = [[UIScrollView alloc] initWithFrame:self.bounds];
  CGFloat contentSizeWidth = SHAREITEMCELL_WIDTH * self.shareItemCells.count + margin * (self.shareItemCells.count + 1);
  containerView.contentSize = CGSizeMake(contentSizeWidth, containerView.frame.size.height);
  //
  for (int index=0; index<self.shareItemCells.count; index++) {
    ShareItemCell *itemCell = [self.shareItemCells objectAtIndex:index];
    CGFloat centerX = margin + itemCellWidth/2.0f + (itemCellWidth + margin) * index;
    CGFloat centerY = itemCell.frame.size.height/2.0f;
    itemCell.center = CGPointMake(centerX, centerY);
    [containerView addSubview:itemCell];
  }
  return containerView;
}
- (UIScrollView *)productContainerViewWithGridLayout
{
  UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
  if (UIInterfaceOrientationIsPortrait(orientation)) {
    return [self productContainerViewWithGridLayoutForPortraitOrientation];
  }else if (UIInterfaceOrientationIsLandscape(orientation)){
    return [self productContainerViewWithGridLayoutForLandscapeOrientation];
  }else{
    //默认也走竖屏
    return [self productContainerViewWithGridLayoutForPortraitOrientation];
  }
}
- (UIScrollView *)productContainerViewWithGridLayoutForLandscapeOrientation
{
  //横屏方式的九宫格，每行6个排布，最多2行，多了的话，左右滑动
  int maxColumns = 6;
  int maxRows = 2;
  CGFloat itemCellWidth = SHAREITEMCELL_WIDTH;
  CGFloat itemCellHeight = SHAREITEMCELL_HEIGHT;
  CGFloat viewWidth = [self currentScreenViewWidth];
  CGFloat margin = (viewWidth - itemCellWidth*maxColumns)/(maxColumns+1);
  CGFloat viewHeight = itemCellHeight * maxRows + HEIGHT_OF_CANCELBTN + margin * 1;
  self.frame = CGRectMake(0, 0, viewWidth, viewHeight);
  //
  UIScrollView *containerView = [[UIScrollView alloc] initWithFrame:self.bounds];
  containerView.contentSize = CGSizeMake(containerView.frame.size.width, containerView.frame.size.height);
  //
  for (int index=0; index<self.shareItemCells.count; index++) {
    int row = index / maxColumns;
    int column = index % maxColumns;
    ShareItemCell *itemCell = [self.shareItemCells objectAtIndex:index];
    CGFloat centerX = margin + itemCellWidth/2.0f + (itemCellWidth + margin) * column;
    CGFloat centerY = itemCellHeight/2.0f + row * itemCellHeight;
    itemCell.center = CGPointMake(centerX, centerY);
    [containerView addSubview:itemCell];
  }
  return containerView;
}
- (UIScrollView *)productContainerViewWithGridLayoutForPortraitOrientation
{
  //竖屏方式的九宫格，每行4个排布，最多三行，多了的话，左右滑动
  int maxColumns = 4;
  int maxRows = 3;
  CGFloat itemCellWidth = SHAREITEMCELL_WIDTH;
  CGFloat itemCellHeight = SHAREITEMCELL_HEIGHT;
  CGFloat viewWidth = [self currentScreenViewWidth];
  CGFloat margin = (viewWidth - itemCellWidth*maxColumns)/(maxColumns+1);
  CGFloat viewHeight = itemCellHeight * maxRows + HEIGHT_OF_CANCELBTN + margin * 1;
  self.frame = CGRectMake(0, 0, viewWidth, viewHeight);
  //
  UIScrollView *containerView = [[UIScrollView alloc] initWithFrame:self.bounds];
  containerView.contentSize = CGSizeMake(containerView.frame.size.width, containerView.frame.size.height);
  //
  for (int index=0; index<self.shareItemCells.count; index++) {
    int row = index / maxColumns;
    int column = index % maxColumns;
    ShareItemCell *itemCell = [self.shareItemCells objectAtIndex:index];
    CGFloat centerX = margin + itemCellWidth/2.0f + (itemCellWidth + margin) * column;
    CGFloat centerY = itemCellHeight/2.0f + row * itemCellHeight;
    itemCell.center = CGPointMake(centerX, centerY);
    [containerView addSubview:itemCell];
  }
  return containerView;
}
- (UIButton *)productCancelBtn
{
  UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  cancelBtn.frame = CGRectMake(0, 0, [self currentScreenViewWidth]-0.0f, HEIGHT_OF_CANCELBTN);
  cancelBtn.backgroundColor = [UIColor grayColor];
  cancelBtn.alpha = 0.8f;
  [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
  [cancelBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
  [cancelBtn setBackgroundImage:[[UIImage imageNamed:@"share_cancel_btn_n"] stretchableImageWithLeftCapWidth:5 topCapHeight:20] forState:UIControlStateNormal];
  [cancelBtn setBackgroundImage:[[UIImage imageNamed:@"share_cancel_btn_h"] stretchableImageWithLeftCapWidth:5 topCapHeight:20] forState:UIControlStateHighlighted];
  [cancelBtn addTarget:self action:@selector(handleCancelBtnAction:) forControlEvents:UIControlEventTouchUpInside];
  return cancelBtn;
}
//根据当前屏幕转向的不同，返回不同的宽度
- (CGFloat)currentScreenViewWidth
{
  CGSize screenSize = [UIScreen mainScreen].bounds.size;
  UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
  if (UIInterfaceOrientationIsPortrait(orientation)) {
    return screenSize.width;
  }else if (UIInterfaceOrientationIsLandscape(orientation)){
    return screenSize.height;
  }else{
    //默认也走竖屏
    return screenSize.width;
  }
}
- (void)layoutSubviews
{
  [super layoutSubviews];
  NSLog(@"%s",__FUNCTION__);
}
#pragma mark -- UIAction
- (void)handleCancelBtnAction:(id)sender
{
  if (self.cancelAction) {
    self.cancelAction();
  }
}
#pragma mark -- Public
- (void)shouldDismissView
{
  UIButton *cancelBtn = (UIButton *)[self viewWithTag:TAG_OF_CANCEL_BTN];
  [cancelBtn setHighlighted:YES];
}
#pragma mark -- Notification
- (void)setupNotification
{
  [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleDeviceOrientationChangeNotification:) name:UIDeviceOrientationDidChangeNotification object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleShareItemWillSelectNotification:) name:NOTIFICATION_SHAREITEM_WILL_SELECT object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleShareItemDidSelectNotification:) name:NOTIFICATION_SHAREITEM_DID_SELECT object:nil];
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
  UIDeviceOrientation deviceOrientation = [[UIDevice currentDevice] orientation];
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
  NSLog(@"DeviceOrientation,Previous:%d,Current:%d",self.deviceOrientation, deviceOrientation);
  self.interfaceOrientation = orientation;
  self.deviceOrientation = deviceOrientation;
}
- (void)handleShareItemWillSelectNotification:(NSNotification *)notification
{
  if (self.willSelectAction) {
    self.willSelectAction();
  }
}
- (void)handleShareItemDidSelectNotification:(NSNotification *)notification
{
  if (self.didSelectAction) {
    self.didSelectAction();
  }
}
@end
