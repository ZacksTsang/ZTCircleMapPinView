//
//  ZTSampleHelpAnnotation.m
//  ZTCircleAnnotationView
//
//  Created by Zacks Tsang  on 13-8-23.
//  Copyright (c) 2013年 www.aiysea.com. All rights reserved.
//

#import "ZTSampleHelpAnnotation.h"

@implementation ZTSampleHelpAnnotation
- (id)initWithCoordinate:(CLLocationCoordinate2D)aCoordinate
{
    self = [super init];
    if (self) {
        coordinate = aCoordinate;
    }
    
    return self;
}

- (CLLocationCoordinate2D)coordinate{
    return coordinate;
}
@end
