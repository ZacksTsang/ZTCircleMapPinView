//
//  ZTAnnotation.m
//  ZTCircleAnnotationView
//
//  Created by Zacks Tsang  on 13-8-21.
//  Copyright (c) 2013年 www.aiysea.com. All rights reserved.
//

#import "ZTAnnotation.h"

@implementation ZTAnnotation

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
