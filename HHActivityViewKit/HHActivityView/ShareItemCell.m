//
//  ShareItemCell.m
//  HHActivityViewKit
//
//  Created by lingaohe on 12/20/13.
//  Copyright (c) 2013 ilingaohe. All rights reserved.
//

#import "ShareItemCell.h"

@interface ShareItemCell ()
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *title;
@end

@implementation ShareItemCell

- (instancetype)initWithImage:(UIImage *)image title:(NSString *)title
{
  if (self = [super init]) {
    self.image = image;
    self.title = title;
    [self setupView];
  }
  return self;
}

#pragma mark -- UIView
- (void)setupView
{
  self.frame = CGRectMake(0, 0, SHAREITEMCELL_WIDTH, SHAREITEMCELL_HEIGHT);
  //
  UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
  imageView.backgroundColor = [UIColor redColor];
  imageView.image = self.image;
  //
  UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, 60, 20)];
  titleView.textAlignment = NSTextAlignmentCenter;
  titleView.backgroundColor = [UIColor greenColor];
  titleView.text = self.title;
  //
  UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  shareBtn.frame = self.bounds;
  shareBtn.backgroundColor = [UIColor clearColor];
  [shareBtn addTarget:self action:@selector(handleShareBtnAction:) forControlEvents:UIControlEventTouchUpInside];
  //
  [self addSubview:imageView];
  [self addSubview:titleView];
  [self addSubview:shareBtn];
}
#pragma mark -- UIAction
- (void)handleShareBtnAction:(id)sender
{
  if (self.shareAction) {
    self.shareAction();
  }
}
@end
