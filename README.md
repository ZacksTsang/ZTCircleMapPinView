ZTCircleMapPinView
==================

show the map pin view to center view what inspired by CityGuide

#IOS Require
  ios5 and above

#Usage
##First
make an annotation from ZTSampleHelpAnnotation
##Second
make a annotionView what you want [just like the ZTContentView]
##Third
overwrite the method of ZTMapView 

    if ([annotation isKindOfClass:[ZTAnnotation class]]) {
        
        _mapView.detailView = (ZTAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"DetailsAnnotationView"];
        //        _detailView=nil;
        
        if (!_mapView.detailView) {
            _mapView.detailView = [[ZTAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"DetailsAnnotationView"];
            
            [_mapView.detailView addCenterView:[[ZTContentView alloc] init] andRadius:30];
        }
        
        
        
        
        [_mapView showCirclePinView];
        
        
        return _mapView.detailView;
  	}
    
