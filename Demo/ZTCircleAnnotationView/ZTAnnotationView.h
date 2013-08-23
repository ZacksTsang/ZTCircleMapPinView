//
//  ZTAnnotationView.h
//  ZTCircleAnnotationView
//
//  Created by Zacks Tsang  on 13-8-21.
//  Copyright (c) 2013年 www.aiysea.com. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface ZTAnnotationView : MKAnnotationView{
    CGPoint _center;
    
    float _endAngle;
    
    float _startAngle;
    
    UIView *_line;
    
    float _radius;
}

@property (nonatomic,strong)UIView *contentView;

@property(nonatomic,assign)BOOL isDismiss;

-(void)addCenterView:(UIView *)centerView andRadius:(float)radius;

-(void)turnByAngel:(float)angel;

-(void)showByAngle:(float)angel;

- (void)hiddenView;

-(void)dismissView:(void (^)(void))finish;

@end
