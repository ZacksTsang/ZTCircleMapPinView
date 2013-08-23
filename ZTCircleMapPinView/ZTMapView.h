//
//  ZTMapView.h
//  ZTCircleAnnotationView
//
//  Created by Zacks Tsang  on 13-8-21.
//  Copyright (c) 2013年 www.aiysea.com. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "ZTAnnotation.h"
#import "ZTAnnotationView.h"

@interface ZTMapView : MKMapView<MKMapViewDelegate>{
    
    ZTAnnotation *_detailsAnnotation;
    
}

@property(strong,nonatomic) ZTAnnotationView *detailView;

@property(nonatomic,weak) id<MKMapViewDelegate> delegate;

- (void)showCirclePinView;
@end
