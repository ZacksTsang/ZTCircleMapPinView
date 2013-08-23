//
//  UIView+ZTHelper.h
//  DivingIslandDemo
//
//  Created by Zacks Tsang  on 13-8-19.
//  Copyright (c) 2013年 www.aiysea.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZTHelper)

-(CGPoint)inSuperViewPoint:(UIView *)parentView;
- (void)fix2RoundCorners:(CGFloat)radius;
- (void)fix2ScaleView:(CGFloat)scale;
@end
