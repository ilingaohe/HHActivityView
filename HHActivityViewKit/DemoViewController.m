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
//  [self.activityView dismissViewAnimated:NO];
  return YES;
}
#pragma mark --
- (void)setupView
{
  UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
  btn.frame = CGRectMake(100, 100, 120, 60);
  btn.backgroundColor = [UIColor redColor];
  [btn addTarget:self action:@selector(handleBtnAction:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:btn];
}
- (void)handleBtnAction:(id)sender
{
  //
  NSMutableArray *shareItemCells = [NSMutableArray array];
  for (int index=0; index<9; index++) {
    ShareItemCell *itemOne = [[ShareItemCell alloc] initWithImage:nil title:[NSString stringWithFormat:@"%d",index]];
    itemOne.shareAction = ^{
      NSLog(@"%d",index);
    };
    [shareItemCells addObject:itemOne];
  }
  //
  ShareContentView *contentView = [[ShareContentView alloc] initWithShareItemCells:shareItemCells];
  contentView.cancelAction = ^{
    NSLog(@"Cancel");
  };
  contentView.backgroundColor = [UIColor grayColor];
  contentView.center = CGPointMake([self currentScreenViewWidth]/2.0f, [self currentScreenViewHeight]-contentView.frame.size.height/2.0f);
  //
  HHActivityView *activityView = [[HHActivityView alloc] initWithContentView:contentView];
  [activityView setupAnimationType:HHAnimationTypeSlide direction:HHAnimationDirectionBottom];
  [activityView showInView:self.view tapDismiss:YES];
  self.activityView = activityView;
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
