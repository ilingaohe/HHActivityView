//
//  ShareContentView.h
//  HHActivityViewKit
//
//  Created by lingaohe on 12/20/13.
//  Copyright (c) 2013 ilingaohe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareItemCell.h"

@interface ShareContentView : UIView
@property (nonatomic, copy) ShareAction cancelAction;

- (instancetype)initWithShareItemCells:(NSArray *)shareItemCells;

@end
