//
//  UIView+ZTHelper.m
//  DivingIslandDemo
//
//  Created by Zacks Tsang  on 13-8-19.
//  Copyright (c) 2013年 www.aiysea.com. All rights reserved.
//

#import "UIView+ZTHelper.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (ZTHelper)


-(CGPoint)inSuperViewPoint:(UIView *)parentView{

    CGPoint centerPoint=CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    
    UIView *superView=[self superview];
    
    while (superView!=nil) {
        
        if ([superView isKindOfClass:[UIWindow class]]||parentView!=nil) {
            
            centerPoint=[self convertPoint:centerPoint toView:superView];
            
            break;
            
        }

        
        superView=[superView superview];
        
    }
    
    
    return centerPoint;

}
- (void)fix2RoundCorners:(CGFloat)radius{
    
    [self.layer setMasksToBounds:YES];
    [self.layer setCornerRadius:radius];
    self.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.layer.borderWidth = 2.0;
    
}


- (void)fix2ScaleView:(CGFloat)scale{
    
    CGAffineTransform currentTransform = self.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, scale,scale);
    [self setTransform:newTransform];
    
}
@end
