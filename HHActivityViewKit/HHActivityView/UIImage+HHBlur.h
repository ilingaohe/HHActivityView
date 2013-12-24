//
//  UIImage+HHBlur.h
//  HHActivityViewKit
//
//  Created by lingaohe on 12/24/13.
//  Copyright (c) 2013 ilingaohe. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (HHScreenShot)
- (UIImage *)captureScreenShot;
@end
@interface UIImage (HHBlur)
-(UIImage *)croppedImageAtFrame:(CGRect)frame;
- (UIImage *)applyLightEffect;
@end
