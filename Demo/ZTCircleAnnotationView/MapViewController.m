//
//  MapViewController.m
//  ZTCircleAnnotationView
//
//  Created by Zacks Tsang  on 13-8-23.
//  Copyright (c) 2013年 www.aiysea.com. All rights reserved.
//

#import "MapViewController.h"
#import "DemoAnnotation.h"
#import "ZTContentView.h"


@interface MapViewController ()

@end

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _mapView=[[ZTMapView alloc]initWithFrame:self.view.bounds];
    
    
    
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = 51.22;
    coordinate.longitude = 4.39625;
    _mapView.region = MKCoordinateRegionMakeWithDistance(coordinate, 500000, 500000);
    
    NSMutableArray *pins = [NSMutableArray array];
    
    for(int i=0;i<5;i++) {
        CGFloat latDelta = rand()*0.125/RAND_MAX - 0.02;
        CGFloat lonDelta = rand()*0.130/RAND_MAX - 0.08;
        
        CGFloat lat = 51.21992;
        CGFloat lng = 4.39625;
        
        
        CLLocationCoordinate2D newCoord = {lat+latDelta*10, lng+lonDelta*10};
        DemoAnnotation *pin = [[DemoAnnotation alloc] initWithCoordinate:newCoord];

        
        [pins addObject:pin];
    }
    
    [_mapView addAnnotations:pins];
    
    _mapView.delegate=self;
    
    [self.view addSubview:_mapView];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    
    if ([annotation isKindOfClass:[ZTAnnotation class]]) {
        
        _mapView.detailView = (ZTAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"DetailsAnnotationView"];
        //        _detailView=nil;
        
        if (!_mapView.detailView) {
            _mapView.detailView = [[ZTAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"DetailsAnnotationView"];
            //view and line width
            [_mapView.detailView addCenterView:[[ZTContentView alloc] init] andRadius:30];
        }
        
        
        
        
        [_mapView showCirclePinView];
        
        
        return _mapView.detailView;
	}
    

    return nil;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
