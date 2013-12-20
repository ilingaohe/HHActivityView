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
@property (nonatomic, copy) ShareAction willSelectAction;
@property (nonatomic, copy) ShareAction didSelectAction;

- (instancetype)initWithShareItemCells:(NSArray *)shareItemCells;
@end
