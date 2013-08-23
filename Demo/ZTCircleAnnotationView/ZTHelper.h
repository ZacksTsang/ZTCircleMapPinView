//
//  ZTHelper.h
//  ZTCircleAnnotationView
//
//  Created by Zacks Tsang  on 13-8-23.
//  Copyright (c) 2013年 www.aiysea.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZTHelper : NSObject

+(ZTHelper *)sharedInstance;
-(float)dealFixAngel:(CGPoint)finalPoint;

@end
