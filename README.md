ZTCircleMapPinView
==================

show the map pin view to center view what inspired by CityGuide

![Preview](http://ww3.sinaimg.cn/small/b0c9ca8cgw1e8jk5ehj8ej20hs0qoq7t.jpg) 
![Preview](http://ww4.sinaimg.cn/small/b0c9ca8cgw1e8jk54pchej20hs0qodku.jpg)
![Preview](http://ww1.sinaimg.cn/small/b0c9ca8cgw1e8jk57yoofj20hs0qodkp.jpg)
![Preview](http://ww2.sinaimg.cn/small/b0c9ca8cgw1e8jk5a2yg9j20hs0qowil.jpg)
![Preview](http://ww1.sinaimg.cn/small/b0c9ca8cgw1e8jk5beh9mj20hs0qoq79.jpg)

#GET
  	pod 'ZTCircleMapPinView'

#IOS Require
  ios5 and above

#Usage
##First
make an annotation from ZTSampleHelpAnnotation
##Second
make a annotionView what you want [just like the ZTContentView]
##Third
overwrite the method of ZTMapView 

    - (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
    {
    
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
    

       return nil;
    }

    
