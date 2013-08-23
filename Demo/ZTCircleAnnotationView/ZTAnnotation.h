//
//  ZTAnnotation.h
//  ZTCircleAnnotationView
//
//  Created by Zacks Tsang  on 13-8-21.
//  Copyright (c) 2013年 www.aiysea.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface ZTAnnotation : NSObject <MKAnnotation>{
    CLLocationCoordinate2D coordinate;
}

- (id)initWithCoordinate:(CLLocationCoordinate2D)aCoordinate;

- (CLLocationCoordinate2D)coordinate;
@end
