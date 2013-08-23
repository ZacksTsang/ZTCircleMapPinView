//
//  MapViewController.h
//  ZTCircleAnnotationView
//
//  Created by Zacks Tsang  on 13-8-23.
//  Copyright (c) 2013年 www.aiysea.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTMapView.h"

@interface MapViewController : UIViewController<MKMapViewDelegate>{

    ZTMapView *_mapView;
}

@end
