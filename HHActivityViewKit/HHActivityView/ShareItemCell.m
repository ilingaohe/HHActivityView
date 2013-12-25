//
//  ShareItemCell.m
//  HHActivityViewKit
//
//  Created by lingaohe on 12/20/13.
//  Copyright (c) 2013 ilingaohe. All rights reserved.
//

#import "ShareItemCell.h"
#import "UIImage+HHBlur.h"

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
  UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 15, 50, 50)];
  imageView.backgroundColor = [UIColor clearColor];
  imageView.image = self.image;
  //
  UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, 60, 20)];
  titleView.textAlignment = NSTextAlignmentCenter;
  titleView.backgroundColor = [UIColor clearColor];
  titleView.font = [UIFont systemFontOfSize:10.0f];
  titleView.numberOfLines = 2;
  titleView.text = self.title;
  //
  UIColor *maskColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
  UIImage *maskImage = [UIImage imageWithColor:maskColor size:imageView.bounds.size];
  //
  UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  shareBtn.frame = imageView.frame;
  [shareBtn setImage:maskImage forState:UIControlStateHighlighted];
  [shareBtn addTarget:self action:@selector(handleShareBtnAction:) forControlEvents:UIControlEventTouchUpInside];
  shareBtn.layer.cornerRadius = 5.0f;
  shareBtn.layer.masksToBounds = YES;
  //
  [self addSubview:imageView];
  [self addSubview:titleView];
  [self addSubview:shareBtn];
}
#pragma mark -- UIAction
- (void)handleShareBtnAction:(id)sender
{
  [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_SHAREITEM_WILL_SELECT object:nil];
  if (self.shareAction) {
    self.shareAction();
  }
  [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_SHAREITEM_DID_SELECT object:nil];
}
@end
