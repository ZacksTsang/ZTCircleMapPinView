//
//  ZTContentView.m
//  ZTCircleAnnotationView
//
//  Created by Zacks Tsang  on 13-8-21.
//  Copyright (c) 2013年 www.aiysea.com. All rights reserved.
//

#import "ZTContentView.h"
#import "UIView+ZTHelper.h"

@implementation ZTContentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self=(ZTContentView *)[[[NSBundle mainBundle] loadNibNamed:@"ZTContentView" owner:nil options:nil] objectAtIndex:0];
        
        [self.mainView fix2RoundCorners:self.mainView.frame.size.width/2];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
