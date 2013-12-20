//
//  ShareItemCell.h
//  HHActivityViewKit
//
//  Created by lingaohe on 12/20/13.
//  Copyright (c) 2013 ilingaohe. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SHAREITEMCELL_WIDTH 60.0f
#define SHAREITEMCELL_HEIGHT 80.0f

typedef void(^ShareAction)(void);

@interface ShareItemCell : UIView
@property (nonatomic, copy) ShareAction shareAction;

- (instancetype)initWithImage:(UIImage *)image title:(NSString *)title;
@end
