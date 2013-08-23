//
//  ZTMapView.m
//  ZTCircleAnnotationView
//
//  Created by Zacks Tsang  on 13-8-21.
//  Copyright (c) 2013年 www.aiysea.com. All rights reserved.
//

#import "ZTMapView.h"
#import "ZTAnnotation.h"
#import "ZTAnnotationView.h"
#import "UIView+ZTHelper.h"
#import "ZTHelper.h"
#import "ZTSampleHelpAnnotation.h"

@implementation ZTMapView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        super.delegate=self;
    }
    return self;
}

-(MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
{
    if( [delegate respondsToSelector:@selector(mapView:viewForOverlay:)] )
    {
        return [delegate mapView:mapView viewForOverlay:overlay];
    }
    return nil;
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    
    if( [delegate respondsToSelector:@selector(mapView:viewForAnnotation:)] )
    {
        return [delegate mapView:mapView viewForAnnotation:annotation];
    }
    return nil;
}


- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    if( [delegate respondsToSelector:@selector(mapView:regionWillChangeAnimated:)] )
    {
        [delegate mapView:mapView regionWillChangeAnimated:animated];
    }
}

- (void)mapViewWillStartLoadingMap:(MKMapView *)mapView
{
    if( [delegate respondsToSelector:@selector(mapViewWillStartLoadingMap:)] )
    {
        [delegate mapViewWillStartLoadingMap:mapView];
    }
}
- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView
{
    if( [delegate respondsToSelector:@selector(mapViewDidFinishLoadingMap:)] )
    {
        [delegate mapViewDidFinishLoadingMap:mapView];
    }
}
- (void)mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error
{
    if( [delegate respondsToSelector:@selector(mapViewDidFailLoadingMap:withError:)] )
    {
        [delegate mapViewDidFailLoadingMap:mapView withError:error];
    }
}
- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    if( [delegate respondsToSelector:@selector(mapView:didAddAnnotationViews:)] )
    {
        [delegate mapView:mapView didAddAnnotationViews:views];
    }
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    if( [delegate respondsToSelector:@selector(mapView:annotationView:calloutAccessoryControlTapped:)] )
    {
        [delegate mapView:mapView annotationView:view calloutAccessoryControlTapped:control];
    }
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    if ([view.annotation isKindOfClass:[ZTSampleHelpAnnotation class]]) {
        
        if (_detailsAnnotation) {
            [mapView removeAnnotation:_detailsAnnotation];
            _detailsAnnotation = nil;
        }
        
        double delayInSeconds = 0.001;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            _detailsAnnotation = [[ZTAnnotation alloc]
                                  initWithCoordinate:view.annotation.coordinate];
            
            [mapView addAnnotation:_detailsAnnotation];
            
        });
        
        NSLog(@"anno add");

    }
    
    
    
    if( [delegate respondsToSelector:@selector(mapView:didSelectAnnotationView:)] )
    {
        [delegate mapView:mapView didSelectAnnotationView:view];
    }
}
- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view
{
    
    if (_detailsAnnotation&& ![view isKindOfClass:[ZTAnnotation class]]) {
        if (_detailsAnnotation.coordinate.latitude == view.annotation.coordinate.latitude&&
            _detailsAnnotation.coordinate.longitude == view.annotation.coordinate.longitude) {
            if (_detailView) {
                [_detailView dismissView:^{
                    if (_detailsAnnotation) {
                        [mapView removeAnnotation:_detailsAnnotation];
                        _detailsAnnotation = nil;
                        
                        _detailView=nil;
                    }
                    
                }];
            }
        }
        NSLog(@"finish");
    }

    
    if( [delegate respondsToSelector:@selector(mapView:didDeselectAnnotationView:)] )
    {
        [delegate mapView:mapView didDeselectAnnotationView:view];
    }
}

- (void)mapViewWillStartLocatingUser:(MKMapView *)mapView
{
    if( [delegate respondsToSelector:@selector(mapViewWillStartLocatingUser:)] )
    {
        [delegate mapViewWillStartLocatingUser:mapView];
    }
}
- (void)mapViewDidStopLocatingUser:(MKMapView *)mapView
{
    if( [delegate respondsToSelector:@selector(mapViewDidStopLocatingUser:)] )
    {
        [delegate mapViewDidStopLocatingUser:mapView];
    }
}
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if( [delegate respondsToSelector:@selector(mapView:didUpdateUserLocation:)] )
    {
        [delegate mapView:mapView didUpdateUserLocation:userLocation];
    }
}
- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    if( [delegate respondsToSelector:@selector(mapView:didFailToLocateUserWithError:)] )
    {
        [delegate mapView:mapView didFailToLocateUserWithError:error];
    }
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view didChangeDragState:(MKAnnotationViewDragState)newState
   fromOldState:(MKAnnotationViewDragState)oldState
{
    if( [delegate respondsToSelector:@selector(mapView:annotationView:didChangeDragState:fromOldState:)] )
    {
        [delegate mapView:mapView annotationView:view didChangeDragState:newState fromOldState:oldState];
    }
}

// Called after the provided overlay views have been added and positioned in the map.
- (void)mapView:(MKMapView *)mapView didAddOverlayViews:(NSArray *)overlayViews
{
    if( [delegate respondsToSelector:@selector(mapView:didAddOverlayViews:)] )
    {
        [delegate mapView:mapView didAddOverlayViews:overlayViews];
    }
}

- (void) mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    if (_detailView) {
        
        [self roundPinView];
    }
    
    if( [delegate respondsToSelector:@selector(mapView:regionDidChangeAnimated:)] )
    {
        [delegate mapView:mapView regionDidChangeAnimated:animated];
    }
}


- (void)roundPinView
{
    CGPoint centerPoint=[_detailView inSuperViewPoint:nil];
   
    
    if (centerPoint.y>self.frame.size.height||centerPoint.y<0||centerPoint.x<0||centerPoint.x>self.frame.size.width) {
        
        [_detailView dismissView:^{
            if (_detailsAnnotation) {
                ZTSampleHelpAnnotation *pin = [[ZTSampleHelpAnnotation alloc] initWithCoordinate: _detailsAnnotation.coordinate];
                
                
                [self addAnnotation:pin];
                [self removeAnnotation:_detailsAnnotation];
            }
            
        }];
        
    }else{
        [_detailView turnByAngel:[[ZTHelper sharedInstance] dealFixAngel:centerPoint]];
    }
}


- (void)showCirclePinView
{
    if (_detailView) {
        [_detailView hiddenView];
        
        double delayInSeconds = 0.000001;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            [[_detailView superview] bringSubviewToFront:_detailView];
            
            CGPoint centerPoint=[_detailView inSuperViewPoint:nil];
            //            centerPoint.y+=10;
            //            centerPoint.x+=6;
            
            [_detailView showByAngle:[[ZTHelper sharedInstance] dealFixAngel:centerPoint]];
        });
    }
    
}

@end
