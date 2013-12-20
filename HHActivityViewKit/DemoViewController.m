//
//  DemoViewController.m
//  HHActivityViewKit
//
//  Created by lingaohe on 12/19/13.
//  Copyright (c) 2013 ilingaohe. All rights reserved.
//

#import "DemoViewController.h"
#import "HHActivityView.h"

@interface DemoViewController ()

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
  UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 480-100, 320, 100)];
  contentView.backgroundColor = [UIColor grayColor];
  //
  HHActivityView *activityView = [[HHActivityView alloc] initWithContentView:contentView];
  [activityView setupAnimationType:HHAnimationTypeSlide direction:HHAnimationDirectionBottom];
  [activityView showInView:self.view tapDismiss:YES];
}
@end
