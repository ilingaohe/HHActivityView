//
//  DemoViewController.m
//  HHActivityViewKit
//
//  Created by lingaohe on 12/19/13.
//  Copyright (c) 2013 ilingaohe. All rights reserved.
//

#import "DemoViewController.h"
#import "HHActivityView.h"
#import "ShareContentView.h"

@interface DemoViewController ()
@property (nonatomic, strong) HHActivityView *activityView;
@end

@implementation DemoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
  [self setupView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)shouldAutorotate
{
  NSLog(@"%s",__FUNCTION__);
  return YES;
}
#pragma mark --
- (void)setupView
{
  //
  UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
  bgImageView.image = [UIImage imageNamed:@"Default.png"];
  bgImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self.view addSubview:bgImageView];
  //
  UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  shareBtn.frame = CGRectMake(0, 0, 140, 80);
  [shareBtn setBackgroundColor:[UIColor redColor]];
  [shareBtn setImage:[UIImage imageNamed:@"share_icon_normal"] forState:UIControlStateNormal];
  [shareBtn setImage:[UIImage imageNamed:@"share_icon_pressed"] forState:UIControlStateHighlighted];
  [shareBtn setTitle:@"Share" forState:UIControlStateNormal];
  [shareBtn addTarget:self action:@selector(handleBtnAction:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:shareBtn];
  //AutoLayout
  [shareBtn setTranslatesAutoresizingMaskIntoConstraints:NO];
  NSLayoutConstraint *centerYContraint = [NSLayoutConstraint constraintWithItem:shareBtn attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:[shareBtn superview] attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0];
  NSLayoutConstraint *centerXContraint = [NSLayoutConstraint constraintWithItem:shareBtn attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:[shareBtn superview] attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0];
  [[shareBtn superview] addConstraints:@[centerYContraint,centerXContraint]];
}
- (UIImage *)fetchImageAtIndex:(NSUInteger)index
{
  UIImage *image = [UIImage imageNamed:@"share_apple"];
  switch (index) {
    case 0:
      image = [UIImage imageNamed:@"share_apple"];
      break;
    case 1:
      image = [UIImage imageNamed:@"share_link"];
      break;
    case 2:
      image = [UIImage imageNamed:@"share_sms"];
      break;
    case 3:
      image = [UIImage imageNamed:@"share_mail"];
      break;
    case 4:
      image = [UIImage imageNamed:@"share_weibosina"];
      break;
    case 5:
      image = [UIImage imageNamed:@"share_weibotencent"];
      break;
    case 6:
      image = [UIImage imageNamed:@"share_renren"];
      break;
    case 7:
      image = [UIImage imageNamed:@"share_weixintimeline"];
      break;
    case 8:
      image = [UIImage imageNamed:@"share_weixinsession"];
      break;
    default:
      break;
  }
  return image;
}
- (void)handleBtnAction:(id)sender
{
  //
  NSMutableArray *shareItemCells = [NSMutableArray array];
  for (int index=0; index<9; index++) {
    ShareItemCell *itemOne = [[ShareItemCell alloc] initWithImage:[self fetchImageAtIndex:index] title:[NSString stringWithFormat:@"%d",index]];
    itemOne.shareAction = ^{
      NSLog(@"Choose:%d",index);
    };
    [shareItemCells addObject:itemOne];
  }
  //
  ShareContentView *contentView = [[ShareContentView alloc] initWithShareItemCells:shareItemCells];
  contentView.center = CGPointMake([self currentScreenViewWidth]/2.0f, [self currentScreenViewHeight]-contentView.frame.size.height/2.0f);
  //
  HHActivityView *activityView = [[HHActivityView alloc] initWithContentView:contentView];
  [activityView setupAnimationType:HHAnimationTypeSlide direction:HHAnimationDirectionBottom];
  __weak HHActivityView *weakActivityView = activityView;
  contentView.cancelAction = ^{
    NSLog(@"Cancel");
    [weakActivityView dismissViewAnimated:YES];
  };
  contentView.willSelectAction = ^{
    [weakActivityView dismissViewAnimated:YES];
  };
  contentView.didSelectAction = ^{
  
  };
  __weak UIView *showView = self.view;
  [activityView showInView:showView tapDismiss:YES];
//  self.activityView = activityView;
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
//根据当前屏幕转向的不同，返回不同的宽度
- (CGFloat)currentScreenViewHeight
{
  CGSize screenSize = [UIScreen mainScreen].bounds.size;
  UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
  if (UIInterfaceOrientationIsPortrait(orientation)) {
    return screenSize.height;
  }else if (UIInterfaceOrientationIsLandscape(orientation)){
    return screenSize.width;
  }else{
    //默认也走竖屏
    return screenSize.height;
  }
}
@end
